import os
import cv2
import numpy as np
import argparse

def crop_center(image, crop_ratio=0.70):
    center_y, center_x = image.shape[0] // 2, image.shape[1] // 2
    crop_height, crop_width = int(image.shape[0] * crop_ratio / 2), int(image.shape[1] * crop_ratio / 2)
    cropped_image = image[center_y - crop_height:center_y + crop_height, center_x - crop_width:center_x + crop_width]
    return cropped_image

def gaussian_blur_subtract(image, ksize=33):
    blurred_image = cv2.GaussianBlur(image, (ksize, ksize), 0)
    sub_image = cv2.subtract(image, blurred_image)
    return cv2.GaussianBlur(sub_image, (ksize, ksize), 0) + image

def apply_multiple_radial_thresholds(image, threshold_range=[100, 170], n=5):
    t_min, t_max = threshold_range
    thresholds = np.linspace(t_min, t_max, n)
    
    height, width = image.shape[:2]
    center_x, center_y = width // 2, height // 2

    # Create radial gradient
    Y, X = np.ogrid[:height, :width]
    dist_from_center = np.sqrt((X - center_x)**2 + (Y - center_y)**2)
    max_dist = np.sqrt(center_x**2 + center_y**2)
    
    results = []
    for threshold_value in thresholds:
        radial_threshold = threshold_value + (dist_from_center / max_dist) * (threshold_value - threshold_value)

        # Apply threshold
        thresholded_img = np.zeros_like(image, dtype=np.uint8)
        thresholded_img[image > radial_threshold] = 255

        # Find contours
        contours, _ = cv2.findContours(thresholded_img, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        large_contours = [cnt for cnt in contours if 10000 < cv2.contourArea(cnt)]

        results.append((thresholded_img, large_contours, threshold_value))
    
    return results

def adjust_gamma(image, gamma=1.0):
    inv_gamma = 1.0 / gamma
    table = np.array([(i / 255.0) ** inv_gamma * 255 for i in np.arange(0, 256)]).astype("uint8")
    return cv2.LUT(image, table)

def equalize_brightness(image, clip_limit=2.0, tile_grid_size=(8, 8), gamma=1.0):
    if gamma != 1.0:
        image = adjust_gamma(image, gamma)
    
    clahe = cv2.createCLAHE(clipLimit=clip_limit, tileGridSize=tile_grid_size)
    equalized_image = clahe.apply(image)
    
    return equalized_image

def filter_by_color(image, lower_bound, upper_bound):
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    mask = cv2.inRange(hsv_image, lower_bound, upper_bound)
    return mask

def process_image_with_color_filter(image_path, output_dir, threshold_range, n, channel, crop_ratio_r):
    file_extension = os.path.splitext(image_path)[1].lower()
    image = cv2.imread(image_path)

    if image is None:
        print(f"Error: Unable to load image at {image_path}. It may not be a valid image file.")
        return []

    if channel in ['red', 'green', 'blue']:
        channel_idx = {'red': 2, 'green': 1, 'blue': 0}[channel]
        channel_image = image[:, :, channel_idx]
    else:
        channel_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    cropped_image = crop_center(channel_image, crop_ratio_r)
    equalized_image = equalize_brightness(cropped_image, clip_limit=3.0, tile_grid_size=(16, 16), gamma=1.2)
    processed_image = gaussian_blur_subtract(equalized_image)

    lower_color_bound = np.array([0, 0, 180])  # HSV lower bound for light colors
    upper_color_bound = np.array([180, 30, 255])  # HSV upper bound for light colors
    color_mask = filter_by_color(image, lower_color_bound, upper_color_bound)

    if len(processed_image.shape) == 3:
        processed_image = cv2.cvtColor(processed_image, cv2.COLOR_BGR2GRAY)
    if processed_image.shape[:2] != color_mask.shape:
        color_mask = cv2.resize(color_mask, (processed_image.shape[1], processed_image.shape[0]))
    if color_mask.dtype != np.uint8:
        color_mask = color_mask.astype(np.uint8)

    processed_image = cv2.bitwise_and(processed_image, processed_image, mask=color_mask)

    results = apply_multiple_radial_thresholds(processed_image, threshold_range, n)

    base_name = os.path.basename(image_path)
    name, ext = os.path.splitext(base_name)
    processed_files = []

    original_output_path = os.path.join(output_dir, f"{name}_original{ext}")
    cv2.imwrite(original_output_path, image)

    cropped_color_image = crop_center(image, crop_ratio_r)

    for i, (thresholded_img, contours, threshold_value) in enumerate(results):
        thresholded_path = os.path.join(output_dir, f"{name}_threshold_{int(threshold_value)}{ext}")
        contour_path = os.path.join(output_dir, f"{name}_contours_{int(threshold_value)}{ext}")

        cv2.imwrite(thresholded_path, thresholded_img)

        contour_img = cropped_color_image.copy()
        for contour in contours:
            x, y, w, h = cv2.boundingRect(contour)
            cv2.rectangle(contour_img, (x, y), (x + w, y + h), (0, 255, 255), 4)
        cv2.drawContours(contour_img, contours, -1, (0, 255, 0), 2)

        cv2.imwrite(contour_path, contour_img)

        processed_files.append({
            'original': base_name,
            'threshold': int(threshold_value),
            'threshold_image': os.path.basename(thresholded_path),
            'contour_image': os.path.basename(contour_path),
        })

    return processed_files

def process_images_in_folder(folder_path, output_dir, threshold_range=[100, 170], n=5, channel='blue', crop_ratio=0.7):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    for file_name in os.listdir(folder_path):
        file_path = os.path.join(folder_path, file_name)
        
        if os.path.isfile(file_path) and is_image(file_name):
            process_image_with_color_filter(file_path, output_dir, threshold_range, n, channel, crop_ratio)
        else:
            print(f"Skipping non-image file: {file_name}")

def is_image(file_name):
    _, ext = os.path.splitext(file_name)
    return ext.lower() in {'.jpg', '.jpeg', '.png', '.bmp', '.gif', '.tiff'}

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process images with specific parameters.")
    parser.add_argument("folder_path", type=str, help="Path to the folder containing images.")
    parser.add_argument("output_dir", type=str, help="Directory to save processed images.")
    parser.add_argument("low_threshold", type=int, help="Low threshold value.")
    parser.add_argument("high_threshold", type=int, help="High threshold value.")
    parser.add_argument("n", type=int, help="Number of outputs per picture.")
    parser.add_argument("channel", type=str, help="Channel for processing the pictures.")
    parser.add_argument("crop_ratio", type=float, help="Crop ratio for pictures")

    args = parser.parse_args()
    threshold_range = [args.low_threshold, args.high_threshold]
    
    process_images_in_folder(args.folder_path, args.output_dir, threshold_range, args.n, args.channel, args.crop_ratio)

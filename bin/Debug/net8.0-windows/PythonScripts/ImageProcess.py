﻿import os
import cv2
import numpy as np
import matplotlib.pyplot as plt
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

    # 创建径向渐变的基础
    Y, X = np.ogrid[:height, :width]
    dist_from_center = np.sqrt((X - center_x)**2 + (Y - center_y)**2)
    max_dist = np.sqrt(center_x**2 + center_y**2)
    
    results = []
    for threshold_value in thresholds:
        radial_threshold = threshold_value + (dist_from_center / max_dist) * (threshold_value - threshold_value)

        # 应用阈值
        thresholded_img = np.zeros_like(image)
        thresholded_img[image > radial_threshold] = 255

        # 找到轮廓
        contours, _ = cv2.findContours(thresholded_img, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        large_contours = [cnt for cnt in contours if 10000 < cv2.contourArea(cnt) and cv2.arcLength(cnt, True) < 10000]


        results.append((thresholded_img, large_contours, threshold_value))
    
    
    return results

def adjust_gamma(image, gamma=1.0):
    inv_gamma = 1.0 / gamma
    table = np.array([(i / 255.0) ** inv_gamma * 255 for i in np.arange(0, 256)]).astype("uint8")
    return cv2.LUT(image, table)

def equalize_brightness(image, clip_limit=2.0, tile_grid_size=(8, 8), gamma=1.0):
    # 伽马校正
    if gamma != 1.0:
        image = adjust_gamma(image, gamma)
    
    # CLAHE 均衡化
    clahe = cv2.createCLAHE(clipLimit=clip_limit, tileGridSize=tile_grid_size)
    equalized_image = clahe.apply(image)
    
    return equalized_image

IMAGE_EXTENSIONS = {'.jpg', '.jpeg', '.png', '.bmp', '.gif', '.tiff', ".JPG"}

def is_image(file_name):
    # 提取文件扩展名并检查是否在常见图像格式列表中
    _, ext = os.path.splitext(file_name)
    return ext.lower() in IMAGE_EXTENSIONS


# def process_image(image_path, output_dir, threshold_range, n, channel, crop_ratio_r):
#     # 获取文件扩展名
#     file_extension = os.path.splitext(image_path)[1].lower()  # 转换为小写

#     # 尝试读取图像
#     image = cv2.imread(image_path)

#     # 检查图像是否读取成功
#     if image is None:
#         print(f"Error: Unable to load image at {image_path}. It may not be a valid image file.")
#         return []
#     if channel == 'red':
#         channel_image = image[:, :, 2]
#     elif channel == 'green':
#         channel_image = image[:, :, 1]
#     elif channel == 'blue':
#         channel_image = image[:, :, 0]
#     else:
#         channel_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

#     channel_image_crop = crop_center(channel_image, crop_ratio_r)

#     # 动态调整亮度均衡化参数
#     channel_image_crop_eq = equalize_brightness(channel_image_crop, clip_limit=3.0, tile_grid_size=(16, 16), gamma=1.2)
#     gray_image = channel_image_crop_eq

#     gray_image_blur_sub = gaussian_blur_subtract(gray_image)

#     kernel = np.ones((5,5), np.uint8)
#     gray_image_blur_sub_erode = cv2.erode(gray_image_blur_sub, kernel, iterations=1)

#     results = apply_multiple_radial_thresholds(gray_image_blur_sub_erode, threshold_range, n)

#     base_name = os.path.basename(image_path)
#     name, ext = os.path.splitext(base_name)

#     processed_files = []

#     original_output_path = os.path.join(output_dir, f"{name}_original{ext}")
#     cv2.imwrite(original_output_path, image)

#     for i, (thresholded_img, large_contours, threshold_value) in enumerate(results):
#         thresholded_output_path = os.path.join(output_dir, f"{name}_threshold_{int(threshold_value)}{ext}")
#         contour_output_path = os.path.join(output_dir, f"{name}_contours_{int(threshold_value)}{ext}")

#         cv2.imwrite(thresholded_output_path, thresholded_img)

#         contour_img = crop_center(image.copy(), crop_ratio_r)
#         for contour in large_contours:
#             x, y, w, h = cv2.boundingRect(contour)
#             x, y, w, h = max(0, x - 10), max(0, y - 10), min(image.shape[1] - x, w + 20), min(image.shape[0] - y, h + 20)
#             # 修改矩形轮廓的颜色为黄色，并加粗线条
#             cv2.rectangle(contour_img, (x, y), (x + w, y + h), (0, 255, 255), 4)  # 颜色改为黄色，厚度为 4

#         contour_img = cv2.drawContours(contour_img, large_contours, -1, (0, 255, 0), 2)
#         cv2.imwrite(contour_output_path, contour_img)

#         processed_files.append({
#             'original': base_name,
#             'threshold': int(threshold_value),
#             'threshold_image': os.path.basename(thresholded_output_path),
#             'contour_image': os.path.basename(contour_output_path),
#             'original_image': base_name
#         })

#     return processed_files

# Updated 01/15/2025
def process_image(image_path, output_dir, threshold_range, n, channel, crop_ratio_r):
    # 获取文件扩展名
    file_extension = os.path.splitext(image_path)[1].lower()
    image = cv2.imread(image_path)

    # 检查图像是否读取成功
    if image is None:
        print(f"Error: Unable to load image at {image_path}. It may not be a valid image file.")
        return []

    # 选择通道或灰度化
    if channel in ['red', 'green', 'blue']:
        channel_idx = {'red': 2, 'green': 1, 'blue': 0}[channel]
        channel_image = image[:, :, channel_idx]
    else:
        channel_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # 裁剪与亮度均衡化
    cropped_image = crop_center(channel_image, crop_ratio_r)
    equalized_image = equalize_brightness(cropped_image, clip_limit=3.0, tile_grid_size=(16, 16), gamma=1.2)

    # 高斯滤波与增强
    processed_image = gaussian_blur_subtract(equalized_image)

    # 径向动态阈值处理
    results = apply_multiple_radial_thresholds(processed_image, threshold_range, n)

    # 保存原图和结果
    base_name = os.path.basename(image_path)
    name, ext = os.path.splitext(base_name)
    processed_files = []

    original_output_path = os.path.join(output_dir, f"{name}_original{ext}")
    cv2.imwrite(original_output_path, image)

    # 使用裁剪后的彩色图像作为轮廓绘制的基础
    cropped_color_image = crop_center(image, crop_ratio_r)

    for i, (thresholded_img, contours, threshold_value) in enumerate(results):
        thresholded_path = os.path.join(output_dir, f"{name}_threshold_{int(threshold_value)}{ext}")
        contour_path = os.path.join(output_dir, f"{name}_contours_{int(threshold_value)}{ext}")

        # 保存阈值图像
        cv2.imwrite(thresholded_path, thresholded_img)

        # 在彩色图像上绘制轮廓
        contour_img = cropped_color_image.copy()
        for contour in contours:
            x, y, w, h = cv2.boundingRect(contour)
            # 绘制黄色矩形框
            cv2.rectangle(contour_img, (x, y), (x + w, y + h), (0, 255, 255), 4)
        # 绘制绿色轮廓
        cv2.drawContours(contour_img, contours, -1, (0, 255, 0), 2)

        # 保存绘制了轮廓的彩色图像
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
        
        # 如果是文件且是图像文件，则调用 process_image
        if os.path.isfile(file_path) and is_image(file_name):
            process_image(file_path, output_dir, threshold_range, n, channel, crop_ratio)
        else:
            print(f"跳过非图像文件: {file_name}")
# If you want to run this script independently for testing, you can add a main guard
if __name__ == "__main__":
        parser = argparse.ArgumentParser(description="Process images with specific parameters.")
        parser.add_argument("folder_path", type=str, help="Path to the folder containing images.")
        parser.add_argument("output_dir", type=str, help="Directory to save processed images.")
        parser.add_argument("low_threshold", type=int, help="Low threshold value.")
        parser.add_argument("high_threshold", type=int, help="High threshold value.")
        parser.add_argument("n", type=int, help="Number of outputs per picture.")
        parser.add_argument("channel", type=str, help="Channel for processing the pictures.")
        parser.add_argument("crop_ratio", type=float, help="Crop ratio to pictures")
        
        args = parser.parse_args()
        threshold_range = [args.low_threshold, args.high_threshold]
        
        process_images_in_folder(args.folder_path, args.output_dir, threshold_range, args.n, args.channel, args.crop_ratio)

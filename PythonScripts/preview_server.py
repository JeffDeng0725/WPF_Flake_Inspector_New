import socket
import json
import cv2
import numpy as np
import struct
import os
import math

HOST = '127.0.0.1'  # 本地地址
PORT = 9999         # 监听端口

def fix_brightness_hsv(image, reference=150):
    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    V = hsv[:, :, 2].astype(np.int32)
    avg_v = np.mean(V)
    adjustment = avg_v - reference
    if abs(adjustment) > 5:
        V_new = V - int(round(adjustment))
        V_new = np.clip(V_new, 0, 255).astype(np.uint8)
        hsv[:, :, 2] = V_new
        fixed_image = cv2.cvtColor(hsv, cv2.COLOR_HSV2BGR)
        return fixed_image
    else:
        return image

def polygon_roughness_metric(contour, epsilon_ratio=0.02):
    original_perimeter = cv2.arcLength(contour, True)
    if original_perimeter == 0:
        return 0.0
    epsilon = epsilon_ratio * original_perimeter
    approx = cv2.approxPolyDP(contour, epsilon, True)
    approx_perimeter = cv2.arcLength(approx, True)
    ratio = approx_perimeter / original_perimeter
    roughness = 1.0 - ratio
    return roughness

def circularity_metric(contour):
    area = cv2.contourArea(contour)
    perimeter = cv2.arcLength(contour, True)
    if perimeter == 0:
        return 0.0
    return (4 * math.pi * area) / (perimeter ** 2)

def process_image(image_path, output_dir, lower_hsv, upper_hsv, 
                  min_area=2000.0, min_perimeter=100.0, max_perimeter=10000.0,
                  max_roughness=0.23, min_circularity=0.2, reference_brightness=150):
    """
    处理图像并返回 Result 图像的文件路径（在原图上绘制轮廓和矩形框）
    """
    image = cv2.imread(image_path)
    if image is None:
        raise FileNotFoundError(f"无法读取图像：{image_path}")
    
    # 亮度归一化
    fixed_image = fix_brightness_hsv(image, reference=reference_brightness)
    
    # 转换到 HSV 并生成二值掩膜
    hsv_image = cv2.cvtColor(fixed_image, cv2.COLOR_BGR2HSV)
    mask = cv2.inRange(hsv_image, lower_hsv, upper_hsv)
    
    # 形态学闭运算去噪，抹除小洞
    kernel = np.ones((9, 9), np.uint8)
    mask_cleaned = cv2.morphologyEx(mask, cv2.MORPH_CLOSE, kernel, iterations=1)
    
    # 查找轮廓
    contours, _ = cv2.findContours(mask_cleaned, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    base_name = os.path.basename(image_path)
    print(f"{base_name} - 总轮廓数: {len(contours)}")
    
    # 根据面积和周长进行初步过滤
    base_valid_contours = []
    for cnt in contours:
        area = cv2.contourArea(cnt)
        if area < min_area:
            continue
        perimeter = cv2.arcLength(cnt, True)
        if perimeter < min_perimeter or perimeter > max_perimeter:
            continue
        base_valid_contours.append(cnt)
    print(f"{base_name} - 面积与周长过滤后轮廓数: {len(base_valid_contours)}")
    
    # 根据粗糙度和圆度进一步过滤
    valid_contours = []
    for cnt in base_valid_contours:
        roughness = polygon_roughness_metric(cnt)
        circ = circularity_metric(cnt)
        if roughness <= max_roughness and circ >= min_circularity:
            valid_contours.append(cnt)
    print(f"{base_name} - 最终有效轮廓数: {len(valid_contours)}")
    
    # 生成 Result 图像：在原图上绘制轮廓和矩形框
    result_image = fixed_image.copy()
    cv2.drawContours(result_image, valid_contours, -1, (0, 255, 0), 2)
    for cnt in valid_contours:
        x, y, w, h = cv2.boundingRect(cnt)
        cv2.rectangle(result_image, (x, y), (x+w, y+h), (0, 0, 255), 4)
    
        # 创建输出目录
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    # 生成 result_path（文件名附加有效轮廓数，扩展名固定为 .jpg）
    name, _ = os.path.splitext(base_name)
    result_name = f"{name}_{len(valid_contours)}.jpg"
    result_path = os.path.join(output_dir, result_name)
    
    # 使用 JPEG 格式保存（质量参数可选，范围 0-100，95为高质量）
    cv2.imwrite(result_path, result_image, [cv2.IMWRITE_JPEG_QUALITY, 95])
    print(f"Result图保存至：{result_path}")

    
    return result_path

def main():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((HOST, PORT))
        s.listen(1)
        print(f"Server listening on {HOST}:{PORT}")
        while True:
            conn, addr = s.accept()
            with conn:
                print("Connected by", addr)
                data = b""
                # 持续接收直到收到换行符
                while True:
                    part = conn.recv(1024)
                    if not part:
                        break
                    data += part
                    if b'\n' in part:
                        break
                try:
                    message = data.decode('utf-8').strip()
                    print("Received JSON:", message)
                    params = json.loads(message)
                    print("Params dict:", params)
                except Exception as e:
                    print("Failed to parse JSON:", e)
                    continue

                try:
                    # 获取输入图像路径和输出目录，从 JSON 中传入，否则使用默认值
                    input_image_path = params.get("input_image_path", "your_input_image.png")
                    output_dir = params.get("output_dir", r"D:\VisualStudio\Test\MyToDo1\Processed")
                    
                    # 获取 HSV 参数
                    lower_hsv = np.array([params["lowerH"], params["lowerS"], params["lowerV"]])
                    upper_hsv = np.array([params["higherH"], params["higherS"], params["higherV"]])
                    
                    # 调用图像处理函数，得到 Result 图像的路径
                    result_path = process_image(
                        input_image_path, output_dir, lower_hsv, upper_hsv,
                        min_area=2000.0, min_perimeter=100.0, max_perimeter=10000.0,
                        max_roughness=0.23, min_circularity=0.2, reference_brightness=150
                    )
                    
                    # 发送 Result 图像数据
                    with open(result_path, "rb") as f:
                        result_bytes = f.read()
                    conn.sendall(struct.pack('!I', len(result_bytes)))  # 发送4字节长度
                    conn.sendall(result_bytes)                           # 发送图像数据
                    print("Sent result image, length:", len(result_bytes))
                except Exception as e:
                    print("Error processing image:", e)

if __name__ == "__main__":
    main()

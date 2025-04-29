import cv2
import numpy as np
import os
import math
import argparse

def is_image(file_name):
    """判断文件是否为图像"""
    _, ext = os.path.splitext(file_name)
    return ext.lower() in {'.jpg', '.jpeg', '.png', '.bmp', '.gif', '.tiff', '.JPG'}

def fix_brightness_hsv(image, reference=150):
    """
    对图像进行亮度归一化：
      1. 将图像从 BGR 转换到 HSV
      2. 计算 V 通道（亮度）的平均值
      3. 如果平均值与 reference 相差超过 5，则统一调整 V 通道：
           调整量 = (平均 V 值 - reference)
           对 V 通道每个像素减去该调整量（差为负则相当于加亮度）
      4. 转换回 BGR 返回
    """
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
    """
    使用多边形逼近方法计算轮廓的粗糙度（毛躁度）：
      1. 计算原始轮廓周长
      2. 根据 epsilon_ratio 计算 epsilon，用 cv2.approxPolyDP 逼近轮廓
      3. 计算逼近后轮廓周长，并计算比值：approx_perimeter / original_perimeter
      4. 定义粗糙度为： 1 - (比值)
         值越大表示轮廓越毛躁
    """
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
    """
    计算轮廓的圆度：
      圆度 = 4π * 面积 / (周长²)
    对于完美圆形，圆度等于 1；数值越低表示形状越不规则（例如毛躁、边缘不平）。
    """
    area = cv2.contourArea(contour)
    perimeter = cv2.arcLength(contour, True)
    if perimeter == 0:
        return 0.0
    return (4 * math.pi * area) / (perimeter ** 2)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='使用 OpenCV trackbar 实时调整 HSV 并框选图像碎片')
    parser.add_argument('--image', type=str, required=True, help='输入图片路径')
    # 用户不需要保存图像，因此可以不提供输出参数
    parser.add_argument('--min_area', type=float, default=2000.0, help='最小轮廓面积')
    parser.add_argument('--min_perimeter', type=float, default=100.0, help='最小轮廓周长')
    parser.add_argument('--max_perimeter', type=float, default=10000.0, help='最大轮廓周长')
    parser.add_argument('--max_roughness', type=float, default=0.23, help='最大粗糙度')
    parser.add_argument('--min_circularity', type=float, default=0.2, help='最小圆度')
    parser.add_argument('--reference', type=int, default=150, help='参考亮度值')
    args = parser.parse_args()

    # 读取原始图像，并进行亮度归一化
    image = cv2.imread(args.image)
    if image is None:
        raise FileNotFoundError("无法读取图像，请检查图片路径")
    fixed_image = fix_brightness_hsv(image, reference=args.reference)
    hsv_image = cv2.cvtColor(fixed_image, cv2.COLOR_BGR2HSV)

    # 创建窗口，并设置为可调整大小，同时指定窗口大小，避免占满全屏
    cv2.namedWindow('Trackbars', cv2.WINDOW_NORMAL)
    cv2.namedWindow('Result', cv2.WINDOW_NORMAL)
    cv2.namedWindow('Processed', cv2.WINDOW_NORMAL)
    cv2.resizeWindow('Trackbars', 400, 300)
    cv2.resizeWindow('Result', 800, 600)
    cv2.resizeWindow('Processed', 800, 600)

    # 创建 trackbar，用于控制六个 HSV 参数
    cv2.createTrackbar('LH', 'Trackbars', 0, 180, lambda x: None)
    cv2.createTrackbar('LS', 'Trackbars', 0, 255, lambda x: None)
    cv2.createTrackbar('LV', 'Trackbars', 0, 255, lambda x: None)
    cv2.createTrackbar('UH', 'Trackbars', 180, 180, lambda x: None)
    cv2.createTrackbar('US', 'Trackbars', 255, 255, lambda x: None)
    cv2.createTrackbar('UV', 'Trackbars', 255, 255, lambda x: None)

    kernel = np.ones((9, 9), np.uint8)

    while True:
        # 读取 trackbar 数值
        lh = cv2.getTrackbarPos('LH', 'Trackbars')
        ls = cv2.getTrackbarPos('LS', 'Trackbars')
        lv = cv2.getTrackbarPos('LV', 'Trackbars')
        uh = cv2.getTrackbarPos('UH', 'Trackbars')
        us = cv2.getTrackbarPos('US', 'Trackbars')
        uv = cv2.getTrackbarPos('UV', 'Trackbars')
        
        lower = np.array([lh, ls, lv])
        upper = np.array([uh, us, uv])
        
        # 生成二值掩膜，并做形态学闭运算（抹除小洞）
        mask = cv2.inRange(hsv_image, lower, upper)
        mask_cleaned = cv2.morphologyEx(mask, cv2.MORPH_CLOSE, kernel, iterations=1)
        
        # 查找轮廓，过滤后得到有效轮廓
        contours, _ = cv2.findContours(mask_cleaned, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        base_valid_contours = []
        for cnt in contours:
            area = cv2.contourArea(cnt)
            if area < args.min_area:
                continue
            perimeter = cv2.arcLength(cnt, True)
            if perimeter < args.min_perimeter or perimeter > args.max_perimeter:
                continue
            base_valid_contours.append(cnt)
        valid_contours = []
        for cnt in base_valid_contours:
            roughness = polygon_roughness_metric(cnt)
            circ = circularity_metric(cnt)
            if roughness <= args.max_roughness and circ >= args.min_circularity:
                valid_contours.append(cnt)
        
        # 得到经过掩膜处理后的彩色图像（不含轮廓绘制）
        processed_image = cv2.bitwise_and(fixed_image, fixed_image, mask=mask_cleaned)
        
        # 在归一化图像上绘制轮廓和外接矩形，得到最终结果图像
        result_image = fixed_image.copy()
        cv2.drawContours(result_image, valid_contours, -1, (0, 255, 0), 2)
        for cnt in valid_contours:
            x, y, w, h = cv2.boundingRect(cnt)
            cv2.rectangle(result_image, (x, y), (x+w, y+h), (0, 0, 255), 4)
        
        # 实时显示：结果图像和经过掩膜处理后的彩色图像
        cv2.imshow('Result', result_image)
        cv2.imshow('Processed', processed_image)
        
        # 检测用户是否关闭了任一窗口
        if (cv2.getWindowProperty('Result', cv2.WND_PROP_VISIBLE) < 1 or
            cv2.getWindowProperty('Processed', cv2.WND_PROP_VISIBLE) < 1 or
            cv2.getWindowProperty('Trackbars', cv2.WND_PROP_VISIBLE) < 1):
            break

        # 按 'q' 键退出（如果需要手动退出）
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cv2.destroyAllWindows()

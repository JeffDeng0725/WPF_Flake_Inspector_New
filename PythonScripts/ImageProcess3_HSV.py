#!/usr/bin/env python3
# -*- coding: gbk -*-

import cv2
import numpy as np
import os
import math
import argparse
import datetime

def is_image(file_name):
    _, ext = os.path.splitext(file_name)
    return ext.lower() in {'.jpg', '.jpeg', '.png', '.bmp', '.gif', '.tiff'}

def fix_brightness_hsv(image, reference=150):
    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    V = hsv[:, :, 2].astype(np.int32)
    avg_v = np.mean(V)
    adjustment = avg_v - reference
    if abs(adjustment) > 5:
        V_new = np.clip(V - int(round(adjustment)), 0, 255).astype(np.uint8)
        hsv[:, :, 2] = V_new
        return cv2.cvtColor(hsv, cv2.COLOR_HSV2BGR)
    return image

def polygon_roughness_metric(contour, epsilon_ratio=0.02):
    orig = cv2.arcLength(contour, True)
    if orig == 0:
        return 0.0
    eps = epsilon_ratio * orig
    approx = cv2.approxPolyDP(contour, eps, True)
    return 1.0 - (cv2.arcLength(approx, True) / orig)

def circularity_metric(contour):
    area = cv2.contourArea(contour)
    peri = cv2.arcLength(contour, True)
    return (4 * math.pi * area / peri**2) if peri > 0 else 0.0

def process_image(image_path, output_dir, lower_hsv, upper_hsv,
                  min_area, min_perimeter, max_perimeter,
                  max_roughness, min_circularity, reference):
    img = cv2.imread(image_path)
    if img is None:
        print(f"Skip {image_path}: cannot read")
        return

    fixed = fix_brightness_hsv(img, reference)
    hsv = cv2.cvtColor(fixed, cv2.COLOR_BGR2HSV)
    mask = cv2.inRange(hsv, lower_hsv, upper_hsv)
    mask = cv2.morphologyEx(mask, cv2.MORPH_CLOSE, np.ones((5,5),np.uint8))

    contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    print(f"{os.path.basename(image_path)} → {len(contours)} contours found")

    base = [
        c for c in contours
        if cv2.contourArea(c) >= min_area
        and min_perimeter <= cv2.arcLength(c, True) <= max_perimeter
    ]
    print(f"{os.path.basename(image_path)} → {len(base)} after area/perimeter filter")

    valid = [
        c for c in base
        if polygon_roughness_metric(c) <= max_roughness
        and circularity_metric(c) >= min_circularity
    ]
    print(f"{os.path.basename(image_path)} → {len(valid)} valid contours")

    out = fixed.copy()
    cv2.drawContours(out, valid, -1, (0,255,0), 1)
    for c in valid:
        x, y, w, h = cv2.boundingRect(c)
        cv2.rectangle(out, (x-3, y-3), (x+w+3, y+h+3), (0,0,255), 4)

    base_name, ext = os.path.splitext(os.path.basename(image_path))
    new_name = f"{base_name}_{len(valid)}{ext}"
    cv2.imwrite(os.path.join(output_dir, new_name), out)
    print(f"Saved → {new_name}\n")

def process_folder(args):
    # 1) 校验输入目录
    if not os.path.isdir(args.input_folder):
        raise FileNotFoundError(f"{args.input_folder} does not exist or is not a folder")

    # 2) 在父级输出目录下创建一个以时间戳命名的子文件夹
    parent_out = args.output_folder
    os.makedirs(parent_out, exist_ok=True)
    timestamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    run_folder = os.path.join(parent_out, f"{args.setter_name}-{timestamp}")
    os.makedirs(run_folder, exist_ok=True)
    print(f"Results will be saved into: {run_folder}")

    lower = np.array([args.lower_h, args.lower_s, args.lower_v])
    upper = np.array([args.higher_h, args.higher_s, args.higher_v])

    for fn in os.listdir(args.input_folder):
        path = os.path.join(args.input_folder, fn)
        if os.path.isfile(path) and is_image(fn):
            print(f"Processing {fn}...")
            process_image(
                path,
                run_folder,   # ← 输出到时间戳子文件夹
                lower, upper,
                args.min_area,
                args.min_perimeter,
                args.max_perimeter,
                args.max_roughness,
                args.min_circularity,
                args.reference
            )
        else:
            print(f"Skipping non-image {fn}")

if __name__ == "__main__":
    p = argparse.ArgumentParser(description="Batch detect flakes via HSV + contour metrics")
    p.add_argument("--input_folder",    required=True)
    p.add_argument("--output_folder",   required=True)
    p.add_argument("--setter_name",     required=True, help="name prefix for this run")
    p.add_argument("--lower_h",   type=int, required=True)
    p.add_argument("--lower_s",   type=int, required=True)
    p.add_argument("--lower_v",   type=int, required=True)
    p.add_argument("--higher_h",  type=int, required=True)
    p.add_argument("--higher_s",  type=int, required=True)
    p.add_argument("--higher_v",  type=int, required=True)
    p.add_argument("--min_area",      type=int,   default=1000)
    p.add_argument("--min_perimeter", type=int,   default=100)
    p.add_argument("--max_perimeter", type=int,   default=5000)
    p.add_argument("--max_roughness", type=float, default=0.18)
    p.add_argument("--min_circularity", type=float, default=0.2)
    p.add_argument("--reference",     type=int,   default=150)
    args = p.parse_args()
    process_folder(args)

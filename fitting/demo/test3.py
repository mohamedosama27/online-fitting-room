#!~/Desktop/myFolder/Grad project/torch/pytorch-env/bin/python
import cv2
import torch
import numpy as np

from detectron2.config import get_cfg
from detectron2.data.detection_utils import read_image
from detectron2.engine.defaults import DefaultPredictor
from creatingModel.src import demo


def detect_human(image_path):
    confidence_threshold = 0.7
    config_file = '../configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml'
    opts = ['MODEL.WEIGHTS',
            'detectron2://COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x/137849600/model_final_f10217.pkl',
            'MODEL.DEVICE', 'cpu']

    cfg = get_cfg()
    cfg.merge_from_file(config_file)
    cfg.merge_from_list(opts)
    cfg.MODEL.RETINANET.SCORE_THRESH_TEST = confidence_threshold
    cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = confidence_threshold
    cfg.MODEL.PANOPTIC_FPN.COMBINE.INSTANCES_CONFIDENCE_THRESH = confidence_threshold
    cfg.freeze()

    img = read_image(image_path, format="BGR")
    image = cv2.imread(image_path)

    predictor = DefaultPredictor(cfg)
    predictions = predictor(img)
    # print(predictions)

    i = 0
    for box in predictions["instances"].pred_boxes:
        if predictions["instances"].pred_classes[i] == 0:

            mask = np.zeros((image.shape[0], image.shape[1]), dtype=np.uint8)
            pred_mask = predictions["instances"].pred_masks[i]
            mask = np.zeros(image.shape, dtype=np.uint8)

            for i in range(image.shape[0]):
                for j in range(image.shape[1]):
                    if pred_mask[i][j]:
                        mask[i][j] = 255

            result = cv2.bitwise_and(image, mask)
            result[mask == 0] = 255
            (startX, startY, endX, endY) = box
            startX = startX.type(torch.int64)
            startY = startY.type(torch.int64)
            endY = endY.type(torch.int64)
            endX = endX.type(torch.int64)
            crop_img = result[startY:endY, startX:endX + 5]
            # cv2.imshow('image' + str(startX), crop_img)

        i = +1
    return result, crop_img.shape[0]

def detect_joints(image_path):
    confidence_threshold = 0.7
    config_file = '../configs/COCO-Keypoints/keypoint_rcnn_R_50_FPN_3x.yaml'
    opts = ['MODEL.WEIGHTS',
            'detectron2://COCO-Keypoints/keypoint_rcnn_R_50_FPN_3x/137849621/model_final_a6e10b.pkl',
            'MODEL.DEVICE', 'cpu']
    cfg = get_cfg()
    cfg.merge_from_file(config_file)
    cfg.merge_from_list(opts)
    cfg.MODEL.RETINANET.SCORE_THRESH_TEST = confidence_threshold
    cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = confidence_threshold
    cfg.MODEL.PANOPTIC_FPN.COMBINE.INSTANCES_CONFIDENCE_THRESH = confidence_threshold
    cfg.freeze()

    img = read_image(image_path, format="BGR")
    predictor = DefaultPredictor(cfg)
    predictions = predictor(img)
    return predictions
#
# def detect_parts(image, predictions, part_name):
#
#     if part_name == 'leg':
#         top_left = 11
#         top_right = 12
#         bottom = 15
#     if part_name == 'chest':
#         top_left = 5
#         top_right = 6
#         bottom = 11
#
#     keypoints = predictions["instances"].pred_keypoints[0]
#     for idx, keypoint in enumerate(keypoints):
#         # draw keypoint
#         x, y, prob = keypoint
#         if prob > 0.05:
#             if idx == top_right:
#                 startX = x
#                 startY = y
#             if idx == bottom:
#                 endY = y
#             if idx == top_left:
#                 endX = x
#
#     startX = startX.type(torch.int64)
#     startY = startY.type(torch.int64)
#     endY = endY.type(torch.int64)
#     endX = endX.type(torch.int64)
#
#     # print(endX+20)
#     # print(startY)
#     # print(endY)
#     # print(image.shape)
#
#     crop_img = image[startY - 10:endY, startX - 20:endX + 20]
#     # cv2.imshow('imagex', crop_img)
#     # cv2.waitKey(0)
#     return crop_img
#

def get_chest_width(predictions):

    keypoints = predictions["instances"].pred_keypoints[0]
    for idx, keypoint in enumerate(keypoints):
        x, y, prob = keypoint
        if prob > 0.05:
            if idx == 5:
                endY = y

    endY = endY.type(torch.int64)
    count_pixels = 0
    for i in range(0, human_img.shape[1]):
        pixel = human_img[endY, i]
        if not all(pixel == [255, 255, 255]):
            count_pixels=count_pixels+1

    return count_pixels

def get_leg_height(predictions):

    keypoints = predictions["instances"].pred_keypoints[0]
    for idx, keypoint in enumerate(keypoints):
        x, y, prob = keypoint
        if prob > 0.05:
            if idx == 11:
                startY = y
            elif idx == 15:
                endY = y


    endY = endY.type(torch.int64)
    startY = startY.type(torch.int64)
    crop_img = human_img[startY:endY,:]
    count_pixels = crop_img.shape[0]

    return count_pixels

def get_upper_body_height(predictions):

    keypoints = predictions["instances"].pred_keypoints[0]
    for idx, keypoint in enumerate(keypoints):
        x, y, prob = keypoint
        if prob > 0.05:
            if idx == 5:
                startY = y
            elif idx == 11:
                endY = y


    endY = endY.type(torch.int64)
    startY = startY.type(torch.int64)
    crop_img = human_img[startY:endY,:]
    count_pixels = crop_img.shape[0]

    return count_pixels

def get_hip_width_front(predictions):

    keypoints = predictions["instances"].pred_keypoints[0]
    for idx, keypoint in enumerate(keypoints):
        x, y, prob = keypoint
        if prob > 0.05:
            if idx == 11:
                endY = y

    endY = endY.type(torch.int64)
    count_pixels = 0
    for i in range(0, human_img.shape[1]):
        pixel = human_img[endY, i]
        if not all(pixel == [255, 255, 255]):
            count_pixels=count_pixels+1

    return count_pixels

def get_hip_width_side(predictions):

    keypoints = predictions["instances"].pred_keypoints[0]
    for idx, keypoint in enumerate(keypoints):
        x, y, prob = keypoint
        if prob > 0.05:
            if idx == 11 or idx == 12:
                endY = y

    endY = endY.type(torch.int64)
    count_pixels = 0
    for i in range(0, human_img.shape[1]):
        pixel = human_img[endY, i]
        if not all(pixel == [255, 255, 255]):
            count_pixels=count_pixels+1

    return count_pixels
image_path = 'me6.jpeg'
side_image_path = 'me7_s.jpeg'

real_height = 165.0
weight = 51.0
type = 'male'

human_img, height = detect_human(image_path)
print("Human height with pixels")
print(height)
pixels_per_metric = height / real_height

predictions = detect_joints(image_path)

count_chest_pixels = get_chest_width(predictions)
print("Chest width with pixels")
print(count_chest_pixels)
real_chest_width = count_chest_pixels / pixels_per_metric
print("Chest width with cm")
print(real_chest_width)

# count_leg_pixels = get_leg_height(predictions)
# print("Leg height with pixels")
# print(count_leg_pixels)
# real_leg_height = (count_leg_pixels / pixels_per_metric) + 20
# print("Leg height with cm")
# print(real_leg_height)
#
# count_upper_pixels = get_upper_body_height(predictions)
# print("Upper height with pixels")
# print(count_upper_pixels)
# real_upper_height = (count_upper_pixels / pixels_per_metric)
# print("Upper height with cm")
# print(real_upper_height)

count_hip_pixels = get_hip_width_front(predictions)
real_hip_width = (count_hip_pixels / pixels_per_metric)

human_img, height = detect_human(side_image_path)

print("Human height with pixels")
print(height)

pixels_per_metric = height / real_height
predictions = detect_joints(side_image_path)

count_hip_side_pixels = get_hip_width_side(predictions)
real_hip_width_side = (count_hip_side_pixels / pixels_per_metric)
print("\U0001F618")

a = real_hip_width / 2
b = real_hip_width_side / 2

hip = (22/7) * (a + b) * (1 +( (3 * ((a - b) ** 2)) / ((10 + ((4 - ((3 * ((a - b) ** 2)) / ((a + b) ** 2)) ) ** 0.5)) * ((a + b) ** 2))))
print("Hip with cm")
print(hip)
demo.show_app(type, real_height, weight, real_chest_width, hip)

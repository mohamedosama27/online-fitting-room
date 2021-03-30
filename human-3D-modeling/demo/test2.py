# Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved
import cv2
import torch
import numpy as np

from detectron2.config import get_cfg
from detectron2.data.detection_utils import read_image
from detectron2.engine.defaults import DefaultPredictor

def detect_parts():
    confidence_threshold = 0.7
    image_path = 't.jpg'
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
    image = cv2.imread(image_path)

    predictor = DefaultPredictor(cfg)
    predictions = predictor(img)

    keypoints = predictions["instances"].pred_keypoints[0]
    for idx, keypoint in enumerate(keypoints):
        # draw keypoint
        x, y, prob = keypoint
        if prob > 0.05:
            if idx == 12:
                startX = x
                startY = y
            if idx == 15:
                endY = y
            if idx == 11:
                endX = x

    startX = startX.type(torch.int64)
    startY = startY.type(torch.int64)
    endY = endY.type(torch.int64)
    endX = endX.type(torch.int64)
    crop_img = image[startY:endY, startX - 20:endX + 20]
    cv2.imshow('imagex', crop_img)
    cv2.waitKey(0)

detect_parts()
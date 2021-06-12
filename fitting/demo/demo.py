# Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved
import argparse
import glob
import multiprocessing as mp
import os
import time
import cv2
import torch
import tqdm
import numpy as np

from detectron2.config import get_cfg
from detectron2.data.detection_utils import read_image
from detectron2.utils.logger import setup_logger
from torch import tensor

from predictor import VisualizationDemo

from detectron2.data import MetadataCatalog
from detectron2.engine.defaults import DefaultPredictor
from detectron2.utils.video_visualizer import VideoVisualizer
from detectron2.utils.visualizer import ColorMode, Visualizer

# constants
WINDOW_NAME = "COCO detections"


def setup_cfg():
    # load config from file and command-line arguments
    cfg = get_cfg()
    # To use demo for Panoptic-DeepLab, please uncomment the following two lines.
    # from detectron2.projects.panoptic_deeplab import add_panoptic_deeplab_config  # noqa
    # add_panoptic_deeplab_config(cfg)
    cfg.merge_from_file('../configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml')
    opts = ['MODEL.WEIGHTS', 'detectron2://COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x/137849600/model_final_f10217.pkl', 'MODEL.DEVICE', 'cpu']
    cfg.merge_from_list(opts)
    # Set score_threshold for builtin models
    confidence_threshold = 0.7
    cfg.MODEL.RETINANET.SCORE_THRESH_TEST = confidence_threshold
    cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = confidence_threshold
    cfg.MODEL.PANOPTIC_FPN.COMBINE.INSTANCES_CONFIDENCE_THRESH = confidence_threshold
    cfg.freeze()
    return cfg


# def get_parser():
#     parser = argparse.ArgumentParser(description="Detectron2 demo for builtin configs")
#     parser.add_argument(
#         "--config-file",
#         default="configs/quick_schedules/mask_rcnn_R_50_FPN_inference_acc_test.yaml",
#         metavar="FILE",
#         help="path to config file",
#     )
#     parser.add_argument("--webcam", action="store_true", help="Take inputs from webcam.")
#     parser.add_argument("--video-input", help="Path to video file.")
#     parser.add_argument(
#         "--input",
#         nargs="+",
#         help="A list of space separated input images; "
#              "or a single glob pattern such as 'directory/*.jpg'",
#     )
#     parser.add_argument(
#         "--output",
#         help="A file or directory to save output visualizations. "
#              "If not given, will show output in an OpenCV window.",
#     )
#
#     parser.add_argument(
#         "--confidence-threshold",
#         type=float,
#         default=0.7,
#         help="Minimum score for instance predictions to be shown",
#     )
#     parser.add_argument(
#         "--opts",
#         help="Modify config options using the command-line 'KEY VALUE' pairs",
#         default=[],
#         nargs=argparse.REMAINDER,
#     )
#     return parser
#

if __name__ == "__main__":
    # mp.set_start_method("spawn", force=True)
    # args = get_parser().parse_args()
    # setup_logger(name="fvcore")
    # logger = setup_logger()
    # logger.info("Arguments: " + str(args))

    # cfg = setup_cfg()
    cfg = get_cfg()
    # To use demo for Panoptic-DeepLab, please uncomment the following two lines.
    # from detectron2.projects.panoptic_deeplab import add_panoptic_deeplab_config  # noqa
    # add_panoptic_deeplab_config(cfg)
    cfg.merge_from_file('../configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml')
    opts = ['MODEL.WEIGHTS',
            'detectron2://COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x/137849600/model_final_f10217.pkl',
            'MODEL.DEVICE', 'cpu']
    cfg.merge_from_list(opts)
    # Set score_threshold for builtin models
    confidence_threshold = 0.7
    cfg.MODEL.RETINANET.SCORE_THRESH_TEST = confidence_threshold
    cfg.MODEL.ROI_HEADS.SCORE_THRESH_TEST = confidence_threshold
    cfg.MODEL.PANOPTIC_FPN.COMBINE.INSTANCES_CONFIDENCE_THRESH = confidence_threshold
    cfg.freeze()

    # metadata = MetadataCatalog.get(
    #     cfg.DATASETS.TEST[0] if len(cfg.DATASETS.TEST) else "__unused"
    # )
    # cpu_device = torch.device("cpu")
    # instance_mode = ColorMode.IMAGE
    # parallel = False
    # if parallel:
    #     num_gpu = torch.cuda.device_count()
    #     self.predictor = AsyncPredictor(cfg, num_gpus=num_gpu)
    # else:
    # demo = VisualizationDemo(cfg)
    image_path = 'l.jpg'
    img = read_image(image_path, format="BGR")

    # if args.input:
    #     if len(args.input) == 1:
    #         args.input = glob.glob(os.path.expanduser(image_path))
    #         assert args.input, "The input path(s) was not found"
    #     for path in tqdm.tqdm(args.input, disable=not args.output):
    #         # use PIL, to be consistent with evaluation

    # start_time = time.time()
    # predictions = demo.run_on_image(img)
    predictor = DefaultPredictor(cfg)
    predictions = predictor(img)

    # logger.info(
    #     "{}: {} in {:.2f}s".format(
    #         path,
    #         "detected {} instances".format(len(predictions["instances"]))
    #         if "instances" in predictions
    #         else "finished",
    #         time.time() - start_time,
    #     )
    # )
    # print(predictions["instances"].panoptic_seg)

    image = cv2.imread(image_path)
    i = 0
    for box in predictions["instances"].pred_boxes:
        if predictions["instances"].pred_classes[i] == 0:
            mask = np.zeros((image.shape[0], image.shape[1]), dtype=np.uint8)
            # for x in predictions["instances"].pred_masks[i].numpy():
            #         if (y != False) :
            #             print(y)
            pred_mask = predictions["instances"].pred_masks[i]
            mask = np.zeros(image.shape, dtype=np.uint8)
            for i in range(image.shape[0]):
                for j in range(image.shape[1]):
                    if pred_mask[i][j]:
                        mask[i][j] = 255

            # mask = predictions["instances"].pred_masks[i].numpy()
            # mask = np.asarray(predictions["instances"].pred_masks[i])
            # print(len(predictions["instances"].pred_masks[i]))
            # print(len(image))

            result = cv2.bitwise_and(image, mask)
            # # Color background white
            result[mask == 0] = 255  # Optional
            # cv2.imshow('result', result)
            (startX, startY, endX, endY) = box
            startX = startX.type(torch.int64)
            startY = startY.type(torch.int64)
            endY = endY.type(torch.int64)
            endX = endX.type(torch.int64)
            crop_img = result[startY:endY, startX:endX + 5]
            # print(predictions["instances"].pred_masks[i])

            cv2.imshow('image' + str(startX), crop_img)

            # print(image)
            # print("----------------------------------------------------")
            # print(predictions["instances"].pred_masks[i].numpy())

            # mask = image * predictions["instances"].pred_masks[i].numpy()
            # cv2.imshow('imagee'+str(startX), mask)
        i = +1
    cv2.waitKey(0)

    # print(predictions["instances"].pred_masks)

    # cv2.namedWindow(WINDOW_NAME, cv2.WINDOW_NORMAL)
    # cv2.imshow(WINDOW_NAME, visualized_output.get_image()[:, :, ::-1])

    # if cv2.waitKey(0) == 27:
    #     break  # esc to quit

    # if args.output:
    #     if os.path.isdir(args.output):
    #         assert os.path.isdir(args.output), args.output
    #         out_filename = os.path.join(args.output, os.path.basename(path))
    #     else:
    #         assert len(args.input) == 1, "Please specify a directory with args.output"
    #         out_filename = args.output
    #     visualized_output.save(out_filename)
    # else:
    #     cv2.namedWindow(WINDOW_NAME, cv2.WINDOW_NORMAL)
    #     cv2.imshow(WINDOW_NAME, visualized_output.get_image()[:, :, ::-1])
    #     if cv2.waitKey(0) == 27:
    #         break  # esc to quit
# elif args.webcam:
#     assert args.input is None, "Cannot have both --input and --webcam!"
#     assert args.output is None, "output not yet supported with --webcam!"
#     cam = cv2.VideoCapture(0)
#     for vis in tqdm.tqdm(demo.run_on_video(cam)):
#         cv2.namedWindow(WINDOW_NAME, cv2.WINDOW_NORMAL)
#         cv2.imshow(WINDOW_NAME, vis)
#         if cv2.waitKey(1) == 27:
#             break  # esc to quit
#     cam.release()
#     cv2.destroyAllWindows()
# elif args.video_input:
#     video = cv2.VideoCapture(args.video_input)
#     width = int(video.get(cv2.CAP_PROP_FRAME_WIDTH))
#     height = int(video.get(cv2.CAP_PROP_FRAME_HEIGHT))
#     frames_per_second = video.get(cv2.CAP_PROP_FPS)
#     num_frames = int(video.get(cv2.CAP_PROP_FRAME_COUNT))
#     basename = os.path.basename(args.video_input)
#
#     if args.output:
#         if os.path.isdir(args.output):
#             output_fname = os.path.join(args.output, basename)
#             output_fname = os.path.splitext(output_fname)[0] + ".mkv"
#         else:
#             output_fname = args.output
#         assert not os.path.isfile(output_fname), output_fname
#         output_file = cv2.VideoWriter(
#             filename=output_fname,
#             # some installation of opencv may not support x264 (due to its license),
#             # you can try other format (e.g. MPEG)
#             fourcc=cv2.VideoWriter_fourcc(*"x264"),
#             fps=float(frames_per_second),
#             frameSize=(width, height),
#             isColor=True,
#         )
#     assert os.path.isfile(args.video_input)
#     for vis_frame in tqdm.tqdm(demo.run_on_video(video), total=num_frames):
#         if args.output:
#             output_file.write(vis_frame)
#         else:
#             cv2.namedWindow(basename, cv2.WINDOW_NORMAL)
#             cv2.imshow(basename, vis_frame)
#             if cv2.waitKey(1) == 27:
#                 break  # esc to quit
#     video.release()
#     if args.output:
#         output_file.release()
#     else:
#         cv2.destroyAllWindows()

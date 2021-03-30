import cv2
import numpy as np
import tensorflow as tf
from tensorflow.python.keras.models import load_model

class fashion_tools(object):
    def __init__(self,imageid,model,version=1.1):
        self.imageid = imageid
        self.model   = model
        self.version = version
        
    def get_dress(self,stack=False):
        name =  self.imageid
        file = cv2.imread(name)
        file = tf.image.resize_with_pad(file,target_height=512,target_width=512)
        file = np.expand_dims(file,axis=0)/ 255.
        seq = self.model.predict(file)
        seq = seq[3][0,:,:,:]
        return seq

    def get_patch(self):
        return None


    
def segmentCloth(imgName,id):
    model = load_model("segment/save_ckp_frozen.h5")
    api    = fashion_tools(imgName,model)
    image_ = api.get_dress(True)
    frame_normed = 255 * (image_ - image_.min()) / (image_.max() - image_.min())
    frame_normed = np.array(frame_normed, np.int)
    cv2.imwrite("seg_" + imgName ,frame_normed)
    # return frame_normed

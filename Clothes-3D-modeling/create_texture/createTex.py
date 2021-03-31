import torch.nn as nn
from create_texture import network
from PIL import Image
import torch.nn.functional as F
from torchvision import transforms
import cv2
import os
import numpy as np
from create_texture.utils import *

class Demo():
    def __init__(self,clothType,frontImgPath,backImgPath,segFront,segBack):
        self.gpus = '0'
        self.clothType = clothType
        self.mesh = 'create_texture/object/' + clothType + '.obj'
        self.img_front=frontImgPath
        self.seg_front= segFront
        self.img_back=  backImgPath
        self.seg_back= segBack
        self.map_up_front= 'create_texture/map_shirts_front.pt'
        self.map_up_back= 'create_texture/map_shirts_back.pt'
        self.map_low_front= 'create_texture/map_{}_front.pt'.format(self.clothType),
        self.map_low_back= 'create_texture/map_{}_back.pt'.format(self.clothType),
        self.device = torch.device("cpu")
        self.output='texture.jpg'
        self.gpu_ids = [0]
        self.transform = transforms.Compose(
            [  transforms.Resize((256, 256)),
                transforms.ToTensor() ]  )
        self.net_map = network.ResnetGenerator(2, 2, 0, 64, n_blocks=6, norm_layer = nn.InstanceNorm2d)


    def read_images(self, image_path):
        image = self.transform(Image.open(image_path).convert("RGB"))
        image = image.unsqueeze(0)
        return image.to(self.device)

    def get_img_rep(self, seg_out):
        x = torch.from_numpy(np.linspace(-1, 1, 256))
        y = torch.from_numpy(np.linspace(-1, 1, 256))

        xx = x.view(-1, 1).repeat(1, 256)
        yy = y.repeat(256, 1)
        meshed = torch.cat([yy.unsqueeze_(2), xx.unsqueeze_(2)], 2)
        meshed = meshed.permute(2, 0, 1)

        out_fg_binary = seg_out.unsqueeze(0)
        mask2 = torch.cat((out_fg_binary, out_fg_binary), dim=0)

        rend_rep = mask2.float() * meshed.float()
        return rend_rep.unsqueeze(0).to(self.device)


    def forward(self):
        dict = ['front', 'back']
        for val in dict:
            if val=='front':
                img_path = self.img_front
                segImg=self.seg_front
            else:
                img_path = self.img_back
                segImg=self.seg_back
            map_net_pth = 'create_texture/map_'+ self.clothType +"_"+val+".pt"
            self.net_map.load_state_dict(torch.load(map_net_pth,map_location='cpu'))
            self.net_map.to(self.device)
            self.net_map.eval()
            ret, bw_img = cv2.threshold(segImg, 127, 255, cv2.THRESH_BINARY)
            bw_img=cv2.resize(bw_img,(256,256))
            bw_img=torch.from_numpy(bw_img)
            bw_img = bw_img.unsqueeze(0)
            image = self.read_images(img_path)
            map_in = self.get_img_rep(bw_img)
            map_in = map_in.to(self.device)
            map_in=map_in[:,0,:,:,:]
            out = self.net_map(map_in)
            out = out.permute(0, 2, 3, 1)
            uv_out = F.grid_sample(image, out)
            setattr(self, 'uv_'+ val, tensor2image(uv_out[0, :, :, :]))

    def combine_textures(self,id):
        if self.clothType=='shirts':
            val='up'
        else:
            val='low'
        cut1 = getattr(self, 'uv_'+'front')
        cut2 = getattr(self, 'uv_' + 'back')
        base = np.zeros((2000, 2000, 3))
        cut1 = cv2.resize(cut1, (1000, 1000))
        cut2 = cv2.resize(cut2, (1000, 1000))
        base = base.astype('float64')
        base[500:1500, 0:1000] = cut1
        base[500:1500, 1000:2000] = cut2
        cv2.imwrite('texture_'+str(id)+'.jpg', base)

    def run(self,id):
        self.forward()
        self.combine_textures(id)

def createTexture(clothType,frontImagePath,backImagePath,frontSeg,backSeg,id):
    demo = Demo(clothType,frontImagePath,backImagePath,frontSeg,backSeg)
    demo.run(id)

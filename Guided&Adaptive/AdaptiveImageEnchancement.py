import cv2
import numpy as np



def contrast_demo(img1, c, b):  # 亮度就是每个像素所有通道都加上b
    rows, cols, chunnel = img1.shape
    blank = np.zeros([rows, cols, chunnel], img1.dtype)  # np.zeros(img1.shape, dtype=uint8)
    dst = cv2.addWeighted(img1, c, blank, 1 - c, b)
    cv2.imshow("con_bri_demo", dst)
#   imgpixel2 = dst[500, 500];
#   print(imgpixel2)

img1 = cv2.imread(r"4.bmp", cv2.IMREAD_COLOR)

#img2 = cv2.imread(r"gugong1.bmp", cv2.IMREAD_COLOR)
# imgpixel1 = img1[500, 500];
# print(imgpixel1)
# print (img1.shape)
#width = img1.shape[0]     #长度
#height = img1.shape[1]     #宽度
#for i in range(1, width):
#    for j in range(1, height):
#        if img2[i,j]:
#            contrast_demo(img1[i,j], 1.2, 10)
#        else:
#           contrast_demo(img1[i,j], 1, 3)

contrast_demo(img1, 1.2, 5)

cv2.waitKey(0)
cv2.destroyAllWindows()
from imutils.video import VideoStream
from MYFPS import FPS
import numpy as np
import argparse
import imutils
import pickle
import time
import cv2
import os
import sys
from PIL import Image


ap = argparse.ArgumentParser()
ap.add_argument("-f", "--folder", required = True,
	help = "path to folder to output the scans to.")
ap.add_argument("-s", "--seconds", type = float, default = 5,
	help = "time for scan to take place")

args = vars(ap.parse_args())
vs = VideoStream(src = 0).start()
time.sleep(2.0)

fps = FPS().start()
scan_count = 1

if not os.path.isdir(args["folder"]):
	os.system("mkdir " + args['folder'])

while fps.elapsed() < args["seconds"]:
	frame = vs.read()
	frame  = imutils.resize(frame, width = 600)
	path = os.path.join(args["folder"], "scan" + str("%0d" % scan_count) + ".png")
	frame = frame[:, :, [2, 1, 0]]
	gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
	fm = cv2.Laplacian(gray, cv2.CV_64F).var()


	cv2.putText(gray, "{:.2f}".format(fm), (10, 300),
	cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 0, 255), 3)
	cv2.imshow("Image", gray)
	if fm > .6:
		img = Image.fromarray(frame, "RGB")
		key = cv2.waitKey(1) & 0xFF
		img.save(path)
		scan_count += 1


vs.stop()



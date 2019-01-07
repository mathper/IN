import numpy as np
import cv2
import imutils
from imutils import paths

path = list(paths.list_images('D://Documents/UV/INFO 05/Projet IN/Data/'))

for img in path:

	# load the image
	image = cv2.imread(img)

	image = imutils.resize(image, width=1000) #(0, 0), fx=0.4, fy=0.4)

	# define the list of boundaries
	boundaries = [
		#([100, 0, 0], [255, 250, 150]),
		([150, 0, 0], [255, 250, 100]),
		#([150, 0, 0], [255, 250, 150]),
	]

	# loop over the boundaries
	for (lower, upper) in boundaries:
		# create NumPy arrays from the boundaries
		lower = np.array(lower, dtype="uint8")
		upper = np.array(upper, dtype="uint8")

		# find the colors within the specified boundaries and apply
		# the mask
		mask = cv2.inRange(image, lower, upper)
		mask = cv2.morphologyEx(mask, cv2.MORPH_GRADIENT, kernel=cv2.getStructuringElement(cv2.MORPH_RECT, (5, 5)))
		output = cv2.bitwise_and(image, image, mask = mask)

		# show the images
		cv2.imshow("images", np.hstack([image, output]))
		cv2.waitKey(0)
import numpy as np
from skimage import io
import os
from sklearn.cluster import KMeans
from skimage.viewer import canvastools as can

classes = {'pool': 1, 'other': 2}
nb = len(classes)
palette = np.uint8([[0, 0, 0], [255, 255, 255]])

images = []
path = 'data/trainer/P0458.png'
#for filename in os.listdir(path):
img = io.imread(path) #os.path.join(path, filename))
rows, cols, bands = img.shape
X = img.reshape(rows*cols, bands)
#can.PaintTool()
kmeans = KMeans(n_clusters=nb, random_state=0).fit(X)
unsupervised = kmeans.labels_.reshape(rows, cols)
io.imshow(palette[unsupervised])
io.show()
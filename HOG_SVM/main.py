import numpy as np
from skimage import io
import os
from sklearn.cluster import KMeans
from skimage.viewer import canvastools as can

classes = {'other': 0, 'pool': 1}
nb = len(classes)
palette = np.uint8([[0, 0, 0], [255, 255, 255]])

images = []
path = 'data/trainer/P0458.png'
path2 = 'data/trainer/P0458.txt'
#for filename in os.listdir(path):
img = io.imread(path) #os.path.join(path, filename))
rows, cols, bands = img.shape

# Unsupervised classification
X = img.reshape(rows*cols, bands)
#can.PaintTool()
kmeans = KMeans(n_clusters=nb, random_state=0).fit(X)
unsupervised = kmeans.labels_.reshape(rows, cols)
io.imshow(palette[unsupervised])
io.show()

# Supervised classification
supervised = nb*np.ones(shape=(rows, cols), dtype=np.int)
with open(path2) as f :
   for line in f :
      supervised[line] = classes['pool']

y = supervised.ravel()
train = np.flatnonzero(supervised < nb)
test = np.flatnonzero(supervised == nb)

from sklearn.svm import SVC
clf = SVC()
clf.fit(X[train], y[train])
y[test] = clf.predict(X[test])
supervised = y.reshape(rows, cols)
io.imshow(palette[supervised])
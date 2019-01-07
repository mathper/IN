import random
import numpy as np

WINDOW_SIZE = [178, 218]
WINDOW_STEP_SIZE = 20
ORIENTATIONS = 9
PIXELS_PER_CELL = [8, 8]
CELLS_PER_BLOCK = [3, 3]
VISUALISE = False
NORMALISE = None
THRESHOLD = 0.4
MODEL_PATH = 'sgd_svm_10000_10000_1.model'
PYRAMID_DOWNSCALE = 1.5
POS_SAMPLES = 1000
NEG_SAMPLES = 1000
RANDOM_STATE = 31
random.seed(RANDOM_STATE)
np.random.seed(RANDOM_STATE)

from rpy2.robjects import r, pandas2ri
import pandas as pd
import numpy as np

pandas2ri.activate()
path = 'C:/Users/micha/OneDrive/Skrivebord/02445-Project/Data/armdata.rdata'
robj = r.load(path)

data = np.array(r['armdata'])
data[0:1]
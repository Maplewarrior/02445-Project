import numpy as np

########################################################     For (y,z) coordinates

optimal_trees_yz = [525, 300, 300, 225, 675, 75, 675, 675, 150, 300,
                    150, 300, 150, 300, 150, 600, 600, 75, 750, 600,
                    300, 750, 600, 450, 375, 75, 450, 600, 225, 525]

E_gen_RF_final_yz = np.array([
       [0.78125],[0.76875],[0.80625],[0.74375], [0.8    ],[0.7375 ],[0.725  ],[0.75625],[0.75625],[0.7875 ],
       [0.71875],[0.80625],[0.76875],[0.8125 ], [0.73125],[0.73125],[0.74375],[0.75   ],[0.79375], [0.775  ],
       [0.7    ],[0.79375],[0.69375],[0.74375],[0.7625 ],[0.7875 ],[0.775  ],[0.76875],[0.79375],[0.81875]])


optimal_hidden_units_yz = [
                           [11, 6, 9, 11, 10, 8, 3, 10, 11, 7],
                           11, 10, 10, 10, 10, 11, 10, 9, 7, 9,
                           8, 7, 8, 7, 10, 7, 9, 11, 10, 10]

E_gen_ANN_final_yz = np.array([
   [0.86875],[0.8375 ],[0.8125 ],[0.80625], [0.79375],[0.7875 ],[0.8125 ],[0.81875],[0.8375 ],[0.8375 ],
   [0.775  ],[0.85   ],[0.85   ],[0.7875 ],[0.81875],[0.8125 ],[0.8    ],[0.78125],[0.8375 ],[0.84375],
    [0.84375],[0.825  ],[0.81875],[0.83125],[0.8375 ],[0.775  ],[0.84375],[0.8375 ],[0.825  ],[0.7875 ]])

optimal_lambdas_yz = [
                       1e-07, 1e-06, 1e-07, 10.0, 10.0, 1e-06, 10.0, 1e-06, 0.1, 1.0,
                       1e-06, 10.0, 10.0, 1e-08, 0.1, 10.0, 10.0, 1e-07, 1e-05, 0.0001,                   
                      1e-08, 1e-08, 0.001, 1e-07, 0.1, 1e-05, 0.01, 1e-07, 10.0, 0.0001]
E_gen_LogReg_final_yz = np.array([
    [0.7875 ],[0.75625],[0.75625],[0.7875 ],[0.7875 ],[0.725  ],[0.75625],[0.76875],[0.83125],[0.775  ],
    [0.75625],[0.83125],[0.7125 ], [0.7875 ], [0.775  ],[0.78125],[0.74375],[0.75625], [0.775  ],[0.775 ],
    [0.7875 ], [0.80625],[0.75625],[0.78125],[0.74375],[0.8    ],[0.7875 ],[0.775  ], [0.7625 ],[0.78125]])

#########################################################    For (x,z) 

optimal_trees_xz = [300, 450, 150, 300, 375, 525, 375, 75 , 300, 450,
                    450, 375, 450, 150, 600, 375, 150, 75, 150, 300,
                    375, 300, 375, 525, 600, 300, 150, 750, 150, 300]
E_gen_RF_final_xz = np.array([
    [0.73125],[0.73125],[0.70625],[0.68125],[0.6625 ],[0.75   ],[0.75   ],[0.6875 ],[0.7625 ],[0.7    ],
    [0.725  ],[0.7375 ],[0.68125],[0.75   ],[0.75625],[0.7    ],[0.7375 ],[0.7125 ],[0.71875],[0.70625], 
    [0.7625],[0.7375],[0.71875],[0.6875],[0.75625],[0.775],[0.6625],[0.70625], [0.725], [0.7315]])

optimal_hidden_units_xz = [4, 5, 2, 7, 4, 4, 6, 9 ,5 , 7,
                           9, 5, 8, 3, 3, 5, 3, 7, 11, 10,
                           4, 11, 10, 6, 7, 7, 4, 7, 4, 5]
E_gen_ANN_final_xz = np.array([
    [0.73125],[0.73125],[0.7625 ],[0.71875],[0.79375],[0.76875],[0.7875 ],[0.76875],[0.775  ],[0.9375 ],
    [0.775  ],[0.75625],[0.74375],[0.73125],[0.79375],[0.79375],[0.7125 ],[0.725  ],[0.80625],[0.71875],
    [0.75625],[0.76875],[0.775  ],[0.7875 ],[0.7875 ],[0.8    ],[0.775  ],[0.74375], [0.675  ],[0.775  ]])

optimal_lambdas_xz = [1e-08, 1.0, 0.01, 1.0, 0.1, 1e-05, 10.0, 1e-08 , 0.01, 1.0,
                      1.0, 1e-05, 1e-06, 1.0, 10.0, 1e-05, 0.1, 1e-07, 1.0, 1.0, 
                      0.01, 1.0, 1e-8, 1e-8, 0.1, 10, 0.0001, 0.01, 1e-06, 1e-07 ]
E_gen_LogReg_final_xz = np.array([
       [0.76875],[0.79375],[0.75625],[0.79375],[0.7375 ],[0.7375 ],[0.78125],[0.6875 ],[0.775  ],[0.71875],
       [0.75   ],[0.74375],[0.75   ],[0.775  ],[0.79375],[0.7    ],[0.75   ],[0.75625],[0.775  ],[0.7875 ],
       [0.75625],[0.74375],[0.76875],[0.75   ],[0.7    ],[0.80625],[0.75   ],[0.75   ],[0.73125],[0.80625]])



############ For (x,y,z) 
optimal_trees_xyz = [375, 300, 300, 450, 525, 300, 150, 525 , 375, 375,
                     750, 600, 750, 675, 525, 375, 300, 675, 450, 525,
                     375, 600, 375, 225, 750, 600, 750, 300, 225, 750]
E_gen_RF_final_xyz = np.array([
    [0.4875], [0.49375], [0.425],[0.475], [0.49375], [0.475], [0.50625], [0.5], [0.55625],[0.46875],
    [0.4625 ],[0.50625],[0.49375],[0.49375],[0.56875],[0.5375 ],[0.46875],[0.55625],[0.5375 ],[0.5    ],
    [0.5    ],[0.5375 ],[0.525  ],[0.51875],[0.50625],[0.41875],[0.53125],[0.56875],[0.49375], [0.5    ]])


optimal_hidden_units_xyz = [6, 6, 4, 4, 8, 2, 2, 4 , 4, 2,
                            5, 3, 4, 6, 3, 8, 6, 1, 6, 4,
                            5, 5, 5, 8, 6, 4, 2, 6, 9, 5]
E_gen_ANN_final_xyz = np.array([
    [0.50625],[0.45625],[0.49375],[0.4625],[0.475],[0.5125],[0.5125],[0.425],[0.5375],[0.43125],
    [0.49375],[0.50625],[0.45625],[0.4375 ],[0.4625 ],[0.5375 ], [0.50625],[0.5    ],[0.4625 ],[0.54375],
    [0.4625 ],[0.48125],[0.45625],[0.49375],[0.475  ],[0.44375],[0.5    ],[0.60625],[0.5375 ],[0.50625]])


optimal_lambdas_xyz = [1e-08, 1e-06, 10, 0.001, 100, 1e-05, 1e-08, 1e-08, 100, 1e-08,
                       1e-08, 1e-08, 1e-06, 10.0, 1.0, 0.1, 1e-08, 10.0, 10.0, 1e-06,
                       1e-07, 10.0, 1.0, 10.0, 1e-08, 1.0, 10.0, 10.0, 1e-07, 1e-06]


E_gen_LogReg_final_xyz = np.array([
    [0.50625],[0.49375],[0.475],[0.49375],[0.45],[0.51875],[0.4375],[0.45],[0.5125],[0.44375   ],
    [0.4875 ],[0.5125 ],[0.43125],[0.45625],[0.46875],[0.5    ],[0.45625],[0.475  ],[0.44375],[0.53125],
    [0.4375 ],[0.4625 ], [0.4875 ],[0.41875],[0.4625 ],[0.41875],[0.50625],[0.54375],[0.5125 ],[0.4875 ]])


######## For (x,y)
optimal_trees_xy = [525, 675, 450, 525, 300, 525, 150, 300, 375, 750,
                    450, 375, 75, 675, 525, 375, 300, 600, 375, 375,
                    600, 525, 225, 450, 225, 450, 450, 600, 450, 525
                    ]
E_gen_RF_final_xy = np.array([
    0.7375, 0.79375, 0.775, 0.75625, 0.75625, 0.7875, 0.71875, 0.7625, 0.73125, 0.725 ,
    0.7125, 0.7375, 0.73125, 0.80625, 0.71875, 0.750, 0.71875, 0.69375, 0.7625, 0.7125,
    0.775, 0.73125, 0.6875, 0.74375, 0.75625, 0.79375, 0.73125, 0.74375,0.73125, 0.725])

optimal_hidden_units_xy = [4, 1, 1, 4, 2, 2, 4, 3, 1, 7,
                           1, 2, 1, 2, 8, 1, 1, 2, 3, 1,
                           8, 2, 3, 2, 1, 2, 2, 2, 4, 4
                           ]
E_gen_ANN_final_xy = np.array([[0.71875, 0.7, 0.7625, 0.7375, 0.75, 0.71875, 0.75, 0.7377, 0.675, 0.69375, 
                               0.74375, 0.78125, 0.7375, 0.75625, 0.6875, 0.70625, 0.71875, 0.76875, 0.70825, 0.71875,
                               0.75625, 0.7375, 0.7625, 0.71875,0.70125, 0.75, 0.725, 0.7125, 0.675, 0.73125]])

optimal_lambdas_xy = [10, 1, 1e-6, 10, 1e-7, 1e-6, 10, 1e-6, 1e-8, 1,
                      1e-7, 10, 1e-5, 1e-8, 1e-8, 1, 1e-8, 1, 10, 1, 
                      0.01, 10.0, 10.0, 1e-08, 1e-08, 1e-08, 1e-08, 1.0, 1.0, 1e-08]

E_gen_LogReg_final_xy = np.array([0.69375, 0.7125, 0.74375, 0.68125, 0.65625, 0.7375, 0.70625, 0.7125, 0.66875, 0.71875,
                                 0.7125, 0.7125, 0.7125, 0.7, 0.65625, 0.70625, 0.7, 0.6875, 0.65625, 0.69375,
                                 0.7375, 0.725, 0.6625, 0.6875,0.6625, 0.71875, 0.725, 0.71875, 0.6875, 0.7])


#%%
import scipy.stats as st

# Pairwise correlated t-test for (x,y,z)

def conf_int(z_obs, alpha,  sigma):
    CI_lower = st.t.ppf(alpha/2,len(z_obs), np.mean(z_obs), sigma)
    CI_upper = st.t.ppf(1-(alpha/2),len(z_obs), np.mean(z_obs), sigma)
    return CI_lower, CI_upper 


dif_RF_ANN_xyz = E_gen_RF_final_xyz - E_gen_ANN_final_xyz
dif_RF_lr_xyz = E_gen_RF_final_xyz - E_gen_LogReg_final_xyz
dif_ANN_lr_xyz = E_gen_ANN_final_xyz - E_gen_LogReg_final_xyz

J, K = 30, 10

# Compute means 
r_hat1 = np.mean(dif_RF_ANN_xyz)
r_hat2 = np.mean(dif_RF_lr_xyz)
r_hat3 = np.mean(dif_ANN_lr_xyz)


s_hat_sq_1 = (1/(J-1))*((dif_RF_ANN_xyz - r_hat1)**2).sum()
s_hat_sq_2 = (1/(J-1))*((dif_RF_lr_xyz - r_hat2)**2).sum()
s_hat_sq_3 = (1/(J-1))*((dif_ANN_lr_xyz - r_hat3)**2).sum()

s_thilde_sq_1 = (1/J + 1/(K-1))*s_hat_sq_1
s_thilde_sq_2 = (1/J + 1/(K-1))*s_hat_sq_2
s_thilde_sq_3 = (1/J + 1/(K-1))*s_hat_sq_3


# Confidence intervals

C1_lower, C1_upper = conf_int(dif_RF_ANN_xyz, alpha=0.05, sigma = np.sqrt(s_thilde_sq_1))
C2_lower, C2_upper = conf_int(dif_RF_lr_xyz, alpha=0.05, sigma = np.sqrt(s_thilde_sq_2))
C3_lower, C3_upper = conf_int(dif_ANN_lr_xyz, alpha=0.05, sigma = np.sqrt(s_thilde_sq_3))

# Computing test statistics
rho = 1/K

t_hat1 = r_hat1/(np.sqrt(s_hat_sq_1)* np.sqrt(1/J + rho/(1-rho)))
t_hat2 = r_hat2/(np.sqrt(s_hat_sq_2)* np.sqrt(1/J + rho/(1-rho)))
t_hat3 = r_hat3/(np.sqrt(s_hat_sq_3)* np.sqrt(1/J + rho/(1-rho)))

p1 = 2*st.t.cdf(-abs(t_hat1), J-1, 0, 1)
p2 = 2*st.t.cdf(-abs(t_hat2), J-1, 0, 1)
p3 = 2*st.t.cdf(-abs(t_hat3), J-1, 0, 1)

print("for (x,y,z) coordinates: \n")

print("RF vs ANN: ", (C1_lower, C1_upper), p1)

print("RF vs. LogReg: ", (C2_lower, C2_upper), p2)

print("ANN vs. LogReg: ", (C3_lower, C3_upper), p3)

#%%

# For (x,y)
dif_RF_ANN_xy = E_gen_RF_final_xy - E_gen_ANN_final_xy
dif_RF_lr_xy = E_gen_RF_final_xy - E_gen_LogReg_final_xy
dif_ANN_lr_xy = E_gen_ANN_final_xy - E_gen_LogReg_final_xy

J, K = 30, 10

# Compute means 
r_hat1 = np.mean(dif_RF_ANN_xy)
r_hat2 = np.mean(dif_RF_lr_xy)
r_hat3 = np.mean(dif_ANN_lr_xy)


s_hat_sq_1 = (1/(J-1))*((dif_RF_ANN_xy - r_hat1)**2).sum()
s_hat_sq_2 = (1/(J-1))*((dif_RF_lr_xy - r_hat2)**2).sum()
s_hat_sq_3 = (1/(J-1))*((dif_ANN_lr_xy - r_hat3)**2).sum()

s_thilde_sq_1 = (1/J + 1/(K-1))*s_hat_sq_1
s_thilde_sq_2 = (1/J + 1/(K-1))*s_hat_sq_2
s_thilde_sq_3 = (1/J + 1/(K-1))*s_hat_sq_3


# Confidence intervals

C1_lower, C1_upper = conf_int(dif_RF_ANN_xy, alpha=0.05, sigma = np.sqrt(s_thilde_sq_1))
C2_lower, C2_upper = conf_int(dif_RF_lr_xy, alpha=0.05, sigma = np.sqrt(s_thilde_sq_2))
C3_lower, C3_upper = conf_int(dif_ANN_lr_xy, alpha=0.05, sigma = np.sqrt(s_thilde_sq_3))

# Computing test statistics
rho = 1/K

t_hat1 = r_hat1/(np.sqrt(s_hat_sq_1)* np.sqrt(1/J + rho/(1-rho)))
t_hat2 = r_hat2/(np.sqrt(s_hat_sq_2)* np.sqrt(1/J + rho/(1-rho)))
t_hat3 = r_hat3/(np.sqrt(s_hat_sq_3)* np.sqrt(1/J + rho/(1-rho)))

p1 = 2*st.t.cdf(-abs(t_hat1), J-1, 0, 1)
p2 = 2*st.t.cdf(-abs(t_hat2), J-1, 0, 1)
p3 = 2*st.t.cdf(-abs(t_hat3), J-1, 0, 1)

print("for (x,y) coordinates: \n")

print("RF vs ANN: ", (C1_lower, C1_upper), p1)

print("RF vs. LogReg: ", (C2_lower, C2_upper), p2)

print("ANN vs. LogReg: ", (C3_lower, C3_upper), p3)


#%%

# For (x,z)


dif_RF_ANN_xz = E_gen_RF_final_xz - E_gen_ANN_final_xz
dif_RF_lr_xz = E_gen_RF_final_xz - E_gen_LogReg_final_xz
dif_ANN_lr_xz = E_gen_ANN_final_xz - E_gen_LogReg_final_xz

J, K = 30, 10

# Compute means 
r_hat1 = np.mean(dif_RF_ANN_xz)
r_hat2 = np.mean(dif_RF_lr_xz)
r_hat3 = np.mean(dif_ANN_lr_xz)


s_hat_sq_1 = (1/(J-1))*((dif_RF_ANN_xz - r_hat1)**2).sum()
s_hat_sq_2 = (1/(J-1))*((dif_RF_lr_xz - r_hat2)**2).sum()
s_hat_sq_3 = (1/(J-1))*((dif_ANN_lr_xz - r_hat3)**2).sum()

s_thilde_sq_1 = (1/J + 1/(K-1))*s_hat_sq_1
s_thilde_sq_2 = (1/J + 1/(K-1))*s_hat_sq_2
s_thilde_sq_3 = (1/J + 1/(K-1))*s_hat_sq_3


# Confidence intervals

C1_lower, C1_upper = conf_int(dif_RF_ANN_xz, alpha=0.05, sigma = np.sqrt(s_thilde_sq_1))
C2_lower, C2_upper = conf_int(dif_RF_lr_xz, alpha=0.05, sigma = np.sqrt(s_thilde_sq_2))
C3_lower, C3_upper = conf_int(dif_ANN_lr_xz, alpha=0.05, sigma = np.sqrt(s_thilde_sq_3))

# Computing test statistics
rho = 1/K

t_hat1 = r_hat1/(np.sqrt(s_hat_sq_1)* np.sqrt(1/J + rho/(1-rho)))
t_hat2 = r_hat2/(np.sqrt(s_hat_sq_2)* np.sqrt(1/J + rho/(1-rho)))
t_hat3 = r_hat3/(np.sqrt(s_hat_sq_3)* np.sqrt(1/J + rho/(1-rho)))

p1 = 2*st.t.cdf(-abs(t_hat1), J-1, 0, 1)
p2 = 2*st.t.cdf(-abs(t_hat2), J-1, 0, 1)
p3 = 2*st.t.cdf(-abs(t_hat3), J-1, 0, 1)

print("for (x,z) coordinates: \n")

print("RF vs ANN: ", (C1_lower, C1_upper), p1)

print("RF vs. LogReg: ", (C2_lower, C2_upper), p2)

print("ANN vs. LogReg: ", (C3_lower, C3_upper), p3)

#%%

# For (y,z)

dif_RF_ANN_yz = E_gen_RF_final_yz - E_gen_ANN_final_yz
dif_RF_lr_yz = E_gen_RF_final_yz - E_gen_LogReg_final_yz
dif_ANN_lr_yz = E_gen_ANN_final_yz - E_gen_LogReg_final_yz

J, K = 30, 10

# Compute means 
r_hat1 = np.mean(dif_RF_ANN_yz)
r_hat2 = np.mean(dif_RF_lr_yz)
r_hat3 = np.mean(dif_ANN_lr_yz)


s_hat_sq_1 = (1/(J-1))*((dif_RF_ANN_yz - r_hat1)**2).sum()
s_hat_sq_2 = (1/(J-1))*((dif_RF_lr_yz - r_hat2)**2).sum()
s_hat_sq_3 = (1/(J-1))*((dif_ANN_lr_yz - r_hat3)**2).sum()

s_thilde_sq_1 = (1/J + 1/(K-1))*s_hat_sq_1
s_thilde_sq_2 = (1/J + 1/(K-1))*s_hat_sq_2
s_thilde_sq_3 = (1/J + 1/(K-1))*s_hat_sq_3


# Confidence intervals

C1_lower, C1_upper = conf_int(dif_RF_ANN_yz, alpha=0.05, sigma = np.sqrt(s_thilde_sq_1))
C2_lower, C2_upper = conf_int(dif_RF_lr_yz, alpha=0.05, sigma = np.sqrt(s_thilde_sq_2))
C3_lower, C3_upper = conf_int(dif_ANN_lr_yz, alpha=0.05, sigma = np.sqrt(s_thilde_sq_3))

# Computing test statistics
rho = 1/K

t_hat1 = r_hat1/(np.sqrt(s_hat_sq_1)* np.sqrt(1/J + rho/(1-rho)))
t_hat2 = r_hat2/(np.sqrt(s_hat_sq_2)* np.sqrt(1/J + rho/(1-rho)))
t_hat3 = r_hat3/(np.sqrt(s_hat_sq_3)* np.sqrt(1/J + rho/(1-rho)))

p1 = 2*st.t.cdf(-abs(t_hat1), J-1, 0, 1)
p2 = 2*st.t.cdf(-abs(t_hat2), J-1, 0, 1)
p3 = 2*st.t.cdf(-abs(t_hat3), J-1, 0, 1)

print("for (y,z) coordinates: \n")

print("RF vs ANN: ", (C1_lower, C1_upper), p1)

print("RF vs. LogReg: ", (C2_lower, C2_upper), p2)

print("ANN vs. LogReg: ", (C3_lower, C3_upper), p3)


D#%%

# For difference in coordinates 


dif_lr_xyz_and_RF_xz = E_gen_LogReg_final_xyz - E_gen_RF_final_xz

dif_lr_xyz_and_lr_xy = E_gen_LogReg_final_xyz - E_gen_LogReg_final_xy

dif_lr_xyz_and_lr_yz = E_gen_LogReg_final_xyz - E_gen_LogReg_final_yz 



J, K = 30, 10

# Compute means 
r_hat1 = np.mean(dif_lr_xyz_and_RF_xz)
r_hat2 = np.mean(dif_lr_xyz_and_lr_xy)
r_hat3 = np.mean(dif_lr_xyz_and_lr_yz)


s_hat_sq_1 = (1/(J-1))*((dif_lr_xyz_and_RF_xz - r_hat1)**2).sum()
s_hat_sq_2 = (1/(J-1))*((dif_lr_xyz_and_lr_xy - r_hat2)**2).sum()
s_hat_sq_3 = (1/(J-1))*((dif_lr_xyz_and_lr_yz - r_hat3)**2).sum()

s_thilde_sq_1 = (1/J + 1/(K-1))*s_hat_sq_1
s_thilde_sq_2 = (1/J + 1/(K-1))*s_hat_sq_2
s_thilde_sq_3 = (1/J + 1/(K-1))*s_hat_sq_3


# Confidence intervals

C1_lower, C1_upper = conf_int(dif_lr_xyz_and_RF_xz, alpha=0.05, sigma = np.sqrt(s_thilde_sq_1))
C2_lower, C2_upper = conf_int(dif_lr_xyz_and_lr_xy, alpha=0.05, sigma = np.sqrt(s_thilde_sq_2))
C3_lower, C3_upper = conf_int(dif_lr_xyz_and_lr_yz, alpha=0.05, sigma = np.sqrt(s_thilde_sq_3))

# Computing test statistics
rho = 1/K

t_hat1 = r_hat1/(np.sqrt(s_hat_sq_1)* np.sqrt(1/J + rho/(1-rho)))
t_hat2 = r_hat2/(np.sqrt(s_hat_sq_2)* np.sqrt(1/J + rho/(1-rho)))
t_hat3 = r_hat3/(np.sqrt(s_hat_sq_3)* np.sqrt(1/J + rho/(1-rho)))

p1 = 2*st.t.cdf(-abs(t_hat1), J-1, 0, 1)
p2 = 2*st.t.cdf(-abs(t_hat2), J-1, 0, 1)
p3 = 2*st.t.cdf(-abs(t_hat3), J-1, 0, 1)

print("Comparision of coordinates: \n")

print("(x,y,z) vs. (x,z): ", (C1_lower, C1_upper), p1)

print("(x,y,z) vs. (x,y): ", (C2_lower, C2_upper), p2)

print("(x,y,z) vs. (y,z): ", (C3_lower, C3_upper), p3)


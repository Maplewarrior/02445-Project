# Data preprocessing for 3-way ANOVA 

load("armdata.RData")

# e experiments: 1:16
# p people: 1:10
# r repetitions: 1:10
# i measurements: 1:300

data_all_exps <- c(NA, 16*10*10*300)
count = 1
for (e in 1:16){
  for (p in 1:10){
    for (r in 1:10){
      for (i in 1:300){
        data_all_exps[count] <- armdata[[e]][[p]][[r]][[i]]
        count = count+1
      }
    }
  }
}
vec_experiments <- c(rep("e1", 30000), rep("e2", 30000),rep("e3", 30000),rep("e4", 30000),rep("e5", 30000),rep("e6", 30000),
                     rep("e7", 30000),rep("e8", 30000),rep("e9", 30000),rep("e10", 30000),rep("e11", 30000),rep("e12", 30000),
                     rep("e13", 30000),rep("e14", 30000),rep("e15", 30000),rep("e16", 30000))

people <- c(rep("p1", 3000), rep("p2", 3000),rep("p3", 3000),rep("p4", 3000),rep("p5", 3000),rep("p6", 3000),
                rep("p7", 3000),rep("p8", 3000),rep("p9", 3000),rep("p10", 3000))

vec_people <- c(rep(people, 16))

x_coords <- c(rep("x",100))
y_coords <- c(rep("y",100))
z_coords <- c(rep("z",100))

vec_coords <- c(rep(c(x_coords,y_coords,z_coords),1600))

df_all <- data.frame(data_all_exps, vec_experiments, vec_coords, vec_people)

# Test
# df_all$data_all_exps[384206]
# df_all$data_all_exps[384205]
# df_all$data_all_exps[384204]
# df_all$data_all_exps[384203]
# df_all$data_all_exps[384202]
# df_all$data_all_exps[384201]

# Remove NaN's from df_all
num_nans <- length(is.na(df_all$data_all_exps)[is.na(df_all$data_all_exps) == T])
nan_indexes <- which(is.na(df_all$data_all_exps), arr.ind = T, useNames=F)
  
# test_index = nan_indexes[1]
# test_index

# test = T
# if (df_all$vec_coords[test_index] == df_all$vec_coords[test_index+1]){
#   if (test == T){print("success")
#   }
# }
# is.na(df_all$data_all_exps[test_index])

for (i in 1:num_nans){
  below = FALSE
  below_2 = FALSE
  above = FALSE
  index = nan_indexes[i]
  
  below_value = df_all$data_all_exps[index+1]
  below_2_value = df_all$data_all_exps[index+2]
  above_value = df_all$data_all_exps[index-1]
  
  # Check if the below value of a NaN is also a NaN
  if (df_all$vec_coords[index] == df_all$vec_coords[index+1]){
  if (is.na(below_value) == FALSE){
    below = TRUE
  }}
  if (df_all$vec_coords[index] == df_all$vec_coords[index+2]){
  if (is.na(below_value_2) ==FALSE) {
    below_2 = TRUE}}
  
  # Check if the above value of a NaN is not a NaN
  if (df_all$vec_coords[index] == df_all$vec_coords[index-1]){
    if (is.na(above_value) == FALSE){
      above = TRUE
    }}
  
  if (above == T && below ==T){
    df_all$data_all_exps[index] = (below_value + above_value)/2
    }
  if (above == T && below == F){
    df_all$data_all_exps[index] = above_value
  }
  if (below == T && above == F){
    df_all$data_all_exps[index] = below_value
  }
  if (below == F && below_2 == T){
    df_all$data_all_exps[index] = below_2_value
  }
}
# Check the number of remanining NaN values
#length(is.na(df_all$data_all_exps)[is.na(df_all$data_all_exps) == T])

# Get the indices of the remaining NaN values
new_nan_indexes <- which(is.na(df_all$data_all_exps), arr.ind = T, useNames=F)

# Replace the remaining NaN values with the previous valid value.
for (i in length(new_nan_indexes):1){
  index <- new_nan_indexes[i]
  print(index)
  df_all$data_all_exps[index] <- df_all$data_all_exps[index+1]
}

# Test if the replacing was done correctly (index 384204 and below were all originally NaN's)
# df_all$data_all_exps[384206]
# df_all$data_all_exps[384205]
# df_all$data_all_exps[384204]
# df_all$data_all_exps[384203]
# df_all$data_all_exps[384202]
# df_all$data_all_exps[384201]


# Save dataframe as a .csv file

write.csv(df_all, "C:\\Users\\micha\\OneDrive\\Skrivebord\\02445-Project\\Data\\armdataPreprocessed.csv", row.names = F)

# Save a .csv file containing all labels
distances <- c(rep("15", 90000), rep("22.5",90000),rep("30",90000),rep("37.5",90000), rep("45",90000), rep(NA, 30000))
distances[449999:450001]

obstacle <- c(rep("S", 30000), rep("M", 30000), rep("L", 30000))
obstacles <-c(rep(obstacle, 5), rep(NA, 30000))

df_all_labels <- data.frame(data_all_exps, vec_experiments, vec_coords, vec_people, distances, obstacles)
write.csv(df_all, "C:\\Users\\micha\\OneDrive\\Skrivebord\\02445-Project\\Data\\armdataPreprocessedAllLabels.csv", row.names = F)





# Delete this? 

# vec_e1_groups <- c(rep("e1_p1", 3000),rep("e1_p2", 3000),rep("e1_p3", 3000),rep("e1_p4", 3000),
#                    rep("e1_p5", 3000),rep("e1_p6", 3000),rep("e1_p7", 3000),rep("e1_p8", 3000),
#                    rep("e1_p9", 3000),rep("e1_p10", 3000))
# 
# vec_e2_groups <- c(rep("e2_p1", 3000),rep("e2_p2", 3000),rep("e2_p3", 3000),rep("e2_p4", 3000),
#                    rep("e2_p5", 3000),rep("e2_p6", 3000),rep("e2_p7", 3000),rep("e2_p8", 3000),
#                    rep("e2_p9", 3000),rep("e2_p10", 3000))
# 
# vec_e3_groups <- c(rep("e3_p1", 3000),rep("e3_p2", 3000),rep("e3_p3", 3000),rep("e3_p4", 3000),
#                    rep("e3_p5", 3000),rep("e3_p6", 3000),rep("e3_p7", 3000),rep("e3_p8", 3000),
#                    rep("e3_p9", 3000),rep("e3_p10", 3000))
# 
# vec_e4_groups <- c(rep("e4_p1", 3000),rep("e4_p2", 3000),rep("e4_p3", 3000),rep("e4_p4", 3000),
#                    rep("e4_p5", 3000),rep("e4_p6", 3000),rep("e4_p7", 3000),rep("e4_p8", 3000),
#                    rep("e4_p9", 3000),rep("e4_p10", 3000))
# 
# vec_e5_groups <- c(rep("e5_p1", 3000),rep("e5_p2", 3000),rep("e5_p3", 3000),rep("e5_p4", 3000),
#                    rep("e5_p5", 3000),rep("e5_p6", 3000),rep("e5_p7", 3000),rep("e5_p8", 3000),
#                    rep("e5_p9", 3000),rep("e5_p10", 3000))
# 
# vec_e6_groups <- c(rep("e6_p1", 3000),rep("e6_p2", 3000),rep("e6_p3", 3000),rep("e6_p4", 3000),
#                    rep("e6_p5", 3000),rep("e6_p6", 3000),rep("e6_p7", 3000),rep("e6_p8", 3000),
#                    rep("e6_p9", 3000),rep("e6_p10", 3000))
# 
# vec_e7_groups <- c(rep("e7_p1", 3000),rep("e7_p2", 3000),rep("e7_p3", 3000),rep("e7_p4", 3000),
#                    rep("e7_p5", 3000),rep("e7_p6", 3000),rep("e7_p7", 3000),rep("e7_p8", 3000),
#                    rep("e7_p9", 3000),rep("e7_p10", 3000))
# 
# vec_e8_groups <- c(rep("e8_p1", 3000),rep("e8_p2", 3000),rep("e8_p3", 3000),rep("e8_p4", 3000),
#                    rep("e8_p5", 3000),rep("e8_p6", 3000),rep("e8_p7", 3000),rep("e8_p8", 3000),
#                    rep("e8_p9", 3000),rep("e8_p10", 3000))
# 
# vec_e9_groups <- c(rep("e9_p1", 3000),rep("e9_p2", 3000),rep("e9_p3", 3000),rep("e9_p4", 3000),
#                    rep("e9_p5", 3000),rep("e9_p6", 3000),rep("e9_p7", 3000),rep("e9_p8", 3000),
#                    rep("e9_p9", 3000),rep("e9_p10", 3000))
# 
# vec_e10_groups <- c(rep("e10_p1", 3000),rep("e10_p2", 3000),rep("e10_p3", 3000),rep("e10_p4", 3000),
#                     rep("e10_p5", 3000),rep("e10_p6", 3000),rep("e10_p7", 3000),rep("e10_p8", 3000),
#                     rep("e10_p9", 3000),rep("e10_p10", 3000))
# 
# vec_e11_groups <- c(rep("e11_p1", 3000),rep("e11_p2", 3000),rep("e11_p3", 3000),rep("e11_p4", 3000),
#                     rep("e11_p5", 3000),rep("e11_p6", 3000),rep("e11_p7", 3000),rep("e11_p8", 3000),
#                     rep("e11_p9", 3000),rep("e11_p10", 3000))
# 
# vec_e12_groups <- c(rep("e12_p1", 3000),rep("e12_p2", 3000),rep("e12_p3", 3000),rep("e12_p4", 3000),
#                     rep("e12_p5", 3000),rep("e12_p6", 3000),rep("e12_p7", 3000),rep("e12_p8", 3000),
#                     rep("e12_p9", 3000),rep("e12_p10", 3000))
# 
# vec_e13_groups <- c(rep("e13_p1", 3000),rep("e13_p2", 3000),rep("e13_p3", 3000),rep("e13_p4", 3000),
#                     rep("e13_p5", 3000),rep("e13_p6", 3000),rep("e13_p7", 3000),rep("e13_p8", 3000),
#                     rep("e13_p9", 3000),rep("e13_p10", 3000))
# 
# vec_e14_groups <- c(rep("e14_p1", 3000),rep("e14_p2", 3000),rep("e14_p3", 3000),rep("e14_p4", 3000),
#                     rep("e14_p5", 3000),rep("e14_p6", 3000),rep("e14_p7", 3000),rep("e14_p8", 3000),
#                     rep("e14_p9", 3000),rep("e14_p10", 3000))
# 
# vec_e15_groups <- c(rep("e15_p1", 3000),rep("e15_p2", 3000),rep("e15_p3", 3000),rep("e15_p4", 3000),
#                     rep("e15_p5", 3000),rep("e15_p6", 3000),rep("e15_p7", 3000),rep("e15_p8", 3000),
#                     rep("e15_p9", 3000),rep("e15_p10", 3000))
# 
# vec_e16_groups <- c(rep("e16_p1", 3000),rep("e16_p2", 3000),rep("e16_p3", 3000),rep("e16_p4", 3000),rep("e16_p5", 3000),rep("e16_p6", 3000),rep("e16_p7", 3000),rep("e16_p8", 3000),
#                     rep("e16_p9", 3000),rep("e16_p10", 3000))


# vec_all_groups <- c(vec_e1_groups, vec_e2_groups, vec_e3_groups, vec_e4_groups, vec_e5_groups,
#                     vec_e6_groups, vec_e7_groups, vec_e8_groups, vec_e9_groups, vec_e10_groups,
#                     vec_e11_groups, vec_e12_groups, vec_e13_groups, vec_e14_groups, vec_e15_groups,
#                     vec_e16_groups)
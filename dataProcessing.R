# 02445 project 


# Convert data from R file to .csv
load("armdata.RData")

# 16 experiments, 10 people in each experiment that repeat the motion 10 times. 

length(armdata)

# Acesss experiments
length(armdata[[1]])

# Access people
length(armdata[[1]][[1]])
# Access repetition
length(armdata[[1]][[1]][[1]])

# Access datapoint within repetition
armdata[[1]][[1]][[1]][201:300]

X <- rnorm(5,0,1)
Y <- rnorm(5,2,1)
Lin_m <- lm(Y~X)
anova(Lin_m)$Pr[1]



# for (e in 1:length(armdata)){
#   for (p in 1:length(armdata[[1]])){
#    for (r in 1:length(armdata[[1]][[1]])){
#      for i in 1:length(armdata[[1]][[1]][[1]]){
#        
#       }
#     }
#   }
# }


# armdata[[1]][[1]][[2]]
mean(armdata[[1]][[1]][[2]][1:100])

# armdata[[1]][[1]][[2]][101:200]
# armdata[[1]][[1]][[2]][201:300]


### 1) Assess if there is a significant effect of person of the observed trajectories. 


# ANOVA on means where x, y and z are separated.

People <- list("p1","p2","p3","p4","p5","p6","p7","p8","p9","p10")
Reps <- c("r1","r2","r3","r4","r5","r6","r7","r8","r9","r10")
e1_means_x <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(Reps, People))
e1_means_y <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(Reps, People))
e1_means_z <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(Reps, People))

e2_means_x <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(Reps, People))
e2_means_y <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(Reps, People))
e2_means_z <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(Reps, People))

e3_means_x <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(Reps, People))
e3_means_y <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(Reps, People))
e3_means_z <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(Reps, People))

for (i in 1:10){
  for (j in 1:10){
    e1_means_x[j,i] <- mean(armdata[[1]][[i]][[j]][1:100])
    e1_means_y[j,i] <- mean(armdata[[1]][[i]][[j]][101:200])
    e1_means_z[j,i] <- mean(armdata[[1]][[i]][[j]][201:300])
    
    e2_means_x[j,i] <- mean(armdata[[2]][[i]][[j]][1:100])
    e2_means_y[j,i] <- mean(armdata[[2]][[i]][[j]][101:200])
    e2_means_z[j,i] <- mean(armdata[[2]][[i]][[j]][201:300])
  
    e3_means_x[j,i] <- mean(armdata[[3]][[i]][[j]][1:100])
    e3_means_y[j,i] <- mean(armdata[[3]][[i]][[j]][101:200])
    e3_means_z[j,i] <- mean(armdata[[3]][[i]][[j]][201:300])
  }
}


vec_e1_grps <- c(rep("e1_p1", 10),rep("e1_p2", 10),rep("e1_p3", 10),rep("e1_p4", 10),
                   rep("e1_p5", 10),rep("e1_p6", 10),rep("e1_p7", 10),rep("e1_p8", 10),
                   rep("e1_p9", 10),rep("e1_p10", 10))
vec_e2_grps <- c(rep("e2_p1", 10),rep("e2_p2", 10),rep("e2_p3", 10),rep("e2_p4", 10),
                 rep("e2_p5", 10),rep("e2_p6", 10),rep("e2_p7", 10),rep("e2_p8", 10),
                 rep("e2_p9", 10),rep("e2_p10", 10))

vec_e3_grps <- c(rep("e3_p1", 10),rep("e3_p2", 10),rep("e3_p3", 10),rep("e3_p4", 10),
                 rep("e3_p5", 10),rep("e3_p6", 10),rep("e3_p7", 10),rep("e3_p8", 10),
                 rep("e3_p9", 10),rep("e3_p10", 10))

vec_e1_data_x <- c(e1_means_x); vec_e1_data_y <- c(e1_means_y); vec_e1_data_z <- c(e1_means_z)
vec_e2_data_x <- c(e2_means_x); vec_e2_data_y <- c(e2_means_y); vec_e2_data_z <- c(e2_means_z)
vec_e3_data_x <- c(e3_means_x); vec_e3_data_y <- c(e3_means_y); vec_e3_data_z <- c(e3_means_z)
 
df_e1_mean_x <- data.frame(vec_e1_data_x, vec_e1_grps); df_e1_mean_y <- data.frame(vec_e1_data_y, vec_e1_grps); df_e1_mean_z <- data.frame(vec_e1_data_z, vec_e1_grps)
df_e2_mean_x <- data.frame(vec_e2_data_x, vec_e2_grps); df_e2_mean_y <- data.frame(vec_e2_data_y, vec_e2_grps); df_e2_mean_z <- data.frame(vec_e2_data_z, vec_e2_grps)
df_e3_mean_x <- data.frame(vec_e3_data_x, vec_e3_grps); df_e3_mean_y <- data.frame(vec_e3_data_y, vec_e3_grps); df_e3_mean_z <- data.frame(vec_e3_data_z, vec_e3_grps)


LM_e1_mean_x <- lm(vec_e1_data_x ~ vec_e1_grps, data = df_e1_mean_x)
LM_e1_mean_y <- lm(vec_e1_data_y ~ vec_e1_grps, data = df_e1_mean_y)
LM_e1_mean_z <- lm(vec_e1_data_z ~ vec_e1_grps, data = df_e1_mean_z)

LM_e2_mean_x <- lm(vec_e2_data_x ~ vec_e2_grps, data = df_e2_mean_x)
LM_e2_mean_y <- lm(vec_e2_data_y ~ vec_e2_grps, data = df_e2_mean_y)
LM_e2_mean_z <- lm(vec_e2_data_z ~ vec_e2_grps, data = df_e2_mean_z)

LM_e3_mean_x <- lm(vec_e3_data_x ~ vec_e3_grps, data = df_e3_mean_x)
LM_e3_mean_y <- lm(vec_e3_data_y ~ vec_e3_grps, data = df_e3_mean_y)
LM_e3_mean_z <- lm(vec_e3_data_z ~ vec_e3_grps, data = df_e3_mean_z)

anova(LM_e1_mean_x)$Pr[1]; anova(LM_e1_mean_y)$Pr[1]; anova(LM_e1_mean_z)$Pr[1]
anova(LM_e2_mean_x)$Pr[1]; anova(LM_e2_mean_y)$Pr[1]; anova(LM_e2_mean_z)$Pr[1]
anova(LM_e3_mean_x)$Pr[1]; anova(LM_e3_mean_y)$Pr[1]; anova(LM_e3_mean_z)$Pr[1]


## ANOVA for each experiment & repetition.
# Looking at each coordinate

data_e1 <- matrix(, 3000, 10)
data_e2 <- matrix(, 3000, 10)
data_e3 <- matrix(, 3000, 10)
data_e4 <- matrix(, 3000, 10)
data_e5 <- matrix(, 3000, 10)
data_e6 <- matrix(, 3000, 10)
data_e7 <- matrix(, 3000, 10)
data_e8 <- matrix(, 3000, 10)
data_e9 <- matrix(, 3000, 10)
data_e10 <- matrix(, 3000, 10)
data_e11 <- matrix(, 3000, 10)
data_e12 <- matrix(, 3000, 10)
data_e13 <- matrix(, 3000, 10)
data_e14 <- matrix(, 3000, 10)
data_e15 <- matrix(, 3000, 10)
data_e16 <- matrix(, 3000, 10)


for (i in 1:10){
  for (j in 1:10){
    data_e1[,i] <- armdata[[1]][[i]][[j]]
    data_e2[,i] <- armdata[[2]][[i]][[j]]
    data_e3[,i] <- armdata[[3]][[i]][[j]]
    data_e4[,i] <- armdata[[4]][[i]][[j]]
    data_e5[,i] <- armdata[[5]][[i]][[j]]
    data_e6[,i] <- armdata[[6]][[i]][[j]]
    data_e7[,i] <- armdata[[7]][[i]][[j]]
    data_e8[,i] <- armdata[[8]][[i]][[j]]
    data_e9[,i] <- armdata[[9]][[i]][[j]]
    data_e10[,i] <- armdata[[10]][[i]][[j]]
    data_e11[,i] <- armdata[[11]][[i]][[j]]
    data_e12[,i] <- armdata[[12]][[i]][[j]]
    data_e13[,i] <- armdata[[13]][[i]][[j]]
    data_e14[,i] <- armdata[[14]][[i]][[j]]
    data_e15[,i] <- armdata[[15]][[i]][[j]]
    data_e16[,i] <- armdata[[16]][[i]][[j]]
  }
}
vec_e1_data <- c(data_e1); vec_e2_data <- c(data_e2); vec_e3_data <- c(data_e3)
vec_e4_data <- c(data_e4); vec_e5_data <- c(data_e5); vec_e6_data <- c(data_e6)
vec_e7_data <- c(data_e7); vec_e8_data <- c(data_e8); vec_e9_data <- c(data_e9)
vec_e10_data <- c(data_e10); vec_e11_data <- c(data_e11); vec_e12_data <- c(data_e12)
vec_e13_data <- c(data_e13); vec_e14_data <- c(data_e14); vec_e15_data <- c(data_e15); vec_e16_data <- c(data_e16)

vec_e1_groups <- c(rep("e1_p1", 3000),rep("e1_p2", 3000),rep("e1_p3", 3000),rep("e1_p4", 3000),
                   rep("e1_p5", 3000),rep("e1_p6", 3000),rep("e1_p7", 3000),rep("e1_p8", 3000),
                   rep("e1_p9", 3000),rep("e1_p10", 3000))

vec_e2_groups <- c(rep("e2_p1", 3000),rep("e2_p2", 3000),rep("e2_p3", 3000),rep("e2_p4", 3000),
                   rep("e2_p5", 3000),rep("e2_p6", 3000),rep("e2_p7", 3000),rep("e2_p8", 3000),
                   rep("e2_p9", 3000),rep("e2_p10", 3000))

vec_e3_groups <- c(rep("e3_p1", 3000),rep("e3_p2", 3000),rep("e3_p3", 3000),rep("e3_p4", 3000),
                   rep("e3_p5", 3000),rep("e3_p6", 3000),rep("e3_p7", 3000),rep("e3_p8", 3000),
                   rep("e3_p9", 3000),rep("e3_p10", 3000))

vec_e4_groups <- c(rep("e4_p1", 3000),rep("e4_p2", 3000),rep("e4_p3", 3000),rep("e4_p4", 3000),
                   rep("e4_p5", 3000),rep("e4_p6", 3000),rep("e4_p7", 3000),rep("e4_p8", 3000),
                   rep("e4_p9", 3000),rep("e4_p10", 3000))

vec_e5_groups <- c(rep("e5_p1", 3000),rep("e5_p2", 3000),rep("e5_p3", 3000),rep("e5_p4", 3000),
                   rep("e5_p5", 3000),rep("e5_p6", 3000),rep("e5_p7", 3000),rep("e5_p8", 3000),
                   rep("e5_p9", 3000),rep("e5_p10", 3000))

vec_e6_groups <- c(rep("e6_p1", 3000),rep("e6_p2", 3000),rep("e6_p3", 3000),rep("e6_p4", 3000),
                   rep("e6_p5", 3000),rep("e6_p6", 3000),rep("e6_p7", 3000),rep("e6_p8", 3000),
                   rep("e6_p9", 3000),rep("e6_p10", 3000))

vec_e7_groups <- c(rep("e7_p1", 3000),rep("e7_p2", 3000),rep("e7_p3", 3000),rep("e7_p4", 3000),
                   rep("e7_p5", 3000),rep("e7_p6", 3000),rep("e7_p7", 3000),rep("e7_p8", 3000),
                   rep("e7_p9", 3000),rep("e7_p10", 3000))

vec_e8_groups <- c(rep("e8_p1", 3000),rep("e8_p2", 3000),rep("e8_p3", 3000),rep("e8_p4", 3000),
                   rep("e8_p5", 3000),rep("e8_p6", 3000),rep("e8_p7", 3000),rep("e8_p8", 3000),
                   rep("e8_p9", 3000),rep("e8_p10", 3000))

vec_e9_groups <- c(rep("e9_p1", 3000),rep("e9_p2", 3000),rep("e9_p3", 3000),rep("e9_p4", 3000),
                   rep("e9_p5", 3000),rep("e9_p6", 3000),rep("e9_p7", 3000),rep("e9_p8", 3000),
                   rep("e9_p9", 3000),rep("e9_p10", 3000))

vec_e10_groups <- c(rep("e10_p1", 3000),rep("e10_p2", 3000),rep("e10_p3", 3000),rep("e10_p4", 3000),
                   rep("e10_p5", 3000),rep("e10_p6", 3000),rep("e10_p7", 3000),rep("e10_p8", 3000),
                   rep("e10_p9", 3000),rep("e10_p10", 3000))

vec_e11_groups <- c(rep("e11_p1", 3000),rep("e11_p2", 3000),rep("e11_p3", 3000),rep("e11_p4", 3000),
                   rep("e11_p5", 3000),rep("e11_p6", 3000),rep("e11_p7", 3000),rep("e11_p8", 3000),
                   rep("e11_p9", 3000),rep("e11_p10", 3000))

vec_e12_groups <- c(rep("e12_p1", 3000),rep("e12_p2", 3000),rep("e12_p3", 3000),rep("e12_p4", 3000),
                   rep("e12_p5", 3000),rep("e12_p6", 3000),rep("e12_p7", 3000),rep("e12_p8", 3000),
                   rep("e12_p9", 3000),rep("e12_p10", 3000))

vec_e13_groups <- c(rep("e13_p1", 3000),rep("e13_p2", 3000),rep("e13_p3", 3000),rep("e13_p4", 3000),
                   rep("e13_p5", 3000),rep("e13_p6", 3000),rep("e13_p7", 3000),rep("e13_p8", 3000),
                   rep("e13_p9", 3000),rep("e13_p10", 3000))

vec_e14_groups <- c(rep("e14_p1", 3000),rep("e14_p2", 3000),rep("e14_p3", 3000),rep("e14_p4", 3000),
                   rep("e14_p5", 3000),rep("e14_p6", 3000),rep("e14_p7", 3000),rep("e14_p8", 3000),
                   rep("e14_p9", 3000),rep("e14_p10", 3000))

vec_e15_groups <- c(rep("e15_p1", 3000),rep("e15_p2", 3000),rep("e15_p3", 3000),rep("e15_p4", 3000),
                   rep("e15_p5", 3000),rep("e15_p6", 3000),rep("e15_p7", 3000),rep("e15_p8", 3000),
                   rep("e15_p9", 3000),rep("e15_p10", 3000))

vec_e16_groups <- c(rep("e16_p1", 3000),rep("e16_p2", 3000),rep("e16_p3", 3000),rep("e16_p4", 3000),rep("e16_p5", 3000),rep("e16_p6", 3000),rep("e16_p7", 3000),rep("e16_p8", 3000),
                   rep("e16_p9", 3000),rep("e16_p10", 3000))

df_e1 <- data.frame(vec_e1_data, vec_e1_groups)
df_e2 <- data.frame(vec_e2_data, vec_e2_groups)
df_e3 <- data.frame(vec_e3_data, vec_e3_groups)
df_e4 <- data.frame(vec_e4_data, vec_e4_groups)
df_e5 <- data.frame(vec_e5_data, vec_e5_groups)
df_e6 <- data.frame(vec_e6_data, vec_e6_groups)
df_e7 <- data.frame(vec_e7_data, vec_e7_groups)
df_e8 <- data.frame(vec_e8_data, vec_e8_groups)
df_e9 <- data.frame(vec_e9_data, vec_e9_groups)
df_e10 <- data.frame(vec_e10_data, vec_e10_groups)
df_e11 <- data.frame(vec_e11_data, vec_e11_groups)
df_e12 <- data.frame(vec_e12_data, vec_e12_groups)
df_e13 <- data.frame(vec_e13_data, vec_e13_groups)
df_e14 <- data.frame(vec_e14_data, vec_e14_groups)
df_e15 <- data.frame(vec_e15_data, vec_e15_groups)
df_e16 <- data.frame(vec_e16_data, vec_e16_groups)




LM_e1 <- lm(vec_e1_data ~ vec_e1_groups, data = df_e1)
LM_e2 <- lm(vec_e2_data ~ vec_e2_groups, data = df_e2)
LM_e3 <- lm(vec_e3_data ~ vec_e3_groups, data = df_e3)
LM_e4 <- lm(vec_e4_data ~ vec_e4_groups, data = df_e4)
LM_e5 <- lm(vec_e5_data ~ vec_e5_groups, data = df_e5)
LM_e6 <- lm(vec_e6_data ~ vec_e6_groups, data = df_e6)
LM_e7 <- lm(vec_e7_data ~ vec_e7_groups, data = df_e7)
LM_e8 <- lm(vec_e8_data ~ vec_e8_groups, data = df_e8)
LM_e9 <- lm(vec_e9_data ~ vec_e9_groups, data = df_e9)
LM_e10 <- lm(vec_e10_data ~ vec_e10_groups, data = df_e10)
LM_e11 <- lm(vec_e11_data ~ vec_e11_groups, data = df_e11)
LM_e12 <- lm(vec_e12_data ~ vec_e12_groups, data = df_e12)
LM_e13 <- lm(vec_e13_data ~ vec_e13_groups, data = df_e13)
LM_e14 <- lm(vec_e14_data ~ vec_e14_groups, data = df_e14)
LM_e15 <- lm(vec_e15_data ~ vec_e15_groups, data = df_e15)
LM_e16 <- lm(vec_e16_data ~ vec_e16_groups, data = df_e16)

p_vals <- c(anova(LM_e1)$Pr[1], anova(LM_e2)$Pr[1], anova(LM_e3)$Pr[1], anova(LM_e4)$Pr[1],
            anova(LM_e5)$Pr[1], anova(LM_e6)$Pr[1], anova(LM_e7)$Pr[1], anova(LM_e8)$Pr[1],
            anova(LM_e9)$Pr[1], anova(LM_e10)$Pr[1], anova(LM_e11)$Pr[1], anova(LM_e12)$Pr[1],
            anova(LM_e13)$Pr[1], anova(LM_e14)$Pr[1], anova(LM_e15)$Pr[1], anova(LM_e16)$Pr[1])
p_vals

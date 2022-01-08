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
armdata[[1]][[1]][[1]][[1]]

X <- rnorm(5,0,1)
Y <- rnorm(5,2,1)
Lin_m <- lm(Y~X)
anova(Lin_m)$Pr[1]
Experiments <- list("e1", "e2", "e3", "e4", "e5", "e6", "e7", "e8", "e9", "e10", "e11", "e12", "e13", "e14", "e15", "e16")
People <- list("p1","p2","p3","p4","p5","p6","p7","p8","p9","p10")
Reps <- c("r1","r2","r3","r4","r5","r6","r7","r8","r9","r10")

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
# armdata[[1]][[1]][[2]][1:100]
# armdata[[1]][[1]][[2]][101:200]
# armdata[[1]][[1]][[2]][201:300]


### 1) Assess if there is a significant effect of person of the observed trajectories. 

e1_means_x <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(People, Reps))
e1_means_y <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(People, Reps))
e1_means_z <- matrix(,nrow = 10, ncol = 10, byrow = T, dimnames = list(People, Reps))


for (p in 1:10){
  for (r in 1:10){
    e1_means_x[p,r] <- mean(armdata[[1]][[p]][[r]][1:100])
    e1_means_y[p,r] <- mean(armdata[[1]][[p]][[r]][101:200])
    e1_means_z[p,r] <- mean(armdata[[1]][[p]][[r]][201:300])
  }
}
p_vals_x <- matrix(, nrow = 10, ncol = 10)
p_vals_y <- matrix(, nrow = 10, ncol = 10)
p_vals_z <- matrix(, nrow = 10, ncol = 10)
for (i in 1:10){
  for (j in 1:10){
  p_vals_x[i,j] <- t.test(e1_means_x[i,], e1_means_x[j, ], paired = T)$p.value
  p_vals_y[i,j] <- t.test(e1_means_y[i,], e1_means_y[j, ], paired = T)$p.value
  p_vals_z[i,j] <- t.test(e1_means_z[i,], e1_means_z[j, ], paired = T)$p.value
  
  }
}
# From this computation only 45 p-vals are valid, symmetric matrices. 



e1_means_x[1,]
e1_means_x[1,2]
e1_means_x
t.test(e1_means_x)$p.value
t.test(e1_means_y)$p.value
t.test(e1_means_z)$p.value




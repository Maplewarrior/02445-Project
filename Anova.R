####### ANOVA 3-Way #########
#df <- read.csv("df.csv")
df <- read.csv("Project - 02445/Data/armdataPreprocessed.csv")
head(df)


length(df$data_all_exps[1:30000])
length(df$vec_coords[1:30000])
length(df$vec_experiments[df$vec_coords=="x"])

### Boxplots
{
#boxplot(df$data_all_exps[1:30000] ~ df$vec_coords[1:30000],main="data exp1 vs coords")
#boxplot(df$data_all_exps[1:180000] ~ df$vec_coords[1:180000],main="data half exp vs coords")
boxplot(df$data_all_exps ~ df$vec_coords,main="All Data vs Coords")

boxplot(df$data_all_exps[df$vec_coords=="y"] ~ df$vec_coords[df$vec_coords=="y"],main="All Data vs Coords")

#experiments
df$vec_experiments <- factor(df$vec_experiments, levels=c("e1", "e2", "e3", "e4", "e5", "e6", "e7", "e8", "e9", "e10", "e11", "e12", "e13", "e14", "e15", "e16"))
boxplot(df$data_all_exps[df$vec_coords=="x"] ~ df$vec_experiments[df$vec_coords=="x"], main="X-Data vs Experiments", xlab="Experiments", ylab="X-Data")
boxplot(df$data_all_exps[df$vec_coords=="y"] ~ df$vec_experiments[df$vec_coords=="y"], main="Y-Data vs Experiments", xlab="Experiments", ylab="Y-Data")
boxplot(df$data_all_exps[df$vec_coords=="z"] ~ df$vec_experiments[df$vec_coords=="z"], main="Z-Data vs Experiments", xlab="Experiments", ylab="Z-Data")

#boxplot(df_e16z$data_all_exps ~ df_e16z$vec_experiments)
df$vec_people <- factor(df$vec_people, levels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))
par(mfrow=c(1,1))
#jpeg("Boxplot_X_people.jpg", width = 350, height = "350")
boxplot(df$data_all_exps[df$vec_coords=="x"] ~ df$vec_people[df$vec_coords=="x"],main="X-Data vs Person", xlab="People", ylab="X-Data")
boxplot(df$data_all_exps[df$vec_coords=="y"] ~ df$vec_people[df$vec_coords=="y"],main="Y-Data vs Person", xlab="People", ylab="Y-Data")
boxplot(df$data_all_exps[df$vec_coords=="z"] ~ df$vec_people[df$vec_coords=="z"],main="Z-Data vs Person", xlab="People", ylab="Z-Data")


boxplot(df$data_all_exps[df$vec_coords=="z"], df$vec_people[df$vec_coords=="z"],main="Z-Data vs Person", xlab="People", ylab="Z-Data")


boxplot(df$data_all_exps[df$vec_coords=="z"] ~ df$vec_experiments[df$vec_coords=="z"], main="Z-Data vs Experiments", xlab="Experiments", ylab="Z-Data")

#Outlier of person2 exp5, plot all repetitions
min(df$data_all_exps[df$vec_coords=="z"])
df_e5z_p2 = subset(df, (df$vec_experiments=="e5" & df$vec_coords=="z" & df$vec_people=="p2"))
min(df_e5z_p2$data_all_exps)
boxplot(df_e5z_p2$data_all_exps)
plot(df_e5z_p2$data_all_exps)
plot(df_e5z_p2$data_all_exps[601:700], xlab="Time data", ylab="Z-coordinate", main="Person2 Exp5 Rep6")
plot(df_e5z_p2$data_all_exps[621:647])
# Person 2 exp 5, repetition 6 has dropped the cylinder possibly since
#z-coordinate doesnt follow a parabel like all other repeitions
# sample frequency 110 hertz - 100points per second - meaning less than 1 second to move object
}

### Scatter plots
{
library("ggplot2")
qqnorm(df$data_all_exps[df$vec_coords=="x"], main = "Normal Q-Q Plot X-Data")
qqnorm(df$data_all_exps[df$vec_coords=="y"], main = "Normal Q-Q Plot Y-Data")
qqnorm(df$data_all_exps[df$vec_coords=="z"], main = "Normal Q-Q Plot Z-Data")
# Y-coords are almost normally distributed

#ggplot(data= df, mapping = aes(x=vec_people[vec_coords=="x"], y=data_all_exps[vec_coords=="x"]))
ggplot(data= df, mapping = aes(x=vec_people, y=data_all_exps)) + geom_point(size=2, shape=23, colour="blue")
df_e1 = subset(df, df$vec_experiments=="e1")
df_e1x = subset(df, (df$vec_experiments=="e1" & df$vec_coords=="x"))
ggplot(data= df_e1x, mapping = aes(x=vec_people, y=data_all_exps)) + geom_point()
}

### Feature: Max height of all repetitions for each experiemtn are normally distributed 
{
df_e1z = subset(df, (df$vec_experiments=="e1" & df$vec_coords=="z"))
l <- 1
u <- 100
max_exp1z <- c(NA, 100)
#Exp 1, all 10 repetitions, all 10 people, z-coordinates
for (i in 1:100){
  max_exp1z[i] <- max(df_e1z$data_all_exps[l:u])
  l = l + 100
  u = u + 100
}
max_exp1z
mean(max_exp1z)
min(max_exp1z)
boxplot(max_exp1z)
index_scatt <- c(1:100)
df_scatt <- data.frame(max_exp1z, index_scatt)
ggplot(df_scatt,aes(x=index_scatt, y=max_exp1z)) + ggtitle("Max Heights for Experiment 1") +
  ylab("Max Heights") + scale_x_discrete(name="Person",labels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"),limits=10*c(1:10)) +
  geom_point(colour = "black",size=4)+ theme(axis.text=element_text(size=12),
                                                                                                                                                                                           axis.title=element_text(size=14,face="bold"))
ggsave("Max_heights_Exp1.jpg")

}
library("ggplot2")
df_z = subset(df, df$vec_coords=="z")
l <- 1
u <- 100
max_z <- c(NA, 1600)
#aLL 16 Exp, all 10 repetitions, all 10 people, z-coordinates
for (i in 1:1600){
  max_z[i] <- max(df_z$data_all_exps[l:u])
  l = l + 100
  u = u + 100
}
#max_z
mean(max_z)
min(max_z)
boxplot(max_z)
index_scatt_z <- c(1:1600)
df_scatt_z <- data.frame(max_z, index_scatt_z)
ggplot(df_scatt_z,aes(x=index_scatt_z, y=max_z)) + ggtitle("Max Heights for Experiment 1") +
  ylab("Max Heights") + scale_x_discrete(name="Person",labels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"),limits=160*c(1:10)) +
  geom_point(colour = "black",size=1)+ theme(axis.text=element_text(size=12),
                                             axis.title=element_text(size=14,face="bold"))
ggsave("Max_heights_Exp1.jpg")

Lm <- lm(index_scatt_z ~max_z )
qqnorm(max_z, main="All Max Heights")
qqline(Lm)

### Linear Model
{
#L1 <- lm(data_all_exps[1:30000] ~ vec_people[1:30000] +vec_coords[1:30000], data =df)

#L1 <- lm(data_all_exps[1:30000] ~ vec_people[1:30000] + vec_experiments[1:30000] + vec_coords[1:30000], data =df)
L1 <- lm(data_all_exps ~ vec_coords, data =df)
anova(L1)

L2 <- lm(data_all_exps ~ vec_people + vec_coords, data =df)
anova(L2)

L3 <- lm(data_all_exps ~ vec_people + vec_experiments + vec_coords, data =df)
anova(L3)

L4 <- lm(data_all_exps ~ vec_people + vec_experiments * vec_coords, data =df)
anova(L4)

L5 <- lm(data_all_exps ~ vec_people * vec_experiments * vec_coords, data =df)
anova(L5)
qqplot(residuals(L5))

plot(fitted(L1), residuals(L1))

}
#Look at the features


####### EXPERIMENT 16 #####
## d=22.5 and obstacle=S   - using some assumptions
{
### Max height z-coord for exp 16 each person
df_e16z = subset(df, (df$vec_experiments=="e16" & df$vec_coords=="z"))
l <- 1
u <- 100
max_p1_exp16z_all <- c(NA, 10)
#For person 1, exp 16, all 10 repetitions, z-coordinates
for (i in 1:10){
  #print(paste0("i=",i," l=",l, " u=",u))
  max_p1_exp16z_all[i] <- max(df_e16z$data_all_exps[l:u])
  l = l + 100
  u = u + 100
}
max_p1_exp16z_all
mean(max_p1_exp16z_all)

### Max height z-coord for exp 16 all 10 people
l <- 1
u <- 100
max_exp16z <- c(NA, 100)
#Exp 16, all 10 repetitions, all 10 people, z-coordinates
for (i in 1:100){
  max_exp16z[i] <- max(df_e16z$data_all_exps[l:u])
  l = l + 100
  u = u + 100
}
max_exp16z
mean(max_exp16z)
min(max_exp16z)
boxplot(max_exp16z)
#The obstacle could also be a S small at 20cm tall since the minimum max height lifted is 25cm
## This assumes all repetitions are valid (successful) attempts to move the cylinder over the obstacle


### Max length x-coord for exp 16 all 10 people
df_e16x = subset(df, (df$vec_experiments=="e16" & df$vec_coords=="x"))
df_e16z = subset(df, (df$vec_experiments=="e16" & df$vec_coords=="z"))
l <- 1
u <- 100
length_exp16x <- c(NA, 100)
#For person 1, exp 16, all 10 repetitions, z-coordinates
for (i in 1:100){
  index_maxh <- which.max(df_e16z$data_all_exps[l:u])
  length_exp16x[i] <- df_e16x$data_all_exps[index_maxh]
  l = l + 100
  u = u + 100
}
length_exp16x
mean(length_exp16x)
min(length_exp16x)
boxplot(length_exp16x)
#Take maxpoint of trajectory and find x-value for this point. This should give
# an estimate of d which is the distance from start point to obstacle
#The mean would be a good indicator of d, so we could guess d=22.5 since the 
# boxplot shows most of the data is above this point - rather than 30cm which is
# at the 75% quantile mark
}


### 3D Plots
{
library(rgl)
start_cyl <- cylinder3d(cbind(0, 0, seq(0, 10, length = 10)), radius = c(3,3,3), sides = 20, closed = -2)
target_cyl <- cylinder3d(cbind(60, 0, seq(0, 10, length = 10)), radius = c(3,3,3), sides = 20, closed = -2)
cyl1 <- cylinder3d(cbind(0, 0, 10 + seq(0, 12.5, length = 10)), radius = c(3,3,3), sides = 20, closed = -2)
cyl2 <- cylinder3d(cbind(60, 0, 10 + seq(0, 12.5, length = 10)), radius = c(3,3,3), sides = 20, closed = -2)
cyl3 <- cylinder3d(cbind(30, 0, seq(0, 20, length = 10)), radius = c(3,3,3), sides = 10, closed = -2)
shape_start <- shade3d(addNormals(subdivision3d(start_cyl)), col = "darkgreen")
shape_target <- shade3d(addNormals(subdivision3d(target_cyl)), col = "darkgreen")
shape_S <- shade3d(addNormals(subdivision3d(cyl1)), col = "pink")
shape_M <- shade3d(addNormals(subdivision3d(cyl2)), col = "pink", alpha = 0.5)
shape_T <- shade3d(addNormals(subdivision3d(cyl3)), col = "lightblue")
surface3d(c(-7, 67), c(-20, 20), matrix(0, 2, 2), col = "brown", alpha = 0.9, specular = "black")
lines3d(armdata[[7]][[1]][[1]])

# Plot different peoples movement trajectories for the most "variant" experiment and repetition
}
####### ANOVA 3-Way #########
df <- read.csv("df.csv")
head(df_all)


length(df$data_all_exps[1:30000])
length(df$vec_coords[1:30000])
length(df$vec_experiments[df$vec_coords=="x"])

### Boxplots
#boxplot(df$data_all_exps[1:30000] ~ df$vec_coords[1:30000],main="data exp1 vs coords")
#boxplot(df$data_all_exps[1:180000] ~ df$vec_coords[1:180000],main="data half exp vs coords")
boxplot(df$data_all_exps ~ df$vec_coords,main="All Data vs Coords")

#boxplot(df$data_all_exps[df$vec_coords=="y"] ~ df$vec_coords[df$vec_coords=="y"],main="All Data vs Coords")

boxplot(df$data_all_exps[df$vec_coords=="x"] ~ df$vec_experiments[df$vec_coords=="x"], main="X-Data vs Experiments", xlab="Experiments", ylab="X-Data"
        , names=c("e1", "e2", "e3", "e4", "e5", "e6", "e7", "e8", "e9", "e10", "e11", "e12", "e13", "e14", "e15", "e16"))
boxplot(df$data_all_exps[df$vec_coords=="y"] ~ df$vec_experiments[df$vec_coords=="y"], main="Y-Data vs Experiments", xlab="Experiments", ylab="Y-Data"
        , names=c("e1", "e2", "e3", "e4", "e5", "e6", "e7", "e8", "e9", "e10", "e11", "e12", "e13", "e14", "e15", "e16"))
boxplot(df$data_all_exps[df$vec_coords=="z"] ~ df$vec_experiments[df$vec_coords=="z"], main="Z-Data vs Experiments", xlab="Experiments", ylab="Z-Data"
        , names=c("e1", "e2", "e3", "e4", "e5", "e6", "e7", "e8", "e9", "e10", "e11", "e12", "e13", "e14", "e15", "e16"))

#boxplot(df_e16z$data_all_exps ~ df_e16z$vec_experiments)
boxplot(df$data_all_exps[df$vec_coords=="x"] ~ df$vec_people[df$vec_coords=="x"],main="X-Data vs Person", xlab="People", ylab="X-Data"
        , names=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))
boxplot(df$data_all_exps[df$vec_coords=="y"] ~ df$vec_people[df$vec_coords=="y"],main="Y-Data vs Person", xlab="People", ylab="Y-Data"
        , names=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))
boxplot(df$data_all_exps[df$vec_coords=="z"] ~ df$vec_people[df$vec_coords=="z"],main="Z-Data vs Person", xlab="People", ylab="Z-Data"
        , names=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))

### Scatter plots
library("ggplot2")
qqnorm(df$data_all_exps[df$vec_coords=="x"], main = "Normal Q-Q Plot X-Data")
qqnorm(df$data_all_exps[df$vec_coords=="y"], main = "Normal Q-Q Plot Y-Data")
qqnorm(df$data_all_exps[df$vec_coords=="z"], main = "Normal Q-Q Plot Z-Data")

#ggplot(data= df, mapping = aes(x=vec_people[vec_coords=="x"], y=data_all_exps[vec_coords=="x"]))
ggplot(data= df, mapping = aes(x=vec_people, y=data_all_exps)) + geom_point(size=2, shape=23, colour="blue")

#df_e1 = split(df, df$vec_experiments=="e1")
df_e1 = subset(df, df$vec_experiments=="e1")
df_e1x = subset(df, (df$vec_experiments=="e1" & df$vec_coords=="x"))
#View(df_e1)
ggplot(data= df_e1x, mapping = aes(x=vec_people, y=data_all_exps)) + geom_point()

### Linear Model
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



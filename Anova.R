####### ANOVA 3-Way #########
#df <- read.csv("df.csv")
df <- read.csv("Project - 02445/Data/armdataPreprocessed.csv")
#df <- read.csv("Data/armdataPreprocessed.csv")
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

df$vec_people <- factor(df$vec_people, levels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))
par(mfrow=c(1,1))
boxplot(df$data_all_exps[df$vec_coords=="x"] ~ df$vec_people[df$vec_coords=="x"],main="X-Data vs Person", xlab="People", ylab="X-Data")
boxplot(df$data_all_exps[df$vec_coords=="y"] ~ df$vec_people[df$vec_coords=="y"],main="Y-Data vs Person", xlab="People", ylab="Y-Data")
boxplot(df$data_all_exps[df$vec_coords=="z"] ~ df$vec_people[df$vec_coords=="z"],main="Z-Data vs Person", xlab="People", ylab="Z-Data")

### Outlier of person2 exp5, plot all repetitions
df_e5z_p2 = subset(df, (df$vec_experiments=="e5" & df$vec_coords=="z" & df$vec_people=="p2"))
#boxplot(df_e5z_p2$data_all_exps)
plot(df_e5z_p2$data_all_exps)
plot(df_e5z_p2$data_all_exps[601:700], xlab="Index", ylab="Z-coordinate", main="Person 2 Exp 5 Rep 6")
plot(df_e5z_p2$data_all_exps[621:647])
# Person 2 exp 5, repetition 6 has dropped the cylinder possibly since
#z-coordinate doesnt follow a parabel like all other repeitions
# sample frequency 110 hertz - 100points per second - meaning less than 1 second to move object


df_all_length$length_people <- factor(df_all_length$length_people, levels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))
boxplot(df_all_length$data_all_lengths ~df_all_length$length_people)

df_all_length$length_experiments <- factor(df_all_length$length_experiments, levels=c("e1", "e2", "e3", "e4", "e5", "e6", "e7", "e8", "e9", "e10", "e11", "e12", "e13", "e14", "e15", "e16"))
boxplot(df_all_length$data_all_lengths ~df_all_length$length_experiments)

library("rgl")
plot3d(x=data_all_exps[1:100],y=data_all_exps[101:200],z=data_all_exps[201:300],type = 's', 
       radius = .1,  xlab="x", ylab="y", zlab="z")

#plot(data_all_exps[1:300])

}



library("ggplot2")
#ggplot(data= df, mapping = aes(x=vec_people[vec_coords=="x"], y=data_all_exps[vec_coords=="x"]))
ggplot(data= df, mapping = aes(x=vec_people, y=data_all_exps)) + geom_point(size=2, shape=23, colour="blue")
df_e1 = subset(df, df$vec_experiments=="e1")
df_e1x = subset(df, (df$vec_experiments=="e1" & df$vec_coords=="x"))
ggplot(data= df_e1x, mapping = aes(x=vec_people, y=data_all_exps)) + geom_point()


### Feature: Max height of all repetitions for each experiment are normally distributed 
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
}
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

### QQ plots x,y,z data for specific datapoints
#Choose datapoint 25 for each repetition
point <- 25
count_point <- 0
point25_x <- c(NA, 1600)
point25_y <- c(NA, 1600)
point25_z <- c(NA, 1600)
for (i in 1:1600){
  point25_x[i] <- df$data_all_exps[point+count_point]
  point25_y[i] <- df$data_all_exps[point+count_point+100]
  point25_z[i] <- df$data_all_exps[point+count_point+200]
  count_point <- count_point + 300
}
qqnorm(point25_x[1401:1410], main = "Q-Q Plot 25th X-datapoint Exp. 15 Pers. 1")
qqline(point25_x[1401:1410], lwd = 2)

qqnorm(point25_y[1401:1410], main = "Q-Q Plot 25th Y-datapoint Exp. 15 Pers. 1")
qqline(point25_y[1401:1410], lwd = 2)

qqnorm(point25_z[1401:1410], main = "Q-Q Plot 25th Z-datapoint Exp. 15 Pers. 1")
qqline(point25_z[1401:1410], lwd = 2)


point <- 50
count_point <- 0
point50_x <- c(NA, 1600)
point50_y <- c(NA, 1600)
point50_z <- c(NA, 1600)
for (i in 1:1600){
  point50_x[i] <- df$data_all_exps[point+count_point]
  point50_y[i] <- df$data_all_exps[point+count_point+100]
  point50_z[i] <- df$data_all_exps[point+count_point+200]
  count_point <- count_point + 300
}
qqnorm(point50_x[1401:1410], main = "Q-Q Plot 50th X-datapoint Exp. 15 Pers. 1")
qqline(point50_x[1401:1410], lwd = 2)

qqnorm(point50_y[1401:1410], main = "Q-Q Plot 50th Y-datapoint Exp. 15 Pers. 1")
qqline(point50_y[1401:1410], lwd = 2)

qqnorm(point50_z[1401:1410], main = "Q-Q Plot 50th Z-datapoint Exp. 15 Pers. 1")
qqline(point50_z[1401:1410], lwd = 2)      

{
qqnorm(dfme$data_all_means[dfme$mean_coords=="y"], main = "Normal Q-Q Plot Mean Y")
qqline(dfme$data_all_means[dfme$mean_coords=="y"])

qqnorm(dfme$data_all_means[dfme$mean_coords=="z"], main = "Normal Q-Q Plot Mean Z")
qqline(dfme$data_all_means[dfme$mean_coords=="z"])


qqnorm(dfh$data_all_max, main = "Normal Q-Q Plot Max Height")
qqline(dfh$data_all_max, lwd = 2)

qqnorm(dfl$data_all_lengths, main = "Normal Q-Q Plot Trajectory Length")
qqline(dfl$data_all_lengths, lwd = 2)
}

#########  Look at the features 2-way ANOVA
#Mean
{
dfme <- read.csv("Project - 02445/Data/armdataPreprocessedMeans.csv")
head(dfme)
# X, Y, Z means should follow people and experiments
Lmex <- lm(data_all_means[dfme$mean_coords=="x"] ~ mean_people[dfme$mean_coords=="x"] * mean_experiments[dfme$mean_coords=="x"], data = dfme)
plot(fitted(Lmex), residuals(Lmex))
qqnorm(residuals(Lmex))
abline(0, sd(residuals(Lmex)))
anova(Lmex)

Lmey <- lm(data_all_means[dfme$mean_coords=="y"] ~ mean_people[dfme$mean_coords=="y"] * mean_experiments[dfme$mean_coords=="y"], data = dfme)
plot(fitted(Lmey), residuals(Lmey))
qqnorm(residuals(Lmey))
abline(0, sd(residuals(Lmey)))
anova(Lmey)

Lmez <- lm(data_all_means[dfme$mean_coords=="z"] ~ mean_people[dfme$mean_coords=="z"] * mean_experiments[dfme$mean_coords=="z"], data = dfme)
plot(fitted(Lmez), residuals(Lmez))
qqnorm(residuals(Lmez))
abline(0, sd(residuals(Lmez)))
anova(Lmez)
# Z coordinates: experiments have significant effect p-valye 0.095 compared to people 0.8 p-value
# X and Y coordinates: people have significatn effect 0.022 and 0.036 respectively. 
#This makes sense as the x-distance is the same for each experiment
# y-movement mean should be close to zero and peoples errors should be the main factor, which holds true
#Interactions are unsignificant

kruskal.test(dfme$data_all_means[dfme$mean_coords=="x"], dfme$mean_people[dfme$mean_coords=="x"])
kruskal.test(dfme$data_all_means[dfme$mean_coords=="x"], dfme$mean_experiments[dfme$mean_coords=="x"])
kruskal.test(dfme$data_all_means[dfme$mean_coords=="y"], dfme$mean_people[dfme$mean_coords=="y"])
kruskal.test(dfme$data_all_means[dfme$mean_coords=="y"], dfme$mean_experiments[dfme$mean_coords=="y"])
kruskal.test(dfme$data_all_means[dfme$mean_coords=="z"], dfme$mean_people[dfme$mean_coords=="z"])
kruskal.test(dfme$data_all_means[dfme$mean_coords=="z"], dfme$mean_experiments[dfme$mean_coords=="z"])
# Same conclusions as two way anova
}
{
# X, Y, Z means should follow people and Experiment 1
dfme1 <- subset(dfme, dfme$mean_experiments=="e1")
head(dfme1)
Lmex <- lm(data_all_means[dfme$mean_coords=="x"] ~ mean_people[dfme$mean_coords=="x"], data = dfme1)
plot(fitted(Lmex), residuals(Lmex))
qqnorm(residuals(Lmex))
abline(0, sd(residuals(Lmex)))
anova(Lmex)

Lmey <- lm(data_all_means[dfme$mean_coords=="y"] ~ mean_people[dfme$mean_coords=="y"], data = dfme1)
plot(fitted(Lmey), residuals(Lmey))
qqnorm(residuals(Lmey))
abline(0, sd(residuals(Lmey)))
anova(Lmey)

Lmez <- lm(data_all_means[dfme$mean_coords=="z"] ~ mean_people[dfme$mean_coords=="z"], data = dfme1)
plot(fitted(Lmez), residuals(Lmez))
qqnorm(residuals(Lmez))
abline(0, sd(residuals(Lmez)))
anova(Lmez)

#For exp 1, all people
dfme1 <- subset(dfme, dfme$mean_experiments=="e1")
head(dfme1)
Lmez <- lm(data_all_means[mean_coords=="x"] ~ mean_people[mean_coords=="x"], data = dfme1)
plot(fitted(Lmez), residuals(Lmez))
qqnorm(residuals(Lmez))
abline(0, sd(residuals(Lmez)))
anova(Lmez)

#For person 1, all exp
dfmep1 <- subset(dfme, dfme$mean_people=="p1")
head(dfmep1)
Lmep1 <- lm(data_all_means[mean_coords=="x"] ~ mean_experiments[mean_coords=="x"], data = dfmep1)
plot(fitted(Lmep1), residuals(Lmep1))
qqnorm(residuals(Lmep1))
abline(0, sd(residuals(Lmep1)))
anova(Lmep1)

#For person 1, exp1
dfmep1e1 <- subset(dfme, (dfme$mean_people=="p1" & dfme$mean_experiments=="e1"))
head(dfmep1e1)
boxplot(dfmep1e1$data_all_means)
Lmep1e1 <- lm(data_all_means[mean_coords=="x"] ~ mean_coords[mean_coords=="x"], data = dfmep1e1)
length(dfmep1e1$data_all_means[dfmep1e1$mean_coords=="x"] )

plot(fitted(Lmep1e1), residuals(Lmep1e1))
qqnorm(residuals(Lmep1e1))
abline(0, sd(residuals(Lmep1e1)))
anova(Lmep1e1)
} #Useless anova tests

#Max height
{
dfh <- read.csv("Project - 02445/Data/armdataPreprocessedMaxs.csv")
head(dfh)
dfh <- subset(dfh, dfh$max_coords=="z")
head(dfh)

Lhz <- lm(data_all_max ~ max_people* max_experiments, data = dfh)
plot(fitted(Lhz), residuals(Lhz), main="Residuals Max Height", xlab="Fitted values", ylab="Residuals")
qqnorm(residuals(Lhz), main="Normal Q-Q Plot Max Height")
abline(0, sd(residuals(Lhz)))
# Somewhat normal - as few outliers at low range - not the best fit
anova(Lhz)
boxplot(dfh$data_all_max)
# Experiments have a significant effect on max heights p: 0.071, whereas people are insignificant p: 0.85
#possibly do absolute value on y to see maximum curvature of trajectory

#Kruskal-wallis non parametric
kruskal.test(dfh$data_all_max, dfh$max_people)
kruskal.test(dfh$data_all_max, dfh$max_experiments)
# p:0.04 for experiments which is the same finding as above with anova
}
{
dfh1 <- subset(dfh, dfh$max_experiments=="e16")
head(dfh1)
length(dfh1$data_all_max)
Lhz1 <- lm(data_all_max ~ max_people, data = dfh1)
plot(fitted(Lhz1), residuals(Lhz1))
qqnorm(residuals(Lhz1))
abline(0, sd(residuals(Lhz1)))
#Not the best fit
anova(Lhz1)
kruskal.test(dfh1$data_all_max, dfh1$max_people)
#Same conclsuion that people dont have a significant effect on max height
} #For single experiment 16

#Curve length
{
dfl <- read.csv("Project - 02445/Data/armdataPreprocessedLength.csv")
head(dfl)
Ll <- lm(data_all_lengths ~ length_people * length_experiments, data = dfl)
plot(fitted(Ll), residuals(Ll), main="Residuals Trajectory Length", xlab="Fitted values", ylab="Residuals")
qqnorm(residuals(Ll), main="Normal Q-Q Plot Trajectory Length")
abline(0, sd(residuals(Ll)))
# Pretty normal - a few outliers at high range
anova(Ll)
dfl$length_people <- factor(dfl$length_people, levels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))
#boxplot(dfl$data_all_lengths ~ dfl$length_people, main="Boxplot Trajectory Length")
#Llp <- lm(data_all_lengths ~ length_people, data = dfl)
#plot(fitted(Llp), residuals(Llp), main="Residuals Trajectory Length", xlab="Fitted values", ylab="Residuals")

#par(mfrow=c(4,4)) 
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e1"] ~ dfl$length_people[dfl$length_experiments=="e1"], main="Boxplot Trajectory Length Experiment 1", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e2"] ~ dfl$length_people[dfl$length_experiments=="e2"], main="Boxplot Trajectory Length Experiment 2", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e3"] ~ dfl$length_people[dfl$length_experiments=="e3"], main="Boxplot Trajectory Length Experiment 3", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e4"] ~ dfl$length_people[dfl$length_experiments=="e4"], main="Boxplot Trajectory Length Experiment 4", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e5"] ~ dfl$length_people[dfl$length_experiments=="e5"], main="Boxplot Trajectory Length Experiment 5", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e6"] ~ dfl$length_people[dfl$length_experiments=="e6"], main="Boxplot Trajectory Length Experiment 6", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e7"] ~ dfl$length_people[dfl$length_experiments=="e7"], main="Boxplot Trajectory Length Experiment 7", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e8"] ~ dfl$length_people[dfl$length_experiments=="e8"], main="Boxplot Trajectory Length Experiment 8", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e9"] ~ dfl$length_people[dfl$length_experiments=="e9"], main="Boxplot Trajectory Length Experiment 9", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e10"] ~ dfl$length_people[dfl$length_experiments=="e10"], main="Boxplot Trajectory Length Experiment 10", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e11"] ~ dfl$length_people[dfl$length_experiments=="e11"], main="Boxplot Trajectory Length Experiment 11", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e12"] ~ dfl$length_people[dfl$length_experiments=="e12"], main="Boxplot Trajectory Length Experiment 12", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e13"] ~ dfl$length_people[dfl$length_experiments=="e13"], main="Boxplot Trajectory Length Experiment 13", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e14"] ~ dfl$length_people[dfl$length_experiments=="e14"], main="Boxplot Trajectory Length Experiment 14", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e15"] ~ dfl$length_people[dfl$length_experiments=="e15"], main="Boxplot Trajectory Length Experiment 15", xlab="People", ylab="Trajectory Length")
boxplot(dfl$data_all_lengths[dfl$length_experiments=="e16"] ~ dfl$length_people[dfl$length_experiments=="e16"], main="Boxplot Trajectory Length Experiment 16", xlab="People", ylab="Trajectory Length")
#Variance is not equal, therefore we log transform the trajectory lengths
}

#kruskal.test(dfl$data_all_lengths, dfl$length_experiments)
bartlett.test(dfl$data_all_lengths, dfl$length_experiments)
par(mfrow=c(1,1))
### Log lengths
{
dfl$log_lengths <- log(dfl$data_all_lengths) #log_e() so its the ln()
head(dfl)
#boxplot(dfl$log_lengths ~ dfl$length_people, main="Boxplot Trajectory Length All Experiments")
dfl$length_people <- factor(dfl$length_people, levels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))
boxplot(dfl$log_lengths[dfl$length_experiments=="e1"] ~ dfl$length_people[dfl$length_experiments=="e1"], main="Boxplot Log Trajectory Length Experiment 1", xlab="People", ylab="Log Trajectory Length")
# We can see that the log transform only slightly notificably reduces the spread for person 1 and 9

#plot(dfl$data_all_lengths[dfl$length_experiments=="e1"])
dfl_e1 <- subset(dfl, length_experiments=="e1")
head(dfl_e1)
ggplot(data= dfl_e1, mapping = aes(x=length_people, y=data_all_lengths)) + 
  geom_violin(trim=FALSE, fill='violet') + 
  stat_summary(fun=median, geom="point", size=2, color="black") 
#geom_boxplot(width=0.1)
#geom_point(size=2, shape=23, colour="blue")

#head(dfl$log_lengths)
#plot(dfl$log_lengths)
Llog <- lm(log_lengths ~ length_people * length_experiments, data=dfl)
plot(fitted(Llog), residuals(Llog), main="Residuals Log Trajectory Length", xlab="Fitted values", ylab="Residuals")
qqnorm(residuals(Llog), main="Normal Q-Q Plot Log Trajectory Length")
abline(0, sd(residuals(Llog)))
hist(residuals(Llog), main="Histogram of Residual Log Trajectory Length", xlab="Residuals", ylab="Frequency")

boxplot(dfl$log_lengths[dfl$length_experiments=="e1"] ~ dfl$length_people[dfl$length_experiments=="e1"], main="Boxplot Log Trajectory Length Experiment 1", xlab="People", ylab="Log Trajectory Length")

# Pretty normal - a few outliers at high range
anova(Llog)

#plot(Ll)
#plot(Llog)
library(ggfortify)
autoplot(Ll)
boxplot(log_lengths[1:1000] ~ dfl$length_people[1:1000], main="Boxplot Log Trajectory Length")
length(log_lengths)

qqnorm(dfl$data_all_lengths, main = "Normal Q-Q Plot Trajectory Length")
qqline(dfl$data_all_lengths, lwd = 2)

dfl$length_experiments <- factor(dfl$length_experiments, levels=c("e16","e1", "e4", "e7", "e10", "e13", "e2", "e5", "e8", "e11", "e14", "e3", "e6", "e9", "e12", "e15"))
dfl$length_experiments <- factor(dfl$length_experiments, levels=c("e16","e7", "e10", "e4", "e13", "e1", "e8", "e11", "e14", "e5", "e2", "e12", "e9", "e15", "e6", "e3"))
plot(dfl$length_experiments, dfl$data_all_lengths, xlab="Experiment", ylab="Trajectory Length", main="Trajectory Length for Experiments",
     xaxt = "n")
axis(side=1, at=c(1:16), cex.axis=0.84, labels=c("16","7", "10", "4", "13", "1", "8", "11", "14", "5", "2", "12", "9", "15", "6", "3"))
scatterplot(dfl$data_all_lengths,dfl$length_experiments)

plot(dfl$data_all_lengths)

max(dfl$data_all_lengths)
length(dfl$data_all_lengths)
boxplot(dfl$data_all_lengths)
#We remove the 2 outliers with 130+ curve length so that anova gives a better results

dfl_out <- dfl[dfl$data_all_lengths != max(dfl$data_all_lengths),]
max(dfl$data_all_lengths)
length(dfl_out$data_all_lengths)
boxplot(dfl_out$data_all_lengths)       

dfl_out2 <- dfl_out[dfl_out$data_all_lengths != max(dfl_out$data_all_lengths),]
max(dfl_out2$data_all_lengths)
length(dfl_out2$data_all_lengths)
boxplot(dfl_out2$data_all_lengths)       

Llo <- lm(data_all_lengths ~ length_people * length_experiments, data = dfl_out2)
plot(fitted(Llo), residuals(Llo))
qqnorm(residuals(Llo))
abline(0, sd(residuals(Llo)))
anova(Ll)


kruskal.test(dfl$data_all_lengths, dfl$length_people)
kruskal.test(dfl$data_all_lengths, dfl$length_experiments)
}

### Trajectory Energy
{
dfe <- read.csv("Project - 02445/Data/armdataPreprocessedEnergy.csv")
head(dfe)
dfe$energy_people <- factor(dfe$energy_people, levels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))

# Forward selection 
Le1 <- lm(data_all_energy ~ energy_experiments, data = dfe)
Le2 <- lm(data_all_energy ~ energy_people, data = dfe)
Le3 <- lm(data_all_energy ~ energy_experiments:energy_people, data = dfe)
anova(Le1)
anova(Le2)
anova(Le3)
Le7 <- lm(data_all_energy ~ energy_people + energy_experiments, data = dfe)
Le4 <- lm(data_all_energy ~ energy_experiments + energy_experiments:energy_people, data = dfe)
Le5 <- lm(data_all_energy ~ energy_people + energy_experiments:energy_people, data = dfe)
Le6 <- lm(data_all_energy ~ energy_people * energy_experiments, data = dfe)
anova(Le7)
anova(Le4)
anova(Le5)
anova(Le6)
aov(Le6)
summary(Le6)
library(car)

durbinWatsonTest(Le6)

#plot(Le6)
#interaction.plot(dfe$energy_people, dfe$energy_experiments, dfe$data_all_energy, c=1:16)
dfe$energy_experiments <- factor(dfe$energy_experiments, levels=c("e1","e2", "e3", "e4", "e5", "e6", "e7", "e8", "e9", "e10", "e11", "e12", "e13", "e14", "e15", "e16"))

interaction.plot(x.factor = dfe$energy_people, trace.factor = dfe$energy_experiments, 
                 response = dfe$data_all_energy, fun = mean, 
                 type = "b", legend = TRUE, fixed=TRUE, lwd = 2,
                 xlab = "Person", ylab="Trajectory Energy", trace.label="Experiment",
                 pch=c(1,19),col=1:16)
myinteraction.plot(x.factor = dfe$energy_people, trace.factor = dfe$energy_experiments, 
                   response = dfe$data_all_energy, fun = mean, 
                   type = "b", legend = TRUE, fixed=TRUE, lwd = 2,
                   xlab = "Person", ylab="Trajectory Energy", trace.label="Experiment",
                   pch=c(1,19), col=1:16, x.intersp=1, y.intersp=0.8, 
                   leg.pt.cex=1, leg.cex=0.85)

#col = c("#00AFBB", "#E7B800")
#legend("topright",title="Experiment",
       #legend=c("e1","e2", "e3", "e4", "e5", "e6", "e7", "e8", "e9", "e10", "e11", "e12", "e13", "e14", "e15", "e16"),
       #cex=1,col=1:16 
       #)
#       pch=c(1,2,3))
# trace.label = "Experiment",
#leg.bty = T

aov6 <- aov(Le6)
TukeyHSD(aov6, "energy_people")

TukeyHSD(aov6, "energy_experiments")


par(mfrow=c(1,1))
#hist(residuals(Le6), main="Histogram of Residual Trajectory Energy", xlab="Residuals", ylab="Frequency", prob=FALSE)
#install.packages("rcompanion") 
library('rcompanion')
plotNormalHistogram(residuals(Le6), prob = FALSE, xlab="Residuals", ylab="Frequency",
                     main = "Histogram of Residuals Trajectory Energy", col="grey", linecol="red",
                     length = 1600 )
qqnorm(residuals(Le6), main="Normal Q-Q Plot Trajectory Energy")
abline(0, sd(residuals(Le6)))
# Pretty normal - a few outliers at low range
plot(Le6, which=1, main="Residuals Trajectory Energy", caption="")
plot(fitted(Le6), residuals(Le6), main="Residuals Trajectory Energy", xlab="Fitted values", ylab="Residuals")

plot(Le6, which=3, main="Scale-Location", caption="")
#plot(Le6, which=4)
#plot(Le6, which=6)
#library(car)
#leveragePlots(Le6, data=Duncan)

#Boxplots of energy
par(mfrow=c(1,1))
boxplot(data_all_energy[energy_experiments=="e1"] ~ energy_people[energy_experiments=="e1"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e2"] ~ energy_people[energy_experiments=="e2"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e3"] ~ energy_people[energy_experiments=="e3"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e4"] ~ energy_people[energy_experiments=="e4"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e5"] ~ energy_people[energy_experiments=="e5"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e6"] ~ energy_people[energy_experiments=="e6"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e7"] ~ energy_people[energy_experiments=="e7"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e8"] ~ energy_people[energy_experiments=="e8"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e9"] ~ energy_people[energy_experiments=="e9"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e10"] ~ energy_people[energy_experiments=="e10"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e11"] ~ energy_people[energy_experiments=="e11"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e12"] ~ energy_people[energy_experiments=="e12"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e13"] ~ energy_people[energy_experiments=="e13"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e14"] ~ energy_people[energy_experiments=="e14"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e15"] ~ energy_people[energy_experiments=="e15"],data=dfe)
boxplot(data_all_energy[energy_experiments=="e16"] ~ energy_people[energy_experiments=="e16"],data=dfe)


library(ggplot2)
#library(lattice)
dfe1 <- subset(dfe, energy_experiments=="e1")
p1 <- ggplot(dfe1, aes(x=energy_people[energy_experiments=="e1"], y=data_all_energy[energy_experiments=="e1"])) + geom_boxplot()
p2 <- ggplot(dfe1, aes(x=energy_people[energy_experiments=="e2"], y=data_all_energy[energy_experiments=="e2"])) + geom_boxplot()
#library(gridExtra)

}
df$vec_people <- factor(df$vec_people, levels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))
df1 <- subset(df, vec_experiments=="e1")
df2 <- subset(df, vec_experiments=="e2")
df3 <- subset(df, vec_experiments=="e3")
df4 <- subset(df, vec_experiments=="e4")
df5 <- subset(df, vec_experiments=="e5")
df6 <- subset(df, vec_experiments=="e6")
df7 <- subset(df, vec_experiments=="e7")
df8 <- subset(df, vec_experiments=="e8")
df9 <- subset(df, vec_experiments=="e9")
df10 <- subset(df, vec_experiments=="e10")
df11 <- subset(df, vec_experiments=="e11")
df12 <- subset(df, vec_experiments=="e12")
df13 <- subset(df, vec_experiments=="e13")
df14 <- subset(df, vec_experiments=="e14")
df15 <- subset(df, vec_experiments=="e15")
df16 <- subset(df, vec_experiments=="e16")
p1 <- ggplot(df1, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot() + labs(x="People", y="Values", fill="Coords")
p2 <- ggplot(df2, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p3 <- ggplot(df3, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p4 <- ggplot(df4, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p5 <- ggplot(df5, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p6 <- ggplot(df6, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p7 <- ggplot(df7, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p8 <- ggplot(df8, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p9 <- ggplot(df9, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p10 <- ggplot(df10, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p11 <- ggplot(df11, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p12 <- ggplot(df12, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p13 <- ggplot(df13, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p14 <- ggplot(df14, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p15 <- ggplot(df15, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
p16 <- ggplot(df16, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot()+ labs(x="People", y="Values", fill="Coords")
#install.packages("ggpubr")
library('ggpubr')
ggarrange(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16 + rremove("x.text"), labels = c("e1", "e2", "e3", "e4","e5", "e6", "e7", "e8","e9", "e10", "e11", "e12","e13", "e14", "e15", "e16"),ncol = 4, nrow = 4, common.legend = TRUE, legend = "bottom")
#p_all <- ggplot(df, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot() + labs(title="Experiments",x="People", y="Values", fill="Coords") 
#p_all

ggplot(df, aes(x=vec_people, y=data_all_exps, fill=vec_coords)) + geom_boxplot(alpha=0.9) + labs(x="People", y="Values", fill="Coords") + facet_wrap(vars(df$vec_experiment)) 

dfx <- subset(df, vec_coords=="x")
dfy <- subset(df, vec_coords=="y")
dfz <- subset(df, vec_coords=="z")
dfx$vec_people <- factor(dfx$vec_people, levels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))
dfy$vec_people <- factor(dfy$vec_people, levels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))
dfz$vec_people <- factor(dfz$vec_people, levels=c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10"))
dfx$vec_experiments <- factor(dfx$vec_experiments, levels=c("e1", "e2", "e3", "e4","e5", "e6", "e7", "e8","e9", "e10", "e11", "e12","e13", "e14", "e15", "e16"))
dfy$vec_experiments <- factor(dfy$vec_experiments, levels=c("e1", "e2", "e3", "e4","e5", "e6", "e7", "e8","e9", "e10", "e11", "e12","e13", "e14", "e15", "e16"))
dfz$vec_experiments <- factor(dfz$vec_experiments, levels=c("e1", "e2", "e3", "e4","e5", "e6", "e7", "e8","e9", "e10", "e11", "e12","e13", "e14", "e15", "e16"))
ggplot(dfx, aes(x=vec_people, y=data_all_exps)) + geom_boxplot(fill="#ff4019",alpha=0.9) + labs(x="People", y="Values") + facet_wrap(vars(dfx$vec_experiment))
ggplot(dfy, aes(x=vec_people, y=data_all_exps)) + geom_boxplot(fill="#40de0b", alpha=0.9) + labs(x="People", y="Values") + facet_wrap(vars(dfy$vec_experiment))
ggplot(dfz, aes(x=vec_people, y=data_all_exps)) + geom_boxplot(fill="#00abff", alpha=0.9) + labs(x="People", y="Values") + facet_wrap(vars(dfz$vec_experiment))


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


plots.dir.path <- list.files(tempdir(), pattern="rs-graphics", full.names = TRUE); 
plots.png.paths <- list.files(plots.dir.path, pattern=".png", full.names = TRUE)

file.copy(from=plots.png.paths, to="C:/Users/ollie/Desktop/Plots 02445")

#Interaction plot
myinteraction.plot <- function (x.factor, trace.factor, response, fun = mean, 
                                type = c("l", "p", "b", "o", "c"), legend = TRUE, 
                                trace.label = deparse(substitute(trace.factor)), 
                                fixed = FALSE, xlab = deparse(substitute(x.factor)), ylab = ylabel, 
                                ylim = range(cells, na.rm = TRUE), lty = nc:1, col = 1, pch = c(1L:9, 
                                                                                                0, letters), xpd = NULL, leg.bg = par("bg"), leg.bty = "n", 
                                xtick = FALSE, xaxt = par("xaxt"), x.intersp = 1, y.intersp = 1, 
                                leg.cex = 1, leg.pt.cex = leg.cex, axes = TRUE, ...) {
  ylabel <- paste(deparse(substitute(fun)), "of ", deparse(substitute(response)))
  type <- match.arg(type)
  cells <- tapply(response, list(x.factor, trace.factor), fun)
  nr <- nrow(cells)
  nc <- ncol(cells)
  xvals <- 1L:nr
  if (is.ordered(x.factor)) {
    wn <- getOption("warn")
    options(warn = -1)
    xnm <- as.numeric(levels(x.factor))
    options(warn = wn)
    if (!anyNA(xnm)) 
      xvals <- xnm
  }
  xlabs <- rownames(cells)
  ylabs <- colnames(cells)
  nch <- max(sapply(ylabs, nchar, type = "width"))
  if (is.null(xlabs)) 
    xlabs <- as.character(xvals)
  if (is.null(ylabs)) 
    ylabs <- as.character(1L:nc)
  xlim <- range(xvals)
  xleg <- xlim[2L] + 0.05 * diff(xlim)
  xlim <- xlim + c(-0.2/nr, if (legend) 0.2 + 0.02 * nch else 0.2/nr) * 
    diff(xlim)
  dev.hold()
  on.exit(dev.flush())
  matplot(xvals, cells, ..., type = type, xlim = xlim, ylim = ylim, 
          xlab = xlab, ylab = ylab, axes = axes, xaxt = "n", col = col, 
          lty = lty, pch = pch)
  if (axes && xaxt != "n") {
    axisInt <- function(x, main, sub, lwd, bg, log, asp, 
                        ...) axis(1, x, ...)
    mgp. <- par("mgp")
    if (!xtick) 
      mgp.[2L] <- 0
    axisInt(1, at = xvals, labels = xlabs, tick = xtick, 
            mgp = mgp., xaxt = xaxt, ...)
  }
  if (legend) {
    yrng <- diff(ylim)
    yleg <- ylim[2L] - 0.1 * yrng
    if (!is.null(xpd) || {
      xpd. <- par("xpd")
      !is.na(xpd.) && !xpd. && (xpd <- TRUE)
    }) {
      op <- par(xpd = xpd)
      on.exit(par(op), add = TRUE)
    }
    text(xleg, ylim[2L] - 0.05 * yrng, paste("  ", trace.label), 
         adj = 0)
    if (!fixed) {
      ord <- sort.list(cells[nr, ], decreasing = TRUE)
      ylabs <- ylabs[ord]
      lty <- lty[1 + (ord - 1)%%length(lty)]
      col <- col[1 + (ord - 1)%%length(col)]
      pch <- pch[ord]
    }
    legend(xleg, yleg, legend = ylabs, col = col, pch = if (type %in% 
                                                            c("p", "b")) 
      pch, lty = if (type %in% c("l", "b")) 
        lty, bty = leg.bty, bg = leg.bg, x.intersp=x.intersp, y.intersp=y.intersp, 
      cex=leg.cex, pt.cex=leg.pt.cex)
  }
  invisible()
}

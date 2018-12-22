
mtcars[1:20,]
#######PCA works with numerical variables
str(mtcars)
help(mtcars)
mtcars.pca <- prcomp(mtcars[,c(2:7,10,11)], center = TRUE,scale. = TRUE)
summary(mtcars.pca)
#######Look at the object
str(mtcars.pca)
plot(mtcars.pca)
####Add principal components
train.data <- data.frame(mtcars$mpg, mtcars.pca$x)
train.data <- train.data[,1:3]
###########
train.data[1:2,]
mtcars[1:2,]
model1<-lm(mpg~.,data=mtcars)
summary(model1)
colnames(train.data)[1]<-"mpg"
model2<-lm(mpg~.,data=train.data)
summary(model2)
summary(model1)

##########Same data apply factor analsysi
n.factors <- 2   

fit <- factanal(mtcars, 
                n.factors,                # number of factors to extract
                scores=c("regression"),
                rotation="none")

print(fit, digits=2, cutoff=.3, sort=TRUE)
load <- fit$loadings[,1:2] 
plot(load,type="n") # set up plot 
text(load,labels=names(mtcars),cex=.7) # add variable names
#########Another method
fit <- factanal(mtcars, 
                n.factors,              # number of factors to extract
                rotation="varimax")     # 'varimax' is an ortho rotation

load <- fit$loadings[,1:2] 
load
library(psy)
scree.plot(fit$correlation)
library(nFactors)
ev <- eigen(cor(mtcars)) # get eigenvalues
ap <- parallel(subject=nrow(mtcars),var=ncol(mtcars), rep=100, cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)
####################################
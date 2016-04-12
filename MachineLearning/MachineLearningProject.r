# Machine Learning Project
# Refer to 
# https://rstudio-pubs-static.s3.amazonaws.com/28753_c3f068c4cced42ae8697070e34bbef12.html 
# http://rstudio-pubs-static.s3.amazonaws.com/23115_093b86293413411792eee518bccc1723.html (use this one)

library(caret)
library(randomForest)
library(MASS)
library(ggplot2)
library(rpart)
library(rpart.plot)
library(rattle)

#set seed
set.seed(333)

# load data 
setwd('C:\\Users\\i53655\\local\\study\\Cousera\\MachineLearning\\CourseProject')

url <- 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv'
destfile <- 'pml_training.csv'
if (!file.exists(destfile)) {
  download.file(url, destfile)
}
full.training <- read.csv(destfile, na.strings=c("NA","#DIV/0!",""), row.names=1)
dim(full.training)
table(full.training$classe)  # outcome

# ========== Select predictors =======================
# preprocessing of the training set (remove columns that have a lot of NAs), indirectly selection of predictors
# To ease the computation and due to the low informativity loss, the dataset is 
full.training <- full.training[,7:dim(full.training)[2]]
training <- full.training[,colSums(is.na(full.training))==0]
dim(training)

#nzVarFields <- nearZeroVar(slim.training, saveMetrics=TRUE)  # near zero variance
#training <- slim.training[, !nzVarFields$nzv]

###### model building ######
# #Partition rows into training and crossvalidation
inTrain <- createDataPartition(training$classe, p = 0.75, list=FALSE)
validation <- training[-inTrain,]
training <- training[inTrain, ]
dim(training)

# exploratory plot to find that the classification problem (need to use Tree-based regression for model development)
# all 
if (0) {
  predictorNames <- names(training)
  numNames <- length(predictorNames)
  dec = 4
  ifig = 1
  for (ipart in seq(1,numNames,by=dec)) {
    start = ipart
    end = ipart + dec-1
    if (end > numNames-1) end = numNames-1
    partNames = predictorNames[start:end]
    print(partNames)
    feature.obj <- featurePlot(x=training[,partNames], y=as.factor(training$classe), 
                               plot="strip", pch=1, cex=0.5, layout = c(2,2))
    png(paste('.\\plots\\featurePlot_',ifig,'.png',sep=""),1000,1000)
    print(feature.obj)
    dev.off() 
    ifig = ifig + 1
  }
}

# machine learning models check and selection
# Decision tree and random forest algorithms are known for their ability of detecting the features that are important for classification
# test tree-based models (rpart and rf)

#rp.model <- train(classe ~., data = training, method='rpart', tuneLength = 53)
rp.model <- rpart(classe ~., data=training, method='class')
rpart.plot(rp.model, main="Classification Tree", extra=100, under=TRUE, faclen=0,cex=0.6)
#text(rp.model$finalModel,use.n=TRUE, all=TRUE, cex=0.8)

#importantPredictors <- varImp(rp.model)
#plot(importantPredictors, main='Importance of Top 20 variables in', top=20)

pred0 <- predict(rp.model, validation, type='class')

# in-sample accuracy
confusionMatrix(pred0, validation$classe)  

# out-sample error
accuracy <- sum(pred0==validation$classe)/length(pred0) 
rp.error <- 1-accuracy

# random forest method
#trControl <- trainControl(method = "cv", 10)
rf.model <- train(classe ~ ., data=training, method = "rf") #, trControl=trControl)
rf.model <- randomForest(classe ~., data=training, method='class')

# cross-validation and plot
pred1 <- predict(rf.model, validation)
confusionMatrix(pred1, validation$classe)    
accuracy <- sum(pred1==validation$classe)/length(pred1) 
rf.error <- 1-accuracy

#importantPredictors <- varImp(rf.model)
#plot(importantPredictors, main='Importance of Top 20 variables in', top=20)

# ========= prediction ===============
# prediction 
url <- 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv'
destfile <- 'pml_testing.csv'
if (!file.exists(destfile)) {
  download.file(url, destfile)
}
testing = read.csv(destfile,na.strings=c("NA","#DIV/0!",""))

# apply similar correction for testing as training data !!!
#full.testing<- full.testing[,6:dim(full.testing)[2]]
##criteria = 0.5*nrow(full.testing)
#removeCols <- sapply( colnames(full.testing), function(x) {return(sum(is.na(full.testing[, x])) > criteria || sum(x=="") > criteria)} )
#slim.testing <- full.testing[, !removeCols]

testing <- testing[,7:dim(testing)[2]]
#testing <- full.testing[,colSums(is.na(full.testing))==0]
dim(testing)

#nzVarFields <- nearZeroVar(slim.testing, saveMetrics=TRUE)  # near zero variance (no changes)
#testing <- slim.testing[, !nzVarFields$nz]

ptest <- predict(rf.model, testing, type='class')   # write out ptest for submission or display the values of the prediction

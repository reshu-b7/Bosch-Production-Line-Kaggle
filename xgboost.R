

library(data.table)
library(Matrix)
library(caret)
library(xgboost)


numeric <- fread("train_numeric.csv")



Y  <- numeric$Response
numeric[ , Response := NULL]

for(col in names(numeric)) set(numeric, j = col, value = numeric[[col]] + 2)
for(col in names(numeric)) set(numeric, which(is.na(numeric[[col]])), col, 0)

X <- Matrix(as.matrix(numeric), sparse = T)


folds <- createFolds(as.factor(Y), k = 6)
valid <- folds$Fold1
model <- c(1:length(Y))[-valid]

param <- list(objective = "binary:logistic",
              eval_metric = "auc",
              eta = 0.01,
              base_score = 0.005,
              col_sample = 0.5) 

dmodel <- xgb.DMatrix(X[model,], label = Y[model])
dvalid <- xgb.DMatrix(X[valid,], label = Y[valid])

m1 <- xgb.train(data = dmodel, param, nrounds = 60,
                watchlist = list(mod = dmodel, val = dvalid))

pred <- predict(m1,dvalid)



mc <- function(actual, predicted) {
  
  tp <- as.numeric(sum(actual == 1 & predicted == 1))
  tn <- as.numeric(sum(actual == 0 & predicted == 0))
  fp <- as.numeric(sum(actual == 0 & predicted == 1))
  fn <- as.numeric(sum(actual == 1 & predicted == 0))
  
  numer <- (tp * tn) - (fp * fn)
  denom <- ((tp + fp) * (tp + fn) * (tn + fp) * (tn + fn)) ^ 0.5
  
  numer / denom
}

matt <- data.table(thresh = seq(0.001, 0.999, by = 0.001))

matt$scores <- sapply(matt$thresh, FUN =
                        function(x) mc(Y[valid], (pred > quantile(pred, x)) * 1))

print(matt)
best <- matt$thresh[which(matt$scores == max(matt$scores))]
sub   <- data.table(
                    Response = (pred > quantile(pred, best)) * 1)
predx <- as.factor(unlist(sub))
confusionMatrix(predx,Y[valid])



test<- fread("test_numeric.csv", select = c(
Id  <- test$Id
test[ , Id := NULL]



for(col in names(test)) set(test, j = col, value = test[[col]] + 2)
for(col in names(test)) set(test, which(is.na(test[[col]])), col, 0)

X <- Matrix(as.matrix(test), sparse = T)
dtest <- xgb.DMatrix(X)
testpred  <- predict(m1, dtest)
sub1   <- data.table(Id = Id,
                    Response = (pred > quantile(testpred, best)) * 1)

write.csv(sub1, "sub.csv", row.names = F)

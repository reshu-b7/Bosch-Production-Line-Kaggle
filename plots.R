library(data.table)
library(DMwR)
library(Matrix)
library(caret)
library(xgboost)
library(plotly)
numericdata<- fread("train_numeric.csv", select= c("Response"), header=TRUE)
datedata<- fread("train_date.csv", header=TRUE)
attach(datedata)

toplot <- data.frame(c(numericdata$Response,datedata$L3_S33_D3866,datedata$L1_S24_D1847,datedata$L1_S24_D1605))


p <- subplot(
  plot_ly(toplot, x = L3_S33_D3866, y = Response),
  plot_ly(toplot, x = L1_S24_D1847, y = Response),
  margin = 0.05,
  nrows=2
) %>% layout(showlegend = FALSE)


par(mfrow=c(3,1))
plot(datedata$L1_S24_D1001,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L1_S24_D1001"),  pch = 3)
plot(datedata$L1_S24_D1847,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L1_S24_D1847"), pch = 3)
plot(datedata$L1_S24_D1845,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L1_S24_D1845"), pch = 3)



par(mfrow=c(3,1))
plot(datedata$L0_S17_D434,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L0_S17_D434"),  pch = 3)
plot(datedata$L0_S0_D19,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L0_S0_D19"), pch = 3)
plot(datedata$L0_S0_D17,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L0_S0_D17"), pch = 3)



par(mfrow=c(3,1))
plot(datedata$L2_S26_D3107,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L2_S26_D3107"),  pch = 3)
plot(datedata$L2_S26_D3041,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L2_S26_D3041"), pch = 3)
plot(datedata$L2_S26_D3114,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L2_S26_D3114"), pch = 3)



par(mfrow=c(3,1))
plot(datedata$L3_S33_D3866,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L2_S26_D3107"),  pch = 3)
plot(datedata$L3_S29_D3408,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L2_S26_D3041"), pch = 3)
plot(datedata$L3_S38_D3961,jitter(numericdata$Response),xlab="Station Timestamp",ylab="Response",main= paste("Station ","L2_S26_D3114"), pch = 3)



datedata<- fread("train_date.csv",select=c("L0_S24_D1847","L3_S29_D3408","L2_S26_D3114","L0_S17_D434"), header=TRUE)

numericdata<- fread("train_numeric.csv", select= c("Response", "L0_S17_F433", "L1_S24_F1846", "L3_S33_F3407", "L2_S26_F3113"), header=TRUE)


par(mfrow=c(2,2))
plot(datedata$L0_S17_D434,numericdata$L0_S17_F433,  col=ifelse(numericdata$Response==1, 'black', 'orange'),xlab="Station Timestamp", ylab="Feature", main= paste("L0_S0_D19","VARIATION OVER TIME"), pch = 4 )
plot(datedata$L1_S24_D1847,numericdata$L1_S24_F1846,  col=ifelse(numericdata$Response==1, 'black', 'orange'),xlab="Station Timestamp", ylab="Feature", main= paste("L1_S24_F1846","VARIATION OVER TIME"), pch = 4 )
plot(datedata$L3_S29_D3408,numericdata$L3_S33_F3407,  col=ifelse(numericdata$Response==1, 'black', 'orange'),xlab="Station Timestamp", ylab="Feature", main= paste("L3_S29_D3408","VARIATION OVER TIME"), pch = 4 )
plot(datedata$L2_S26_D3114,numericdata$L2_S26_F3113,  col=ifelse(numericdata$Response==1, 'black', 'orange'),xlab="Station Timestamp", ylab="Feature", main= paste("L2_S26_D3114","VARIATION OVER TIME"), pch = 4 )

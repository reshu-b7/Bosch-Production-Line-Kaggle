# Bosch-Production-Line-Kaggle

The main objective of this prpject is to understand the manufacturing process at Bosch and explore their production lines and stations
with advanced analytics to refine their productivity.

<h3> DATASET </h3>
The data set for this paper has been taken from the famous Kaggle competition of Bosch Production Line Performance.The data characterizes the measurement of the various states of parts as they pass through the many stations of the production line. The manufacturing system assigns a unique Id to each part and also records its response (1 = fail, 0= pass) which represents either failing or passing the quality
control test. The features of each part are anonymous and are represented in a way that informs the user of the line number, station number and feature number of the respective part. 

![Alt text](/screenshots/dataset.png)



<h3> PREPROCESSING AND FEATURE EXTRACTION </h3>

A simple exploration of data shows that the class label has 6879  positive labels compared to 1176868 negative labels giving a ratio of 1:172. This leads to a class imbalanced dataset.The SMOTE and undersampling combination allows us to create a hybrid dataset. Synthetic sampling increases the percentage of the minority class without replacement. We apply an oversampling of 100% to get double the amount of
minority classes present. Similarly, we apply an undersampling of 200% to get majority classes as twice the number of minority classes. By applying such a blend of both sampling techniques, the initial bias of the learner turns towards the minority class also.

![Alt text](/screenshots/feature.jpeg)


The numeric data contains 970 variables all of which may not be important to determine the quality factor of the manufactured product. XGBoost is one of the algorithms that can be used to determine importance of features for numerical group of data only. It generates the top features with highest importance categorized by the value of gain. We select top 20 features given below from the entire dataset to carry out further analysis on them.


<h3> EXPLORATORY DATA ANALYSIS </h3>


![Alt text](/screenshots/eda1.png)

![Alt text](/screenshots/eda2.png)


This pictorial representation of the data indicates the distribution of failure and acceptance of a component over the timespan. To avoid overlapping of points, we add a little noise called “jitter” in the data to get scattered points and ease in visualization. We can
deduce about the time of maximum failure from such plots. For instance, we can observe that for features in Line 1 , the most failure of the component occur in the middle rather than starting or end of the day whereas Line 0 accounts for failure almost equally for the entire period.


![Alt text](/screenshots/eda3.png)



The plot demonstrates the variation of features and timestamp on each other along with the points that fail or pass the quality check. The plot marks the failed and accepted parts with different colors. First, we note that the feature values are spread over the entire timestamp indicating the measurements were taken in a continuous manner with little or no breaks in between. Additionally the points for Line 0 and Line 2 are comparatively sparse whereas Line 1 and Line 3 have abundance of data points. This verifies our result of obtaining features and stations of Line 1 and Line 3 as the top 20.


<h3> CLASSIFICATION BY NON-SCALABLE PLATFORM </h3>

We use different supervised learning classification techniques namely XGBoost and Support Vector Machines for this purpose.
The runtime for XGBoost was approximately 720 seconds and SVM was 36000 seconds on a system of 4 cores, 3.2 GHz processor and 16GB RAM.

![Alt text](/screenshots/accuracyR.png)


<h3> CLASSIFICATION BY SCALABLE PLATFORM APACHE SPARK</h3>

Apache Spark provides a distributed and parallel computing environment for large scale data processing.

![Alt text](/screenshots/accuracyspark.png)


Hence we present a more efficient methodology to deal with the volume, variability and velocity of the data which could turn out to be beneficial for advanced data analysis at the manufacturing system at BOSCH, giving them the opportunity to have a proficient quality control.




<h3>FILES: </h3>

xgboost.R= modeling with R </br>
plots.R= plotting data








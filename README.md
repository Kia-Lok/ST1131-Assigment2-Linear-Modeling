# HDB Resale Price Prediction
Dataset used to predict resale prices of flats is found [here](https://data.gov.sg/datasets/d_8b84c4ee58e3cfc0ece0d773c8ca6abc/view), provided by HDB. This task originally appeared as an assignment for ST1131 and is done by finding a suitable linear model via trial-and-error in R. This repository explores using tree-based models in Python on the same dataset to see if it can provide an improvement over linear modelling and avoiding trial-and-error process. This is also an exploration into tree-based models and learning how to apply them in context of data science.

## Table of Contents
- [Original Findings](#original-findings)
- [Non-Linear Modelling with YDF](#non-linear-modelling-with-ydf)
- [Non-Linear Modelling with SKLearn](#non-linear-modelling-with-sklearn)
- [Evaluation and Conclusion](#evaluation-and-conclusion)

## Original Findings
Detailed findings are in the report. We transformed certain categories in the dataset to reduce number of categories in categorical variables as well as extract certain information from the data and used it in a new category. Categories are also eliminated from consideration as explanatory variables of the model either because they should not have any correlation with resale price or that its already represented by another explanatory variable. 

Through trial-and-error process, we settled on a linear model that uses floor area, storey, region, remaining lease years and year of transaction to predict resale price. The final model doesn't violate constant variance and linearity assumptions and have a R² value of 0.7614.

Through the process, we noted that the linear relationship between resale price and the chosen response variables are weak and not very responsive to data transformation. The final linear model only transformed resale price. We suspect that a non-linear approach will yield potentially much better results.

We note the pros and cons of this method

Pros:
- Linear Modelling allows for exact reconstruction of the model used
- Understand the relationship between data categories better through trial-and-error process

Cons:
- Very time-consuming, with any improvement being uncertain
- Some problems are ill-suited for a linear solution
- Hard to tell if a linear model is overfitted on training data

## Non-Linear Modelling with YDF
Decision Forests (DFs) are a family of machine learning algorithms used for classification, regression, ranking, uplifting and anomaly detection, constructed from a collection of decision trees. Yggdrasil Decision Forests (YDF) is a comprehensive library for training, evaluating, interpreting, and serving these models.

We note that Random Forests algorithm are more robust against overfitting whereas Gradient Boosted Decision Trees typicially enjoys higher accuracy in exchange for being more prone to overfitting. We tried both algorithms and noted that the Random Forests algorithm performed significantly worse on test data compared to Gradient Boosted. Hence, we will only be working with Gradient Boosted in this repository.

This and the next section is done in Python3 Jupyter Notebook. The same transformation is performed on the data and we used the exact same categories to build the model. We decided to split the data into 90% training data and 10% test data. We use Mean Absolute Percentage Error (MAPE) and Determination (R²) to measure the performance of the model.

Results:
| Data   | MAPE  | R²    |
|--------|-------|-------|
| Train  | 0.093 | 0.861 |
| Test   | 0.110 | 0.642 |

The R² value on train data is a significant improvement from our linear model. The MAPE is around 9.3% and 11% for training and test data respectively, which is an acceptable error range for pricey things like flats. We do note that the R² value on test data suffered significantly, suggesting possible overfitting in the model. Unfortunately, YDF hides a lot of the finer details within the library itself and cannot be changed from the outside. This makes it hard to adjust certain factors like max height and learning rate that may reduce overfitting. This caused us to also consider the Gradient Boosted algorithm in SKLearn where these factors are easily adjustable.

We note the pros and cons of the YDF library

Pros:
- Provides very detailed report of model training loss over iterations, importance of explanatory variables, tree structure etc
- Very easy to use, making it convenient to use it as a quick test
- Automatically assigns data types as categorical or numerical in the model, which is very convenient as long as numerical data are all in float

Cons:
- Doesn't expose finer details of training, making it hard to tackle overfitting

## Non-Linear Modelling with SKLearn
We perform the exact same data transformation as the previous 2 sections and use a gradient boosting alogrithm on the dataset. Playing around with the learning rate, number of estimators and max height, we found that a lr of 0.05, max height of 6 and number of estimators at 500 gave the best results. Changing any will lead to a slightly worse result.

Results:
| Data   | MAPE  | R²    |
|--------|-------|-------|
| Train  | 0.062 | 0.941 |
| Test   | 0.104 | 0.815 |



## Evaluation and Conclusion

# Customer Churn Prediction Analysis

## Overview

This project focuses on predicting customer churn using Machine Learning techniques and deriving actionable business insights through data analysis. The objective is to identify customers who are likely to discontinue services and help businesses implement effective retention strategies.

## Tech Stack

* Python: Data cleaning, preprocessing, exploratory data analysis, and machine learning model development.
* SQL:Data extraction, aggregation, and business analysis queries.
* Machine Learning: Predictive modeling and customer churn classification.
* Libraries: Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn.

## Project Workflow

1. Collected and explored customer demographic and service usage data.
2. Performed data cleaning, handled missing values, and encoded categorical variables.
3. Used SQL queries to analyze customer behavior, churn patterns, and key business metrics.
4. Conducted Exploratory Data Analysis (EDA) to identify factors contributing to customer churn.
5. Built and evaluated multiple machine learning models, including Logistic Regression and Random Forest.
6. Compared model performance using Accuracy, Precision, Recall, F1-Score.
7. Generated business recommendations to improve customer retention and reduce churn.

## Key Insights

* Customers with month-to-month contracts exhibit significantly higher churn rates.
* Higher monthly charges and shorter tenure are strongly associated with churn.
* Customers without online security and tech support services are more likely to leave.
* Long-term contracts and bundled services improve customer retention.

## Business Impact

The predictive model enables organizations to proactively identify at-risk customers and design targeted retention campaigns, reducing customer attrition and improving long-term revenue.

## Repository Structure

```text
├── data/
├── notebooks/
├── sql_queries/
├── models/
├── visualizations/
├── requirements.txt
└── README.md
```

## Future Improvements

* Implement XGBoost and LightGBM models.
* Deploy the model using Flask or Streamlit.
* Build an interactive dashboard using Power BI or Tableau for churn monitoring.

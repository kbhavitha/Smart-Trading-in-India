# Smart-Trading-in-India

This project is about analysing the imports and exports of India from 2014 to 2017 and deriving the following insights.

1. Finding country(s) that have similar trading semantics with India, so that India has better alternative choice in case of any unexpected crisis between the countries in trading market.
2. Predicting the range of price of goods that are to be imported or exported in the coming years of Indian trading.
3. Predicting the price of goods that are to be imported or exported in the coming years of Indian trading.
4. Analysing the fluctuations in foreign exchange rate to predict the changes in the rupee value and finding the impact of predicted rupee value on the Indian trading. This enables us to choose a better country among the countries that are having similar trading semantics with less change in foreign exchange rate.

**Data Source**

1.	Indian Import dataset: https://data.gov.in/catalog/principal-commodity-wise-import
2.	Indian Export dataset: https://data.gov.in/catalog/principal-commodity-wise-export
3.	Indian currency vs. other country: 
There are 22 datasets, i.e., Indian currency comparison with 22 other country currencies.
Link for US Dollar vs. Indian Rupee:
https://in.investing.com/currencies/usd-inr-historical-data

**Tools and Techniques used**

R Language,  Classification, Clustering, Timeseries, WEKA tool

**Schemantic Model**

![image](https://user-images.githubusercontent.com/38485915/147389588-99d5ac48-8d16-4aea-918f-a088b87d6dc9.png)

**Project Structure**
  
  _R CODE\project.R_ - Forming proper dataset
  
    1. Combined imports and exports data to two different datasets.
    2. The attribute pc_description in dataset contains names of the goods involved in Indian trading. Similar types of goods are grouped and named as type of that good. 
    3. In import dataset, countries and their contribution towards trading (in terms of price) was calculated using group_by() function on countries and corresponding sum of value (where value is price of goods) is calculated.
    4. These countries are ordered in descending order on the basis of the summarized price and top 10 countries are considered for further analysis.
    5. From these top 10 countries top 25 goods are calculated.
    6. Similarity same calculation is done for exports.
    
   _Preprocessing Data_ - Rapid Miner is used to replace the missing values and discreting the dataset.
    
    

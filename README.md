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
  _R CODE\dendogram_final.R_ - Identifying similar trading patterns
  
    1. Top 95% countries and top 95% products contributing towards Indian trading were found by filtering the variables country.wide and prd.wide using fraction<0.95 and stored in variables ctr95 and prd95.
    2. Dendrogram was plotted using the function rect.hclust(hc.import).
    3. The countries present in the each cluster were identified using the function cutree.
    4. Results for import dataset
    
  ![image](https://user-images.githubusercontent.com/38485915/147390249-f07e8d82-75c4-4a44-a6d0-6e0351388fe9.png)
    
    5. Results for export dataset
    
    ![image](https://user-images.githubusercontent.com/38485915/147390253-c6394334-a37a-410d-a372-4fb62163c407.png)
   
  _Prediction of Range of Price_ - Weka is used to classify and random tree gave highest accuracy.
    
  ![image](https://user-images.githubusercontent.com/38485915/147390297-ae1e90e2-cde9-4068-bdac-ac65edf9a989.png)

  ![image](https://user-images.githubusercontent.com/38485915/147390315-94a5ca3a-6f7d-4fa2-aad2-691940472819.png)

  _Prediction of Price_ - Weka is used to find price and KNN gave highest accuracy
  
  ![image](https://user-images.githubusercontent.com/38485915/147390432-ee1f21a6-4513-43d6-b0f8-7ccc80690d4e.png)
  ![image](https://user-images.githubusercontent.com/38485915/147390435-33898968-de22-4740-9440-4605d48604c8.png)

  _R CODE\arima_time _series.R_ - Time Series Analysis on Foreign Exchange Rate
    
    1. As year vs price plot is non-stationary, differentiation is applied.
    2. Using Arima model forecasting done with descent accuracy.
    
  ![image](https://user-images.githubusercontent.com/38485915/147390598-5c1a23e0-37f4-4e1d-b345-c0fb3f0e54e8.png)

**Conclusion**

  Example: Indonesia vs Vietnam
  
  From dendrogram, we found that Indonesia (one of the top 10 countries) is having similar trading semantics as Vietnam. After getting the predicted value of Rupee with respect to Indonesia and Vietnam, we found that the Rupee value is falling with respect to Indonesian currency whereas Rupee is gaining its value against Vietnam???s currency. Thus, we have calculated price per item, i.e., predicted price(from knn)/quantity for both Indonesia and Vietnam. Here, we found that Vietnam imports goods to India in fewer prices than Indonesia. 
  This gave us a conclusion that in coming years, India can trade with Vietnam instead of Indonesia to gain more profits.  
  

      

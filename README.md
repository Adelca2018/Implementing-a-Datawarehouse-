# Implementing-a-Datawarehouse-
This project is an example of implementing a Datawarehouse based on the  Datavault approach

The files have to be executed in this order:  

. **01_Create_Database** : the files creates a relational database corresponding to the data at hand  
. **02_Extract_Clean_Data**: Extract the raw data and make some preprocessing
. **03_Load_Data** : once the preprocessings are done, this script then  loads the data into the relational database created in step 1  
. **04_Load_business_data** : this file does some calculations that will feed the table containing business informations that can be used for quick insights from the managerial perspective  
. **05_Performance insights**: shows quick performance insights  
  
  You can have a look of the relational datawarehouse created in the file **Datawarehouse diagramm.png**
  
  The **input** folder contains initial data. Because of the size of *input2.csv* extends the max size of 25MB supported here in github,  
  the data has been zipped. So one need to unzip first this data before using.
  The **Cleaned Data** folder contains the processed data after running the **02_Extract_Clean_Data**. For the same reason mentioned above one of the data has been submitted as zipped file. 
  
  All paths in codes have been written as relative paths assuming the all the scripts are located in the same folder as it is in the repository



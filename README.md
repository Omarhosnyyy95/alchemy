# Alchemy

## Data Model
![Data Model](model.png)

## Notes on the task
- 9 tables are created from the provided dataset. Please refer to `ddl.sql`
- 5 Raw data sheets are read and loaded to the S3 bucket as is.
- To mimic loading data from S3 to a Data Warehouse, Pandas was used to do the ETL to deliver data to its target tables.
- 9 dataframes are created in the notebook to match the target tables.
  - SalesData.csv
    - sales
    - product
    - currency
    - order_status
  - costs.csv
    - costs
  - FX_Table.csv
    - currency_converter
  - Customer_Table.csv
    - customers
  - Country_Table.csv
    - country
  - date_lookup (created in pandas)
- pandas was used for data manipulation to speed up setup time.
- hash function in python was used for data surrogation which is not the best option. The best practice is to store natural keys and surrogate keys in a separate schema in the DWH.

## How to run your scripts
- clone the repo
- Create a conda environment on your local machine

`conda create --name alchemy python=3.13.2`

`conda activate alchemy`

`pip install pandas notebook boto3`

- Create IAM User on AWS and give it access to read and write to S3, You will need the `AWS access key` and `AWS secret key` for this IAM user while running the notebook.
- Create a bucket in your S3 account.
- Go to the project path, open the notebook, edit the 2nd line with the relevant information.
- The load part is still not complete, but should be the most straight forward part after transforming the datasets to match the final data model.

## How the scripts would be scheduled and run on AWS
- Whatever the option, it's preferable to use an orchestrator like Airflow or Nifii to schedule running our jobs and take care of tasks dependencies.
- Most importantly is to save the raw data in S3 (staging layer). So we will need a pipeline(DAG) for that.
- We will need another dag to do the following. 
  - read raw data from S3
  - create surrogate keys from the specified columns (data modeling decision)
  - data transformation
  - and loading
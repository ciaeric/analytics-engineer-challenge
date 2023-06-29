![Montu Logo](logo.png)

# Summary of Analytics Engineer Challenge
- You will be creating models that run on the GA4 public dataset.
- The data modelling will be completed in dbt (initial setup is completed). There are some steps required for it to work on your local env.
- The data you will be using is described below and is based on raw clickstream events.

## Dataset
Obfuscated Google Analytics 4 data emulating a web ecommerce implementation of Google Analytics. It’s a great way to look at business data and experiment and learn the benefits of analyzing Google Analytics data in BigQuery. [Learn more](https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset)

| column_name                      | data_type                                                                                                                           | description                                                     |
|----------------------------------|------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------|
| event_date                       | STRING                                                                                                                             | The date of the event                                           |
| event_timestamp                  | INT64                                                                                                                              | The timestamp of the event                                      |
| event_name                       | STRING                                                                                                                             | The name of the event                                           |
| event_params                     | ARRAY<STRUCT<key STRING, value STRUCT<string_value STRING, int_value INT64, float_value FLOAT64, double_value FLOAT64>>>         | The parameters associated with the event                        |
| event_previous_timestamp         | INT64                                                                                                                              | The timestamp of the previous event                             |
| event_value_in_usd               | FLOAT64                                                                                                                            | The value of the event in USD                                   |
| event_bundle_sequence_id         | INT64                                                                                                                              | The sequence ID of the event bundle                             |
| event_server_timestamp_offset    | INT64                                                                                                                              | The offset of the server timestamp                              |
| user_id                          | STRING                                                                                                                             | The ID of the user                                              |
| user_pseudo_id                   | STRING                                                                                                                             | The pseudonymous ID of the user                                 |
| privacy_info                     | STRUCT<analytics_storage INT64, ads_storage INT64, uses_transient_token STRING>                                                   | Privacy-related information                                    |
| user_properties                  | ARRAY<STRUCT<key INT64, value STRUCT<string_value INT64, int_value INT64, float_value INT64, double_value INT64, set_timestamp_micros INT64>>> | Properties associated with the user                             |
| user_first_touch_timestamp       | INT64                                                                                                                              | The timestamp of the user's first touch                         |
| user_ltv                         | STRUCT<revenue FLOAT64, currency STRING>                                                                                            | The lifetime value of the user                                  |
| device                           | STRUCT<category STRING, mobile_brand_name STRING, mobile_model_name STRING, mobile_marketing_name STRING, mobile_os_hardware_model INT64, operating_system STRING, operating_system_version STRING, vendor_id INT64, advertising_id INT64, language STRING, is_limited_ad_tracking STRING, time_zone_offset_seconds INT64, web_info STRUCT<browser STRING, browser_version STRING>>> | Information about the device used                               |
| geo                              | STRUCT<continent STRING, sub_continent STRING, country STRING, region STRING, city STRING, metro STRING>                          | Geographic information                                          |
| app_info                         | STRUCT<id STRING, version STRING, install_store STRING, firebase_app_id STRING, install_source STRING>                             | Information about the app                                       |
| traffic_source                   | STRUCT<medium STRING, name STRING, source STRING>                                                                                   | Information about the traffic source                            |
| stream_id                        | INT64                                                                                                                              | The ID of the stream                                            |
| platform                         | STRING                                                                                                                             | The platform of the event                                       |
| event_dimensions                 | STRUCT<hostname STRING>                                                                                                            | Dimensions of the event                                         |
| ecommerce                        | STRUCT<total_item_quantity INT64, purchase_revenue_in_usd FLOAT64, purchase_revenue FLOAT64, refund_value_in_usd FLOAT64, refund_value FLOAT64, shipping_value_in_usd FLOAT64, shipping_value FLOAT64, tax_value_in_usd FLOAT64, tax_value FLOAT64, unique_items INT64, transaction_id STRING> | E-commerce related information                                 |
| items                            | ARRAY<STRUCT<item_id STRING, item_name STRING, item_brand STRING, item_variant STRING, item_category STRING, item_category2 STRING, item_category3 STRING, item_category4 STRING, item_category5 STRING, price_in_usd FLOAT64, price FLOAT64, quantity INT64, item_revenue_in_usd FLOAT64, item_revenue FLOAT64 | Item related information including id brand and other information


## Local Setup

### GCP project and service account
- [Create a Google Cloud Platform (GCP) project named dbttest](https://console.cloud.google.com/welcome). Project name ```dbt_challenge```
- [Create service account that has BigQuery Admin for the dbttest project](https://console.cloud.google.com/iam-admin/serviceaccounts?project=dbttesting-391203)
- Create a service account key and add it to the cred folder. Then rename the file to ```dbt-test.json```
- In the dbt ```test``` folder, make sure the ```profiles.yml``` file is updated to use your new project id and keyfile path. 
- [Find the ga4_obfuscated_sample_ecommerce Dataset in BigQuery](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=google_analytics_sample&page=dataset&project=dbttesting-391203&ws=!1m14!1m4!1m3!1sdbttesting-391203!2sbquxjob_383f6629_18900d67031!3sUS!1m3!3m2!1sbigquery-public-data!2sga4_obfuscated_sample_ecommerce!1m4!4m3!1sdbttesting-391203!2sdbt_test!3ssource_medium)

### Setup your local virtual python environment for dbt:

Run the following commands in your terminal ([Install Anaconda.Navigotor](https://www.anaconda.com/download)). 

Step 1 (create the virtual environment):
```bash
conda create --name dbt python=3.10.11
```

Step 2 (activate the python environment):
```bash
conda activate dbt
```

Step 3 (Install dbt dependencies):
```bash
pip install -r requirements.txt
```
Step 4 (Navigate to the dbt project folder):
```bash
cd test
```

## Challenge

### Notes before you start
- Access the sample data in a public dataset ```ga4_obfuscated_sample_ecommerce``` in BigQuery this will be the source data for this challenge.
- Make sure that your dbt env can access BigQuery. Run ```dbt debug``` to check. 

### Create models
The details of the requirements will be shared separately. 
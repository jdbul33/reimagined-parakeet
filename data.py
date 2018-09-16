# -*- coding: utf-8 -*-
"""
Created on Fri Sep 14 21:07:58 2018

@author: jdbul
"""

import pandas as pd

#%%

school_data = pd.read_csv("total_school_data.csv")
crime_16 = pd.read_csv("Crimes_-_2016.csv")
crime_17 = pd.read_csv("Crimes_-_2017.csv")

#%%
crime_16.info()
print(crime_16.Date[1])

crime_16["Date"] = pd.to_datetime(crime_16.Date, infer_datetime_format=True)

crime_16.info()
print(crime_16.Date[1])

#%%
crime_17.info()
print(crime_17.Date[1])

crime_17["Date"] = pd.to_datetime(crime_17.Date, infer_datetime_format=True)

crime_17.info()
print(crime_17.Date[1])

#%%

crime = pd.concat([crime_16, crime_17], ignore_index=True)

crime = crime[(crime['Date'] >= '2016-09-06') & (crime['Date'] <= '2017-06-20')]

crime.to_csv("crime_1617.csv")

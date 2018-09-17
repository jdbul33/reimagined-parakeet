# -*- coding: utf-8 -*-
"""
Created on Sun Sep 16 13:09:37 2018

@author: jdbul
"""

import pandas as pd
import numpy as np

#%%

crime = pd.read_csv("crime_1617.csv")
crime.info()
crime['Count'] = 1
crime['Count'].head()
crime = crime.dropna(subset=['Ward'])
crime['Ward']=crime.Ward.astype(int)
#%%
"""
Count of total crime by ward for the school year
"""

ward_crimes = crime.groupby("Ward", as_index=False)['Count'].count()
ward_crimes = ward_crimes.rename(columns={'Count':'TotalCrime'})
print(len(ward_crimes))

#%%
"""
Just Homicides
"""
homicides = crime[crime['IUCR'] == '0110'].groupby("Ward", as_index=False)['Count'].count()
homicides = homicides.rename(columns={'Count':'TotalHomicides'})
print(len(homicides))

#%%

crime_totals = pd.merge(ward_crimes, homicides, how="left", on="Ward")
print(crime_totals)
crime_totals.fillna(0, inplace=True)



#%%
"""
General code here, change col names list to change pulled variables
"""

school = pd.read_csv("total_school_data.csv")

high_school = school[school['Grade_Cat'] == 'HS']

col_names = ['WARD_15','Student_Count_Total','Student_Count_Low_Income','Graduation_Rate_School','College_Enrollment_Rate_School', 'School_Survey_Involved_Families',
             'School_Survey_Supportive_Environment','Suspensions_Per_100_Students_Year_1_Pct','Suspensions_Per_100_Students_Year_2_Pct','Student_Attendance_Year_1_Pct','Student_Attendance_Year_2_Pct']

hs_regression = school[col_names]
hs_regression.info()


#%%
"""
Changing survery scores to numeric
"""
ordered_score = ['NOT ENOUGH DATA', 'VERY WEAK', 'WEAK', 'NEUTRAL', 'STRONG', 'VERY STRONG']
hs_regression['Family_Score'] = hs_regression['School_Survey_Involved_Families'].astype("category", ordered=True, categories=ordered_score).cat.codes    
hs_regression['Support_Score'] = hs_regression['School_Survey_Supportive_Environment'].astype("category", ordered=True, categories=ordered_score).cat.codes    

hs_regression = hs_regression.drop(['School_Survey_Supportive_Environment', 'School_Survey_Involved_Families'], axis=1)




#%%
"""
Group school data by average for ward
"""
hs_regression = hs_regression.rename(columns={"WARD_15":"Ward"})
school_data = hs_regression.groupby("Ward", as_index=False).mean()
school_data.isna().sum()
school_data.fillna(school_data.median(), inplace=True)
assert school_data.isna().sum().all() == 0

#%%
"""
Merge with Crime data to prepare for analysis
"""

sas_data = pd.merge(school_data, crime_totals, how="inner", on="Ward")

#%%

sas_data.to_csv("sas_ready.csv")

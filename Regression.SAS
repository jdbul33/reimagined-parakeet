/* Generated Code (IMPORT) */
/* Source File: sas_ready.csv */
/* Source Path: /home/johnbulger0/Econometrics_Proj */
/* Code generated on: 10/16/18, 3:46 PM */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/johnbulger0/Econometrics_Proj/sas_ready.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


%web_open_table(WORK.IMPORT);

data crime_school;
	set work.import;
	logcrime = log(totalcrime);
	loghomicides = log(totalhomicides);
	drop ward;
run;

proc means data=crime_school n nmiss mean median stddev min max;
	vars leader_score graduation_rate_school college_enrollment_rate_school dress_code average_act_school support_score family_score safety_score teacher_collab_score leader_score amb_instruct_score stud_attend teach_attend suspension dropout_rate percent_low_income totalcrime totalhomicides;
run;


proc reg data=crime_school;
	model totalcrime=graduation_rate_school college_enrollment_rate_school dress_code average_act_school support_score family_score safety_score teacher_collab_score leader_score amb_instruct_score stud_attend teach_attend suspension dropout_rate percent_low_income / vif;
quit;	



/* Using Variables from R stepwise regression */



proc reg data=crime_school;
	model totalcrime=graduation_rate_school college_enrollment_rate_school dress_code dropout_rate / vif white;
	quit;



/* Looking at Homicides using same variables */

proc reg data=crime_school;
	model totalhomicides=graduation_rate_school college_enrollment_rate_school dress_code dropout_rate / vif white;
	quit;


/* Using Variables for Log Crime */



proc reg data=crime_school;
	model logcrime=leader_score graduation_rate_school college_enrollment_rate_school dress_code dropout_rate / vif white;
	quit;

/* Using Variables for Log Homicides */



proc reg data=crime_school;
	model loghomicides=graduation_rate_school college_enrollment_rate_school dress_code dropout_rate / vif white;
	quit;

/*check prep.*/
%if not %sysfunc(exist(/*lib*/./*prep_name*/)) %then %do;
    %put NOTE: this prep does not exist.;
    %return;
%end;

/*open prep. for the reading*/
%let dsid=%sysfunc(open(/*lib*/./*prep_name*/));
/*check record in prep.*/
%let nobs=%sysfunc(attrn(&dsid,NLOBS)); /*NLOBS:Number of Logical Observation*/
/*close prep.*/
%let rc=%sysfunc(close(&dsid));

/*when prep. is not records*/
%if &nobs = 0 %then %do;
    %put NOTE: this prep contains no records.;
	%return;
%end;

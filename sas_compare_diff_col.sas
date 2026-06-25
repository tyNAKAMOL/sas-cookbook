/*proc compare*/
proc compare
    base=mst_prep.account_trans1
    compare=mst_prep.account_trans2;
run;

/*merge compare*/
proc contents data=mst_prep.account_trans2
    out=hk_var(keep=name type length)
    noprint;
run;

proc contents data=mst_prep.account_trans1
    out=org_var(keep=name type length)
    noprint;
run;

proc sort data=hk_var; by name; run;
proc sort data=org_var; by name; run;

data compare_var;
    merge hk_var(in=a rename=(type=type_hk length=len_hk))
          org_var(in=b rename=(type=type_org length=len_org));
    by name;

    if a and not b then status='Only in HK';
    else if b and not a then status='Only in ORG';
    else if type_hk ne type_org or len_hk ne len_org
        then status='Type/Length Different';

    if status ne '';
run;

proc print data=compare_var;
run;

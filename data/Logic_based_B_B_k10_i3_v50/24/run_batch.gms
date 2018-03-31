set iter /24*24/
    algo /BM,HR,DB_BM,DB_HR,DB_LD/
    algo2 /BM,HR/
    resu /sol,time,nodes,LB,first,best/
    resu2 /rel,const,vars,bin/;

parameter solu(iter,algo,resu), stats(iter,algo2,resu2);
scalar rel,sol,nodes,time,LBL,first,best,const,vars,bin;


file seed_no / 'seed.gms' /

loop(iter,
   putclose seed_no 'execseed = ' ord(iter) ';';
   execute 'gams Random_gen_presolve.gms s=0 lo=0 o=nul '

   execute 'gams BM_ref.gms r=0 lo=0 o=nul  '
   execute_load "res_prob" rel,sol,nodes,time,LBL,const,vars,bin;
   solu(iter,'BM','sol') = sol;
   solu(iter,'BM','time') = time;
   solu(iter,'BM','nodes') = nodes;
   solu(iter,'BM','LB') = LBL;
   solu(iter,'BM','first') = 0;
   solu(iter,'BM','best') = 0;
   stats(iter,'BM','rel') = rel;
   stats(iter,'BM','const') = const;
   stats(iter,'BM','vars') = vars;
   stats(iter,'BM','bin') = bin;
   execute_unload "stat_total" stats;
   execute_unload "solution_total" solu;

   execute 'gams HR_ref.gms r=0 lo=0 o=nul  '
   execute_load "res_prob" rel,sol,nodes,time,LBL,const,vars,bin;
   solu(iter,'HR','sol') = sol;
   solu(iter,'HR','time') = time;
   solu(iter,'HR','nodes') = nodes;
   solu(iter,'HR','LB') = LBL;
   solu(iter,'HR','first') = 0;
   solu(iter,'HR','best') = 0;
   stats(iter,'HR','rel') = rel;
   stats(iter,'HR','const') = const;
   stats(iter,'HR','vars') = vars;
   stats(iter,'HR','bin') = bin;
   execute_unload "stat_total" stats;
   execute_unload "solution_total" solu;

   execute 'gams Logic_B_B_BM2.gms r=0 lo=0 o=nul  '
   execute_load "res_prob" sol,nodes,time,LBL,first,best;
   solu(iter,'DB_BM','sol') = sol;
   solu(iter,'DB_BM','time') = time;
   solu(iter,'DB_BM','nodes') = nodes;
   solu(iter,'DB_BM','LB') = LBL;
   solu(iter,'DB_BM','first') = first;
   solu(iter,'DB_BM','best') = best;
   execute_unload "solution_total" solu;

   execute 'gams Logic_B_B_HR2.gms r=0 lo=0 o=nul  '
   execute_load "res_prob" sol,nodes,time,LBL,first,best;
   solu(iter,'DB_HR','sol') = sol;
   solu(iter,'DB_HR','time') = time;
   solu(iter,'DB_HR','nodes') = nodes;
   solu(iter,'DB_HR','LB') = LBL;
   solu(iter,'DB_HR','first') = first;
   solu(iter,'DB_HR','best') = best;
   execute_unload "solution_total" solu;


);

*To print the content of the gdx file execute the next line of code
*gdxdump "solution_total" symb=solu format=csv > solution_total.csv



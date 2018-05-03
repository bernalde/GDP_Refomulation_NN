set iter /1*10/
    algo2 /BM,HR/
    resu2 /rel,const,vars,bin/;

parameter stats(iter,algo2,resu2);
scalar rel,const,vars,bin;

$include first_seed
file seed_no / 'seed.gms' /

loop(iter,
   putclose seed_no 'execseed = ' (ord(iter)+first_seed):0:0 ';';
   execute 'gams Random_gen_presolve.gms s=0 lo=0 ';

   execute 'gams BM_ref.gms r=0 lo=0 '
   execute_load "res_prob" rel,const,vars,bin;
   stats(iter,'BM','rel') = rel;
   stats(iter,'BM','const') = const;
   stats(iter,'BM','vars') = vars;
   stats(iter,'BM','bin') = bin;
   execute_unload "stat_total" stats;

   execute 'gams HR_ref.gms r=0 lo=0 '
   execute_load "res_prob" rel,const,vars,bin;
   stats(iter,'HR','rel') = rel;
   stats(iter,'HR','const') = const;
   stats(iter,'HR','vars') = vars;
   stats(iter,'HR','bin') = bin;
   execute_unload "stat_total" stats;

);

*To print the content of the gdx file execute the next line of code
execute 'gdxdump "stat_total" symb=stats format=csv > stat_total.csv';
execute "gdx2sqlite -i stat_total.gdx -o stat_total.db";

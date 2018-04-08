* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '       81.00';';
execute 'gams Random_gen_presolve.gms --seed=81 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_81.gdx -o prob_data_81.db';
putclose seed_no 'execseed = '       82.00';';
execute 'gams Random_gen_presolve.gms --seed=82 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_82.gdx -o prob_data_82.db';
putclose seed_no 'execseed = '       83.00';';
execute 'gams Random_gen_presolve.gms --seed=83 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_83.gdx -o prob_data_83.db';
putclose seed_no 'execseed = '       84.00';';
execute 'gams Random_gen_presolve.gms --seed=84 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_84.gdx -o prob_data_84.db';
putclose seed_no 'execseed = '       85.00';';
execute 'gams Random_gen_presolve.gms --seed=85 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_85.gdx -o prob_data_85.db';
putclose seed_no 'execseed = '       86.00';';
execute 'gams Random_gen_presolve.gms --seed=86 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_86.gdx -o prob_data_86.db';
putclose seed_no 'execseed = '       87.00';';
execute 'gams Random_gen_presolve.gms --seed=87 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_87.gdx -o prob_data_87.db';
putclose seed_no 'execseed = '       88.00';';
execute 'gams Random_gen_presolve.gms --seed=88 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_88.gdx -o prob_data_88.db';
putclose seed_no 'execseed = '       89.00';';
execute 'gams Random_gen_presolve.gms --seed=89 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_89.gdx -o prob_data_89.db';
putclose seed_no 'execseed = '       90.00';';
execute 'gams Random_gen_presolve.gms --seed=90 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_90.gdx -o prob_data_90.db';
execute 'gdx2sqlite -i solution_total.gdx -o solution_total.db';
execute 'gdx2sqlite -i stat_total.gdx -o stat_total.db';

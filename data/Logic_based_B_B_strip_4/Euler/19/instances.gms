* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '        1.00';';
execute 'gams Random_gen_presolve.gms --seed=1 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_1.gdx -o prob_data_1.db';
putclose seed_no 'execseed = '        2.00';';
execute 'gams Random_gen_presolve.gms --seed=2 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_2.gdx -o prob_data_2.db';
putclose seed_no 'execseed = '        3.00';';
execute 'gams Random_gen_presolve.gms --seed=3 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_3.gdx -o prob_data_3.db';
putclose seed_no 'execseed = '        4.00';';
execute 'gams Random_gen_presolve.gms --seed=4 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_4.gdx -o prob_data_4.db';
putclose seed_no 'execseed = '        5.00';';
execute 'gams Random_gen_presolve.gms --seed=5 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_5.gdx -o prob_data_5.db';
putclose seed_no 'execseed = '        6.00';';
execute 'gams Random_gen_presolve.gms --seed=6 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_6.gdx -o prob_data_6.db';
putclose seed_no 'execseed = '        7.00';';
execute 'gams Random_gen_presolve.gms --seed=7 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_7.gdx -o prob_data_7.db';
putclose seed_no 'execseed = '        8.00';';
execute 'gams Random_gen_presolve.gms --seed=8 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_8.gdx -o prob_data_8.db';
putclose seed_no 'execseed = '        9.00';';
execute 'gams Random_gen_presolve.gms --seed=9 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_9.gdx -o prob_data_9.db';
putclose seed_no 'execseed = '       10.00';';
execute 'gams Random_gen_presolve.gms --seed=10 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_10.gdx -o prob_data_10.db';
execute 'gdx2sqlite -i solution_total.gdx -o solution_total.db';
execute 'gdx2sqlite -i stat_total.gdx -o stat_total.db';

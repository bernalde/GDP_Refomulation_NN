* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '       11.00';';
execute 'gams Random_gen_presolve.gms --seed=11 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_11.gdx -o prob_data_11.db';
putclose seed_no 'execseed = '       12.00';';
execute 'gams Random_gen_presolve.gms --seed=12 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_12.gdx -o prob_data_12.db';
putclose seed_no 'execseed = '       13.00';';
execute 'gams Random_gen_presolve.gms --seed=13 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_13.gdx -o prob_data_13.db';
putclose seed_no 'execseed = '       14.00';';
execute 'gams Random_gen_presolve.gms --seed=14 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_14.gdx -o prob_data_14.db';
putclose seed_no 'execseed = '       15.00';';
execute 'gams Random_gen_presolve.gms --seed=15 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_15.gdx -o prob_data_15.db';
putclose seed_no 'execseed = '       16.00';';
execute 'gams Random_gen_presolve.gms --seed=16 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_16.gdx -o prob_data_16.db';
putclose seed_no 'execseed = '       17.00';';
execute 'gams Random_gen_presolve.gms --seed=17 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_17.gdx -o prob_data_17.db';
putclose seed_no 'execseed = '       18.00';';
execute 'gams Random_gen_presolve.gms --seed=18 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_18.gdx -o prob_data_18.db';
putclose seed_no 'execseed = '       19.00';';
execute 'gams Random_gen_presolve.gms --seed=19 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_19.gdx -o prob_data_19.db';
putclose seed_no 'execseed = '       20.00';';
execute 'gams Random_gen_presolve.gms --seed=20 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_20.gdx -o prob_data_20.db';

* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '       31.00';';
execute 'gams Random_gen_presolve.gms --seed=31 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_31.gdx -o prob_data_31.db';
putclose seed_no 'execseed = '       32.00';';
execute 'gams Random_gen_presolve.gms --seed=32 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_32.gdx -o prob_data_32.db';
putclose seed_no 'execseed = '       33.00';';
execute 'gams Random_gen_presolve.gms --seed=33 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_33.gdx -o prob_data_33.db';
putclose seed_no 'execseed = '       34.00';';
execute 'gams Random_gen_presolve.gms --seed=34 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_34.gdx -o prob_data_34.db';
putclose seed_no 'execseed = '       35.00';';
execute 'gams Random_gen_presolve.gms --seed=35 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_35.gdx -o prob_data_35.db';
putclose seed_no 'execseed = '       36.00';';
execute 'gams Random_gen_presolve.gms --seed=36 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_36.gdx -o prob_data_36.db';
putclose seed_no 'execseed = '       37.00';';
execute 'gams Random_gen_presolve.gms --seed=37 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_37.gdx -o prob_data_37.db';
putclose seed_no 'execseed = '       38.00';';
execute 'gams Random_gen_presolve.gms --seed=38 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_38.gdx -o prob_data_38.db';
putclose seed_no 'execseed = '       39.00';';
execute 'gams Random_gen_presolve.gms --seed=39 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_39.gdx -o prob_data_39.db';
putclose seed_no 'execseed = '       40.00';';
execute 'gams Random_gen_presolve.gms --seed=40 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_40.gdx -o prob_data_40.db';

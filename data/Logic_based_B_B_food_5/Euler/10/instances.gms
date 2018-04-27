* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '       21.00';';
execute 'gams Random_gen_presolve.gms --seed=21 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_21.gdx -o prob_data_21.db';
putclose seed_no 'execseed = '       22.00';';
execute 'gams Random_gen_presolve.gms --seed=22 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_22.gdx -o prob_data_22.db';
putclose seed_no 'execseed = '       23.00';';
execute 'gams Random_gen_presolve.gms --seed=23 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_23.gdx -o prob_data_23.db';
putclose seed_no 'execseed = '       24.00';';
execute 'gams Random_gen_presolve.gms --seed=24 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_24.gdx -o prob_data_24.db';
putclose seed_no 'execseed = '       25.00';';
execute 'gams Random_gen_presolve.gms --seed=25 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_25.gdx -o prob_data_25.db';
putclose seed_no 'execseed = '       26.00';';
execute 'gams Random_gen_presolve.gms --seed=26 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_26.gdx -o prob_data_26.db';
putclose seed_no 'execseed = '       27.00';';
execute 'gams Random_gen_presolve.gms --seed=27 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_27.gdx -o prob_data_27.db';
putclose seed_no 'execseed = '       28.00';';
execute 'gams Random_gen_presolve.gms --seed=28 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_28.gdx -o prob_data_28.db';
putclose seed_no 'execseed = '       29.00';';
execute 'gams Random_gen_presolve.gms --seed=29 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_29.gdx -o prob_data_29.db';
putclose seed_no 'execseed = '       30.00';';
execute 'gams Random_gen_presolve.gms --seed=30 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_30.gdx -o prob_data_30.db';

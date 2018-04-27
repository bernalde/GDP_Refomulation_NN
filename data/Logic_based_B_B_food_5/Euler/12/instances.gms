* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '       41.00';';
execute 'gams Random_gen_presolve.gms --seed=41 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_41.gdx -o prob_data_41.db';
putclose seed_no 'execseed = '       42.00';';
execute 'gams Random_gen_presolve.gms --seed=42 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_42.gdx -o prob_data_42.db';
putclose seed_no 'execseed = '       43.00';';
execute 'gams Random_gen_presolve.gms --seed=43 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_43.gdx -o prob_data_43.db';
putclose seed_no 'execseed = '       44.00';';
execute 'gams Random_gen_presolve.gms --seed=44 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_44.gdx -o prob_data_44.db';
putclose seed_no 'execseed = '       45.00';';
execute 'gams Random_gen_presolve.gms --seed=45 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_45.gdx -o prob_data_45.db';
putclose seed_no 'execseed = '       46.00';';
execute 'gams Random_gen_presolve.gms --seed=46 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_46.gdx -o prob_data_46.db';
putclose seed_no 'execseed = '       47.00';';
execute 'gams Random_gen_presolve.gms --seed=47 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_47.gdx -o prob_data_47.db';
putclose seed_no 'execseed = '       48.00';';
execute 'gams Random_gen_presolve.gms --seed=48 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_48.gdx -o prob_data_48.db';
putclose seed_no 'execseed = '       49.00';';
execute 'gams Random_gen_presolve.gms --seed=49 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_49.gdx -o prob_data_49.db';
putclose seed_no 'execseed = '       50.00';';
execute 'gams Random_gen_presolve.gms --seed=50 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_50.gdx -o prob_data_50.db';

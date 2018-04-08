* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '       61.00';';
execute 'gams Random_gen_presolve.gms --seed=61 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_61.gdx -o prob_data_61.db';
putclose seed_no 'execseed = '       62.00';';
execute 'gams Random_gen_presolve.gms --seed=62 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_62.gdx -o prob_data_62.db';
putclose seed_no 'execseed = '       63.00';';
execute 'gams Random_gen_presolve.gms --seed=63 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_63.gdx -o prob_data_63.db';
putclose seed_no 'execseed = '       64.00';';
execute 'gams Random_gen_presolve.gms --seed=64 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_64.gdx -o prob_data_64.db';
putclose seed_no 'execseed = '       65.00';';
execute 'gams Random_gen_presolve.gms --seed=65 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_65.gdx -o prob_data_65.db';
putclose seed_no 'execseed = '       66.00';';
execute 'gams Random_gen_presolve.gms --seed=66 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_66.gdx -o prob_data_66.db';
putclose seed_no 'execseed = '       67.00';';
execute 'gams Random_gen_presolve.gms --seed=67 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_67.gdx -o prob_data_67.db';
putclose seed_no 'execseed = '       68.00';';
execute 'gams Random_gen_presolve.gms --seed=68 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_68.gdx -o prob_data_68.db';
putclose seed_no 'execseed = '       69.00';';
execute 'gams Random_gen_presolve.gms --seed=69 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_69.gdx -o prob_data_69.db';
putclose seed_no 'execseed = '       70.00';';
execute 'gams Random_gen_presolve.gms --seed=70 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_70.gdx -o prob_data_70.db';

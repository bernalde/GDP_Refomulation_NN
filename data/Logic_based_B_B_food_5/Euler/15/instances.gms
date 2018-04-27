* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '       71.00';';
execute 'gams Random_gen_presolve.gms --seed=71 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_71.gdx -o prob_data_71.db';
putclose seed_no 'execseed = '       72.00';';
execute 'gams Random_gen_presolve.gms --seed=72 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_72.gdx -o prob_data_72.db';
putclose seed_no 'execseed = '       73.00';';
execute 'gams Random_gen_presolve.gms --seed=73 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_73.gdx -o prob_data_73.db';
putclose seed_no 'execseed = '       74.00';';
execute 'gams Random_gen_presolve.gms --seed=74 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_74.gdx -o prob_data_74.db';
putclose seed_no 'execseed = '       75.00';';
execute 'gams Random_gen_presolve.gms --seed=75 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_75.gdx -o prob_data_75.db';
putclose seed_no 'execseed = '       76.00';';
execute 'gams Random_gen_presolve.gms --seed=76 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_76.gdx -o prob_data_76.db';
putclose seed_no 'execseed = '       77.00';';
execute 'gams Random_gen_presolve.gms --seed=77 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_77.gdx -o prob_data_77.db';
putclose seed_no 'execseed = '       78.00';';
execute 'gams Random_gen_presolve.gms --seed=78 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_78.gdx -o prob_data_78.db';
putclose seed_no 'execseed = '       79.00';';
execute 'gams Random_gen_presolve.gms --seed=79 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_79.gdx -o prob_data_79.db';
putclose seed_no 'execseed = '       80.00';';
execute 'gams Random_gen_presolve.gms --seed=80 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_80.gdx -o prob_data_80.db';

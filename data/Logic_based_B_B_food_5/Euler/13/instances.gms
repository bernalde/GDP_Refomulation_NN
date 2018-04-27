* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '       51.00';';
execute 'gams Random_gen_presolve.gms --seed=51 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_51.gdx -o prob_data_51.db';
putclose seed_no 'execseed = '       52.00';';
execute 'gams Random_gen_presolve.gms --seed=52 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_52.gdx -o prob_data_52.db';
putclose seed_no 'execseed = '       53.00';';
execute 'gams Random_gen_presolve.gms --seed=53 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_53.gdx -o prob_data_53.db';
putclose seed_no 'execseed = '       54.00';';
execute 'gams Random_gen_presolve.gms --seed=54 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_54.gdx -o prob_data_54.db';
putclose seed_no 'execseed = '       55.00';';
execute 'gams Random_gen_presolve.gms --seed=55 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_55.gdx -o prob_data_55.db';
putclose seed_no 'execseed = '       56.00';';
execute 'gams Random_gen_presolve.gms --seed=56 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_56.gdx -o prob_data_56.db';
putclose seed_no 'execseed = '       57.00';';
execute 'gams Random_gen_presolve.gms --seed=57 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_57.gdx -o prob_data_57.db';
putclose seed_no 'execseed = '       58.00';';
execute 'gams Random_gen_presolve.gms --seed=58 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_58.gdx -o prob_data_58.db';
putclose seed_no 'execseed = '       59.00';';
execute 'gams Random_gen_presolve.gms --seed=59 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_59.gdx -o prob_data_59.db';
putclose seed_no 'execseed = '       60.00';';
execute 'gams Random_gen_presolve.gms --seed=60 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_60.gdx -o prob_data_60.db';

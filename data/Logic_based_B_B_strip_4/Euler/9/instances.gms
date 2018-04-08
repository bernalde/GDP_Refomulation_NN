* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '       91.00';';
execute 'gams Random_gen_presolve.gms --seed=91 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_91.gdx -o prob_data_91.db';
putclose seed_no 'execseed = '       92.00';';
execute 'gams Random_gen_presolve.gms --seed=92 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_92.gdx -o prob_data_92.db';
putclose seed_no 'execseed = '       93.00';';
execute 'gams Random_gen_presolve.gms --seed=93 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_93.gdx -o prob_data_93.db';
putclose seed_no 'execseed = '       94.00';';
execute 'gams Random_gen_presolve.gms --seed=94 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_94.gdx -o prob_data_94.db';
putclose seed_no 'execseed = '       95.00';';
execute 'gams Random_gen_presolve.gms --seed=95 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_95.gdx -o prob_data_95.db';
putclose seed_no 'execseed = '       96.00';';
execute 'gams Random_gen_presolve.gms --seed=96 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_96.gdx -o prob_data_96.db';
putclose seed_no 'execseed = '       97.00';';
execute 'gams Random_gen_presolve.gms --seed=97 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_97.gdx -o prob_data_97.db';
putclose seed_no 'execseed = '       98.00';';
execute 'gams Random_gen_presolve.gms --seed=98 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_98.gdx -o prob_data_98.db';
putclose seed_no 'execseed = '       99.00';';
execute 'gams Random_gen_presolve.gms --seed=99 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_99.gdx -o prob_data_99.db';
putclose seed_no 'execseed = '      100.00';';
execute 'gams Random_gen_presolve.gms --seed=100 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_100.gdx -o prob_data_100.db';

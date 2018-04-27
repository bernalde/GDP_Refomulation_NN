* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '      111.00';';
execute 'gams Random_gen_presolve.gms --seed=111 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_111.gdx -o prob_data_111.db';
putclose seed_no 'execseed = '      112.00';';
execute 'gams Random_gen_presolve.gms --seed=112 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_112.gdx -o prob_data_112.db';
putclose seed_no 'execseed = '      113.00';';
execute 'gams Random_gen_presolve.gms --seed=113 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_113.gdx -o prob_data_113.db';
putclose seed_no 'execseed = '      114.00';';
execute 'gams Random_gen_presolve.gms --seed=114 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_114.gdx -o prob_data_114.db';
putclose seed_no 'execseed = '      115.00';';
execute 'gams Random_gen_presolve.gms --seed=115 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_115.gdx -o prob_data_115.db';
putclose seed_no 'execseed = '      116.00';';
execute 'gams Random_gen_presolve.gms --seed=116 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_116.gdx -o prob_data_116.db';
putclose seed_no 'execseed = '      117.00';';
execute 'gams Random_gen_presolve.gms --seed=117 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_117.gdx -o prob_data_117.db';
putclose seed_no 'execseed = '      118.00';';
execute 'gams Random_gen_presolve.gms --seed=118 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_118.gdx -o prob_data_118.db';
putclose seed_no 'execseed = '      119.00';';
execute 'gams Random_gen_presolve.gms --seed=119 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_119.gdx -o prob_data_119.db';
putclose seed_no 'execseed = '      120.00';';
execute 'gams Random_gen_presolve.gms --seed=120 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_120.gdx -o prob_data_120.db';

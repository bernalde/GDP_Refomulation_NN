* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '      121.00';';
execute 'gams Random_gen_presolve.gms --seed=121 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_121.gdx -o prob_data_121.db';
putclose seed_no 'execseed = '      122.00';';
execute 'gams Random_gen_presolve.gms --seed=122 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_122.gdx -o prob_data_122.db';
putclose seed_no 'execseed = '      123.00';';
execute 'gams Random_gen_presolve.gms --seed=123 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_123.gdx -o prob_data_123.db';
putclose seed_no 'execseed = '      124.00';';
execute 'gams Random_gen_presolve.gms --seed=124 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_124.gdx -o prob_data_124.db';
putclose seed_no 'execseed = '      125.00';';
execute 'gams Random_gen_presolve.gms --seed=125 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_125.gdx -o prob_data_125.db';
putclose seed_no 'execseed = '      126.00';';
execute 'gams Random_gen_presolve.gms --seed=126 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_126.gdx -o prob_data_126.db';
putclose seed_no 'execseed = '      127.00';';
execute 'gams Random_gen_presolve.gms --seed=127 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_127.gdx -o prob_data_127.db';
putclose seed_no 'execseed = '      128.00';';
execute 'gams Random_gen_presolve.gms --seed=128 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_128.gdx -o prob_data_128.db';
putclose seed_no 'execseed = '      129.00';';
execute 'gams Random_gen_presolve.gms --seed=129 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_129.gdx -o prob_data_129.db';
putclose seed_no 'execseed = '      130.00';';
execute 'gams Random_gen_presolve.gms --seed=130 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_130.gdx -o prob_data_130.db';

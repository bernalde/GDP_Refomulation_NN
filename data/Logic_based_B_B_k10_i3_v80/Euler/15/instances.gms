* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '      151.00';';
execute 'gams Random_gen_presolve.gms --seed=151 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_151.gdx -o prob_data_151.db';
putclose seed_no 'execseed = '      152.00';';
execute 'gams Random_gen_presolve.gms --seed=152 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_152.gdx -o prob_data_152.db';
putclose seed_no 'execseed = '      153.00';';
execute 'gams Random_gen_presolve.gms --seed=153 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_153.gdx -o prob_data_153.db';
putclose seed_no 'execseed = '      154.00';';
execute 'gams Random_gen_presolve.gms --seed=154 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_154.gdx -o prob_data_154.db';
putclose seed_no 'execseed = '      155.00';';
execute 'gams Random_gen_presolve.gms --seed=155 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_155.gdx -o prob_data_155.db';
putclose seed_no 'execseed = '      156.00';';
execute 'gams Random_gen_presolve.gms --seed=156 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_156.gdx -o prob_data_156.db';
putclose seed_no 'execseed = '      157.00';';
execute 'gams Random_gen_presolve.gms --seed=157 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_157.gdx -o prob_data_157.db';
putclose seed_no 'execseed = '      158.00';';
execute 'gams Random_gen_presolve.gms --seed=158 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_158.gdx -o prob_data_158.db';
putclose seed_no 'execseed = '      159.00';';
execute 'gams Random_gen_presolve.gms --seed=159 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_159.gdx -o prob_data_159.db';
putclose seed_no 'execseed = '      160.00';';
execute 'gams Random_gen_presolve.gms --seed=160 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_160.gdx -o prob_data_160.db';
execute 'gdx2sqlite -i solution_total.gdx -o solution_total.db';
execute 'gdx2sqlite -i stat_total.gdx -o stat_total.db';

* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '      141.00';';
execute 'gams Random_gen_presolve.gms --seed=141 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_141.gdx -o prob_data_141.db';
putclose seed_no 'execseed = '      142.00';';
execute 'gams Random_gen_presolve.gms --seed=142 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_142.gdx -o prob_data_142.db';
putclose seed_no 'execseed = '      143.00';';
execute 'gams Random_gen_presolve.gms --seed=143 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_143.gdx -o prob_data_143.db';
putclose seed_no 'execseed = '      144.00';';
execute 'gams Random_gen_presolve.gms --seed=144 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_144.gdx -o prob_data_144.db';
putclose seed_no 'execseed = '      145.00';';
execute 'gams Random_gen_presolve.gms --seed=145 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_145.gdx -o prob_data_145.db';
putclose seed_no 'execseed = '      146.00';';
execute 'gams Random_gen_presolve.gms --seed=146 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_146.gdx -o prob_data_146.db';
putclose seed_no 'execseed = '      147.00';';
execute 'gams Random_gen_presolve.gms --seed=147 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_147.gdx -o prob_data_147.db';
putclose seed_no 'execseed = '      148.00';';
execute 'gams Random_gen_presolve.gms --seed=148 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_148.gdx -o prob_data_148.db';
putclose seed_no 'execseed = '      149.00';';
execute 'gams Random_gen_presolve.gms --seed=149 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_149.gdx -o prob_data_149.db';
putclose seed_no 'execseed = '      150.00';';
execute 'gams Random_gen_presolve.gms --seed=150 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_150.gdx -o prob_data_150.db';
execute 'gdx2sqlite -i solution_total.gdx -o solution_total.db';
execute 'gdx2sqlite -i stat_total.gdx -o stat_total.db';

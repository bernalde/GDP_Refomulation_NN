* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '      161.00';';
execute 'gams Random_gen_presolve.gms --seed=161 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_161.gdx -o prob_data_161.db';
putclose seed_no 'execseed = '      162.00';';
execute 'gams Random_gen_presolve.gms --seed=162 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_162.gdx -o prob_data_162.db';
putclose seed_no 'execseed = '      163.00';';
execute 'gams Random_gen_presolve.gms --seed=163 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_163.gdx -o prob_data_163.db';
putclose seed_no 'execseed = '      164.00';';
execute 'gams Random_gen_presolve.gms --seed=164 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_164.gdx -o prob_data_164.db';
putclose seed_no 'execseed = '      165.00';';
execute 'gams Random_gen_presolve.gms --seed=165 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_165.gdx -o prob_data_165.db';
putclose seed_no 'execseed = '      166.00';';
execute 'gams Random_gen_presolve.gms --seed=166 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_166.gdx -o prob_data_166.db';
putclose seed_no 'execseed = '      167.00';';
execute 'gams Random_gen_presolve.gms --seed=167 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_167.gdx -o prob_data_167.db';
putclose seed_no 'execseed = '      168.00';';
execute 'gams Random_gen_presolve.gms --seed=168 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_168.gdx -o prob_data_168.db';
putclose seed_no 'execseed = '      169.00';';
execute 'gams Random_gen_presolve.gms --seed=169 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_169.gdx -o prob_data_169.db';
putclose seed_no 'execseed = '      170.00';';
execute 'gams Random_gen_presolve.gms --seed=170 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_170.gdx -o prob_data_170.db';
execute 'gdx2sqlite -i solution_total.gdx -o solution_total.db';
execute 'gdx2sqlite -i stat_total.gdx -o stat_total.db';

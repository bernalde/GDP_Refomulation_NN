* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '      181.00';';
execute 'gams Random_gen_presolve.gms --seed=181 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_181.gdx -o prob_data_181.db';
putclose seed_no 'execseed = '      182.00';';
execute 'gams Random_gen_presolve.gms --seed=182 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_182.gdx -o prob_data_182.db';
putclose seed_no 'execseed = '      183.00';';
execute 'gams Random_gen_presolve.gms --seed=183 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_183.gdx -o prob_data_183.db';
putclose seed_no 'execseed = '      184.00';';
execute 'gams Random_gen_presolve.gms --seed=184 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_184.gdx -o prob_data_184.db';
putclose seed_no 'execseed = '      185.00';';
execute 'gams Random_gen_presolve.gms --seed=185 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_185.gdx -o prob_data_185.db';
putclose seed_no 'execseed = '      186.00';';
execute 'gams Random_gen_presolve.gms --seed=186 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_186.gdx -o prob_data_186.db';
putclose seed_no 'execseed = '      187.00';';
execute 'gams Random_gen_presolve.gms --seed=187 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_187.gdx -o prob_data_187.db';
putclose seed_no 'execseed = '      188.00';';
execute 'gams Random_gen_presolve.gms --seed=188 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_188.gdx -o prob_data_188.db';
putclose seed_no 'execseed = '      189.00';';
execute 'gams Random_gen_presolve.gms --seed=189 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_189.gdx -o prob_data_189.db';
putclose seed_no 'execseed = '      190.00';';
execute 'gams Random_gen_presolve.gms --seed=190 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_190.gdx -o prob_data_190.db';
execute 'gdx2sqlite -i solution_total.gdx -o solution_total.db';
execute 'gdx2sqlite -i stat_total.gdx -o stat_total.db';

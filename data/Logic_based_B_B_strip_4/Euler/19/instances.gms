* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '      191.00';';
execute 'gams Random_gen_presolve.gms --seed=191 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_191.gdx -o prob_data_191.db';
putclose seed_no 'execseed = '      192.00';';
execute 'gams Random_gen_presolve.gms --seed=192 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_192.gdx -o prob_data_192.db';
putclose seed_no 'execseed = '      193.00';';
execute 'gams Random_gen_presolve.gms --seed=193 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_193.gdx -o prob_data_193.db';
putclose seed_no 'execseed = '      194.00';';
execute 'gams Random_gen_presolve.gms --seed=194 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_194.gdx -o prob_data_194.db';
putclose seed_no 'execseed = '      195.00';';
execute 'gams Random_gen_presolve.gms --seed=195 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_195.gdx -o prob_data_195.db';
putclose seed_no 'execseed = '      196.00';';
execute 'gams Random_gen_presolve.gms --seed=196 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_196.gdx -o prob_data_196.db';
putclose seed_no 'execseed = '      197.00';';
execute 'gams Random_gen_presolve.gms --seed=197 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_197.gdx -o prob_data_197.db';
putclose seed_no 'execseed = '      198.00';';
execute 'gams Random_gen_presolve.gms --seed=198 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_198.gdx -o prob_data_198.db';
putclose seed_no 'execseed = '      199.00';';
execute 'gams Random_gen_presolve.gms --seed=199 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_199.gdx -o prob_data_199.db';
putclose seed_no 'execseed = '      200.00';';
execute 'gams Random_gen_presolve.gms --seed=200 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_200.gdx -o prob_data_200.db';

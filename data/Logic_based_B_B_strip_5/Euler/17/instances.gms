* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '      171.00';';
execute 'gams Random_gen_presolve.gms --seed=171 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_171.gdx -o prob_data_171.db';
putclose seed_no 'execseed = '      172.00';';
execute 'gams Random_gen_presolve.gms --seed=172 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_172.gdx -o prob_data_172.db';
putclose seed_no 'execseed = '      173.00';';
execute 'gams Random_gen_presolve.gms --seed=173 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_173.gdx -o prob_data_173.db';
putclose seed_no 'execseed = '      174.00';';
execute 'gams Random_gen_presolve.gms --seed=174 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_174.gdx -o prob_data_174.db';
putclose seed_no 'execseed = '      175.00';';
execute 'gams Random_gen_presolve.gms --seed=175 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_175.gdx -o prob_data_175.db';
putclose seed_no 'execseed = '      176.00';';
execute 'gams Random_gen_presolve.gms --seed=176 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_176.gdx -o prob_data_176.db';
putclose seed_no 'execseed = '      177.00';';
execute 'gams Random_gen_presolve.gms --seed=177 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_177.gdx -o prob_data_177.db';
putclose seed_no 'execseed = '      178.00';';
execute 'gams Random_gen_presolve.gms --seed=178 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_178.gdx -o prob_data_178.db';
putclose seed_no 'execseed = '      179.00';';
execute 'gams Random_gen_presolve.gms --seed=179 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_179.gdx -o prob_data_179.db';
putclose seed_no 'execseed = '      180.00';';
execute 'gams Random_gen_presolve.gms --seed=180 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_180.gdx -o prob_data_180.db';

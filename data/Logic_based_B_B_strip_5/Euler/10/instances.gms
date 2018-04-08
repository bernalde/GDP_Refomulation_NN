* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '      101.00';';
execute 'gams Random_gen_presolve.gms --seed=101 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_101.gdx -o prob_data_101.db';
putclose seed_no 'execseed = '      102.00';';
execute 'gams Random_gen_presolve.gms --seed=102 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_102.gdx -o prob_data_102.db';
putclose seed_no 'execseed = '      103.00';';
execute 'gams Random_gen_presolve.gms --seed=103 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_103.gdx -o prob_data_103.db';
putclose seed_no 'execseed = '      104.00';';
execute 'gams Random_gen_presolve.gms --seed=104 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_104.gdx -o prob_data_104.db';
putclose seed_no 'execseed = '      105.00';';
execute 'gams Random_gen_presolve.gms --seed=105 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_105.gdx -o prob_data_105.db';
putclose seed_no 'execseed = '      106.00';';
execute 'gams Random_gen_presolve.gms --seed=106 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_106.gdx -o prob_data_106.db';
putclose seed_no 'execseed = '      107.00';';
execute 'gams Random_gen_presolve.gms --seed=107 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_107.gdx -o prob_data_107.db';
putclose seed_no 'execseed = '      108.00';';
execute 'gams Random_gen_presolve.gms --seed=108 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_108.gdx -o prob_data_108.db';
putclose seed_no 'execseed = '      109.00';';
execute 'gams Random_gen_presolve.gms --seed=109 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_109.gdx -o prob_data_109.db';
putclose seed_no 'execseed = '      110.00';';
execute 'gams Random_gen_presolve.gms --seed=110 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_110.gdx -o prob_data_110.db';

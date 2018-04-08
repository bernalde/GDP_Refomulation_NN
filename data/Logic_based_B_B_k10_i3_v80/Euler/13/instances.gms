* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '      131.00';';
execute 'gams Random_gen_presolve.gms --seed=131 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_131.gdx -o prob_data_131.db';
putclose seed_no 'execseed = '      132.00';';
execute 'gams Random_gen_presolve.gms --seed=132 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_132.gdx -o prob_data_132.db';
putclose seed_no 'execseed = '      133.00';';
execute 'gams Random_gen_presolve.gms --seed=133 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_133.gdx -o prob_data_133.db';
putclose seed_no 'execseed = '      134.00';';
execute 'gams Random_gen_presolve.gms --seed=134 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_134.gdx -o prob_data_134.db';
putclose seed_no 'execseed = '      135.00';';
execute 'gams Random_gen_presolve.gms --seed=135 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_135.gdx -o prob_data_135.db';
putclose seed_no 'execseed = '      136.00';';
execute 'gams Random_gen_presolve.gms --seed=136 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_136.gdx -o prob_data_136.db';
putclose seed_no 'execseed = '      137.00';';
execute 'gams Random_gen_presolve.gms --seed=137 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_137.gdx -o prob_data_137.db';
putclose seed_no 'execseed = '      138.00';';
execute 'gams Random_gen_presolve.gms --seed=138 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_138.gdx -o prob_data_138.db';
putclose seed_no 'execseed = '      139.00';';
execute 'gams Random_gen_presolve.gms --seed=139 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_139.gdx -o prob_data_139.db';
putclose seed_no 'execseed = '      140.00';';
execute 'gams Random_gen_presolve.gms --seed=140 s=0 lo=0 '
execute 'gdx2sqlite -i prob_data_140.gdx -o prob_data_140.db';
execute 'gdx2sqlite -i solution_total.gdx -o solution_total.db';
execute 'gdx2sqlite -i stat_total.gdx -o stat_total.db';

* Run file to generate 10.00instances of mymodel
file seed_no / 'seed.gms' /
putclose seed_no 'execseed = '        1.00';';
execute 'gams Random_gen_presolve.gms --seed=1 s=0 lo=0 '
putclose seed_no 'execseed = '        2.00';';
execute 'gams Random_gen_presolve.gms --seed=2 s=0 lo=0 '
putclose seed_no 'execseed = '        3.00';';
execute 'gams Random_gen_presolve.gms --seed=3 s=0 lo=0 '
putclose seed_no 'execseed = '        4.00';';
execute 'gams Random_gen_presolve.gms --seed=4 s=0 lo=0 '
putclose seed_no 'execseed = '        5.00';';
execute 'gams Random_gen_presolve.gms --seed=5 s=0 lo=0 '
putclose seed_no 'execseed = '        6.00';';
execute 'gams Random_gen_presolve.gms --seed=6 s=0 lo=0 '
putclose seed_no 'execseed = '        7.00';';
execute 'gams Random_gen_presolve.gms --seed=7 s=0 lo=0 '
putclose seed_no 'execseed = '        8.00';';
execute 'gams Random_gen_presolve.gms --seed=8 s=0 lo=0 '
putclose seed_no 'execseed = '        9.00';';
execute 'gams Random_gen_presolve.gms --seed=9 s=0 lo=0 '
putclose seed_no 'execseed = '       10.00';';
execute 'gams Random_gen_presolve.gms --seed=10 s=0 lo=0 '

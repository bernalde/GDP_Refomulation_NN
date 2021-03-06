set iter /1*10/
;
parameter i /0/;
$include first_seed
i = first_seed;
file frun / instances.gms /; put frun '* Run file to generate ' card(iter):0 'instances of mymodel';
put / "file seed_no / 'seed.gms' /";
loop(iter,
         i = i + 1;
         put / "putclose seed_no 'execseed = '" (ord(iter)+first_seed) "';';";
         put / "execute 'gams Random_gen_presolve.gms --seed=" i:0:0 " s=0 lo=0 '";
         put / "execute 'gdx2sqlite -i prob_data_"(ord(iter)+first_seed):0:0 ".gdx -o prob_data_"(ord(iter)+first_seed):0:0 ".db';";
);
put / "execute 'gdx2sqlite -i solution_total.gdx -o solution_total.db';";
put / "execute 'gdx2sqlite -i stat_total.gdx -o stat_total.db';";


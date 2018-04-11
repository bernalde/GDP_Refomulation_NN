for D in ./*; do
    if [ -d "$D" ]; then
	cp ./run_batch.gms "$D"
	cp ./cplex.opt "$D"
	cp ./Logic_B_B_BM2.gms "$D"
	cp ./Logic_B_B_HR2.gms "$D"
	cp ./generate_batch.gms "$D"
	cp ./Random_gen_presolve.gms "$D"
        cd "$D"
        gams generate_batch.gms
        gams instances.gms
	rm prob_data*.gdx
	rm *.lst
        cd ..
    fi
done

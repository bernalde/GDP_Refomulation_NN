declare -i iter
iter=0
for D in ./*; do
    if [ -d "$D" ]; then
	sed -i '1s@.*@scalar first_seed /'"$iter"'0/;''@' first_seed.gms
	cp ./first_seed.gms "$D"
	cp ./BM_ref.gms "$D"
	cp ./HR_ref.gms "$D"
	cp ./Random_gen_presolve.gms "$D"
	cp ./Logic_B_B_HR2.gms "$D"
	cp ./Logic_B_B_BM2.gms "$D"
	cp ./run_batch.gms "$D"
	cp ./generate_batch.gms "$D"
	iter=$(( $iter + 1))
    fi
done

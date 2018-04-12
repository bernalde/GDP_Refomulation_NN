for D in ./*; do
    if [ -d "$D" ]; then
	cp ./Logic_B_B_HR2.gms "$D"
	cp ./run_batch.gms "$D"
        cd "$D"
        cd ..
    fi
done

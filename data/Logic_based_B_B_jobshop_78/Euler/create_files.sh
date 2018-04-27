for D in ./*; do
    if [ -d "$D" ]; then
        cd "$D"
        gams generate_batch.gms
        gams instances.gms
	rm *.lst
        cd ..
    fi
done

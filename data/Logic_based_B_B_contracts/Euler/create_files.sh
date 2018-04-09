for D in ./*; do
    if [ -d "$D" ]; then
	cp ./generate_batch.gms "$D"
        cd "$D"
	rm *.g00
	rm *.lxi
	rm *.db
	rm Untitle*
        gams generate_batch.gms
        gams instances.gms
	rm prob_data*.gdx
        cd ..
    fi
done

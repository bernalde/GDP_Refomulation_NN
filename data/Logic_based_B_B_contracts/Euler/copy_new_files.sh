for D in ./*; do
    if [ -d "$D" ]; then
	cp ./run_stats.gms "$D"
        cd "$D"
        cd ..
    fi
done

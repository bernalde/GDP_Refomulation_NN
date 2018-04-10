for D in ./*; do
    if [ -d "$D" ]; then
        cd "$D"
        gams dbs.gms
	rm dbs.lst
        cd ..
    fi
done

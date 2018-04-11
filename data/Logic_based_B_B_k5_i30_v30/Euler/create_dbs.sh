for D in ./*; do
    if [ -d "$D" ]; then
        cd "$D"
        gams dbs.gms
        cd ..
    fi
done

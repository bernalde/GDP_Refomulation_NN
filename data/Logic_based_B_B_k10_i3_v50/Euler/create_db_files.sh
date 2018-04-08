for D in ./*; do
    if [ -d "$D" ]; then
        cd "$D"
        pwd
        cd ..
    fi
done

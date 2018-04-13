for D in ./*; do
    if [ -d "$D" ]; then
        cd "$D"
	rm prob_data_1.db
	rm prob_data_2.db
	rm prob_data_3.db
	rm prob_data_4.db
	rm prob_data_5.db
	rm prob_data_6.db
	rm prob_data_7.db
	rm prob_data_8.db
	rm prob_data_9.db
	rm prob_data_10.db
	rm Unti*
	rm *LAG*
	rm *.g00
	cd ..
    fi
done

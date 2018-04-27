declare -i iter
iter=0
for D in ./*; do
    if [ -d "$D" ]; then
	if [[ $iter -gt 5 && $iter -lt 12 ]]; then
	echo $iter
	sed -i '13s/.*/#PBS -N contracts_'"$iter"'/' parallel.sh
	sed -i '17s@.*@cd /home/bernalde/IntroToMLProj/GDP_Refomulation_NN/data/Logic_based_B_B_contracts/Euler/'"$iter"'@' parallel.sh
	qsub parallel.sh
	fi
	iter=$(( $iter + 1))
    fi
done

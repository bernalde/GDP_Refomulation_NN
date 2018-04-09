declare -i iter
iter=0
for D in ./*; do
    if [ -d "$D" ]; then
	echo $iter
	sed -i '13s/.*/#PBS -N constracts_'"$iter"'/' parallel.sh
	sed -i '17s@.*@cd /home/bernalde/IntroToMLProj/GDP_Refomulation_NN/data/Logic_based_B_B_constracts/Euler/'"$iter"'@' parallel.sh
	qsub parallel.sh
	iter=$(( $iter + 1))
    fi
done

declare -i iter
iter=0
for D in ./*; do
    if [ -d "$D" ]; then
	echo $iter
	sed -i '13s/.*/#PBS -N stats_'"$iter"'/' parallel_st.sh
	sed -i '17s@.*@cd /home/bernalde/IntroToMLProj/GDP_Refomulation_NN/data/Logic_based_B_B_contracts/Euler/'"$iter"'@' parallel_st.sh
	qsub parallel_st.sh
	iter=$(( $iter + 1))
    fi
done

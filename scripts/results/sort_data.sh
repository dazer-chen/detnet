for I in bwresv stresv;do
	for J in mid full;do
		cat rx_"$I"_"$J".dat | sort -rnk4 > rx_"$I"_"$J"_sort.dat
		for A in 1 2 3 4 5;do
			grep "$(cat rx_"$I"_"$J".dat | sort -rnk4 | awk '{print $1" "$2}' | head -n"$A" | tail -n1)" tx_"$I"_"$J".dat >> tx_"$I"_"$J"_sort.dat
		done
	done
done

	I="bwresv"
	J="low"
		cat rx_"$I"_"$J".dat | sort -nk4 | tail -n5 > rx_"$I"_"$J"_sort.dat
		for A in 1 2 3 4 5;do
			grep "$(cat rx_"$I"_"$J".dat | sort -nk4 | tail -n5 | awk '{print $1" "$2}' | head -n"$A" | tail -n1)" tx_"$I"_"$J".dat >> tx_"$I"_"$J"_sort.dat
		done

		I="stresv"
	J="low"
		cat rx_"$I"_"$J".dat | sort -rnk4  > rx_"$I"_"$J"_sort.dat
		for A in 1 2 3 4 5;do
			grep "$(cat rx_"$I"_"$J".dat | sort -rnk4  | awk '{print $1" "$2}' | head -n"$A" | tail -n1)" tx_"$I"_"$J".dat >> tx_"$I"_"$J"_sort.dat
		done
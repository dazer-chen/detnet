if [[ $1 -eq 1 ]];then
for k in bwresv stresv fifo fd ared;do for j in 1 2 3 4 5;do i=500;while [[ $i -le 8500 ]];do echo "$k $i $(cat rx_"$k"_"$i".dat | sort -rnk2 | head -n"$j" | tail -n1) $(cat packets_"$k"_"$i".dat | sort -rnk2 | head -n"$j" | tail -n1 | awk '{print $4}')";i=$(( $i+500 ));done > rx_"$k"_flow_"$j".dat; cat rx_"$k"_flow_"$j".dat; echo "#######";done;done
for k in bwresv stresv fifo fd ared;do for j in 1 2 3 4 5;do i=500;while [[ $i -le 8500 ]];do echo "$k $i $(cat tx_"$k"_"$i".dat | sort -rnk2 | head -n"$j" | tail -n1) $(cat packets_"$k"_"$i".dat | sort -rnk2 | head -n"$j" | tail -n1 | awk '{print $4}')";i=$(( $i+500 ));done > tx_"$k"_flow_"$j".dat; cat tx_"$k"_flow_"$j".dat; echo "#######";done;done
for j in bwresv stresv fd fifo ared;do i=500;while [[ $i -le 8500 ]];do A="$(awk '{sum += $1 } END { print sum }' pkt_"$j"_"$i".dat)".0;B=$(cat pkt_"$j"_"$i".dat | wc -l);echo "$j $i $(python -c "print($A/$B)")";i=$(( $i+500 ));done > pkt_"$j"_av.dat; cat pkt_"$j"_av.dat;done
fi

if [[ $1 -eq 0 ]];then
for a in 1 2 3 4 160 320 640 960; do for k in bwresv ;do for j in 1 2 3 4 5;do i=500;while [[ $i -le 8500 ]];do echo "$k $a $i $(cat rx_"$k"_"$i"_"$a".dat | sort -rnk2 | head -n"$j" | tail -n1) $(cat packets_"$k"_"$i"_"$a".dat | sort -rnk2 | head -n"$j" | tail -n1 | awk '{print $4}')";i=$(( $i+500 ));done > rx_"$k"_"$a"_flow_"$j".dat; cat rx_"$k"_"$a"_flow_"$j".dat; echo "#######";done;done;done
for a in 1 2 3 4 160 320 640 960; do for k in bwresv ;do for j in 1 2 3 4 5;do i=500;while [[ $i -le 8500 ]];do echo "$k $a $i $(cat tx_"$k"_"$i"_"$a".dat | sort -rnk2 | head -n"$j" | tail -n1) $(cat packets_"$k"_"$i"_"$a".dat | sort -rnk2 | head -n"$j" | tail -n1 | awk '{print $4}')";i=$(( $i+500 ));done > tx_"$k"_"$a"_flow_"$j".dat; cat tx_"$k"_"$a"_flow_"$j".dat; echo "#######";done;done;done
fi
#for a in 5 10 20 40 80; do for j in bwresv stresv fd fifo ared;do i=500;while [[ $i -le 8500 ]];do A="$(awk '{sum += $1 } END { print sum }' pkt_"$j"_"$i".dat)".0;B=$(cat pkt_"$j"_"$i".dat | wc -l);echo "$j $i $(python -c "print($A/$B)")";i=$(( $i+500 ));done > pkt_"$j"_av.dat; cat pkt_"$j"_av.dat;done;done

DIR=/home/vamsi/src/detnet/scripts
RES=/home/vamsi/src/detnet/scripts/results

#echo -e "$B\t$A\t$(cat "$RES"/delay_"$B"_"$A".dat | tail -n1 | awk '{print $4}')\t$(awk '{ sum += $4 } END { print sum }' "$RES"/rx_"$B"_"$A".dat)" >> $RES/temp
#A=1000
#rm $RES/delay_util_profile_"$B".dat

D=(DETNET STRESV FD FIFO RED CODEL)
E=(bwresv stresv fd fifo ared codel)
F=($NS3/src/traffic-control/model/bw_resv.cc $NS3/src/traffic-control/model/stresv.cc $NS3/src/traffic-control/model/fd.cc $NS3/src/traffic-control/model/fifo-queue-disc.cc $NS3/src/traffic-control/model/red-queue-disc.cc $NS3/src/traffic-control/model/codel-queue-disc.cc)
echo ${F[0]}
#D=(RED)
#E=(ared)
I=0
C=640
for C in 1 2 3 4 640 960;do
#while [[ $C -le 640 ]];do
	X=${D[$I]}
	B=${E[$I]}
	sed -i -e 's$#define .*QU$#define '$X'QU$g' /home/vamsi/src/detnet/ns-3-allinone/ns-3-dev/scratch/detnet_8.cc
	A=500
	sed -i -e 's/#define PACKETSFIFO .*/#define PACKETSFIFO 0/g' ${F[3]}
	sed -i -e 's/#define PACKETS'$X' .*/#define PACKETS'$X' 1/g' ${F[$I]}
	sed -i -e 's/uint32_t z = .*/uint32_t z = '$C';/g' ${F[$I]}
	rm $RES/delay_util_profile_"$B"_"$C".dat
	while [[ $A -le 8500 ]];do
		cd $DIR
		sed -i -e 's#uint64_t z = .*#uint64_t z = '$A';#g' /home/vamsi/src/detnet/ns-3-allinone/ns-3-dev/scratch/detnet_8.cc
		#RATEC=$(python -c "print(1.0/(($A*1000.0*(1000.0/1030.0))/(1000*8)))")
		#RATEM=$RATEC
		#sed -i -e 's#onoff.SetAttribute("OnTime", StringValue (".*"))#onoff.SetAttribute("OnTime", StringValue ("ns3::ConstantRandomVariable[Constant='$RATEC']"))#g' /home/vamsi/src/detnet/ns-3-allinone/ns-3-dev/scratch/detnet_8.cc
		#sed -i -e 's#onoff.SetAttribute("OffTime", StringValue (".*"))#onoff.SetAttribute("OffTime", StringValue ("ns3::ExponentialRandomVariable[Mean='$RATEM']"))#g' /home/vamsi/src/detnet/ns-3-allinone/ns-3-dev/scratch/detnet_8.cc
		echo "###################"
		echo "Experiment $B $A $C"
		echo "###################"
		$DIR/bwresv1.sh $B $A $C
		echo -e "$B\t$C\t$A\t$(cat "$RES"/delay_"$B"_"$A"_"$C".dat | tail -n1 | awk '{print $4}')\t$(awk '{ sum += $4 } END { print sum }' "$RES"/rx_"$B"_"$A"_"$C".dat)" >> $RES/delay_util_profile_"$B"_"$C".dat
		A=$(( $A+500 ))
	done
	C=$(python -c "print($C*2)")
done

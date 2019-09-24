DIR=/home/vamsi/src/detnet/scripts/results
cd $NS3
#FILE=$NS3/scratch/detnet_2.cc

rm $DIR/rx.dat
rm $DIR/tx.dat
rm $DIR/pkt.dat
rm $DIR/delay.dat
rm $DIR/packets.dat
rm $DIR/time.dat

./waf --run detnet_8 #> /tmp/detnet.dat

#cat /tmp/detnet.dat | grep ThroughputRx > $DIR/rx.dat
#cat /tmp/detnet.dat | grep ThroughputTx > $DIR/tx.dat
#echo "Throughput RX"
#cat $DIR/rx.dat
#echo "Throughput Tx"
#cat $DIR/tx.dat

cd $DIR
cp rx.dat rx_"$1"_"$2"_"$3".dat
cp tx.dat tx_"$1"_"$2"_"$3".dat
cp delay.dat delay_"$1"_"$2"_"$3".dat
cp pkt.dat pkt_"$1"_"$2"_"$3".dat
cp packets.dat packets_"$1"_"$2"_"$3".dat

#gnuplot -c rx.gp $1
#gnuplot tx.gp
#gnuplot -c delay.gp $1
#gnuplot -c pkt.gp $1
#gnuplot jitter.gp $1

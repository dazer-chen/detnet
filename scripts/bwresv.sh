DIR=/home/vamsi/src/detnet/scripts/results
cd $NS3
FILE=$NS3/scratch/detnet_3.cc

echo > $DIR/rx.dat
echo > $DIR/txdat
echo > $DIR/pkt.dat
echo > $DIR/delay.dat
echo > $DIR/packets.dat
./waf --run detnet_3 #> /tmp/detnet.dat
#cat /tmp/detnet.dat | grep ThroughputRx > $DIR/rx.dat
#cat /tmp/detnet.dat | grep ThroughputTx > $DIR/tx.dat
#echo "Throughput RX"
#cat $DIR/rx.dat
#echo "Throughput Tx"
#cat $DIR/tx.dat
cd $DIR
gnuplot rx.gp
#gnuplot tx.gp
gnuplot delay.gp
gnuplot pkt.gp
gnuplot jitter.gp

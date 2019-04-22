DIR=/home/vamsi/src/detnet/scripts/results
cd $NS3
FILE=$NS3/scratch/detnet_2.cc

#echo > $DIR/rx.dat
#echo > $DIR/tx.dat
./waf --run detnet_2 #> /tmp/detnet.dat
#cat /tmp/detnet.dat | grep ThroughputRx > $DIR/rx.dat
#cat /tmp/detnet.dat | grep ThroughputTx > $DIR/tx.dat
#echo "Throughput RX"
#cat $DIR/rx.dat
#echo "Throughput Tx"
#cat $DIR/tx.dat
#cd $DIR
#gnuplot rx.gp
#gnuplot tx.gp

DIR=/home/vamsi/src/detnet/scripts/results
cd $NS3
FILE=$NS3/scratch/detnet_2.cc

echo > $DIR/rx.dat
echo > $DIR/tx.dat
echo > $DIR/pkt.dat
echo > $DIR/delay.dat
echo > $DIR/packets.dat
echo > $DIR/time.dat
./waf --run detnet_6 #> /tmp/detnet.dat
#cat /tmp/detnet.dat | grep ThroughputRx > $DIR/rx.dat
#cat /tmp/detnet.dat | grep ThroughputTx > $DIR/tx.dat
#echo "Throughput RX"
#cat $DIR/rx.dat
#echo "Throughput Tx"
#cat $DIR/tx.dat
cd $DIR
#cp rx.dat rx_$1.dat
#cp tx.dat tx_$1.dat
#cp delay.dat delay_$1.dat
#gnuplot t.gp
#gnuplot tcp_rx.gp
#gnuplot tx.gp
#gnuplot tcp_delay.gp
#gnuplot tcp_pkt.gp

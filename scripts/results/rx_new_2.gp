#! xgp flow_pps.dat
# Created the Fri Dec  8 02:30:12 CET 2017 with:
#   ____________________________
#  /                            \
# /        xgp        __________/
# \__________________/.:nonsns:.
#
 
#-------------------------------------
# SHAPES:
# (c)ircle  (t)riangle (i)nv.tri.
#           (d)iamond  (s)quare
# FILLING:
# (f)illed  (o)paque  (e)mpty (default)
#-------------------------------------
   s=4  ; es=s  ; fs=s+1 ; os=s+66
   c=6  ; ec=c  ; fc=c+1 ; oc=os+1
   t=8  ; et=t  ; ft=t+1 ; ot=oc+1
   i=10 ; ei=i  ; fi=i+1 ; oi=ot+1
   d=12 ; ed=d  ; fd=d+1 ; od=oi+1
   p=14 ; ep=p  ; fp=p+1 ; op=od+1
#-------------------------------------
#  e.g.:  
#  empty circles vs filled squares
#  plot "file" u 1:3 w p pt ec, 
#           "" u 1:4 w lp pt fs
#-------------------------------------

#Happy gnuplotting
#ty=ARG1
set out "rx_new_2.pdf"
#set out "rx_detnet.pdf"
#set out "rx_fifo.pdf"
set term pdf font "Times,12"
#set terminal X11 enhanced font "courier 10 pitch, 16" size 1300,1000

set pointsize 0.75

set key top left
#set ylabel "Per flow rate [pps]"
#set title "Priority Bandwidth reservation Output (21Mbps Input link and 10Mbps Output link)\nPriority Bandwidth Sharing\n10 Detnet Flows and 2 Other heavy flows\nExplicit Bandwidth Reservation for Detnet Flows (Flows send their bandwidth requirement)\n and the remaining availble bandwidth is fairly shared by other flows."
#set title "Fifo Queue Output (21Mbps Input link and 10Mbps Output link)\n10 Detnet Flows and 2 Other heavy flows"

set xlabel "TX Bitrate of Each Priority Flow (Mbps)"
set xtics 1


#set ytics 0.1
#set boxwidth 0.5
#set style fill solid
#set ytics nomirror
#set y2tics
#set yrange [0:5]
#set y2range [0:6000]

set ylabel "RX Bitrate: Priority Flow (Mbps)"

#set y2label "Flow Weight"
#set format y "%.t^.10^%T"
#set ytics 200000
#set yran [1e3:]
#min(a,b)=a<b?a:b
#stats 	'flow_pps.dat'	every ::1 using 1 nooutput
#total=int(STATS_sum)
#print("Total Throughput")
#print(total)
#f(x)=total


set yrange [0:9]
#set ytics nomirror
#set y2range [0:0.1]
#set y2label "Average End-to-End Latency (Secs)\nof Received Packets"
#set y2tics 0.01
set ytics 1
set xrange [0.5:8.5]

#t = 3000.0 / 1024
set arrow 1 from 0,5 to 10,5 nohead dt "-"

#set label "(DetnetFlow)" at 0.8,-0.8
#set label "(DetnetFlow)" at 1.6,-0.8
#set label "(DetnetFlow)" at 2.6,-0.8

set arrow 2 from 1.2,6 to 1.2,5.2
set label "Bw Reservation" at 0.75,4.7

set multiplot layout 1, 2 
#unset title
#unset xlabel
#unset key




plot \
'<cat rx_bwresv_flow_3.dat'	u ($2)/1000:($6)/1000 t 'MFD' axes x1y1 with linespoints lw 1 pt ft lc rgb "blue" pointsize 1,\
'<cat rx_stresv_flow_3.dat'	u ($2)/1000:($6)/1000 t 'STRESV' axes x1y1 with linespoints lw 1 pt ec lc rgb "black" pointsize 1,\
'<cat rx_fd_flow_3.dat'		u ($2)/1000:($6)/1000 t 'FD' axes x1y1 with linespoints lw 1 pt es lc rgb "green",\
'<cat rx_ared_flow_3.dat'	u ($2)/1000:($6)/1000 t 'ARED' axes x1y1 with linespoints lw 1.5 pt ei lc rgb "brown",\
'<cat rx_fifo_flow_3.dat'	u ($2)/1000:($6)/1000 t 'FIFO' axes x1y1 with linespoints lw 1 pt ed lc rgb "violet",\
'<cat tx_bwresv_flow_3.dat'	u ($2)/1000:($6)/1000 t 'Tx' axes x1y1 with linespoints lw 1.5 pt et lc rgb "red"


unset ylabel
unset arrow
unset label
set ylabel "RX Bitrate: Non-Priority Flow (Mbps)"
set xlabel "TX Bitrate of Each Priority Flow (Mbps)"
#set key top right
unset key

plot \
'<cat rx_bwresv_flow_1.dat'	u ($2)/1000:($6)/1000 t 'MFD' axes x1y1 with linespoints lw 1 pt ft lc rgb "blue" pointsize 1,\
'<cat rx_stresv_flow_1.dat'	u ($2)/1000:($6)/1000 t 'STRESV' axes x1y1 with linespoints lw 1 pt ec lc rgb "black" pointsize 1,\
'<cat tx_bwresv_flow_1.dat'	u ($2)/1000:($6)/1000 t 'Tx' axes x1y1 with linespoints lw 1 pt et lc rgb "red",\
'<cat rx_fd_flow_1.dat'		u ($2)/1000:($6)/1000 t 'FD' axes x1y1 with linespoints lw 1 pt es lc rgb "green",\
'<cat rx_ared_flow_1.dat'	u ($2)/1000:($6)/1000 t 'ARED' axes x1y1 with linespoints lw 1.5 pt ei lc rgb "brown",\
'<cat rx_fifo_flow_1.dat'	u ($2)/1000:($6)/1000 t 'FIFO' axes x1y1 with linespoints lw 1 pt ed lc rgb "violet"



#'<cat rx_bwresv_full_sort.dat'	u ($0+1):($4)/1000 t 'Rx Bwresv' axes x1y1 with linespoints lw 2 lc rgb "blue" pt ec ps 1,\
#'<cat rx_stresv_full_sort.dat'	u ($0+1):($4)/1000 t 'Rx STRESV' axes x1y1 with linespoints lw 1.5 pt et lc rgb "blue",\
#'<cat tx_bwresv_full_sort.dat'	u ($0+1):($4)/1000 t 'Tx' axes x1y1 with linespoints lw 2 lc rgb "blue" pt fs,\
#'<cat rx_bwresv_low_sort.dat'	u ($0+1):($4)/1000 t 'Rx Bwresv' axes x1y1 with linespoints lw 2 lc rgb "black" pt ec ps 1,\
#'<cat rx_stresv_low_sort.dat'	u ($0+1):($4)/1000 t 'Rx STRESV' axes x1y1 with linespoints lw 1.5 pt et lc rgb "black",\
#'<cat tx_bwresv_low_sort.dat'	u ($0+1):($4)/1000 t 'Tx' axes x1y1 with linespoints lw 2 lc rgb "black" pt fs

#'<cat rx_bwresv_mid_sort.dat'	u ($0+1):($4)/1000 t 'Rx Bwresv' axes x1y1 with linespoints lw 2 lc rgb "red" pt ec ps 1,\
#'<cat rx_stresv_mid_sort.dat'	u ($0+1):($4)/1000 t 'Rx STRESV' axes x1y1 with linespoints lw 1.5 pt et lc rgb "red",\
#'<cat tx_bwresv_mid_sort.dat'	u ($0+1):($4)/1000 t 'Tx' axes x1y1 with linespoints lw 2 lc rgb "red" pt fs,\
#'<cat rx_bwresv_low_sort.dat'	u ($0+1):($4)/1000 t 'Rx Bwresv' axes x1y1 with linespoints lw 2 lc rgb "black" pt ec ps 1,\
#'<cat rx_stresv_low_sort.dat'	u ($0+1):($4)/1000 t 'Rx STRESV' axes x1y1 with linespoints lw 1.5 pt et lc rgb "black",\
#'<cat tx_bwresv_low_sort.dat'	u ($0+1):($4)/1000 t 'Tx' axes x1y1 with linespoints lw 2 lc rgb "black" pt fs

#'< cat delay_bwresv_full.dat | head -n6'    u ($2):($4)  t 'Delay BwResv'  axes x1y2 with lp lw 2 lc rgb "blue" pt ec,\
#'< cat delay_stresv_full.dat | head -n6'    u ($2):($4)  t 'Delay StResv'  axes x1y2 with lp lw 1.5 lc rgb "black" pt ei


#'<cat rx_ared_10.dat'	u ($2):($4)/1000 t 'Rx ARED' axes x1y1 with linespoints lw 2,\
#'<cat rx_codel_10.dat'	u ($2):($4)/1000 t 'Rx CODEL' axes x1y1 with linespoints lw 2,\

#'< cat rx.dat | tail -n 19'    u ($0+1):($2)/1000     notitle axes x1y1 with steps lc rgb "green" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($5+50)/1000  notitle     axes x1y1 with steps lc rgb "brown" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($8)/1000     notitle  axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($11)/1000    notitle   axes x1y1 with steps lc rgb "red" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($14)/1000    notitle   axes x1y1 with steps lc rgb "blue" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($17)/1000    notitle    axes x1y1 with steps lc rgb "orange" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($2)/1000      t 'Rx Other-1'    axes x1y1 with points lc rgb "green" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($5+50)/1000      t 'Rx Other-2'    axes x1y1 with points lc rgb "brown" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($8)/1000      t 'Rx Detnet-1'   axes x1y1 with points lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($11)/1000      t 'Rx Detnet-2'  axes x1y1 with points lc rgb "red" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($14)/1000      t 'Rx Detnet-3'  axes x1y1 with points lc rgb "blue" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($17)/1000      t 'Rx Total'  axes x1y1 with points lc rgb "orange" lw 2

#'< cat rx.dat | tail -n 19'    u ($0+1):($2)/1000      t 'Rx Other-1'    axes x1y1 with lp ls 3 lc rgb "green" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($5+50)/1000      t 'Rx Other-2'    axes x1y1 with lp lc rgb "brown" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($8)/1000      t 'Rx Detnet-1'   axes x1y1 with lp lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($11)/1000      t 'Rx Detnet-2'  axes x1y1 with lp lc rgb "red" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($14)/1000      t 'Rx Detnet-3'  axes x1y1 with lp lc rgb "blue" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($17)/1000      t 'Rx Total'  axes x1y1 with lp lc rgb "orange" lw 2

#'< cat rx.dat | tail -n 19'    u ($0+1):($2)/1000      t 'Rx Other-1'    axes x1y1 with lp ls 3 lc rgb "green" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($8+10)/1000      t 'Rx Other-2'    axes x1y1 with lp lc rgb "orange" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($5)/1000      t 'Rx Detnet-1'   axes x1y1 with lp lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($11)/1000      t 'Rx Detnet-2'  axes x1y1 with lp lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($14)/1000      t 'Rx Detnet-3'  axes x1y1 with lp lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($17)/1000      t 'Rx Detnet-4'  axes x1y1 with lp lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($20)/1000      t 'Rx Detnet-5'  axes x1y1 with lp lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($23)/1000      t 'Rx Detnet-6'  axes x1y1 with lp lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($26)/1000      t 'Rx Detnet-7'  axes x1y1 with lp lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($29)/1000      t 'Rx Detnet-8'  axes x1y1 with lp lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($32)/1000      t 'Rx Detnet-9'  axes x1y1 with lp lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($35)/1000      t 'Rx Detnet-10' axes x1y1 with lp lc rgb "black" lw 2,\
#'< cat rx.dat | tail -n 19'    u ($0+1):($38)/1000      t 'Rx Total'  axes x1y1 with lp lc rgb "red" lw 2	 
#pause 0.5
#reread

#plot \
#'< cat exp_10flows_rx.dat'    u ($0+1)*10:($2)      t 'Rx Detnet-1'  axes x1y1 with #lp pt 4 lc rgb "blue",\
#'< cat exp_10flows_rx.dat'    u ($0+1)*10:($5)      t 'Rx Detnet-2'  axes x1y1 with line  #lp pt 7 lc rgb "blue",\
#'< cat exp_10flows_rx.dat'    u ($0+1)*10:($8)      t 'Rx Detnet-3'  axes x1y1 with lp pt 8 lc rgb "red",\
#'< cat exp_10flows_rx.dat'    u ($0+1)*10:($11)      t 'Rx Detnet-4'  axes x1y1 with lp pt 11 lc rgb "red"
#'< sort -rnk1 /home/vk/FAIRDROP_BW_MASTER/NETWORKING_FAIRDROP_BW_1.0/plots/flow_pps.dat'	u ($0+1):($1/1000000)   	t 'Networking Alpha-1.0'  axes x1y1 with lp pt 4 lc rgb "black",	\
#'< sort -rnk1 /home/vk/FAIRDROP_BW_MASTER/ACT_FAIRDROP_BW_1.0/plots/flow_pps.dat'    u ($0+1):($1/1000000)      t 'Act Alpha-1.0'  axes x1y1 with lp pt 4 lc rgb "blue",    \
#'< sort -rnk1 /home/vk/FAIRDROP_BW_MASTER/NETWORKING_FAIRDROP_BW_0.4/plots/flow_pps.dat'    u ($0+1):($1/1000000)       t 'Networking Alpha-0.4'  axes x1y1 with lp pt 6 lc rgb "black", \
#'< sort -rnk1 /home/vk/FAIRDROP_BW_MASTER/ACT_FAIRDROP_BW_0.4/plots/flow_pps.dat'    u ($0+1):($1/1000000)      t 'Act Alpha-0.4'  axes x1y1 with lp pt 6 lc rgb "blue",    \
#'< sort -rnk1 /home/vk/FAIRDROP_BW_MASTER/NETWORKING_FAIRDROP_BW_0.1/plots/flow_pps.dat'    u ($0+1):($1/1000000)       t 'Networking Alpha-0.1'  axes x1y1 with lp pt 8 lc rgb "black", \
#'< sort -rnk1 /home/vk/FAIRDROP_BW_MASTER/ACT_FAIRDROP_BW_0.1/plots/flow_pps.dat'    u ($0+1):($1/1000000)      t 'Act Alpha-0.1'  axes x1y1 with lp pt 8 lc rgb "blue",    \

#'/home/vk/NOFAIRDROP_BW_RESULTS/plots/flow_pps.dat'  u ($0+1):($1/1000000) t 'Taildrop'   axes x1y1 with boxes lc rgb "violet"

#'flow_pps.dat'  u ($0+1+0.25):(f($1)/1000000)           t 'Per Flow Throughput'  axes x1y1 with boxes



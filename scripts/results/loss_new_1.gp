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

set out "loss_new_1.pdf"
#set out "delay_fifo.pdf"
set term pdf font "Times,12"
#set terminal X11 enhanced font "courier 10 pitch, 16" size 1200,1000

set pointsize 1.25

set key top right
#set ylabel "Per flow rate [pps]"
#set title "Priority Bandwidth reservation Output (21Mbps Input link and 10Mbps Output link)\nPriority Bandwidth Sharing\n10 Detnet Flows and 2 Other heavy flows\nExplicit Bandwidth Reservation for Detnet Flows (Flows send their bandwidth requirement) \n and the remaining availble bandwidth is fairly shared by other flows."
#set title "Fifo Queue Output (21Mbps Input link and 10Mbps Output link)\n10 Detnet Flows and 2 Other heavy flows"
set xlabel "Flow ID"
set xtics 1
set xrange [1:5.9]
#set ytics 0.1
set boxwidth 0.1
set style fill pattern
#set style fill solid
#set ytics nomirror
#set y2tics
#set yrange [0:5]
#set y2range [0:6000]
set ylabel "Loss Ratio"
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
#set yrange [0:1]
#set ytics 1
set yrange [0:1]

set label "(DetnetFlow)" at 3,-0.1
set label "(DetnetFlow)" at 4,-0.1
set label "(DetnetFlow)" at 5,-0.1

set arrow 1 from 4,0.1 to 4,0.0
set label "Zero loss" at 4,-0.02

set arrow 2 from 5,0.1 to 5,0.0
set label "Zero loss" at 5,-0.02 

set arrow 3 from 3,0.1 to 3,0.0
set label "Zero loss" at 3,-0.02 

plot \
'< cat packets_bwresv_full.dat'    u ($2+0.05):($4)      t 'BwResv'    axes x1y1 with boxes fill pattern 6 lc rgb "blue" lw 2,\
'< cat packets_stresv_full.dat'	 u ($2+0.45):($4)      t 'STRESV'    axes x1y1 with boxes fill pattern 7 lc rgb "black"
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


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
set out "delay_new.pdf"
#set out "delay_detnet.pdf"
#set out "delay_fifo.pdf"
set term pdf font "Times,18"
#set terminal X11 enhanced font "courier 10 pitch, 16" size 1200,1000

set pointsize 0.75

set key top right
#set ylabel "Per flow rate [pps]"
#set title "Priority Bandwidth reservation Output (21Mbps Input link and 10Mbps Output link)\nPriority Bandwidth Sharing\n10 Detnet Flows and 2 Other heavy flows\nExplicit Bandwidth Reservation for Detnet Flows (Flows send their bandwidth requirement) \n and the remaining availble bandwidth is fairly shared by other flows."
#set title "Fifo Queue Output (21Mbps Input link and 10Mbps Output link)\n10 Detnet Flows and 2 Other heavy flows"

set xlabel "TX Bitrate of Each Priority Flow (Mbps)"
#\tTotal=3*(X)+2*(7) Mbps"
#set xtics 1

#set xrange [0:20]
#set ytics 0.1

set boxwidth 0.1
set style fill pattern

#set ytics nomirror
#set y2tics
#set yrange [0:5]
#set y2range [0:110]

set ylabel "Average end-to-end delay (Secs)"

#set y2label "Total Bandwidth Utilization (%)"
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
set yrange [0.006:0.8]
#set xrange ["low";"mid" "high"]
set autoscale xfix
set logscale y 10
#t=ARG1

set arrow 1 from 0.66,0.004 to 0.66,0.95 nohead dt "-"
#set label "Bw Reservation" at 0.75,4.7

set arrow 2 from 0,0.0206 to 9,0.0206 nohead dt "-"

set arrow 3 from 0,0.02575 to 9,0.02575 nohead dt "-"



plot \
'<cat delay_util_profile_bwresv.dat'	u ($2)/1000:($3) t 'MFD' axes x1y1 with lp lc rgb "blue" lw 2 pt ft,\
'<cat delay_util_profile_stresv.dat'	u  ($2)/1000:($3) t 'StResv' axes x1y1 with lp lc rgb "black" pt ec,\
'<cat delay_util_profile_fd.dat'	u ($2)/1000:($3) t 'FD' axes x1y1 with lp lc rgb "green" pt es,\
'<cat delay_util_profile_ared.dat'	u ($2)/1000:($3) t 'ARED' axes x1y1 with lp lc rgb "brown" pt ei,\
'<cat delay_util_profile_fifo.dat'	u ($2)/1000:($3) t 'FIFO' axes x1y1 with lp lc rgb "violet" pt ed
#'<cat delay_util_profile_ared.dat'	u ($2)/1000:($3) t 'ARED' axes x1y1 with lp lc rgb "green"
#'<cat delay_util_profile_codel.dat'	u ($2)/1000:($3) t 'CODEL' axes x1y1 with lp lc rgb "violet",\



#'< cat delay_detnet_10.dat '    u ($0+1):($32)     notitle  axes x1y1 with steps lc rgb "blue" lw 2,\
#'< cat delay_fifo.dat '    u ($0+1):($32)     notitle  axes x1y1 with steps lc rgb "red" lw 2,\
#'< cat delay_detnet_10.dat '    u ($0+1):($32)     t 'BwResv Th=10'  axes x1y1 with points lc rgb "blue" lw 2,\
#'< cat delay_fifo.dat '    u ($0+1):($32)     t 'Fifo'  axes x1y1 with points lc rgb "red" lw 2,\
#'< cat delay_detnet_20.dat '    u ($0+1):($32)      notitle  axes x1y1 with steps lc rgb "brown" lw 2,\
#'< cat delay_detnet_20.dat '    u ($0+1):($32)     t 'BwResv Th=20'  axes x1y1 with points lc rgb "brown" lw 2,\
#'< cat delay_detnet_40.dat '    u ($0+1):($32)      notitle  axes x1y1 with steps lc rgb "orange" lw 2,\
#'< cat delay_detnet_40.dat '    u ($0+1):($32)     t 'BwResv Th=40'  axes x1y1 with points lc rgb "orange" lw 2,\
#'< cat delay_detnet_80.dat '    u ($0+1):($32)      notitle  axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat delay_detnet_80.dat '    u ($0+1):($32)     t 'BwResv Th=80'  axes x1y1 with points lc rgb "black" lw 2

#'< cat delay.dat '    u ($0):($2)      t 'Latency Other-1'    axes x1y1 with steps lc rgb "green" lw 2,\
#'< cat delay.dat '    u ($0):($14)      t 'Latency Other-2'    axes x1y1 with steps lc rgb "orange" lw 2,\
#'< cat delay.dat '    u ($0):($8)      t 'Latency Detnet-1'   axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat delay.dat '    u ($0):($20)     t 'Latency Detnet-2'  axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat delay.dat '    u ($0):($26)     t 'Latency Detnet-3'  axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat delay.dat '    u ($0):($32)     t 'Latency Detnet-4'  axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat delay.dat '    u ($0):($38)     t 'Latency Detnet-5'  axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat delay.dat '    u ($0):($44)     t 'Latency Detnet-6'  axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat delay.dat '    u ($0):($50)     t 'Latency Detnet-7'  axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat delay.dat '    u ($0):($56)     t 'Latency Detnet-8'  axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat delay.dat '    u ($0):($62)     t 'Latency Detnet-9'  axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat delay.dat '    u ($0):($68)     t 'Latency Detnet-10' axes x1y1 with steps lc rgb "black" lw 2,\
#'< cat delay.dat '    u ($0):($74)     t 'Total Mean Latency' axes x1y1 with steps lc rgb "red" lw 2
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


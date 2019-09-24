
echo "$(for i in low mid full;do echo -e "$i\t$(cat delay_stresv_$i.dat | tail -n1 | awk '{print $4}')\t$(awk '{ sum += $4 } END { print sum }' rx_stresv_$i.dat)";done)" > delay_stresv_all.dat

bwresv	500	0.0261253	15972
bwresv	1000	0.0302473	15972.6
bwresv	1500	0.0334918	15972.2
bwresv	2000	0.0359241	15972.4
bwresv	2500	0.0373471	15973
bwresv	3000	0.0385892	15972.5
bwresv	3500	0.0399403	15972.1
bwresv	4000	0.040623	15971.7
bwresv	4500	0.0418085	15971.8
bwresv	5000	0.51306	15972.1
bwresv	5500	0.338703	15972.1




new

bwresv	4500	0.0511602	15972
bwresv	5000	0.0637489	15972.1
bwresv	5500	0.108047	15971.4
bwresv	6000	0.111057	15971.7
bwresv	6500	0.112906	15972.1
bwresv	7000	0.115234	15971.1
bwresv	7500	0.116426	15971.4
bwresv	8000	0.118185	15971.4
bwresv	8500	0.119144	15971.5

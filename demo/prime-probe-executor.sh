#!/bin/sh

# $1 L1-capture samples
# $2 L1-capture delay loop cycles

# $3 L1-rattle first location
# $4 L1-rattle second location
# $5 L1-rattle number of times to access

fname=$(echo "$@" | tr ' ' '-' )

#start the capture
taskset 0x00000002 ./L1-capture $1 $2 > result.txt &
prime_probe=$!
echo "prime and probe running with pid: ${prime_probe}"

#start the rattle
taskset 0x00000002 ./L1-rattle $3 $4 $5 &
echo "starting rattle pid: $!"

#wait until the capture completes
wait "${prime_probe}"

#end any rattles started (should only be the one in this version)
for job in `jobs -p`; do
	kill "${job}"
	echo "terminated rattle ${job}"
done

#make the heatmap
gnuplot heatmapbs.gp

# copy and rename the resulting graph and data
cp result.txt "results/${fname}.dat"
mv heatmapbs.eps "results/${fname}.eps"


#!/bin/sh

echo "Starting L1-capture"
taskset 0x00000002 ./L1-capture 100 > result.txt &
prime_probe=$!
echo "prime and probe running with pid: ${prime_probe}"

# while the capture is running keep starting up rattles to increase chance of hits
while [ -n "${prime_probe}" -a -f "/proc/${prime_probe}/exe" ] ; do
	taskset 0x00000002 ./L1-rattle &
	echo "   starting rattle pid: $!"
	sleep 1s
    # if we start too many rattles too fast then L1-capture doesnt get enough time scheduled to complete
done

echo "prime and probe complete"

# once capture is complete stop all the rattles
for job in `jobs -p`; do
	kill "${job}"
	echo "   terminated rattle ${job}"
done

cat result.txt
echo "Completed"
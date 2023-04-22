#!/bin/bash

#	number of tests:
numtests=35
#	command to execute test:
command="../../hw1.out < input/t\$i.in >& output/t\$i.out"
i="1"
rm -rf output &> /dev/null
mkdir output
while [ $i -le $numtests ]
	do
		eval "$command"
		i=$((i+1))
done

echo -e "All tests executed"

exit

#!/bin/bash

#	number of tests:
numtests=58
#	command to execute test:
command="../../hw1.out < input/t\$i.in >& output/t\$i.out"
i="1"
failed=false
rm -rf output &> /dev/null
mkdir output
while [ $i -le $numtests ]
	do
		eval "$command"
		diff output/t$i.out expected/t$i.out &> /dev/null
		if [[ $? != 0 ]] 
			then
				echo -e "FAILED test #"$i"!"
				failed=true
		fi

		if [[ $? == 0 ]]
        	then
        		echo -e "PASSED test #"$i"!"
        fi

		i=$((i+1))
done

if [ ![$failed] ]
    then
        echo -e "All tests PASSED! Ok to submit :)"
fi

exit

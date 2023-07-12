#!/bin/bash
dockerImage=`awk -F " " 'NR==1 {print $NF}' Dockerfile`
echo $dockerImage
trivy image -q --exit-code 1 --severity CRITICAL $dockerImage
result="$?"
if [ result -eq 0 ]
then
    echo "No vulnerabilities found!"
else
    echo "vulnerabilities found! Need to be fixed!"
fi


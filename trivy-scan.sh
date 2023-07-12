#!/bin/bash
dockerImage=`awk -F " " 'NR==1 {print $NF}' Dockerfile`
echo $dockerImage
trivy image -q --exit-code 1 --severity CRITICAL $dockerImage
result="$?"
if [ result -eq 0 ]
then
    echo "Image Scan Passed. No vulnerabilities found!"
    exit 1
else
    echo "Image Scan Failed!!.  Critical Vulnerabilities Found! Need to be fixed!"
fi


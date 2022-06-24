#!/bin/bash 


quit() {
	exit 1
}

trap quit SIGINT
trap quit SIGTERM

help() {
        echo "Usage: $0 <IP Address (first three octets)> <keyword to grep>"
	echo "       $0 51.222.169 megacorpone.com"
        exit 0
}

[[ $# -lt 2 ]] && help

ip="$1"
keyword="$2"


if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
	echo "[x_x]"
else
	help
fi

pids=""

for n in $( seq 1 255 )
do
	host $ip.$n | grep "$keyword" | cut -d " " -f 1,5 & 
	pids+=" $!"
done	

wait $pids

#!/bin/bash


printf "" > botmon.log

date

while :
do

	date=$(date "+%X")
	output="output.html"
	wget --quiet http://cacti.example.com/cacti_output.html -O $output

	output2=$(cat $output | grep -E ASTER.*disabled | wc -l)
	output3=$(cat $output | grep -v -E ASTER.*disabled.*input | grep ASTER.*input | wc -l)
	output4=$(cat $output | grep -v -E input.*ASTER.*red.*input | grep input.*ASTER.*input | wc -l)
	#nnames=$(cat $output | grep -v -E ASTER.*disabled.*input | egrep -o '(?>pullAst\(')(..........)')
	printf "$date: "
		if [ -z "$output" ]; then
			printf "$output - empty set - "
			#output.html doesnt exist

		elif [ "$output3" -gt 0 ]; then

			printf "$output4 need(s) a kick (.mp3!)"
			/mnt/c/Program\ Files\ \(x86\)/VideoLAN/VLC/vlc.exe -q "C:\Users\Admin\Documents\scripts\halmsg.mp3"
			#vlc.exe with QT interface, hidden, autoplay, one instance allowed, overwrite current playlist
			#exit 2 #critical nagios service
			#cmd.exe /C "start /D C:\Windows\ /MIN C:\Users\Admin\Documents\scripts\play.cmd"
		elif [ "$output2" -ge 0 ]; then
				printf "Nothing needs attention "
		else
				printf ", $output2 recently pulled"
		fi

printf "\n"
sleep 2m
done

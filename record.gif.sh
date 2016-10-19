#!/bin/bash
unset it_broke

if [[ -n $1 ]]
	then
	[[ -d $1 ]] && (echo "directory $1 exists" && exit 1)
	echo filename: $1
	if [[ -n $2 ]]
		then
		echo width: $2
		if [[ -n $3 ]]
			then
			echo height: $3
			echo break with ctrl+c
			mkdir ./$1.tmp/
			recordmydesktop --width=$2 --height=$3 --follow-mouse --no-sound -o $1.tmp/$1.ogv
			else
			echo height: $2
			echo break with ctrl+c
			mkdir ./$1.tmp/
			recordmydesktop --width=$2 --height=$2 --follow-mouse --no-sound -o $1.tmp/$1.ogv
		fi
		else
		echo widthxheight: 800x800
		echo break with ctrl+c
		mkdir ./$1.tmp/
		recordmydesktop --width=800 --height=800 --follow-mouse --no-sound -o $1.tmp/$1.ogv
	fi
  else
	echo requires at least a filename
	echo try: $0 lol 800
	echo or try: $0 lol 800 600
	export it_broke=lol
	exit 1
fi
if [[ -z $it_broke ]]
then
if [[ -e $1.tmp/$1.ogv ]]
then
	echo "found $1.tmp/$1.ogv,proceeding:"
	mkdir -p $1.tmp/tmp &&
	echo "mplayer .."&&
	mplayer -ao null $1.tmp/$1.ogv -vo jpeg:outdir=$1.tmp/tmp &&
	echo "imagemagic convert .."&&
	convert $1.tmp/tmp/* $1.gif &&
	echo convertion to gif successfull &&
	mv $1.tmp/$1.ogv ./ &&
	echo "gif availble at: `pwd`/$1.gif" &&
	echo "ogv available at: `pwd`/$1.ogv" &&
	rm -rf $1.tmp
else
	echo something went wrong, $1.tmp/$1.ogv not found
fi
else
echo it broke: $it_broke
fi

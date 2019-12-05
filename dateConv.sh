#! /usr/bin/env bash

#this script calculate the date in the common format (day/month/year) stardayng from 
#the so called Julian date
#input year (7 for 2007) and day number, so
#
#./DayOfyear2Date.sh 7 30 gives
#30 gennaio 2007
#
#
#    to do:
#
#     attualmente day-> date
#     aggiungere il passaggio contrario;
#     usare le opzioni     
#
#      -g2d gregorian to day of the year (fatto)
#      -d2g  day of the year to gregorian date (fatto)
#      -help con la spiegazione (da fare)
#      -mettere le scritte in inglese sopra       
#      -rivedere
#      -debug
#      -dare nomi alle variabili
#
#
#     -g2d 7 11 8 (year month day) output somma dei giorni di tutti i mesi
#      precedenti fino a month-1 (incluso) + day + 1 se year e bisestile
#
#
#
#

#autor g.zizzi, November 2007 


#nu=$(echo $2/4 | bc -l)
if [[ $# -gt 0 ]]; then
   nu=$(expr $1 % 4)
else 
   nu=0
fi

#dayofmonth[]: vettore con la durata dei mesi dell'anno

	dayofmonth[1]=31
	if [ $nu -eq 0 ]; then 
	dayofmonth[2]=29
	else dayofmonth[2]=28
	fi
	dayofmonth[3]=31
	dayofmonth[4]=30
	dayofmonth[5]=31
	dayofmonth[6]=30
	dayofmonth[7]=31
	dayofmonth[8]=31
	dayofmonth[9]=30
	dayofmonth[10]=31
	dayofmonth[11]=30
	dayofmonth[12]=31

#month[]: vettore col nome dei mesi dell'anno

	month[1]=gennaio
	month[2]=febbraio
	month[3]=marzo
	month[4]=aprile
	month[5]=maggio
	month[6]=giugno
	month[7]=luglio
	month[8]=agosto
	month[9]=settembre
	month[10]=ottobre
	month[11]=novembre
	month[12]=dicembre

#mjd to gregorian(?, controllare)
	case $# in
	0)

	date
	date +%j
        ;;

	2)
	i=0
	T=0

	while [ $T -lt $2 ]
	do
	let "i=$i+1"
	let "T=$T+${dayofmonth[i]}"
	done

	let "T2=$T-${dayofmonth[i]}"
	let "day_tmp=$2-$T+${dayofmonth[i]}"

	if [ $T2 -eq $2 ]
	then
	let "day=$day_tmp+1"
	else let "day=$day_tmp"
	fi

	echo $day ${month[i]}  $1


#if [ $1 -lt 10 ]; then
#           echo $day ${month[i]}  200$1
#	else
#           echo $day ${month[i]}  20$1
#	fi

	;;

# gregorian(?, controllare) to julian date
#usage 
#  |prompt>./DayConverter.sh 10  01  30  (yy mm dd)
	3)
	i=0   #indice
	T=0   #somma dei giorni dei mesi

	while [ $i -lt $2 ]
	do
	let "i=$i+1"
	let "T=$T+${dayofmonth[i]}"
	done

	let "T2=$T-${dayofmonth[i]}"
	let "day_tmp=$3+$T2"
	echo $day_tmp
	;;
	esac
#parte del codice inutile	
#	if [ $T2 -eq $2 ]
#	then
#	   let "day=$day_tmp+1"
#	else let "day=$day_tmp"
#	fi
#	
#	if [ $1 -lt 10 ]; then
#           echo $day ${month[i]}  200$1
#	else
#           echo $day ${month[i]}  20$1
#	fi



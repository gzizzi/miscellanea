#! /usr/bin/env bash

#this script calculate the date in the common format (day/month/year) stardayng from 
#the so called Julian date
#input year (7 for 2007) and day number, so
#
#./DayOfyear2Date.sh 7 30 gives
#30 gennaio 2007


#autor g.zizzi, November 2007 


#nu=$(echo $2/4 | bc -l)
nu=$(expr $1 % 4)

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
#date +%j -d 06/01/2010

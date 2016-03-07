#! /usr/bin/env bash 

#data size converter
#script che uso per convertire agevolmente lo spazio da un'unit√† all'altra 
#
#
#./dsc.sh spazio_disco vecchia_unit√† nuova_unit√†
#
# ./dsc.sh 45900089 B Gb
#oppure 
#./dsc.sh -r vecchia_unit√† nuova_unit√† spazio_disco 
#./dsc.sh -r B Gb 45900089 
#
# le unit√† possono essere scritte senza preoccuparsi delle lettere maiuscole o minuscole
#
# ./dsc.sh
#oppure
# ./dsc.sh  -show
#
# mostrano uno schema delle varie unit√† di misura dello spazio disco
#
#
#to do: inserirlo nel profilo bash in modo da poterlo utilizzare piu' agevolmente 
#to do: introdurre i bit ed i multipli  (usare bit non "b", altrimenti Ë un casino)
#8 Bit = 1 Byte
#to do: mettere le potenze di mille 
#to do: levare l'opzione "-r", i parametri in input devono essere "num unit‡1 unit‡2" oppure "unit‡1 unit‡2 numero" in ogni altro caso lo script deve dare errore


if [[ $1 == "-r" ]]; then
   Nu=$4
else 
   Nu=$1
fi

bin_in=$(echo $2 | grep -i "it" | wc -l)
bin_out=$(echo $3 | grep -i "it" | wc -l)

#echo $bin_in
#echo $bin_out

cb=1

#calcolo del fattore "considero anche i bit"
#bit in ingresso e byte in uscita
if [[ ${bin_in:-0} -eq 1 ]] && [[ ${bin_out:-0} -eq 0 ]]; then cb="1/8"; fi
#byte in ingresso e bit in uscita
if [[ ${bin_in:-0} -eq 0 ]] && [[ ${bin_out:-0} -eq 1 ]]; then cb="8"; fi

#echo $cb

#input_unit=$(echo $2 | sed s/it// | tr '[a-z]' '[A-Z]' | tr 'I' 'i')
#output_unit=$(echo $3 | sed s/it// | tr '[a-z]' '[A-Z]' | tr 'I' 'i')

input_unit=$2
output_unit=$3 

if [[ $# -gt 1 ]]; then

#lista delle varie unit√† di misura
   #units="B_1 KB_10^3 MB_10^6 GB_10^9 TB_10^12 PB_10^15 EB_10^18 ZB_10^21 YB_10^24 KiB_2^10 MiB_2^20 GiB_2^30 TiB_2^40 PiB_2^50 EiB_2^60 ZiB_2^70 YiB_2^80"
   units="B_1 KB_10^3 MB_10^6 GB_10^9 TB_10^12 PB_10^15 EB_10^18 ZB_10^21 YB_10^24 KiB_2^10 MiB_2^20 GiB_2^30 TiB_2^40 PiB_2^50 EiB_2^60 ZiB_2^70 YiB_2^80 Bit_1 Kbit_10^3 Mbit_10^6 Gbit_10^9 Tbit_10^12 Pbit_10^15 Ebit_10^18 Zbit_10^21 Ybit_10^24 Kibit_2^10 Mibit_2^20 Gibit_2^30 Tibit_2^40 Pibit_2^50 Eibit_2^60 Zibit_2^70 Yibit_2^80"

#echo ${input_unit:-0}
#echo ${output_unit:-0}

#estraggo i valori numerici
   old_unit=$(echo $units | sed 's/ /\n/g' |grep ${input_unit:-0} | awk -F_ 'NR==1 {print $2}')
   new_unit=$(echo $units | sed 's/ /\n/g' |grep ${output_unit:-0} | awk -F_ 'NR==1 {print $2}')

#echo $old_unit
#echo $new_unit

#effettuo il calcolo (5 cifre decimali)
   r=$(echo "scale=5; ${cb:-1}*${Nu:-0}*${old_unit:-0}/${new_unit:-1}" | bc -l)
#r=$(bc -l <<< $1*$old_unit/$new_unit)
   echo $r ${output_unit:-" "} 

else
# mostro uno schema delle varie unit√† di misura dello spazio disco

   if [ ${1:-0} == "-show" ] || [[ $# -eq 0 ]]; then 

      echo "         
                                        Multipli del byte
      
                  Prefissi SI 	                        	Prefissi binari                         
      Nome 	      Simbolo 	Multiplo        	Nome 	        Simbolo Multiplo           Errore (1-10^n/2^m)
      kilobyte   	KB 	10^3                    kibibyte 	KiB     2^10 = 1024
      megabyte 	        MB 	10^6  = 1000^2 	        mebibyte 	MiB 	2^20 = 1024^2          +4,9%
      gigabyte 	        GB 	10^9  = 1000^3 	        gibibyte 	GiB 	2^30 = 1024^3          +7,4%
      terabyte 	        TB 	10^12 = 1000^4 	        tebibyte 	TiB 	2^40 = 1024^4          +10,0%
      petabyte 	        PB 	10^15 = 1000^5 	        pebibyte 	PiB 	2^50 = 1024^5          +12,6%
      exabyte 	        EB 	10^18 = 1000^6          exbibyte 	EiB 	2^60 = 1024^6          +15,3%
      zettabyte 	ZB 	10^21 = 1000^7          zebibyte 	ZiB 	2^70 = 1024^7
      yottabyte 	YB 	10^24 = 1000^8          yobibyte 	YiB 	2^80 = 1024^8 
      
                                         Multipli del bit 
      
                   Prefissi SI 	                              	Prefissi binari
      Nome 	      Simbolo 	Multiplo              Nome      Simbolo  Multiplo
      kilobit   	Kbit 	10^3                  kibibit 	Kibit    2^10 = 1024
      megabit 	        Mbit 	10^6  = 1000^2        mebibit 	Mibit    2^20 = 1024^2
      gigabit 	        Gbit 	10^9  = 1000^3        gibibit 	Gibit    2^30 = 1024^3
      terabit 	        Tbit	10^12 = 1000^4        tebibit 	Tibit    2^40 = 1024^4
      petabit 	        Pbit 	10^15 = 1000^5        pebibit 	Pibit    2^50 = 1024^5
      exabit 	        Ebit 	10^18 = 1000^6        exbibit 	Eibit    2^60 = 1024^6
      zettabit 	        Zbit 	10^21 = 1000^7        zebibit 	Zibit    2^70 = 1024^7
      yottabit 	        Ybit 	10^24 = 1000^8        yobibit 	Yibit    2^80 = 1024^8
 
      1B=8bit   2^8=256   2^x \simeq 10^(0.3*x)   1000/1024 \simeq 0.9765625
                          e^x \simeq 10^(0.4*x)                             

      "
  fi
fi

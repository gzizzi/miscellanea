#this script displays geographic information about one or more IPv4 passed as input 
#curl -s https://ipinfo.io/$1?token=fa95e8a89489a2

#!/usr/bin/env bash
set -e
if [ "$#" -lt 1 ]
then
echo  "Please insert at least one ip"
exit
else
echo -e "\c"
fi

#$@ is the list of IP in input
for IP in "$@"
do
   curl -s https://ipinfo.io/$IP?token=fa95e8a89489a2
done

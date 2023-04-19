#This rookie script checks if openvpn3 has chosen one of the IP addresses assigned to the other servers.
#
import subprocess


ip_list = subprocess.check_output("ip a | grep inet' ' | grep tun | awk '{print $2}'|awk -F/ '{print $1}'", shell = True).strip() 
#note: grep inet' '  is necessary to exclude inet6 ip
#note2: I'm iterested only in tun interfaces

print("tun interface's IP")
print(ip_list)


### not the most efficient code
###
###
print("Possible wrong addresses")

if ip_list == "192.168.44.73":
    print('strings equal')
if ip_list == "192.168.44.74":
    print('strings equal')
if ip_list == "192.168.50.79":
    print('strings equal')
if ip_list == "192.168.50.81":
    print('strings equal')
if ip_list == "192.168.42.254":
    print('strings equal')
if ip_list == "192.168.50.254":
    print('strings equal')
if ip_list == "192.168.47.101":
    print('strings equal')
if ip_list == "192.168.44.8":
    print('strings equal')
if ip_list == "192.168.44.70":
    print('strings equal')
if ip_list == "192.168.44.69":
    print('strings equal')
if ip_list == "192.168.44.71":
    print('strings equal')

###
####snippet to be used later
####str_list = ["New York","Los Angeles","Chicago","Houston","Phoenix",
#            "Philadelphia"]
#
#for x in range(len(str_list)):
#    print(str_list[x])

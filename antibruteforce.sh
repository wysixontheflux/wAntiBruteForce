#!/bin/sh
#Port Scan Restrictive
#Supported Systems:
supported="RHEL & Debian"

# Root Force
 if [ "$(id -u)" != "0" ]; then
         printf "${RED}⛔️ Attention droit root obligatoire ⛔️\n" 1>&2
         printf "\n"
         exit 1
fi
echo
    printf "${BLUE} Avez-vous un serveur SSH :question: [o/N]\n"
    read reponse
if [[ "$reponse" == "o" ]]
then 
    printf "${RED} Souhaitez-vous bloquer le SSH Brute-Force :question: [o/N]\n"
    read reponse
if [[ "$reponse" == "o" ]]
then
/sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set
        /sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP
fi
echo
        printf "${CYAN} Parfait les règles sont activent !"
        /sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set
        /sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP
fi
echo
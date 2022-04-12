#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "Criado Por Juliano Oliveira" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "Versão Debian 10 & Debian 11" ; tput sgr0
tput setaf 3 ; tput bold ; echo "" ; echo "Este script irá Instalar FRRouting" ; echo ""
echo " Atualizando pacotes e instalando depencêncas"
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para confirmar..." ; echo "" ; echo "" ; tput sgr0
apt update
sleep 2
apt upgrade
sleep 2
apt install curl apt-transport-https gnupg2 lsb-release tree net-tools
sleep 2
curl -s https://deb.frrouting.org/frr/keys.asc | apt-key add -
sleep 2
FRRVER="frr-stable"
sleep 2
echo deb https://deb.frrouting.org/frr $(lsb_release -s -c) $FRRVER | tee -a /etc/apt/sources.list
sleep 2
apt update
sleep 2
apt install frr frr-doc frr-pythontools frr-rpki-rtrlib frr-snmp
sleep 2
mkdir /etc/frr/backups
sleep 2
cp /etc/frr/daemons /etc/frr/backups/
sleep 2
cp /etc/frr/frr.conf /etc/frr/backups/
sleep 2
cp /etc/frr/vtysh.conf /etc/frr/backups/
sleep 2
cp /etc/frr/support_bundle_commands.conf /etc/frr/backups/
sleep 2
cp /etc/frr/frr.conf /etc/frr/frr.conf.old
cp /etc/frr/daemons /etc/frr/daemons.old
sleep 2
rm /etc/frr/frr.conf
rm /etc/frr/daemons
sleep 2
touch /etc/frr/frr.conf
sleep 2
echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf;
sleep 2
echo net.ipv4.neigh.default.gc_thresh1=4096 >> /etc/sysctl.conf;
sleep 2
echo net.ipv4.neigh.default.gc_thresh2=16384 >> /etc/sysctl.conf;
sleep 2
echo net.ipv4.neigh.default.gc_thresh3=32768 >> /etc/sysctl.conf;
sleep 2
echo net.ipv6.neigh.default.gc_thresh1=4096 >> /etc/sysctl.conf;
sleep 2
echo net.ipv6.neigh.default.gc_thresh2=16384 >> /etc/sysctl.conf;
sleep 2
echo net.ipv6.neigh.default.gc_thresh3=32768 >> /etc/sysctl.conf;
sleep 2
echo net.core.rps_sock_flow_entries=32768 >> /etc/sysctl.conf;
sleep 2
echo net.core.rmem_max=134217728 >> /etc/sysctl.conf;
sleep 2
echo net.core.wmem_max=134217728 >> /etc/sysctl.conf;
sleep 2
echo net.core.netdev_max_backlog=300000 >> /etc/sysctl.conf;
sleep 2
echo net.core.default_qdisc=fq >> /etc/sysctl.conf;
sleep 2
echo net.ipv4.tcp_congestion_control=bbr >> /etc/sysctl.conf;
sleep 2
echo net.ipv4.tcp_rmem=4096 87380 134217728 >> /etc/sysctl.conf;
sleep 2
echo net.ipv4.tcp_wmem=4096 65536 134217728 >> /etc/sysctl.conf;
sleep 2
echo net.ipv4.tcp_moderate_rcvbuf=1 >> /etc/sysctl.conf;
sleep 2
echo net.ipv4.tcp_mtu_probing=1 >> /etc/sysctl.conf;
sleep 2
echo net.ipv6.conf.all.forwarding=1 >> /etc/sysctl.conf;
sleep 2
echo mpls_router >> /etc/modules-load.d/modules.conf;
sleep 2
echo mpls_iptunnel >> /etc/modules-load.d/modules.conf;
sleep 2
sleep 2
rm /etc/rc.local
sleep 2 
touch /etc/rc.local
sleep 2
echo '#!/bin/sh -e' >> /etc/rc.local;
echo modprobe 8021q >> /etc/rc.local;
echo sysctl -p /etc/sysctl.conf >> /etc/rc.local;
echo sysctl --system >> /etc/rc.local;
echo /etc/init.sysctl/sysctl >> /etc/rc.local;
echo exit; >> /etc/rc.local;
chown root /etc/rc.local
chmod +x /etc/rc.local
read -p "Sua interface ethernet exemplo enp0s3 : " interface
if [ -z "$testing" ]
then
echo net.mpls.conf.$interface.input=1 >> /etc/sysctl.conf;
echo net.mpls.platform_labels=100000 >> /etc/sysctl.conf;
rm /etc/frr/daemons
touch /etc/frr/daemons
fi 
read -p "Habilitar BGP? yes para Sim no para Não : " bgp
read -p "Habilitar OSPFv2? yes para Sim no para Não : " ospfv4
read -p "Habilitar OSPFv3? yes para Sim no para Não : " ospfv6
if [ -z "$testing" ]
then
echo bgpd=$bgp>> /etc/frr/daemons;
echo ospfd=$ospfv4 >> /etc/frr/daemons;
echo ospf6d=$ospfv6 >> /etc/frr/daemons;
echo ripd=no >> /etc/frr/daemons;
echo ripngd=no >> /etc/frr/daemons;
echo isisd=no >> /etc/frr/daemons;
echo pimd=no >> /etc/frr/daemons;
echo ldpd=no >> /etc/frr/daemons;
echo nhrpd=no >> /etc/frr/daemons;
echo eigrpd=no >> /etc/frr/daemons;
echo babeld=no >> /etc/frr/daemons;
echo sharpd=no >> /etc/frr/daemons;
echo pbrd=no >> /etc/frr/daemons;
echo bfdd=no >> /etc/frr/daemons;
echo fabricd=no >> /etc/frr/daemons;
echo vrrpd=no >> /etc/frr/daemons;
echo vtysh_enable=yes >> /etc/frr/daemons;
echo zebra_options="  -A 127.0.0.1 -s 90000000" >> /etc/frr/daemons;
echo bgpd_options="   -A 127.0.0.1" >> /etc/frr/daemons;
echo ospfd_options="  -A 127.0.0.1" >> /etc/frr/daemons;
echo ospf6d_options=" -A ::1" >> /etc/frr/daemons;
echo ripd_options="   -A 127.0.0.1" >> /etc/frr/daemons;
echo ripngd_options=" -A ::1" >> /etc/frr/daemons;
echo isisd_options="  -A 127.0.0.1" >> /etc/frr/daemons;
echo pimd_options="   -A 127.0.0.1" >> /etc/frr/daemons;
echo ldpd_options="   -A 127.0.0.1" >> /etc/frr/daemons;
echo nhrpd_options="  -A 127.0.0.1" >> /etc/frr/daemons;
echo eigrpd_options=" -A 127.0.0.1" >> /etc/frr/daemons;
echo babeld_options=" -A 127.0.0.1" >> /etc/frr/daemons;
echo sharpd_options=" -A 127.0.0.1" >> /etc/frr/daemons;
echo pbrd_options="   -A 127.0.0.1" >> /etc/frr/daemons;
echo staticd_options="-A 127.0.0.1" >> /etc/frr/daemons;
echo bfdd_options="   -A 127.0.0.1" >> /etc/frr/daemons;
echo fabricd_options="-A 127.0.0.1" >> /etc/frr/daemons;
echo vrrpd_options="  -A 127.0.0.1" >> /etc/frr/daemons;
fi
read -p "Coloque Hostname do Servidor : " hst
read -p "Coloque AS Local : " as_local
read -p "Endereço IPV4 do servidor Vizinho: " ipv4_neighbor
read -p "AS Remoto IPv4 : " as_neighbor
read -p "Endereço IPv6 do servidor Vizinho : " ipv6_neighbor
read -p "AS Remoto IPv6 : " as_neighbor6
if [ -z "$testing" ]
then
echo frr version 6.0.2 >> /etc/frr/frr.conf;
echo frr defaults traditional >> /etc/frr/frr.conf;
echo hostname $hst >> /etc/frr/frr.conf;
echo log syslog informational >> /etc/frr/frr.conf;
echo ip forwarding >> /etc/frr/frr.conf;
echo ipv6 forwarding >> /etc/frr/frr.conf;
echo service integrated-vtysh-config >> /etc/frr/frr.conf;
echo !
echo router bgp $as_local >> /etc/frr/frr.conf;
echo neighbor $ipv4_neighbor remote-as $as_neighbor >> /etc/frr/frr.conf;
echo neighbor $ipv6_neighbor remote-as $as_neighbor6 >> /etc/frr/frr.conf;
echo ! >> /etc/frr/frr.conf;
echo address-family ipv4 unicast >> /etc/frr/frr.conf;
echo  redistribute kernel >> /etc/frr/frr.conf;
echo  redistribute connected >> /etc/frr/frr.conf;
echo  redistribute static >> /etc/frr/frr.conf;
echo  exit-address-family >> /etc/frr/frr.conf;
echo ! >> /etc/frr/frr.conf;
echo address-family ipv6 unicast >> /etc/frr/frr.conf;
echo  redistribute kernel >> /etc/frr/frr.conf;
echo  redistribute connected >> /etc/frr/frr.conf;
echo  redistribute static >> /etc/frr/frr.conf;
echo neighbor $ipv6_neighbor activate >> /etc/frr/frr.conf;
echo  exit-address-family >> /etc/frr/frr.conf;
echo ! >> /etc/frr/frr.conf;
echo line vty >> /etc/frr/frr.conf;
echo ! >> /etc/frr/frr.conf;
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "FRRouting Instalado" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "Criado Por Juliano Oliveira" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "Linkdin https://www.linkedin.com/in/juliano-oliveira-375b71171/" ; tput sgr0
tput setaf 3 ; tput bold ; echo "" ; echo "Reinicie o Servidor" ; echo ""
sleep 2
exit 1  
fi 

#! /bin/bash
sudo rm -rf /home/schama/data/ssl-ca
sudo rm -rf /srv/samba/ssl-ca/baikonur.at

hostnames="control01.baikonur.at jumphost01.baikonur.at management01.baikonur.at management02.baikonur.at foundry01.baikonur.at display01.baikonur.at observer.baikonur.at ml01.baikonur.at ml02.baikonur.at ml03.baikonur.at testing01.baikonur.at testing02.baikonur.at testing03.baikonur.at testing04.baikonur.at db01.baikonur.at mongodb01.baikonur.at mongodb02.baikonur.at mongodb03.baikonur.at raspi3-04.baikonur.at node01.kube.baikonur.at node02.kube.baikonur.at node03.kube.baikonur.at node04.kube.baikonur.at node05.kube.baikonur.at node06.kube.baikonur.at node07.kube.baikonur.at node08.kube.baikonur.at node09.kube.baikonur.at node10.kube.baikonur.at node11.kube.baikonur.at node12.kube.baikonur.at rpi-cam01.baikonur.at rpi-cam02.baikonur.at rpi-cam03.baikonur.at raspi0-04.baikonur.at"

for hostname in ${hostnames};
do
	echo "sudo rm /etc/ssl/crt/*" | ssh ansible-worker@${hostname}
	echo "sudo rm /etc/ssl/csr/*" | ssh ansible-worker@${hostname}
	echo "sudo rm /etc/ssl/private/*" | ssh ansible-worker@${hostname}
	done
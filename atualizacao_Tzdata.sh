#!/bin/bash

tput setaf 2; echo 'Desabilitando verificacao de SSL do yum.conf...'; tput sgr0
echo "sslverify=false" >> /etc/yum.conf

tput setaf 2; echo 'Mudandos os arquivos necessarios de local...'; tput sgr0
mv tzupdater.jar /tmp

tput setaf 2; echo 'Baixando arquivos necessarios...'; tput sgr0
wget ftp.pbone.net/mirror/vault.centos.org/6.10/updates/i386/Packages/tzdata-2020d-1.el6.noarch.rpm
wget ftp.pbone.net/mirror/vault.centos.org/6.10/updates/i386/Packages/tzdata-java-2020d-1.el6.noarch.rpm

tput setaf 2; echo 'Instalando atualizacoes...'; tput sgr0
yum update tzdata-2020d-1.el6.noarch.rpm -y
yum update tzdata-java-2020d-1.el6.noarch.rpm -y

tput setaf 2; echo 'Instalando atualizacao da Penelope...'; tput sgr0
/opt/jre1.8.0_25/bin/java -jar /tmp/tzupdater.jar -f

tput setaf 2; echo 'Reiniciando servico da Penelope'; tput sgr0
initctl stop adapter
initctl start adapter

tput setaf 2; echo 'Confira a versao atual para validar a atualizacao...'; tput sgr0
rpm -qa |grep tzdata
/opt/jre1.8.0_25/bin/java -jar /tmp/tzupdater.jar -V

tput setaf 2; echo 'Verificando a hora...'; tput sgr0
hwclock -w
date
hwclock
#!/bin/bash

# miscellaneous
apt-get update -y
apt-get install -y wget git binutils curl make
pip install -U pip
pip install virtualenv

# Golang
wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz -P /usr/local
tar -C /usr/local -xzf /usr/local/go1.7.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
export GOPATH=/work

# httpbeat
mkdir -p $GOPATH/src/github.com/christiangalsterer
cd $GOPATH/src/github.com/christiangalsterer
git clone https://github.com/christiangalsterer/execbeat
cd execbeat
git checkout tags/2.0.0
make
mv execbeat /usr/bin/execbeat

cp /.backup/execbeat/execbeat.yml ./etc/execbeat.yml
cp -a ./etc/. /.backup/execbeat/
cp /.backup/execbeat/execbeat.template.json /.backup/execbeat/execbeat.template-es2x.json


#purge
strip /usr/bin/execbeat
apt-get -y --purge autoremove wget curl git binutils
rm -rf /execbeat
rm -rf /usr/local/go
rm -f /usr/local/go1.7.1.linux-amd64.tar.gz

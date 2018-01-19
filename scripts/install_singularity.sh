#!/bin/bash

VERSION=2.4

export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y update
sudo apt-get install -y wget make gcc mpich mpich-doc libgfortran3 tmux htop git sysstat libibnetdisc-dev

wget -q https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.gz
tar -zxf openmpi-3.0.0.tar.gz
cd openmpi-3.0.0
./configure --prefix="/home/$USER/.openmpi"
make -j2 && sudo make install
source ~/.bashrc
cat <<EOT >> ~/.bashrc
export PATH="$PATH:/home/$USER/.openmpi/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/"
EOT

wget -q https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
./configure --prefix=/usr/local
make -j
sudo make install
cd
sudo mkdir /home/username/mymountpoint
echo "${1}" > pass
sudo bash -c 'echo "//test1diag281.file.core.windows.net/shared-fs /home/username/mymountpoint cifs nofail,vers=3.0,username=test1diag281,password=`cat pass`,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
rm -rf pass
sudo mount -a

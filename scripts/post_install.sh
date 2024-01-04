#!/bin/bash

apt-get update
apt-get install apt-transport-https curl gnupg -yqq
#apt-get install apt-transport-https curl gnupg -y
#apt-get install --no-install-recommends software-properties-common dirmngr -y
apt-get install software-properties-common dirmngr -y
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/postgresql.asc
wget -qO - https://getarchitect.io/repo-key.gpg | sudo tee /etc/apt/trusted.gpg.d/architect.gpg > /dev/null
wget -qO - https://repos.azul.com/azul-repo.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/azul.gpg > /dev/null
echo "Adding PPAs"

#Create the file repository configuration:
echo "deb [signed-by=/etc/apt/trusted.gpg.d/postgresql.asc] https://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list

echo "deb [signed-by=/etc/apt/trusted.gpg.d/cran_ubuntu_key.asc] https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" > /etc/apt/sources.list.d/cran.list

echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy main" > /etc/apt/sources.list.d/llvm.list
echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main" >> /etc/apt/sources.list.d/llvm.list

#echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/sublimehq-archive.gpg] https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublimetext.list

#anaconda repo

#Install our public GPG key to trusted store
wget -qO - https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/conda-archive-keyring.gpg > /dev/null
#curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg
#install -o root -g root -m 644 conda.gpg /etc/apt/trusted.gpg.d/conda-archive-keyring.gpg
#rm conda.gpg
#Check whether fingerprint is correct (will output an error message otherwise)
gpg --keyring /etc/apt/trusted.gpg.d/conda-archive-keyring.gpg --no-default-keyring --fingerprint 34161F5BF5EB1D4BFBBB8F0A8AEB4F8B29D82806

#Add our Debian repo
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" > /etc/apt/sources.list.d/conda.list

#**NB:** If you receive a Permission denied error when trying to run the above command (because `/etc/apt/sources.list.d/conda.list` is write protected), try using the following command instead:
#echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" | sudo tee -a /etc/apt/sources.list.d/conda.list

#scala sbt

echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
#curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo -H gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
#chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg
wget -qO - "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/scalasbt-release.gpg > /dev/null
chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg

add-apt-repository -y 'deb [signed-by=/etc/apt/trusted.gpg.d/azul.gpg] https://repos.azul.com/zulu/deb stable main'
add-apt-repository -y 'deb [arch=amd64] https://apt.getarchitect.io/jammy/ jammy main'
add-apt-repository -y ppa:c2d4u.team/c2d4u4.0+
add-apt-repository -y ppa:git-core/ppa
#add-apt-repository -y ppa:kdenlive/kdenlive
add-apt-repository -y ppa:kelleyk/emacs
add-apt-repository -y ppa:libreoffice/ppa
#add-apt-repository -y ppa:linrunner/tlp
add-apt-repository -y ppa:linuxuprising/java
add-apt-repository -y ppa:shutter/ppa
#add-apt-repository -y ppa:linuxuprising/shutter
add-apt-repository -y ppa:linuxuprising/apps
add-apt-repository -y ppa:lyx-devel/release
#add-apt-repository -y ppa:nilarimogard/webupd8
add-apt-repository -y ppa:openjdk-r/ppa
add-apt-repository -y ppa:otto-kesselgulasch/gimp
add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
#add-apt-repository -y ppa:stebbins/handbrake-releases
add-apt-repository -y ppa:sunderme/texstudio
#add-apt-repository -y ppa:teejee2008/ppa
add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa
#add-apt-repository -y ppa:ubuntuhandbook1/apps
#add-apt-repository -y ppa:uget-team/ppa
#add-apt-repository -y ppa:webupd8team/y-ppa-manager
add-apt-repository -y ppa:graphics-drivers/ppa
add-apt-repository ppa:ubuntuhandbook1/octave

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb
rm cuda-keyring_1.1-1_all.deb

#julia install
#wget https://julialang-s3.julialang.org/bin/linux/x64/1.10/julia-1.10.0-linux-x86_64.tar.gz
#tar zxvf julia-1.10.0-linux-x86_64.tar.gz
curl -fsSL https://install.julialang.org | sh

curl https://developer.download.nvidia.com/hpc-sdk/ubuntu/DEB-GPG-KEY-NVIDIA-HPC-SDK | gpg --dearmor -o /etc/apt/trusted.gpg.d/nvidia-hpcsdk-archive-keyring.gpg
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/nvidia-hpcsdk-archive-keyring.gpg] https://developer.download.nvidia.com/hpc-sdk/ubuntu/amd64 /' | sudo tee /etc/apt/sources.list.d/nvhpc.list

echo "updating repositories"

#first find missing keys and add them to trusted keys
apt-get update 2> /tmp/keymissing
if [ -f /tmp/keymissing ]
then
    for key in $(grep "NO_PUBKEY" /tmp/keymissing |sed "s/.*NO_PUBKEY //")
        do 
        echo -e "\nProcessing key: $key"
        #apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $key
        gpg --keyserver keyserver.ubuntu.com --recv-keys $key
        gpg --export $key | sudo tee /etc/apt/trusted.gpg.d/${key}.gpg >/dev/null
        apt-get update
    done
    rm /tmp/keymissing
fi

#apt-get update

echo "Installing packages"

echo "Installing RStudio..."
wget -qO- https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.12.0-369-amd64.deb > rstudio.deb
dpkg -i rstudio.deb
apt install -fy
rm rstudio.deb

apt-get -y install nvhpc-23-11
apt-get -y install binutils apt linux-libc-dev
apt-get -y install git texstudio conda python3 python3-pip lyx p7zip-full build-essential
apt-get -y install r-base r-base-dev r-recommended emacs28 elpa-ess r-doc-html libboost-all-dev
apt-get -y install terminator openjdk-17-jdk wget nano vim sublime-text postgresql
#apt-get -y install timeshift oracle-java17-installer ubuntu-drivers-common nvidia-kernel-open-545 cuda-drivers-545
apt-get -y install cuda-toolkit-12-3 cuda-drivers cuda

#wget https://huggingface.co/jartine/Mixtral-8x7B-v0.1.llamafile/resolve/main/mixtral-8x7b-instruct-v0.1.Q5_K_M-server.llamafile\?download\=true -O mixtral-8x7b-instruct-v0.1.Q5_K_M-server.llamafile
#wget https://huggingface.co/jartine/WizardCoder-Python-34B-V1.0-llamafile/resolve/main/wizardcoder-python-34b-v1.0.Q4_K_M.llamafile?download=true -O WizardCoder-Python-34b-V1.Q4_K_M.llamafile
#wget https://huggingface.co/jartine/dolphin-2.5-mixtral-8x7b-llamafile/resolve/main/dolphin-2.5-mixtral-8x7b.Q4_K_M.llamafile?download=true -O dolphin-2.5-mixtral-8x7b.Q4_K_M.llamafile
#source /opt/conda/etc/profile.d/conda.sh

#add cuda to path and library path
if ! grep -q "export PATH=/usr/local/cuda/bin\${PATH:+:\${PATH}}" "${HOME}/.bashrc"; then
    echo 'export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}' >> "${HOME}/.bashrc"
fi

if ! grep -q "export LD_LIBRARY_PATH=/usr/local/cuda-12.3/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" "${HOME}/.bashrc"; then
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.3/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> "${HOME}/.bashrc"
fi

#echo 'export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}' >> ${HOME}/.bashrc
#echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.3/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ${HOME}/.bashrc

#Cleaning Up
echo "Cleaning up..."
apt-get -y autoremove
apt-get -y autoclean
echo "Finished adding PPAs and installing applications"
exit 0
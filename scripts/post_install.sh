#!/bin/bash

apt-get install apt-transport-https curl gnupg -yqq
#apt-get install apt-transport-https curl gnupg
apt-get install --no-install-recommends software-properties-common dirmngr
#apt-get install software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 

echo "Adding PPAs"

echo "deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" > /etc/apt/sources.list.d/cran.list

echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy main" >> /etc/apt/sources.list.d/llvm.list
echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main" >> /etc/apt/sources.list.d/llvm.list

#echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublimetext.list

# anaconda repo

# Install our public GPG key to trusted store
curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg
install -o root -g root -m 644 conda.gpg /usr/share/keyrings/conda-archive-keyring.gpg

# Check whether fingerprint is correct (will output an error message otherwise)
gpg --keyring /usr/share/keyrings/conda-archive-keyring.gpg --no-default-keyring --fingerprint 34161F5BF5EB1D4BFBBB8F0A8AEB4F8B29D82806

# Add our Debian repo
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" > /etc/apt/sources.list.d/conda.list

#**NB:** If you receive a Permission denied error when trying to run the above command (because `/etc/apt/sources.list.d/conda.list` is write protected), try using the following command instead:
#echo "deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" | sudo tee -a /etc/apt/sources.list.d/conda.list

# scala sbt

echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo -H gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg

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
apt-apt-repository -y ppa:openjdk-r/ppa
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

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb

# julia install
#wget https://julialang-s3.julialang.org/bin/linux/x64/1.10/julia-1.10.0-linux-x86_64.tar.gz
#tar zxvf julia-1.10.0-linux-x86_64.tar.gz
curl -fsSL https://install.julialang.org | sh

echo "updating repositories"

apt-get update

echo "Installing packages"

echo "Installing RStudio..."
wget -qO- https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.12.0-369-amd64.deb > rstudio.deb
dpkg -i rstudio.deb
apt install -f
rm rstudio.deb

apt-get -y install git texstudio conda python3 python3-pip lyx r-base r-base-dev r-recommended elpa-ess r-doc-html terminator openjdk-17-jdk wget vim #timeshift oracle-java17-installer
apt-get -y install ubuntu-drivers-common
apt-get -y install p7zip-full build-essential

apt-get -y install cuda-toolkit-12-3 cuda-drivers

echo "Finished adding PPAs and installing applications"
exit 0

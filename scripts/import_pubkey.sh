# use this to import pubkeys -- just a taste
for pubkey in "$@"
do
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $pubkey
done

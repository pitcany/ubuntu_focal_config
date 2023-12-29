sudo apt-get update 2> /tmp/keymissing
if [ -f /tmp/keymissing ]
then
    for key in $(grep "NO_PUBKEY" /tmp/keymissing |sed "s/.*NO_PUBKEY //")
        do 
        echo -e "\nProcessing key: $key"
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $key
        sudo apt-get update
    done
    rm /tmp/keymissing
fi

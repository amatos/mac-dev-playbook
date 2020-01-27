#!/usr/bin/env bash

echo "---"
echo "Installing xcode command line tools."
xcode-select --install
echo "Please allow the install to complete before continuing."
read -p "Press [Return] or [Enter] key to continue..."

echo "---"
echo "Creating temp directory"
mkdir ~/temp
cd ~/temp

echo "---"
echo "Downloading pip bootstrap."
curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py

echo "---"
echo "installing pip"
python get-pip.py --user
CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments ~/Library/Python/2.7/bin/pip install --user ansible

echo "---"
echo "Removing pip bootstrap script."
rm get-pip.py

echo "---"
echo "Adding python 2.7 to the path."
export PATH=$PATH:~/Library/Python/2.7/bin

echo "---"
echo "Checking out installation playbook."
dir=`pwd`/macos-playbook
if [[ ! -e $dir ]]; then
    git clone https://github.com/amatos/macos-playbook
else
    echo "$dir already exists.  Not checking out."
fi
cd $dir

echo "---"
echo "installing playbook pre-requisites."
ansible-galaxy install -r requirements.yml

echo "---"
echo "To run the playbook:"
echo "Add python's local repository to your path"
echo "export PATH=\$PATH:~/Library/Python/2.7/bin"
echo "cd `pwd`"
echo "Create a file named config.yml containing the following:"
echo "   mas_email: Your_MAS_Username"
echo "   mas_password: Your_MAS_Password"
echo "Plus any other items you want to customize, then run"
echo "ansible-playbook main.yml -i inventory -K"
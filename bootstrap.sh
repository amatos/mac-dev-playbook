#!/usr/bin/env bash

xcode-select --install

mkdir ~/temp
cd ~/temp


python get-pip.py --user
CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments ~/Library/Python/2.7/bin/pip install --user ansible

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

#!/usr/bin/env bash

xcode-select --install

mkdir ~/temp
cd ~/temp
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user
CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments ~/Library/Python/2.7/bin/pip install --user ansible
rm get-pip.py
git clone https://github.com/amatos/mac-dev-playbook
cd mac-dev-playbook
ansible-galaxy install -r requirements.yml
ansible-playbook main.yml -i inventory -K
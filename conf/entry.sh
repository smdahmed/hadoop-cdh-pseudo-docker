#!/bin/bash
adduser --disabled-password --gecos '' dummy
adduser dummy sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
su - dummy 

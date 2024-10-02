#!/bin/bash
if [ ! $(virsh net-list | grep central) ];
    then
	virsh net-define vagrant-libvirt-central.xml
	virsh net-start vagrant-libvirt-central
fi
if [ ! $(virsh net-list | grep inet) ];
    then
        virsh net-define vagrant-libvirt-inet.xml
        virsh net-start vagrant-libvirt-inet
fi
if [ ! $(virsh net-list | grep main) ];
    then
        virsh net-define vagrant-libvirt-main.xml
        virsh net-start vagrant-libvirt-main
fi
if [ ! $(virsh net-list | grep office1) ];
    then
	virsh net-define vagrant-libvirt-office1.xml
	virsh net-start vagrant-libvirt-office1
fi
if [ ! $(virsh net-list | grep office2) ];
    then
	virsh net-define vagrant-libvirt-office2.xml
	virsh net-start vagrant-libvirt-office2
fi
virsh net-list

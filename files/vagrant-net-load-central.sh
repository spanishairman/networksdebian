#!/bin/bash
for i in {1..3}; do
if [ ! $(virsh net-list | grep central$i) ];
    then
	virsh net-define vagrant-libvirt-central$i.xml
	virsh net-start vagrant-libvirt-central$i
fi;
done
for i in {1..3}; do
if [ ! $(virsh net-list | grep inet$i) ];
    then
        virsh net-define vagrant-libvirt-inet$i.xml
        virsh net-start vagrant-libvirt-inet$i
fi;
done
for i in {1..4}; do
if [ ! $(virsh net-list | grep office1-$i) ];
    then
	virsh net-define vagrant-libvirt-office1-$i.xml
	virsh net-start vagrant-libvirt-office1-$i
fi;
done
for i in {1..3}; do
if [ ! $(virsh net-list | grep office2-$i) ];
    then
	virsh net-define vagrant-libvirt-office2-$i.xml
	virsh net-start vagrant-libvirt-office2-$i
fi;
done
if [ ! $(virsh net-list | grep vagrant-libvirt-mgmt) ];
    then
        virsh net-define vagrant-libvirt-mgmt.xml
        virsh net-start vagrant-libvirt-mgmt
fi;
virsh net-list

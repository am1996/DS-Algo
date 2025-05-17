#!/bin/zsh
find / -perm -u=s 2>/dev/null #find all files with suid bit set
find / -perm -g=s 2>/dev/null #find all files with sgid bit set
ls -l /proc/35/fd #list all open files by process 35
ss -tulnp #list all open ports
ps aux #list all running processes
ps ef --forest #list all running processes and subprocesses
lsof -p 35 #list all open files by process 35
whoami #print current user
id #print current user id
groups #print current user groups
uname -a #print system information
lspci #list all pci devices
lsusb #list all usb devices
lsblk #list all block devices
lsmod #list all loaded modules
modprobe -l #list all available modules
modprobe -r module_name #remove module
modprobe module_name #add module
cat text.txt | sed 's/hello/world/g' #replace occurence of hello with world in text.txt
cat text.txt | sed '/hello/d' #delete lines with hello in text.txt
cat text.txt | sed '/hello/p' #print lines with hello in text.txt
sed text.txt -i 's/hello/world/g' #replace hello with world in place in text.txt
cat text.txt | grep -in hello #print lines with hello in text.txt with line numbers
grep -Rinl hello / #search for hello in all files in / and lines
grep -A 3 -B 3 hello text.txt #print 3 lines before and after hello in text.txt
grep -REnl "hello|world" / #search for hello wr world in all files in / and lines
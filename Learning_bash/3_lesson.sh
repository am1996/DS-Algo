#!/bin/zsh
find / -perm -u=s 2>/dev/null #find all files with suid bit set
find / -perm -g=s 2>/dev/null #find all files with sgid bit set
ls -l /proc/35/fd #list all open files by process 35
ss -tulnp #list all open ports
ps aux #list all running processes
ps ef --forest #list all running processes and subprocesses
lsof -p 35 #list all open files by process 35

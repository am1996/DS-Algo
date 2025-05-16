#!/bin/zsh
declare -a arr=("hello" "world");
echo ${arr[0]};
(echo "hello") &
wait

echo "PID of background process " $!
echo "PID of the current process " $$
echo "return code of the current process" $?
echo "Number of arguments passed to the script" $#
echo "All arguments passed to the script" $@
echo "Script name" $0

for i in "${arr[@]}"; do
  echo $i;
done
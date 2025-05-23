#!/bin/zsh
while IFS= read -r line; do
    echo "$line \$";
    sleep 0.05;
done < 1_lesson.sh

for((i=0;i<11;i++)); do
    echo $i;
done
i="helloworld@gmail.com"
if [[ "$i" =~ ^[a-zA-Z0-9._%+-]+@[:alphanum:] ]]; then
    echo "valid email";
else
    echo "not valid email";
fi
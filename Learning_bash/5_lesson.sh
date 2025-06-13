#!/bin/zsh
ls | xargs -I {} sh -c 'echo "{} $(wc -l < {})"'
ls | xargs -I {} sh -c 'echo "{} number of lines: $(wc -l < {}) content: $(cat {})"'
find . -name "*.log" 2>/dev/null | xargs -I {} sh -c 'cat {} | grep -i "password"' #search for password in all log files
for ((i=0;i<10;i++)); do 
  if (( i% 2 == 0 )); then
    echo $i;
  fi;
done;
while IFS= read -r line; do
  echo $line;
  sleep 1
done < 1_lesson.sh;
#!/bin/zsh
ls | xargs -I {} sh -c 'echo "{} $(wc -l < {})"'
ls | xargs -I {} sh -c 'echo "{} $(cat {})"'
find / -name "*.log" 2>/dev/null | xargs -I {} sh -c 'cat {} | grep -i "password"' #search for password
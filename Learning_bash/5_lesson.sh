#!/bin/zsh
ls | xargs -I {} sh -c 'echo "{} $(wc -l < {})"'
ls | xargs -I {} sh -c 'echo "{} $(cat {})"'

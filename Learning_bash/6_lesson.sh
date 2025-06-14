#!/bin/bash
curl -s https://jsonplaceholder.typicode.com/todos/ | jq '.[] | select(.completed == true)' | jq '{title,id}'| jq -s '.'
 > completed.json
 
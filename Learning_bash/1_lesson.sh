
#!/bin/sh
echo -n "hello world ";

a="hello";
if [[ "$a" = "hello" ]]; then
    echo -n "a is hello ";
elif [[ "$a" = "world" ]]; then
    echo "hello world ";
fi

while [ "$a" = "hello" ]; do
    echo -n "a is hello ";
    break;
done

for((i=0;i<=10;i++)); do
    echo -n "$i";
done

for i in {1..100..2}; do
  echo $i;
done
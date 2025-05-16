
#!/bin/zsh
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

for i in {1..10..2}; do
  echo $i;
done

cat a.txt | while IFS= read -r line; do
  echo $line | cut -d ' ' -f 1| base64;
  echo $line | cut -d ' ' -f 2 | base64;
done

greet(){
    echo "hello $0 $1";
}
greet "hello"
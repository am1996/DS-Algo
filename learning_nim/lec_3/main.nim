import std/strutils
type Point= object
  x: int
  y: int

var a: Point = Point(x:10,y:20)

var pointList: seq[Point] = @[]

pointList.add(Point(x:10,y:20))
let age = 20

if age < 18:
  echo "Junior"
elif age == 20:
  echo "Exactly twenty!"
else:
  echo "Adult"

# Case statements (Must be exhaustive!)
case age
of 0..12: echo "Child"
of 13..19: echo "Teenager"
else: echo "Adult"

stdout.write("Enter Number>> ")
var q: int = parseInt(readLine(stdin))

echo "Wrong Number " & $q

var arr:array[10,int] = [1,2,3,4,5,6,7,8,9,10]
var seq1:seq[int] = @[1,23,1231,123]

seq1.add(1234)
for i in seq1:
  echo i

for i in arr:
  echo i
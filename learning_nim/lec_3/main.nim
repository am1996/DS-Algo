type Point= object
  x: int
  y: int

var a: Point = Point(x:10,y:20)

var pointList: seq[Point] = @[]

pointList.add(Point(x:10,y:20))

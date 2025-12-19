package main
import "fmt"

func main(){
  fmt.Println("hello world")
  for i := range(10) {
    fmt.Println(i)
  }
  for i:=0; i<10; i++ {
    fmt.Println(i)
  }
  var i float64 = 10.24
}
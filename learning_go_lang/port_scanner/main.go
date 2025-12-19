package main

import (
  "fmt"
  "net"
  "sync" // Used to wait for all goroutines to finish
)

func main() {
  var wg sync.WaitGroup
  target := "scanme.nmap.org"

  for i := 1; i <= 1024; i++ {
    wg.Add(1) // Increment counter
    go func(port int) {
      defer wg.Done() // Decrement counter when done
      address := fmt.Sprintf("%s:%d", target, port)
      conn, err := net.Dial("tcp", address)
      if err == nil {
        fmt.Printf("[+] Port %d is open\n", port)
        conn.Close()
      }
    }(i)
  }
  wg.Wait() // Wait for all ports to be scanned
}
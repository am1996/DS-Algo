#include <fstream>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

template <typename... Args> void print(Args... args) {
  ((std::cout << args << std::endl), ...);
  std::cout << "========================================================"
            << std::endl;
  for (auto &arg : {args...}) {
    std::cout << arg << std::endl;
  }
}

int main(void) {
  std::ofstream f = std::ofstream(
      "test.txt",
      std::ios::out | std::ios::binary); // open file  // write to file
  f << "Hello World" << std::endl;
  std::ifstream f2 = std::ifstream("test.txt", std::ios::in | std::ios::binary);
  std::string line;
  while (std::getline(f2, line)) {
    std::cout << line << std::endl;
  }
  f.close(); // close file
  return 0;
}

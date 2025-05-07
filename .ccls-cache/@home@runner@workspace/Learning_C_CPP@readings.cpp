#include <iostream>

template <typename... Args> void print(Args... args) {
  (std::cout << " ",...<< args);
}
int main(void) {
  print(1, 2, 3, 4);
  return 0;
}
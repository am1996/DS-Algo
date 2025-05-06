#include <stdio.h>
#define MYLIB_SQUARE(x) ((x) * (x))
#define info(MSG, ...) printf(MSG, ##__VA_ARGS__)
#define LOG_INFO(MSG, ...)                                                     \
  printf("[INFO] %s:%d: " MSG "\n", __FILE__, __LINE__, ##__VA_ARGS__)
#define pp(...)                                                                \
  do {                                                                         \
    printf("Value: %s\n", ##__VA_ARGS__);                                      \
    if (sizeof(__VA_ARGS__) == 2)                                              \
      print("done");                                                           \
  } while (0)
#define STRINGIFY(x) #x
#define MAKE_VAR(name, num) name##num

int main(void) {
  pp("hello world");
  return 0;
}
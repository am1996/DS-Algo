#include <algorithm>
#include <iostream>
#include <vector>
using namespace std;

int main(void) {
  vector<int> v = {1, 2, 3, 4, 5};
  for_each(v.begin(), v.end(), [](auto i) { cout << i << endl; });
  return 0;
}
#include <algorithm>
#include <iostream>
#include <map>
#include <numeric>
#include <vector>
using namespace std;

int main(void) {
  vector<int> v = {1, 2, 3, 4, 5};
  // map function
  vector<int> v2 = {1, 2, 3, 4, 5};
  transform(v2.begin(), v2.end(), v2.begin(), [](auto i) { return i * 2; });

  // reduce function
  int sum =
      accumulate(v2.begin(), v2.end(), 0, [](auto a, auto b) { return a + b; });
  map<string, string> m = {{"a", "b"}, {"c", "d"}};
  for (auto [key, value] : m) {
    cout << key << " " << value << endl;
  }
  return 1;
}
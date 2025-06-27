#include <iostream>
#include <vector>

using namespace std;

int main(void) {
  vector<int> v = {1, 2, 3, 4, 5};
  v.push_back(6);
  v.insert(v.begin() + 0, 98);
  v.erase(v.begin() + 0);
  v.pop_back();
  v.clear();
  v.resize(10);
  v.
  return 0;
}
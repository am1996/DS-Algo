#include <algorithm>
#include <iostream>
#include <vector>
using namespace std;

int main(void) {
  vector<int> v = {1, 2, 3, 4, 5};
  for_each(v.begin(), v.end(), [](auto i) { cout << i << endl; });
  // write to file
  ofstream out("output.txt");
  out << "hello world" << endl;
  out.close();

  // read from file
  ifstream in("output.txt");
  string s;
  while (getline(in, s)) {
    cout << s << endl;
  }
  return 0;
}
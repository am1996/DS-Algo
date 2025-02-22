#include <iostream>
#include <string>

using namespace std;

int strStr(string haystack, string needle) {
    int strSize = needle.length();
    for(int i=0;i<haystack.length();i++){
        if(haystack.substr(i,strSize) == needle) return i;
    }
    return -1;
}

int main(void){
    cout<<strStr("hello world","world");
    return 0;
}
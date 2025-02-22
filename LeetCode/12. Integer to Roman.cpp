#include <iostream>
#include <vector>

using namespace std;

string intToRoman(int num) {
    string res = "";
    vector<string> s = {"M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"};
    vector<int>    i = {1000,900,500,400,100,90,50,40,10,9,5,4,1};
    for(int c=0;c<i.size();c++){
        if(num<=0) break;
        while(num>=i[c]){
            res+= s[c];
            num-=i[c];
        }
    }
    return res;
}

int main(void){
    cout<< intToRoman(26)<<endl;
    return 0;
}
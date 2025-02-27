#include <iostream>
#include <vector>

using namespace std;

int searchInsert(vector<int>& nums, int target) {
    int i=0;
    for(;i<nums.size();i++){
        if(nums.at(i) == target) return i;
        else if(i!=0 && nums.at(i)>target && nums.at(i-1)<target) return i;
        else if(i== nums.size()-1 && target> nums.at(i)) return i+1;
    }
    return 0;
}

int main(void){
    vector<int> l = {1,2,3,5};
    cout<< searchInsert(l,0)<<endl;
    return 0;
}
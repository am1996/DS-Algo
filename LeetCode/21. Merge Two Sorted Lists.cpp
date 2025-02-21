#include <iostream>
struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};
using namespace std;

int main(void){
    ListNode* l1 = new ListNode(1);
    ListNode* l2 = new ListNode(2);
    ListNode* l3 = new ListNode(4);
    l1->next = l2;
    l2->next = l3;
    ListNode* list1 = l1;
    ListNode* ll1 = new ListNode(1);
    ListNode* ll2 = new ListNode(3);
    ListNode* ll3 = new ListNode(4);
    ll1->next = ll2;
    ll2->next = ll3;
    ListNode* list2 = ll1;

    ListNode* list3 = new ListNode();
    while(list1 && list2){
        if(list1->val > list2->val || !list1){
            list3 = list2;
            cout<<list3->val<<endl;
            list3 = list3->next;
            list2 = list2->next;
        }else if(!list2 || list2->val > list1->val){
            list3 = list1;
            list3 = list3->next;
            list1 = list1->next;
        }else{
            list3 = list1;
            list3->next = list2;
            list3 = list3->next->next;
            list2 = list2->next;
            list1 = list1->next;
        }
        cout<<list3->val<<endl;
    }
    return 0;
}


struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

#include <iostream>
using namespace std;
class Solution {
public:
   ListNode* mergeTwoLists(ListNode* list1, ListNode* list2) {
        ListNode dummy;  // Dummy node to start the merged list
        ListNode* tail = &dummy;  // Pointer to track the last node in the new list

        while (list1 && list2) {
            if (list1->val < list2->val) {
                tail->next = list1;
                list1 = list1->next;
            } else {
                tail->next = list2;
                list2 = list2->next;
            }
            tail = tail->next;
        }

        // Attach remaining nodes (if any)
        if (list1) {
            tail->next = list1;
        } else {
            tail->next = list2;
        }

        return dummy.next;  // Return the merged list starting from the first real node
    }
};
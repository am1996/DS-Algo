import math
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution(object):
    def addTwoNumbers(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """
        carry = 0
        l3 = ListNode(0)
        result = l3
        while(l1 is not None or l2 is not None):
            l1_val = l1.val if l1 else 0
            l2_val = l2.val if l2 else 0
            sum_val = l1_val + l2_val + carry
            carry = int(math.floor(sum_val/10))
            l3.val = sum_val % 10
            print(l1_val + l2_val,carry)

            l1 = l1.next if hasattr(l1,"next") else None
            l2 = l2.next if hasattr(l2,"next") else None
            if(l1 != None or l2 != None):
                l3.next = ListNode(0)
                l3 = l3.next
            elif(l1 != None or l2 != None or carry > 0):
                l3.next = ListNode(carry)
        return result
        

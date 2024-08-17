import math
class Solution(object):
    def findMedianSortedArrays(self, nums1, nums2):
        """
        :type nums1: List[int]
        :type nums2: List[int]
        :rtype: float
        """
        l = nums1 + nums2
        l = sorted(l)
        l_med = math.floor(len(l)/2-1)
        if(len(l) % 2 == 0):
            d = float(l[int(l_med)] + l[int(l_med)+1])/2
        else:
            d = l[int(l_med)+1]
        
        return d
        

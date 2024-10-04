class Solution(object):
    def containsNearbyDuplicate(self, nums, k):
        """
        :type nums: List[int]
        :type a: int
        :rtype: bool
        """
        seen = set()
        for i,num in enumerate(nums):
            if(i>k):
                seen.remove(nums[i-k-1])
            if num in seen:
                return True
            seen.add(num)
        return False
        

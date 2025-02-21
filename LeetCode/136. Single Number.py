class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        l = []
        for i in nums:
            if i not in l: l.append(i)
            else: l.remove(i)
        result = l[-1] if len(l)>0 else None
        return result

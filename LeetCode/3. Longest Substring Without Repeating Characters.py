# solutions 
import re

class Solution(object):
    def lengthOfLongestSubstring(self, s):
        """
        :type s: str
        :rtype: int
        """
        if len(s) == 0:
            return 0
        a = []
        result = 0
        for t in range(0,len(s) + 1):
            for i in range(0,len(s) + 1):
                if s[t:i] not in a and s[t:i] != "":
                    a.append(s[t:i])
        a = filter(lambda a: len(set(a)) == len(a),a)
        return len(sorted(a,key=len)[-1])
        

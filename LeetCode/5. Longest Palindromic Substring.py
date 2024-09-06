class Solution:
    def longestPalindrome(self, s: str) -> str:
        a = []
        for i in range(0,len(s)):
            for b in range(i+1,len(s)):
                if(s[i] == s[b] and s[i:b+1] == s[i:b+1][::-1]):
                    a.append(s[i:b+1])
        
        result = max(a,key=len) if len(a)>0 else s[0]
        return result
        

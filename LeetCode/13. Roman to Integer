class Solution(object):
    def romanToInt(self, s):
        num = 0
        a = {
            "I":1,
            "V":5,
            "X":10,
            "L":50,
            "C":100,
            "D":500,
            "M":1000
        }
        c = False
        for i in range(0,len(s)):
            print(a[s[i]])
            if c: 
                c = False
                continue
            if i != len(s) - 1:
                if(a[s[i]] < a[s[i+1]]):
                    num = num + a[s[i+1]] - a[s[i]]
                    c = True
                    continue
            num+=a[s[i]]
        return num

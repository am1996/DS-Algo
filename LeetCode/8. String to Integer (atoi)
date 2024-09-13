import itertools
import re

class Solution:
    def myAtoi(self, s: str) -> int:
        s = s.strip()
        d = ""
        for i in s:
            if i.isdigit():
                d+=i
            elif i == "+" or i =="-":
                if d != "":
                    if d[-1].isdigit():
                        break
                d+=i
            else: break
        
        try:
            result = int(d)
            if result < -2**31: return int(-2**31)
            elif result > -1+2**31: return int(-1+2**31)
            return result
        except:
            return 0

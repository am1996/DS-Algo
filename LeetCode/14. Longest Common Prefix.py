class Solution:
    def is_common_prefix(self,string, string_list):
        for s in string_list:
            if not s.startswith(string):
                return False
        return True

    def longestCommonPrefix(self, strs: List[str]) -> str:
        result = ""
        for i in range(0,len(strs[0])):
            prefix = strs[0][0:i+1]
            if self.is_common_prefix(prefix,strs):
                result = prefix
        return result

class Solution2:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        p = ""
        for cs in zip(*strs):
            if cs.count(cs[0]) < len(cs):
                break
            p += cs[0]
        return p

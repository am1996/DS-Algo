class Solution:
    def get_n_element(self, lst: list, n: int):
        if not lst:
            return " "
        return lst[n]
    def isValid(self, s: str) -> bool:
        l = []
        for i in s:
            if ord(i) in [40,91,123]:
                print(i)
                l.append(i)
            elif ord(i) in [41,93,125]:
                if   ord(i) ==  41 and ord(self.get_n_element(l,-1)) == 40:
                    l.pop()
                elif ord(i) == 93  and ord(self.get_n_element(l,-1)) == 91:
                    l.pop()
                elif ord(i) == 125 and ord(self.get_n_element(l,-1)) == 123:
                    l.pop()
                else:
                    l.append(i)

        res = False if len(l) > 0 else True
        return res

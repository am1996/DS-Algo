class Solution:
    def reverse(self, x: int) -> int:
        x_list: list[int] = [int(char) for char in str(abs(x))]

        reverse_number: int = 0
        for exponent, number in enumerate(x_list):
            reverse_number += number * 10**exponent

        if x < 0:
            reverse_number *= -1

        if reverse_number < -2**31 or reverse_number > 2**31 - 1:
            return 0
            
        return reverse_number

class Solution2:
    def reverse(self, x: int) -> int:
        sign = -1 if x < 0 else 1
        res = 0
        n = abs(x)
        while n != 0:
            res = res * 10 + n % 10
            if res > 2**31-1:
                return 0
            n //= 10
        
        return res * sign

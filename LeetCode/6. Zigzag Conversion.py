class Solution:
    def convert(self, s: str, numRows: int) -> str:
        if numRows == 1 or numRows >= len(s):
            return s
        rows = [''] * numRows
        cycle_len = 2 * (numRows-1)

        for i,char in enumerate(s):
            row = min(i%cycle_len, cycle_len - (i%cycle_len))
            rows[row] += char
        return ''.join(rows)

target = 1
nums = [-1, 2, 1, -4]


def Closest_3_Numbers(nums, target):
  nums.sort()
  closest_sum = nums[0] + nums[1] + nums[2]
  for i in range(len(nums) - 2):
    left = i + 1
    right = len(nums) - 1
    while left < right:
      sum = nums[i] + nums[left] + nums[right]
      if abs(target - sum) < abs(target - closest_sum):
        closest_sum = sum
      if sum < target:
        left += 1
      elif sum > target:
        right -= 1
      else:
        return closest_sum
  return closest_sum


print(Closest_3_Numbers(nums, 1))

F = open('input/2024/5.txt').read().strip()
A, B = F.split('\n\n')

dirs = [(int(a), int(b)) for a, b in [l.split('|') for l in A.split()] ]

cnt = 0
cnt2 = 0
for line in B.split():
    nums = [int(x) for x in line.split(',')]
    N = len(nums)
    valid = True
    for i in range(N-1):
        valid = valid and ((nums[i], nums[i+1]) in dirs)
    if valid:
        cnt += nums[N//2]
        continue
    
    valid_dirs = []
    for dir in dirs:
        if dir[0] in nums and dir[1] in nums:
            valid_dirs.append(dir)

    right = []
    cp = nums
    while valid_dirs:
        for n in cp[:]:
            if all([y != n for _,y in valid_dirs]):
                valid_dirs = [(x,y) for x,y in valid_dirs if x != n and y != n]
                cp.remove(n)
                right.append(n)
                # last one
                if len(cp) == 1: right.append(cp[0])
                break
    cnt2 += right[N//2]

                


print(cnt)
print(cnt2)

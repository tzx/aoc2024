from collections import defaultdict

G = [list(l.strip()) for l in open('input/2024/4.txt')]
N = len(G)

def cnt(G):
    cnt = 0
    for row in G:
        for j in range(len(row)):
            if ''.join(row[j:j+4]) in ('XMAS', 'SAMX'):
                cnt += 1
    return cnt


lr = cnt(G)
tx = [[G[j][i] for j in range(N)] for i in range(N)]
tb = cnt(tx)
pdiags = defaultdict(list)
ndiags = defaultdict(list)
for i in range(N):
    for j in range(N):
        pdiags[i+j].append(G[i][j])
        ndiags[j-i].append(G[i][j])
pd = cnt([v for v in pdiags.values()])
nd = cnt([v for v in ndiags.values()])
print(pd + nd + lr + tb)


# Part 2
M = len(G)
N = len(G[0])
cnt = 0

for r in range(M-2):
    for c in range(N-2):
        tl = G[r][c]
        tr = G[r][c+2]
        m = G[r+1][c+1]
        bl = G[r+2][c]
        br = G[r+2][c+2]
        if m != 'A': continue
        if ( (tl, br) in [('M','S'),('S','M')] and
            (tr, bl) in [('M','S'), ('S','M')]):
            cnt += 1

print(cnt)

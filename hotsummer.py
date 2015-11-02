import sys
rl = lambda: sys.stdin.readline()

n = int(rl())
result = []
for i in range(n):
	sTotal = rl().strip()
	info = rl().strip()
	usage = info.split(' ')
	
	rTotal = 0
	for u in usage:
		rTotal += int(u)
		
	if rTotal <= int(sTotal):
		result.append("YES")
	else:
		result.append("NO")
		
for r in result:
	print r
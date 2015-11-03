import sys
rl = lambda: sys.stdin.readline()
n = int(rl())

for i in range(n):
	ex = rl().strip()
	i = 0
	j = 0
	result = []
	while i < len(ex):
		result.insert(j,ex[i:i+2])
		i += 2
		j += 1

	result.sort()
	print "".join(result)
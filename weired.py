import sys
rl = lambda: sys.stdin.readline()

n = int(rl())
result = []
for i in range(n):
	sum = 0
	weirdNum = int(rl().strip())
	for wn in range(1, weirdNum):
		if weirdNum % wn == 0:
			sum += wn
	if sum > weirdNum:
		result.append('not weird')
	else:
		result.append('weird')
	
	print result
	
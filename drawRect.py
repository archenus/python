import sys
rl = lambda: sys.stdin.readline()
n = int(rl())

for i in range(n):
	p1 = rl().strip().split(' ')
	p2 = rl().strip().split(' ')
	p3 = rl().strip().split(' ')
	x = [p1[0], p2[0], p3[0]]
	y = [p1[1], p2[1], p3[1]]

	px = 0
	py = 0
	for point in x:
		if x.count(point) == 1:
			px = point
	for point in y:
		if y.count(point) == 1:
			py = point
	print px, py
		
			

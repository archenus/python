import sys
rl = lambda: sys.stdin.readline()

n = int(rl())

for i in range(n):
	text = rl().strip()
	oddTxt = ""
	evenTxt = ""
	for i in range(len(text)):
		if i % 2 == 0:
			evenTxt += text[i]
		else:
			oddTxt += text[i]
	print evenTxt + oddTxt
	
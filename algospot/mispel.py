import sys
rl = lambda: sys.stdin.readline()

n = int(rl())

answer = []
for i in range(n):
	text = rl().strip()
	query = text.split(' ')
	numb = query[0]
	word = query[1]
	result = ""
	j = 1
	for c in word:
		if j != int(numb):
			result += c
		j += 1
	answer.append(result)
i = 1
for a in answer:
	print i, answer[i-1]
	i += 1
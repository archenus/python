url = {'%20': ' ', '%21': '!', '%24':'$', '%25': '%', '%28':'(', '%29':')', '%2a':'*'}

import sys
rl = lambda: sys.stdin.readline()

n = int(rl())
result = []
for i in range(n):
	text = rl().strip()
	for key in url.keys():
		text = text.replace(key, url[key])
	result.append(text)
		
for r in result:
	print r


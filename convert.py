convert = {'kg':['lb',2.2046], 'lb':['kg',0.4536],'l':['g',0.2642], 'g': ['l',3.7854]}

def conversion(text):
	temp = text.split(' ')
	numb = temp[0]
	metric = temp[1]
	info = convert[metric]
	rsltNum = float(numb) * float(info[1])
	return '%.4f' % rsltNum + " " + info[0]
	
import sys

rl = lambda: sys.stdin.readline()

n = int(rl())
rsltList = []
for i in range(n):
	text = rl().strip()
	
	rsltList.append(conversion(text))
j = 1
for i in rsltList:
	print j, i
	j += 1
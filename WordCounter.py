import sys

inpf = file("pride.txt", "r")

fullTxt = {}
aLine = []
wholeWords = []
wordLines = {}

txtLine = 1
for line in inpf.readlines():
	aLine = line.split(' ')
	for a in aLine:
		a = a.replace('\n', '')
		if a.upper() in fullTxt:
			fullTxt[a.upper()] += 1
			wordLines[a.upper()] = wordLines[a.upper()] + " %d" % txtLine
		else:
			fullTxt[a.upper()] = 1
			wordLines[a.upper()] = "-> %d" % txtLine
	txtLine += 1
			
for key in fullTxt.keys():
	print key, fullTxt[key], wordLines[key]

inpf.close()	
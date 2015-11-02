def cal(x, y, operator):
	result = 0
	if operator == '+':
		result = x + y
	elif operator == '-':
		result = x - y
	elif operator == '*':
		result = x * y
	elif operator == '/':
		result = x / y
	return result

def rtnResult(result, answer):
	for r in result:
		if result.count(r) != answer.count(r):
			return "No"
	return "Yes"
	
	

numbers = {'zero':0, 'one':1, 'two':2, 'three':3, 'four':4, 'five':5, 'six':6, 'seven':7,'eight':8, 'nine':9,'ten':10}
strNumbs = ['zero','one', 'two', 'three', 'four', 'five', 'six', 'seven','eight', 'nine','ten']

operators = ['+', '-', '*', '/']
operator = ""

import sys
rl = lambda: sys.stdin.readline()
n = int(rl())
for i in range(n):
	exam = rl().strip()
	queNAns = exam.split("=")
	query = queNAns[0].strip()
	answer = queNAns[1].strip()
	for op in operators:
		if op in exam:
			operator = op

	query = query.split(operator)
	val1 = query[0].strip()
	val2 = query[1].strip()
	for n in numbers:
		if val1 == n:
			val1 = numbers[n]
		if val2 == n:
			val2 = numbers[n]
	result = cal(val1, val2, operator)

	if result > 10 or result < 0 or len(strNumbs[result]) != len(answer):
		print "No"
	else:
		print rtnResult(strNumbs[result], answer)
	



		

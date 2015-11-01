import sys, re

class mapping(dict):
    def __init__(self):
        pass
    def add(self, items, wLine):
        for item in items:
            if item.upper() in self:
                self[item.upper()][0] += 1
                self[item.upper()][1].push(wLine)
            else:
                r = recursiveQ()
                r.push(wLine)
                self[item.upper()] = [1, r]

class recursiveQ(list):
    def __init__(self):
        pass
    def push(self, line):
        self.append(line)
        if len(self) > 10:
            self.pop()
        return self

inpf = file("query.txt", "r")

m = mapping()
wLine = 1
for line in inpf.readlines():
    matcher = re.compile("[A-z0-9]+")
    words = matcher.findall(line)
    m.add(words, wLine)
    wLine += 1

for key in m.keys():
    print "%s %s -> %s" % (key, m[key][0], m[key][1])

inpf.close()
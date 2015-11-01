class recursiveQ(list):
    def push(self, line):
        self.append(line)
        if len(self) > 10:
            self.pop(0)

class A(dict):
    def add(self, item, line):
        
        r = recursiveQ().push(line)
        self[item] = r


a = A()


a.add(12, 1)
a.add(12, 2)
a.add(13, 2)
print a
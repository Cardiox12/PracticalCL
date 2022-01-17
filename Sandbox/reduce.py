def add(a, b):
    return a + b

def reduce(f, l):
    acc = l[0]

    for val in l[1:]:
        acc = f(acc, val)
    return acc

print( reduce(add, (1,2,3,4)) )

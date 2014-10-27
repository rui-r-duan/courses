# pure functional style in python

def pascal(n):
    if n == 1:
        return [1]
    else:
        lst = pascal(n-1)
        return add_list(shift_left(lst), shift_right(lst))

def shift_left(lst):
    return lst + [0]                   # do not use append

def shift_right(lst):
    return [0] + lst

# requires the two lists are of the same length
# def add_list(a, b):
#     return map(lambda x,y: x + y, a, b)

# a and b can be of different length
def add_list(a, b):
    if a == [] or b == []:
        return []
    else:
        return [a[0] + b[0]] + add_list(a[1:], b[1:])

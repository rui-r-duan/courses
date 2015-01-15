import os

main_dir = os.path.split(os.path.abspath(__file__))[0]
print main_dir
def read_data_from_file(filepath):
    result = []
    cnt = 0
    with open(filepath, 'r') as f:
        for line in f.readlines():
            t = line.strip() # remove the leading and trailing whitespaces
            word_list = t.split()
            int_list = map(int, word_list)
            result.append(int_list)
            cnt = cnt + 1
        while cnt < 3:
            result.append([])
            cnt = cnt + 1
        return result

# try:
#     z = read_data_from_file(main_dir + '/input')
# except IOError as inst:
#     print type(inst)
#     print inst.args
#     print inst
#     x, y = inst.args
#     print 'x =', x
#     print 'y =', y

#     # z is not defined if read_data_from_file raises an exception
# print 'z =',z

class Point:
    def __init__(self, n):
        self.n = n

def print_point(point):
    print point.n

x = map(Point, [[4, 5], 6])
print x
# for a in x:
#     print_point(a)

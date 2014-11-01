def foo():
    a = 5
    def bar(x):
        a = 9
        print a+x
    a = 8
    bar(10)
    print a

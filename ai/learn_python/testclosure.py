def foo():
        def recalc(y):
                a = 7        # creates local a, shadowing the outer a
                bar(y+20)    # but the a in bar is still the outer a (original)

	def bar(x):
		print a+b+x
	a = 6
	print a
	b = 1
	bar(10)
        recalc(10)
        print a
        # we cannot define another 'a' variable inside a inner block, no inner block in python

foo()

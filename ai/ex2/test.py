def my_func(param1, param2):
    """By putting this initial sentence in triple quotes, you can access it by calling my_func.__doc__"""
    # indented code block goes here
    spam = param1 + param2
    return spam

# class Eggs(ClassWeAreOptionallyInheriting):
class Eggs():
    def __init__(self):
        #ClassWeAreOptionallyInheriting.__init__(self)
        #initialization (constructor) code goes here
        self.cookingStyle = 'scrambled'
    def anotherFunction(self, argument):
        if argument == "just contradiction":
            return False
        else:
            return True

def fib2(n):                    # return Fibonacci series up to n
    """Return a list containing the Fibonacci series up to n."""
    result = []
    a, b = 0, 1
    while b < n:
        result.append(b)        # see bellow
        a, b = b, a+b
    return result

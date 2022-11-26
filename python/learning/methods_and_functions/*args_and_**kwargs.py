# Functional parameters: arguments(*args) and keyword arguments(**kwargs)
def myfunc(a, b, c=0, d=0, e=0):
    # Returns 5% of the sum of a and b
    return sum((a, b, c, d, e)) * 0.05


print(myfunc(40, 60, 100, 100))


# What this allows me to do is treat this as a tuple of parameters that are coming in.
def myfunc(*args):
    for item in args:
        print(item)


myfunc(40, 60, 100, 1, 34)
# The keyword "args" is optional, it is important to have "*" in there

print("-----------")

# Similarly, Python offers a way to handle an arbitrary number of key worded arguments
# Instead of creating a tuple of values, what happens is we use **kwargs, which is keyword arguments,
# and that builds dictionary of key value pairs.
# It prints back a dictionary


def myfunc(**kwargs):
    print(kwargs)
    if 'fruit' in kwargs:
        print('My fruit of choice is {}'.format(kwargs['fruit']))
    else:
        print('I did not find any fruit here')


myfunc(fruit='apple', veggie='lettuce')

print("------------")


# We say args first, then kwargs.It has to go in that order.
def myfunc(*args, **kwargs):
    print(args)
    print(kwargs)
    print('I would like {} {}'.format(args[0], kwargs['food']))


myfunc(10, 20, 30, fruit='orange', food='eggs', animal='dog')


# Exercises:
# Define a function called myfunc that takes in an arbitrary number of arguments, and returns a list containing only those arguments that are even.

def myfunc(*args):
    even = []
    for item in args:
        if item % 2 == 0:
            even.append(item)
    return even


print(myfunc(5, 6, 7, 8))


# Define a function called myfunc that takes in a string, and returns a matching string where every even letter is uppercase, and every odd letter is lowercase. Assume that the incoming string only contains letters, and don't worry about numbers, spaces or punctuation. The output string can start with either an uppercase or lowercase letter, so long as letters alternate throughout the string.
def myfunc(word):
    result = ''
    index = 0
    for letter in word:
        if index % 2 == 0:
            result += letter.upper()
        else:
            result += letter.lower()
        index += 1
    return result


print(myfunc('Digitalforensics'))

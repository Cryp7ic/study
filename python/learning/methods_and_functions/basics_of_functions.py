def sayhello():
    print("hello")


sayhello
sayhello()


def sayhello(name='Thomas'):
    print(f'hello {name}')


sayhello('Jose')
sayhello()

# Return keyword
# Difference between return and print is that return allows you to save the output as a variable


def addnum(num1, num2):
    return num1 + num2


result = addnum(10, 20)
print(result)


def printresult(a, b):
    print(a+b)


def returnresult(a, b):
    return a+b


# printresult can't be saved :
result = printresult(10, 20)
print(type(result))

# Now it is saved and the type is an integer:
result = returnresult(10, 20)
print(type(result))


def myfunc(a, b):
    print(a+b)
    return a+b


result = myfunc(10, 20)
result


# Data type
def sumnum(num1, num2):
    return num1+num2


print(sumnum(10, 20))
print(sumnum('10', '20'))

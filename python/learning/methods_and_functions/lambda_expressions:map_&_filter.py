# map
print("map Function: ")


def square(num):
    return num**2


my_nums = [1, 2, 3, 4, 5]

for item in map(square, my_nums):
    print(item)
print(list(map(square, my_nums)))


def splicer(mystring):
    if len(mystring) % 2 == 0:
        return 'EVEN'
    else:
        return mystring[0]


names = ['Andy', 'Eve', 'Sally']
print(list(map(splicer, names)))

print("-------------------")

print("Filter function: ")


def check_even(num):
    return num % 2 == 0


mynums = [1, 2, 3, 4, 5, 6]

list(filter(check_even, mynums))
for n in filter(check_even, mynums):
    print(n)


print("-------------------")
print("Lambda expression: ")
# A lambda expression is also known as an anonymous function, and the reason for that is because
# it's some functionality that you intend to only use one time.
# We dont use the name or the "def" keyword


lambda num: num ** 2


print(square(3))


print("Map lambda:")

print(list(map(lambda num: num**2, mynums)))


print("Filter lambda:")
print(list(filter(lambda num: num % 2 == 0, mynums)))


# Grab the first character of a string:
print(list(map(lambda name: name[::-1], names)))

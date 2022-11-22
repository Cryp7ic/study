# The term iterate means you can "iterate" over the object.
# You can iterate over every character in as string,
# iterate over every item in a list,
# iterate over every key in a dictionary.

myList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

for num in myList:
    print(num)

for num in myList:
    print('hello')

for num in myList:
    # Check for even
    if num % 2 == 0:
        print(num)
    else:
        print(f'Odd Number: {num}')

listSum = 0

# Last sum
for num in myList:
    listSum = listSum + num
    print(listSum)
# Iterating sums
for num in myList:
    listSum = listSum + num
print(listSum)

myString = 'hello world'

for letter in myString:
    print(letter)

for letter in 'hello world':
    print(letter)

for _ in 'hello world':
    print("cool!")

# Tuples
tup = (1, 2, 3)

for item in tup:
    print(item)

# If you iterate through a squence that contains itself tuples,
# the item can be used with tuple unpacking:
my_list = [(1, 2), (3, 4), (5, 6), (7, 8)]
print(len(my_list))

for item in my_list:
    print(item)

# Tuple unpacking: (you don't need parentheses behind the "for")
for (a, b) in my_list:
    print(a)
    print(b)

for a, b in my_list:
    print(a)

my_list = [(1, 2, 3), (4, 5, 6), (7, 8, 9)]

for a, b, c in my_list:
    print(b)


# Iterating througb Dictionaries
d = {'k1': 1, 'k2': 2, 'k3': 3}

# Keys:
for item in d:
    print(item)

# Values:
for item in d.items():
    print(item)

# Taking advantage of tuple unpacking:
for key, value in d.items():
    print(value)

for value in d.values():
    print(value)

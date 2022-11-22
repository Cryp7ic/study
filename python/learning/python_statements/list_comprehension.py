# List comprehesions are a unique way of quickly creating a list with Python.
# If you find yourself using a for loop along with .append() to create a list,
# List Comprehensions are a good alternative!

mystring = 'hello'
mylist = []
for letter in mystring:
    mylist.append(letter)
print(mylist)


# list comprehesion:
mylist = [letter for letter in mystring]
print(mylist)

mylist = [x for x in 'word']
print(mylist)

mylist = [num for num in range(0, 11)]
print(mylist)
mylist = [num**2 for num in range(0, 11)]
print(mylist)

# Looping:
mylist = [x for x in range(0, 11) if x % 2 == 0]
print(mylist)
mylist = [x**2 for x in range(0, 11) if x % 2 == 0]
print(mylist)

# Complex:
celcius = [0, 10, 20, 34.5]
farenheit = [((9/5)*temp + 32) for temp in celcius]
print(farenheit)
# Is the same as:
farenheit = []
for temp in celcius:
    farenheit.append((9/5)*temp + 32)

print(farenheit)


# Else statements with list comprehesions (not advised, hard to read)
results = [x if x % 2 == 0 else 'ODD' for x in range(0, 11)]
print(results)


# Nested loops
mylist = []
for x in [2, 4, 6]:
    for y in [1, 200, 300]:
        mylist.append(x*y)
print(mylist)

mylist = [x*y for x in [2, 4, 6] for y in [1, 10, 100]]
print(mylist)

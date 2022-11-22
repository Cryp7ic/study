# range(start, stop, step)
from random import randint
from random import shuffle
mylist = [1, 2, 3]
for num in range(0, 10, 2):
    print(num)
# A generator is a special type of function that will generate
# information instead of saving it to memory.
print(list(range(0, 11, 2)))


index_count = 0
for letter in 'abcde':
    print('At index {} the letter is {}'.format(index_count, letter))
    index_count += 1

# Enumerate
index_count = 0
word = 'abcde'

for letter in word:

    print(word[index_count])
    index_count += 1

# Enumerate, returning tuples
word = 'abcde'

for item in enumerate(word):
    print(item)

for index, letter in enumerate(word):
    print(index)
    print(letter)
    print('\n')


# Zip, returning tuples
mylist1 = [1, 2, 3, 4, 5, 6]
mylist2 = ['a', 'b', 'c']
mylist3 = [100, 200, 300]

print(zip(mylist1, mylist2))

for item in zip(mylist1, mylist2, mylist3):
    print(item)

print(list(zip(mylist1, mylist2)))
# Thats wwhy tuple unpacking is useful.


# In operator, good to check if something is in a list. Works in dictionaries as well.
print('x' in [1, 2, 3])
print('x' in ['x', 'y', 'z'])
print('a' in 'a world')
print('mykey' in {'mykey': 345})

d = {'mykey': 345}
print(345 in d.values())
print(345 in d.keys())


# Min, Max
mylist = [10, 20, 30, 40, 100]
print(min(mylist))
print(max(mylist))


# Random library, shuffle
mylist = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
shuffle(mylist)
print(mylist)

# randint
print(randint(0, 100))

mynum = randint(0, 10)
print(mynum)


# User input, always accepts things as a string.
result = input('What is your name?: ')
print("Your name is {}".format(result))

# It will automatically save the number as a string:
result2 = input('Favorite number: ')
print(type(result2))

# In order to cast this or transform it into another data type,
# we need to eiher float, or int:
print(type(float(result2)))
print(type(int(result2)))

result3 = int(input("Enter a random number: "))
print(type(result3))

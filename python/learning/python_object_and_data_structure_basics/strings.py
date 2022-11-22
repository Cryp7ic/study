hello = 'hello,'
dont = "\nI'm going on a \trun"
print(hello + ' ' + dont)
print(len(hello + ' ' + dont))


# Indexing and Slicing with Strings:
myString = "Hello World"
print(myString[0])
print(myString[-3])

myString = 'abcdefghijk'
print(myString[2:])
print(myString[:3])
print(myString[3:6])
print(myString[3:9])

print(myString[::2])

# String propterties and Immutability (Cannot change)
name = 'Sam'
# Does not work, because strings are immutable:
# name[0] = 'P'

# Solution:
lastLetters = name[1:]
word = 'P' + lastLetters
print(word)

letter = 'z'
print(letter * 10)


x = 'Hi this is a string'
print(x.upper())
print(x.lower())
print(x.split())
print(x.split('i'))


# String formatting for Printing:
print('This is a string {}'.format('INSERTED'))
print('The {} {} {}'.format('fox', 'brown', 'quick'))
print('The {2} {1} {0}'.format('fox', 'brown', 'quick'))
print('The {q} {b} {f}'.format(f='fox', b='brown', q='quick'))

result = 100/777
result = 104.12345
print("The result was {r:1.3f}".format(r=result))

name = "Jose"
print('Hello, his name is {}'.format(name))
print(f'Hello, his name is {name}')

name = "Sam"
age = 3
print(f'{name} is {age} years old.')

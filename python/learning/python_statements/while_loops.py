# While loops will continue to execute a block of code while some
# some condition is true.
# Syntax:
# while some_boolean_condition:
# do something
# else:
# do something different

x = 0
while x < 5:
    print(f'The current value of x is {x}')
    x += 1
else:
    print("X IS NOT LESS THAN 5!")

# break, continue, pass
# We can use break, continue, and pass statements in our loops
# to add additional functionality for various cases. The three statements are defined by:

# break: Breaks out of the current closest enclosing loop.
# continue: Goes back to the top of the closest enclosing loop.
# pass: Does nothing at all.

# pass: (helps to avoid errors, when you have a unfinished loop)
x = [1, 2, 3]
for item in x:
    # comment
    pass
    # helps avoiding errors.

print("End of my script")

# continue: (ignores the string 'a')
myString = "Sammy"
for letter in myString:
    if letter == 'a':
        continue
    print(letter)


# break (breaks the loop)
myString = "Sammy"
for letter in myString:
    if letter == 'a':
        break
    print(letter)

x = 0
while x < 5:
    if x == 2:
        break
    print(x)
    x += 1

# A control flow allows us to use logic to execute code only when we want to.
# To control this flow of logic we use some keywords:
# * if
# * elif
# * else
# Syntax:
# if some_confition:
# execute some code
# elif some_other_condition:
# do something different
# else:
# do something else

hungry = True

if hungry:
    print('FEED ME!')
else:
    print('Im not hungry')

loc = 'Bank'
if loc == 'Auto Shop':
    print("Cars are cool!")
elif loc == 'Bank':
    print("Money is cool!")
elif loc == 'Store':
    print("Welcome to the store!")
else:
    print("I do not know much.")

name = "Sammy"
if name == "Frankie":
    print("Hello Frankie!")
elif name == "Sammy":
    print("Hello Sammy!")
else:
    print("What is your name? ")

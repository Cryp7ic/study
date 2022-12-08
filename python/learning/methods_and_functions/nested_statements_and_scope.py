# The concept of 'scope' rules how variables and names are looked up in your code. It determines the visibility of a variable within code.
# The scope of a name or variable depends on the place in your code where you create that variable.
# The Python concept is generally presented using a rule known as the LEGB rule.
# LEGB rule format, Local, Enclosing, Global, and Built-in scopes.
# This summarises not only Python scope levels but also the sequence of steps that Python follows when resolving names in Pytohn.

# L: Local - Names assigned in any way within a function (def or lambda), and not declared global in that function
# E: Enclosing function locals - Names in the local scope of any and all enclosing functions (def or lambda), from inner to outer.
# G: Global (module) - Names assigned at the top-level of a module file, or declared global in a def within a file.
# B: Built-in (Python) - Names preassigned in the built-in names module: open, range, SyntaxError,...

x = 25


def printer():
    x = 50
    return x


print(x)
print(printer())


# Local (num) is local to this lambda expressions:
lambda num: num**2


# Enclosing:
#
name = 'This is a global string'


def greet():

    # ENCLOSING
    name = 'Sammy'

    def hello():
        # LOCAL
        name = 'IM A LOCAL'
        print('Hello '+name)

    hello()


print(name)
greet()


# GLOBAL REASSIGNMENT
x = 50


def func(x):
    print(f"X is {x}")

    # LOCAL REASSIGNMENT
    x = 200
    print(f'I JUST LOCALLY CHANGED X TO {x}')


func(x)
print(x)
# This is what the scope really is.
# The fact that when you declare variables inside of a function definition,
# such as what we've done, those variable names only have a scope local to this function.


x = 50


def func():

    # THIS WILL AFFECT THE GLOBAL x
    global x
    print(f"X is {x}")

    # LOCAL REASSIGNMENT ON A GLOBAL VARIABLE!
    x = 'NEW VALUE'
    print(f'I JUST LOCALLY CHANGED GLOBAL X TO {x}')


print(x)
func()
print(x)

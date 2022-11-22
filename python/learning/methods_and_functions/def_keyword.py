# Creating clean repeatable code is a key of becoming an effective programmer.
# Functions allow us to create blocks of code tha can be easily executed many times, without needing to constantly rewrite the entire block of code.
# Functions will be a huge leap forward in your capabilities in Python.
# Creating a function requires a very specific syntac, including the def keyword, correct indentation, and proper structure.
# 'def' telling Python this is a function.
# Snake casing is all lowercase with underscores between words
# Parenthesis at the end, we can pass in arguments/parameters into the function.
def name_of_function(name):
    '''

    '''
    print("Hello "+name)
# Docstring explains function. Multi-line string to describe function. It's a function comment.


name_of_function("Jose")
# Function can then be executed/called to see the result.

# We can use the return keyword to send back the result of the function, instead of printing it out.
# return allows us to assign the output of the function to a new variable.


def add_function(num1, num2):
    return num1 + num2


result = add_function(1, 2)
print(result)

# Typically a python script or notebook contains several functions interacting with each other
# Let's create a few functions to mimic the carnival guessing game "Three Cup Montee"
# Our simple version will not show the shuffle to the user,
# so the guess is completely random
from random import shuffle
example = [1, 2, 3, 4, 5, 6, 7]
shuffle(example)
print(example)

# We need to create our own function for this


def shuffle_list(mylist):
    shuffle(mylist)
    return mylist


result = shuffle_list(example)

mylist = [' ', 'O', ' ']
shuffle_list(mylist)


def player_guess():
    guess = ''
    while guess not in ['0', '1', '2']:
        guess = input("Pick a number: 0, 1, or 2: ")
    return int(guess)


def check_guess(mylist, guess):
    if mylist[guess] == 'O':
        print("Correct!")
    else:
        print("Wrong guess!")
        print(mylist)


# INITIAL LIST
mylist = [' ', 'O', ' ']
# SHUFFEL LIST
mixedup_list = shuffle_list(mylist)
# USER GUESS
guess = player_guess()
# CHECK GUESS
check_guess(mixedup_list, guess)

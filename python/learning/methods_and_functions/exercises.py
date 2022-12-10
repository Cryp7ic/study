# LESSER OF TWO EVENS: Write a function that returns the lesser of two given numbers if both numbers are even, but returns the greater if one or both numbers are odd
# lesser_of_two_evens(2,4) --> 2
# lesser_of_two_evens(2,5) --> 5

def lesser_of_two_evens(a, b):
    if a % 2 == 0 and b % 2 == 0:
        # BOTH NUMBERS ARE EVEN
        return min(a, b)
    else:  # ONE OR BOTH NUMBERS ARE ODD
        return max(a, b)


print(lesser_of_two_evens(2, 4))
print(lesser_of_two_evens(7, 5))


print("---------------")
# ANIMAL CRACKERS: Write a function takes a two-word string and returns True if both words begin with same letter
# animal_crackers('Levelheaded Llama') --> True
# animal_crackers('Crazy Kangaroo') --> False


def animal_crackers(text):
    wordlist = text.lower().split()
    print(wordlist)

    #first = wordlist[0]
    #second = wordlist[1]
    return wordlist[0][0] == wordlist[1][0]


print(animal_crackers('Levelheaded llama'))
print(animal_crackers('Crazy kangaroo'))


print("----------------")
# MAKES TWENTY: Given two integers, return True if the sum of the integers is 20 or if one of the integers is 20. If not, return False
# makes_twenty(20,10) --> True
# makes_twenty(12,8) --> True
# makes_twenty(2,3) --> False


def makes_twenty(n1, n2):
    # Exercise in one line:
    return (n1+n2) == 20 or n1 == 20 or n2 == 20
    # Longer variation:
    if n1 + n2 == 20:
        return True
    elif n1 == 20 or n2 == 20:
        return True
    else:
        return False


print(makes_twenty(20, 10))
print(makes_twenty(2, 3))


print("-----------------")
# OLD MACDONALD: Write a function that capitalizes the first and fourth letters of a name
# old_macdonald('macdonald') --> MacDonald
# Note: 'macdonald'.capitalize() returns 'Macdonald'


def old_macdonald(name):

    first_half = name[:3]
    second_half = name[3:]
    return first_half.capitalize() + second_half.capitalize()


print(old_macdonald('macdonald'))


print("-----------------")

# The .join method:
mylist = ['a', 'b', 'c']
print('--'.join(mylist))

# MASTER YODA: Given a sentence, return a sentence with the words reversed
# master_yoda('I am home') --> 'home am I'
# master_yoda('We are ready') --> 'ready are We'
# Note: The .join() method may be useful here. The .join() method allows you to join together strings in a list with some connector string. For example, some uses of the .join() method:
# >>> "--".join(['a','b','c'])
# >>> 'a--b--c'
# This means if you had a list of words you wanted to turn back into a sentence, you could just join them with a single space string:
# >>> " ".join(['Hello','world'])
# >>> "Hello world"


def master_yoda(text):
    wordlist = text.split()
    reverse_worldlist = wordlist[::-1]
    return ' '.join(reverse_worldlist)


print(master_yoda('I am home'))
print(master_yoda('We are ready'))


print("-----------------")


# ALMOST THERE: Given an integer n, return True if n is within 10 of either 100 or 200¶

# almost_there(90) --> True
# almost_there(104) --> True
# almost_there(150) --> False
# almost_there(209) --> True

# NOTE: abs(num) returns the absolute value of a number
def almost_there(n):

    return (abs(100-n) <= 10) or (abs(200-n) <= 10)


print(almost_there(104))
print(almost_there(150))
print(almost_there(209))


print("-----------------")


# FIND 33:

# Given a list of ints, return True if the array contains a 3 next to a 3 somewhere.

# has_33([1, 3, 3]) → True
# has_33([1, 3, 1, 3]) → False
# has_33([3, 1, 3]) → False

def has_33(nums):
    for i in range(0, len(nums)-1):

        # if nums[i:i+2] == [3,3]
        # or

        if nums[i] == 3 and nums[i+1] == 3:
            return True
    return False


print(has_33([1, 3, 3]))
print(has_33([1, 3, 1, 3]))
print(has_33([3, 1, 3]))


print("-----------------")


# PAPER DOLL: Given a string, return a string where for every character in the original there are three characters

# paper_doll('Hello') --> 'HHHeeellllllooo'
# paper_doll('Mississippi') --> 'MMMiiissssssiiippppppiii'
def paper_doll(text):
    result = ''
    for c in text:
        result += c*3
    return result


print(paper_doll('Hello'))
print(paper_doll('Mississippi'))


print("-----------------")


# BLACKJACK: Given three integers between 1 and 11, if their sum is less than or equal to 21, return their sum. If their sum exceeds 21 and there's an eleven, reduce the total sum by 10. Finally, if the sum (even after adjustment) exceeds 21, return 'BUST'¶
# blackjack(5,6,7) --> 18
# blackjack(9,9,9) --> 'BUST'
# blackjack(9,9,11) --> 19
def blackjack(a, b, c):
    if sum([a, b, c]) <= 21:
        return sum([a, b, c])
    elif 11 in [a, b, c] and sum([a, b, c])-10 <= 21:
        return sum([a, b, c])-10
    else:
        return 'BUST'


print(blackjack(5, 6, 7))
print(blackjack(9, 9, 9))
print(blackjack(9, 9, 11))


print("-----------------")


# SUMMER OF '69: Return the sum of the numbers in the array, except ignore sections of numbers starting with a 6 and extending to the next 9 (every 6 will be followed by at least one 9). Return 0 for no numbers.

# summer_69([1, 3, 5]) --> 9
# summer_69([4, 5, 6, 7, 8, 9]) --> 9
# summer_69([2, 1, 6, 9, 11]) --> 14
def summer_69(arr):
    total = 0
    add = True
    for num in arr:
        while add:
            if num != 6:
                total += num
                break
            else:
                add = False
        while not add:
            if num != 9:
                break
            else:
                add = True
                break
    return total


print(summer_69([1, 3, 5]))
print(summer_69([4, 5, 6, 7, 8, 9]))
print(summer_69([2, 1, 6, 9, 11]))


print("------------------")


# SPY GAME: Write a function that takes in a list of integers and returns True if it contains 007 in order
# spy_game([1,2,4,0,0,7,5]) --> True
# spy_game([1,0,2,4,0,5,7]) --> True
# spy_game([1,7,2,0,4,5,0]) --> False
def spy_game(nums):

    code = [0, 0, 7, 'x']
    # [0,7,'x']
    # [7,'x']
    # ['x'] length=1
    for num in nums:
        if num == code[0]:
            code.pop(0)

    return len(code) == 1


print(spy_game([1, 2, 4, 0, 0, 7, 5]))
print(spy_game([1, 0, 2, 4, 0, 5, 7]))
print(spy_game([1, 7, 2, 0, 4, 5, 0]))


print("------------------")


# COUNT PRIMES: Write a function that returns the number of prime numbers that exist up to and including a given number
# count_primes(100) --> 25
# By convention, 0 and 1 are not prime.
def count_primes(num):

    # Check for 0 or 1 input
    if num < 2:
        return 0
    # 2 or greater

    # Store our prime numbers
    primes = [2]
    # Counter going up to the input num
    x = 3

    # x is going through every number up to input num
    while x <= num:
        # Check if x is prime
        for y in range(3, x, 2):
            if x % y == 0:
                x += 2
                break
        else:
            primes.append(x)
            x += 2
    print(primes)
    return len(primes)


count_primes(100)


print("------------------")


# Just for fun:
# PRINT BIG: Write a function that takes in a single letter, and returns a 5x5 representation of that letter
# print_big('a')
# out:   *
#      * *
#     *****
#     *   *
#     *   *
# HINT: Consider making a dictionary of possible patterns, and mapping the alphabet to specific 5-line combinations of patterns.
# For purposes of this exercise, it's ok if your dictionary stops at "E".
def print_big(letter):

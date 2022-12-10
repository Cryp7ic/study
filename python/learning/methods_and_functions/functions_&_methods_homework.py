# Write a function that computes the volume of a sphere given its radius.
import string
import math
pi = math.pi


def vol(rad):
    vol = 4/3 * pi * rad**3
    return vol


print(vol(2))


# Write a function that checks whether a number is in a given range (inclusive of high and low)
def ran_check(num, low, high):
    if num > low and num < high:
        print(f'{num} is in the range between {low} and {high}')
    else:
        print(f'{num} is not in the range between {low} and {high}')


ran_check(5, 2, 7)
# 5 is in the range between 2 and 7


# If you only wanted to return a boolean:
def ran_bool(num, low, high):
    if num > low and num < high:
        return True
    else:
        return False


print(ran_bool(3, 1, 10))


print("-------------------------")


# Write a Python function that accepts a string and calculates the number of upper case letters and lower case letters.

# Sample String : 'Hello Mr. Rogers, how are you this fine Tuesday?'
# Expected Output :
# No. of Upper case characters : 4
# No. of Lower case Characters : 33

# HINT: Two string methods that might prove useful: .isupper() and .islower()

# If you feel ambitious, explore the Collections module to solve this problem!
def up_low(s):
    cnt_upper = 0
    cnt_lower = 0

    for word in s:
        if word.isupper():
            cnt_upper += 1
        elif word.islower():
            cnt_lower += 1
        else:
            pass

    print(f"Original String: {s}")
    print(f"No. of Upper case characters : {cnt_upper}")
    print(f"No. of Lower case Characters : {cnt_lower}")


s = 'Hello Mr. Rogers, how are you this fine Tuesday?'
up_low(s)


print("----------------------")


# Write a Python function that takes a list and returns a new list with unique elements of the first list.

# Sample List : [1,1,1,1,2,2,3,3,3,3,4,5]
# Unique List : [1, 2, 3, 4, 5]
def unique_list(lst):
    lst2 = set(lst)
    print(lst2)


unique_list([1, 1, 1, 1, 2, 2, 3, 3, 3, 3, 4, 5])


print("------------------------")


# Write a Python function to multiply all the numbers in a list.

# Sample List : [1, 2, 3, -4]
# Expected Output : -24
def multiply(numbers):
    result = 1
    for num in numbers:
        result = result * num
    print(result)


multiply([1, 2, 3, -4])


print("-------------------------")


# Write a Python function that checks whether a word or phrase is palindrome or not.
# Note: A palindrome is word, phrase, or sequence that reads the same backward as forward, e.g., madam, kayak, racecar, or a phrase "nurses run". Hint: You may want to check out the .replace() method in a string to help out with dealing with spaces. Also google search how to reverse a string in Python, there are some clever ways to do it with slicing notation.
def palindrome(s):
    # REMOVE SPACES STRING
    s = s.replace(' ', '')
    # Check if string is == reversed version of the string
    return s == s[::-1]


print(palindrome("helleh"))
print(palindrome("nurses run"))


print("---------------------------")


# Hard:

# Write a Python function to check whether a string is pangram or not. (Assume the string passed in does not have any punctuation)

# Note : Pangrams are words or sentences containing every letter of the alphabet at least once.
# For example : "The quick brown fox jumps over the lazy dog"

# Hint: You may want to use .replace() method to get rid of spaces.

# Hint: Look at the string module

# Hint: In case you want to use set comparisons
def ispangram(str1, alphabet=string.ascii_lowercase):
    # Create a set of the alphabet
    alphaset = set(alphabet)
    # Remove any spaces from the input string
    str1 = str1.replace(' ', '')
    # Convert into lowercase
    str1 = str1.lower()
    # Grab all unique letters from the string
    str1 = set(str1)
    # Alphabet set == string set input
    return str1 == alphaset


print(ispangram("The quick brown fox jumps over the lazy dog"))
string.ascii_lowercase

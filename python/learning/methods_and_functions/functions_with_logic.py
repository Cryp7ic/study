# The mod operator returns back the remainder after division.
print(2 % 2)
print(3 % 2)
print(41 % 40)

# If a number is even, such as 20, then I know that 2 goes into 20 10 times.
print(20 % 2)
# Any number i put in here, if I provide the mod operator and it ends upd being equal to zero,
# then I know it's even.
# It is even:
print(20 % 2 == 0)
# It is even:
print(21 % 2 == 0)

print("------------")
# Lets construct this into a function:


def even_check(number):
    result = number % 2 == 0
    return result


print(even_check(20))
print(even_check(21))


# I don't actually need to save this as a result parameter:
def even_check(number):
    return number % 2 == 0


print(even_check(20))
print(even_check(21))

print("------------")
# Return true if any number is even inside a list:


def check_even_list(num_list):
    for number in num_list:
        if number % 2 == 0:
            return True
        else:
            pass  # < return False: WRONG!!!! Because if the first number is uneven, it will return False
    return False  # < This is the right way to do it. Because it will complete the entire for loop


print(check_even_list([1, 3, 5]))
print(check_even_list([1, 4, 5]))

print("------------")


# Return all the even numbers in a list:
def check_even_list(num_list):

    # placeholder variables
    even_numbers = []

    for number in num_list:
        if number % 2 == 0:
            even_numbers.append(number)
        else:
            pass  # < return False: WRONG!!!! Because if the first number is uneven, it will return False
    return even_numbers


print(check_even_list([1, 2, 3, 4, 5]))
print(check_even_list([2, 3]))
print(check_even_list([1, 3, 5]))

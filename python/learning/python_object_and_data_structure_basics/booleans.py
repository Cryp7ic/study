# Booleans are operators that allow you to convey True or False statements.
print(bool(1 > 2))
print(1 > 2)

# two nested lists
l_one = [1, 2, [3, 4]]
l_two = [1, 2, {'k1': 4}]
# True or False?
l_one[2][0] >= l_two[2]['k1']
# False

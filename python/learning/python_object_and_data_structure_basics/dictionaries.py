# Dictionaries are unordered mappings for storing objects

myDict = {'key1': 'value1', 'key2': 'value2'}
print(myDict)
print(myDict['key1'])
prices_lookup = {'apple': 2.99, 'oranges': 1.99, 'milk': 5.80}
print(prices_lookup['apple'])
d = {'k1': 123, 'k2': [0, 1, 2], 'k3': {'insideKey': 100}}
print(d['k3']['insideKey'])
d = {'key1': ['a', 'b', 'c']}
my_list = d['key1']
print(my_list)
letter = my_list[2]
print(letter)
print(letter.upper())

d = {'k1': 100, 'k2': 200}
d['k3'] = 300
print(d['k3'])

d['k1'] = 'new value'
print(d['k1'])

d = {'k1': 100, 'k2': 200, 'k3': 300}
print(d.keys())

print(d.values())
print(d.items())

# Exercise 1
d = {'k1': [{'nest_key': ['this is deep', ['hello']]}]}
# Grab hello
print(d['k1'][0]['nest_key'][1][0])
# d is a dict
# d['k1'] is a list with one item
# d['k1'][0] is a dict
# d['k1'][0]['nest_key'] is a list with two items
# d['k1'][0]['nest_key'][1] is a list with one item
# d['k1'][0]['nest_key'][1][0] is the string 'hello'

# Exercise 2
d = {'k1':[1,2,{'k2':['this is tricky',{'tough':[1,2,['hello']]}]}]}
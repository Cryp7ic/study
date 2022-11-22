myfile = open(
    '/home/hachi/Desktop/code/python/learning/python_object_and_data_structure_basics/test.txt')
print(myfile.read())

myfile.seek(0)
print(myfile.read())

myfile.seek(0)
myfile.readlines()

myfile.close()

with open('/home/hachi/Desktop/code/python/learning/python_object_and_data_structure_basics/test.txt') as my_new_file:
    contents = print(my_new_file.read())

with open('/home/hachi/Desktop/code/python/learning/python_object_and_data_structure_basics/test.txt', mode='r+') as test:
    contents = print(test.read())

# %%writefile does not work outside jupyter
# % % writefile my_new_file.txt
# ONE ON FIRST
# TWO ON SECOND
# THREE ON THIRD

with open('/home/hachi/Desktop/code/python/learning/python_object_and_data_structure_basics/test.txt', mode='a') as f:
    f.write('\nFOUR ON FOURTH')
with open('/home/hachi/Desktop/code/python/learning/python_object_and_data_structure_basics/test.txt', mode='r') as f:
    print(f.read())

with open('/home/hachi/Desktop/code/python/learning/python_object_and_data_structure_basics/aofjoaf.txt', mode='w') as f:
    f.write('I CREATED THIS FILE!')

with open('/home/hachi/Desktop/code/python/learning/python_object_and_data_structure_basics/aofjoaf.txt', mode='r') as f:
    print(f.read())

# Write a script that opens a file named 'test.txt' , writes 'Hello World'  to the file, then closes it.
# 1st solution:
x = open('myfile.txt', 'w')
x.write('This is my file')
x.close()

# 2nd solution
with open('test.txt', mode='w') as f:
    f.write('Hello World')

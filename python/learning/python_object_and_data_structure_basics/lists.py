myList = [1, 2, 3]
yourList = ['STRING', 100, 23.2]
print(len(myList))
my_list = ['one', 'two', 'three']
print(my_list[0:1])
anotherList = ['four', 'five']
print(my_list + anotherList)
newList = my_list + anotherList
newList[0] = 'ONE ALL CAPS'
print(newList)
newList.append('six')
print(newList)
poppedItem = newList.pop()
print(poppedItem)
newList.pop(0)
print(newList)

# Sort will sort the characters in alphabetical order!:
newList = ['a', 'e', 'x', 'b', 'c']
numList = [4, 1, 8, 3]
newList.sort()
print(newList.sort())
mySortedList = newList
print(mySortedList)
# None is the return value of a function that returns nothing.

# Reverse
numList.reverse()
print(numList)

# Reassigning 'Hello' in this nested list to say 'Goodbye'
list3 = [1, 2, [3, 4, 'hello']]
# Solution:
list3[2][2] = 'goodbye'
print(list3)
# list3[2] is the third item in the list, which is itself a list of 3 items.
# list3[2][2] is the third item in the list of the third item in the list.

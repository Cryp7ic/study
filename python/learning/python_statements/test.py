st = 'Print only the words that start with s in this sentence'

for word in st.split():
    if word[0] == 's':
        print(word)

for num in range(2, 12, 2):
    print(num)

mylist = [x for x in range(1, 50) if x % 3 == 0]
print(mylist)


st = 'Print every word in this sentence that has an even number of letters'
for word in st.split():
    if len(word) % 2 == 0:
        print(word + ' is even!')

# FizzBuzz
for i in range(1, 100):
    if i % 3 == 0 and i % 5 == 0:
        print("FizzBuzz")
        continue
    elif i % 3 == 0:
        print("Fizz")
        continue
    elif i % 5 == 0:
        print("Buzz")
        continue
    else:
        print(i)

st = 'Create a list of the first letters of every word in this string'

mylist = [word[0] for word in st.split()]
print(mylist)

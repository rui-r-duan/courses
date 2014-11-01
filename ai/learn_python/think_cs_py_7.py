fruit = "banana"

def print_backward(s):
    index = len(s) - 1
    while index >= 0:
        letter = s[index]
        print letter
        index = index - 1

for char in fruit:
    print char

prefixes = "JKLMNOPQ"
suffix = "ack"
for letter in prefixes:
    if letter == 'O' or letter == 'Q':
        print letter + 'u' + suffix
    else:
        print letter + suffix

def find(str, ch, si):
    while si < len(str):
        if str[si] == ch:
            return si
        si = si + 1
    return -1

def countLetters(str, letter):
    count = 0
    for char in str:
        if char == letter:
            count = count + 1
    print count

def countLetters2(str, letter):
    count = 0
    si = find(str, letter, 0)
    while si != -1:
        count = count + 1
        si = find(str, letter, si+1)
    return count

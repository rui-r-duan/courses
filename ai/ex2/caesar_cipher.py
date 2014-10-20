#-------------------------------------------------------------------------------
# author: Rui Duan (0561866)
#-------------------------------------------------------------------------------
def caesar_encrypt(msg, key):
    result = ''
    for c in msg:
        if c.isalpha():
            if c.islower():
                result += chr((ord(c) + key - ord('a')) % 26 + ord('a'))
            else:
                result += chr((ord(c) + key - ord('A')) % 26 + ord('A'))
        else:
            result += c
    return result

def caesar_decrypt(msg, key):
    result = ''
    for c in msg:
        if c.isalpha():
            if c.islower():
                result += chr((ord(c) - key - ord('a')) % 26 + ord('a'))
            else:
                result += chr((ord(c) - key - ord('A')) % 26 + ord('A'))
        else:
            result += c
    return result

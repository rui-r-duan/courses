#-------------------------------------------------------------------------------
# author: Rui Duan (0561866)
#-------------------------------------------------------------------------------

# Pascal Triangle
# Returns the Pascal Triangle up to n-th row
def triangle(n):
    c = []
    if n == 0:
        return c
    if n == 1:
        row = [1]
        c.append(row)
        return c
    else:
        c = [[1]]
        # construct the second line and the following lines up to n-th line
        i = 2                   # line 2
        while i <= n:
            # construct the i-th line element by element
            line = [1]
            previous_line = c[i-2] # the i-th line's previous line stored in c
            for j in range(len(previous_line) - 1):
                line.append(previous_line[j] + previous_line[j+1])
            line += [1]
            c.append(line)
            i += 1
        return c

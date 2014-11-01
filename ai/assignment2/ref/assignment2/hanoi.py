import pygame
import ctypes

pygame.init()

RED = (255, 0, 0)
WHITE = (255, 255, 255)
BACKGROUND = (0,0,0)

disc_one = [0,255,0]
disc_two = [0,0,255]
disc_three = [255,255,0]
disc_four = [255,0,255]
disc_five = [0,255,255]
array_disc = [disc_one, disc_two, disc_three, disc_four, disc_five]

Color_Bar = ((102, 0, 204), (102, 0, 204), (102, 0, 204), (102, 0, 204))


Window_Size = (600, 400)

Bars = ((100, 285, 400, 20), (170, 100, 20, 190),
             (290, 100, 20, 190), (410, 100, 20, 190))


text = [0, 0, 0, 0, 0, 0, 0, 0]
Topic = ("* TOWER OF HANOI *", "1", "2", "3", "FROM TOWER #",
         "TO TOWER #", "MOVE #", "PRESS F1 TO EXIT")
Coor = ((220, 60), (176, 80), (295, 80),
           (416, 80), (110, 300), (320, 300), (260, 330), (220, 350))


screen = pygame.display.set_mode(Window_Size)

pygame.display.set_caption("Tower OF HANOI")

font = pygame.font.Font("C:/Windows/Fonts/comic.ttf", 16)


l_array_disc = [[0 for x in range(5)] for y in range(3)]
k = -1
count = len(open("init.txt", 'rU').readlines())
for line in open("init.txt"):
    k += 1
    if(k == (count - 1)):
        for i in range(len(line)):
            l_array_disc[k][i] = int(line[i]) + 1
    else:
        for i in range(len(line) - 1):
            l_array_disc[k][i] = int(line[i]) + 1


s_array_disc = ((160, 265), (150, 265), (140, 265), (130, 265), (120, 265))
preposition = 0
presecposition = 0
select = 0
selected = False

move_disk = 0

From_Tower = 0
To_Tower = 0

Counter = 0

MOVES = [From_Tower, To_Tower, Counter]
L_MOVE = ((260, 300), (440, 300), (340, 330))
text1 = [0, 0, 0]

finish = False

clock = pygame.time.Clock()             

while not finish:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:  
            finish = True
        elif event.type == pygame.KEYDOWN:
            if(event.key == 282):
                exit()
            elif(event.key == 13):
                if(not selected):
                    
                   
                    j = 0               # j=0 repersent nothing here
                    for i in range(len(l_array_disc[select])):
                        if l_array_disc[select][i] == 0:
                            j += 1

                    if(j != 5):         # at least one on the bar
                        MOVES[0] = select + 1

                        array_disc[l_array_disc[select][4 - j] - 1] = RED
                        move_disk = l_array_disc[select][4 - j]

                        preposition = select
                        presecposition = 4 - j
                        selected = True

                else:

                    if(preposition == select):
                        array_disc[0] = [0,255,0]
                        array_disc[1] = [0,0,255]
                        array_disc[2] = [255,255,0]
                        array_disc[3] = [255,0,255]
                        array_disc[4] = [0,255,255]
                        selected = False
                        move_disk = 0

                    j = 0
                    for i in range(len(l_array_disc[select])):
                        if(l_array_disc[select][i] == 0):
                            j += 1

                    if((j != 0) & (j != 5)):        # 4 on the bar

                        if(l_array_disc[preposition][presecposition] < l_array_disc[select][4 - j]):
                            MOVES[1] = select + 1

                            l_array_disc[select][4 - j + 1] = move_disk
                            l_array_disc[preposition][presecposition] = 0
                            selected = False
                            move_disk = 0
                            MOVES[2] += 1

                            array_disc[0] = [0,255,0]
                            array_disc[1] = [0,0,255]
                            array_disc[2] = [255,255,0]
                            array_disc[3] = [255,0,255]
                            array_disc[4] = [0,255,255]

                    elif(j == 5):
                        MOVES[1] = select + 1

                        l_array_disc[select][0] = move_disk
                        l_array_disc[preposition][presecposition] = 0

                        array_disc[0] = [0,255,0]
                        array_disc[1] = [0,0,255]
                        array_disc[2] = [255,255,0]
                        array_disc[3] = [255,0,255]
                        array_disc[4] = [0,255,255]

                        selected = False
                        move_disk = 0
                        MOVES[2] += 1

            elif(event.key == 276):
                select -= 1

            elif(event.key == 275):
                select += 1
        elif event.type == pygame.MOUSEBUTTONDOWN:

            pos = pygame.mouse.get_pos()
            if ((pos[1] > 100) & (pos[1] < 280)):
                if((pos[0] > 170) & (pos[0] < 190)):
                    select = 0
                elif((pos[0] > 290) & (pos[0] < 310)):
                    select = 1
                elif((pos[0] > 410) & (pos[0] < 430)):
                    select = 2

            pressed_mouse = pygame.mouse.get_pressed()

            if pressed_mouse[0]:

                if(not selected):
                       
                    j = 0
                    for i in range(len(l_array_disc[select])):
                        if l_array_disc[select][i] == 0:
                            j += 1


                    if(j != 5):
                        MOVES[0] = select + 1

                        array_disc[l_array_disc[select][4 - j] - 1] = RED
                        move_disk = l_array_disc[select][4 - j]

                        preposition = select
                        presecposition = 4 - j
                        selected = True

                else:
                    if(preposition == select):
                        array_disc[0] = [0,255,0]
                        array_disc[1] = [0,0,255]
                        array_disc[2] = [255,255,0]
                        array_disc[3] = [255,0,255]
                        array_disc[4] = [0,255,255]
                        selected = False
                        move_disk = 0

                    j = 0
                    for i in range(len(l_array_disc[select])):
                        if(l_array_disc[select][i] == 0):
                            j += 1

                    if((j != 0) & (j != 5)):

                        if(l_array_disc[preposition][presecposition] < l_array_disc[select][4 - j]):
                            MOVES[1] = select + 1

                            l_array_disc[select][4 - j + 1] = move_disk
                            l_array_disc[preposition][presecposition] = 0
                            selected = False
                            move_disk = 0
                            MOVES[2] += 1

                            array_disc[0] = [0,255,0]
                            array_disc[1] = [0,0,255]
                            array_disc[2] = [255,255,0]
                            array_disc[3] = [255,0,255]
                            array_disc[4] = [0,255,255]

                    elif(j == 5):
                        MOVES[1] = select + 1

                        l_array_disc[select][0] = move_disk
                        l_array_disc[preposition][presecposition] = 0

                        array_disc[0] = [0,255,0]
                        array_disc[1] = [0,0,255]
                        array_disc[2] = [255,255,0]
                        array_disc[3] = [255,0,255]
                        array_disc[4] = [0,255,255]

                        selected = False
                        move_disk = 0
                        MOVES[2] += 1

    if select < 0:
        select = 2
    elif select > 2:
        select = 0

    for i in range(len(l_array_disc)):
        if((l_array_disc[i][4] == 1)):
            MessageBox = ctypes.windll.user32.MessageBoxA
            MessageBox(None, 'Congratulation', 'you win!', 0)
            exit()
   
    screen.fill(BACKGROUND)
    pygame.draw.rect(screen, WHITE, (50, 50, 500, 300))

    for i in range(len(Bars)):
        pygame.draw.rect(screen, Color_Bar[i], Bars[i])

    pygame.draw.rect(screen, RED, (168 + select * 120, 98, 22, 181), 2)

    for i in range(len(l_array_disc)):
        for j in range(len(l_array_disc[0])):
            if(l_array_disc[i][j] != 0):
                pygame.draw.rect(screen, array_disc[l_array_disc[i][j] - 1], (s_array_disc[l_array_disc[i][j] - 1][
                                 0] + i * 120, s_array_disc[l_array_disc[i][j] - 1][1] - 20 * j, 40 + (l_array_disc[i][j] - 1) * 20, 20))

    for i in range(len(Topic)):
        text[i] = font.render(Topic[i], True, (0, 0, 0))
        screen.blit(text[i], Coor[i])

    for i in range(len(MOVES)):
        text1[i] = font.render(str(MOVES[i]), True, (0, 0, 0))
        screen.blit(text1[i], L_MOVE[i])

    pygame.display.flip()

    clock.tick(60)

pygame.quit()

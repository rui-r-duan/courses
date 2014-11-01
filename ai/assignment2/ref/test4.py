import pygame
import sys
from collections import namedtuple

pygame.init()
screen = pygame.display.set_mode((500, 400))

# create a named tuple to keep track of the size/location of the rods and their blocks
Rod = namedtuple('Rod', ['rect', 'items'])

# first rod has 4 items. The just use a number to keep track of the size of the blocks 
rods = (Rod(pygame.rect.Rect((100, 150, 25, 250)), [6, 5, 4, 3, 2, 1]),
        Rod(pygame.rect.Rect((225, 150, 25, 250)), []),
        Rod(pygame.rect.Rect((350, 150, 25, 250)), []))

# keep track of the currently selected rod
selected = None

while True:
    if pygame.event.get(pygame.QUIT): break

    screen.fill(pygame.color.Color('white'))

    # draw the rods. It's easy since every rod has a rect which we can use with pygame.draw.rect
    for rod in rods:
        # if a rod is selected, we draw it yellow instead of black
        pygame.draw.rect(screen, pygame.color.Color('yellow' if selected == rod else 'black'), rod.rect)    
        # draw each block of each rod
        for i, item in enumerate(rod.items):
            r = pygame.rect.Rect(rod.rect.x - item * 8, 375 - 25 * i, 25 + item * 16, 25) 
            pygame.draw.rect(screen, pygame.color.Color('green' if selected == rod else 'darkgreen'), r)    

    for e in pygame.event.get():
        if e.type == pygame.MOUSEBUTTONDOWN:
            # check if we clicked a rod. It's easy since every rod has a rect
            rod = next((r for r in rods if r.rect.collidepoint(pygame.mouse.get_pos())), None)
            if rod:
                if selected:
                    # if there's already a rod selected, move block from one the selected
                    # rod to the clicked rod
                    rod.items.append(selected.items.pop())
                    selected = None
                elif rod.items:
                    # if no rod is selected, selected the currently clicked one (if it has blocks)
                    selected = rod
            else:
                selected = None

    pygame.display.flip()
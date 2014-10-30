import os
import pygame
from pygame.locals import *
from pygame.compat import geterror

if not pygame.font: print ('Warning, fonts disabled')
if not pygame.mixer: print ('Warning, sound disabled')

main_dir = os.path.split(os.path.abspath(__file__))[0]
res_dir = os.path.join(main_dir, 'res')

color1 = (100, 50, 200)
color2 = (250, 250, 250)
font_color_white = (230, 230, 230)
font_color_grey = (68, 68, 68)
font_color_blue = (80, 80, 200)
font_color_red = (190, 90, 100)

class Disk(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self)
        self.size_level = 4
        
def main():
    pygame.init()
    screen = pygame.display.set_mode((600, 400))
    pygame.display.set_caption('Tower of Hanoi')
    pygame.mouse.set_visible(True)

    background = pygame.Surface(screen.get_size())
    background = background.convert()
    background.fill(color1)

    if pygame.font:
        font = pygame.font.Font(None, 36)
        text = font.render("*  TOWERS OF HANOI  *", 1, (240, 240, 240))
        textpos = text.get_rect(center = (background.get_width()/2,
                                          background.get_height()/2))
        background.blit(text, textpos)

    screen.blit(background, (0, 0))
    pygame.display.flip()

    clock = pygame.time.Clock()

    going = True
    while going:
        clock.tick(60)

        # Handle Input Events
        for event in pygame.event.get():
            if event.type == QUIT:
                going = False
            elif event.type == KEYDOWN and event.key == K_ESCAPE:
                going = False
            elif event.type == MOUSEBUTTONDOWN:
                background.fill(color2)
                background.blit(text, textpos)
            elif event.type == MOUSEBUTTONUP:
                background.fill(color1)
                background.blit(text, textpos)

        screen.blit(background, (0, 0))
        pygame.display.flip()

    pygame.quit()

if __name__ == '__main__':
    main()

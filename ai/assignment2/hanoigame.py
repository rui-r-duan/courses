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
    def __init__(self, sizelevel):
        pygame.sprite.Sprite.__init__(self)
        self.size_level = sizelevel
        self.image = pygame.Surface([100, 50])
        self.image.fill(font_color_red)
        self.rect = self.image.get_rect()
        self.picked = False

    def update(self):
        "move the disk based on the mouse position"
        if self.picked:
            pos = pygame.mouse.get_pos()
            self.rect.center = pos

def main():
    pygame.init()
    screen = pygame.display.set_mode((640, 480))
    pygame.display.set_caption('Tower of Hanoi')
    pygame.mouse.set_visible(True)

    bg_color = color1

    def redraw():
        background.fill(bg_color)
        if pygame.font:
            background.blit(text, textpos)

    def onMouseButtonDown(event):
        redraw()

    def onMouseButtonUp(event):
        redraw()

    background = pygame.Surface(screen.get_size())
    background = background.convert()

    if pygame.font:
        font = pygame.font.Font(None, 36)
        text = font.render("*  TOWERS OF HANOI  *", 1, (240, 240, 240))
        textpos = text.get_rect(center = (background.get_width()/2,
                                          100))

    redraw()
    screen.blit(background, (0, 0))
    pygame.display.flip()

    clock = pygame.time.Clock()

    # prepare game objects
    disk = Disk(4)
    allsprites = pygame.sprite.RenderPlain((disk,))

    while 1:
        clock.tick(60)

        # Handle Input Events
        for event in pygame.event.get():
            if event.type == QUIT:
                return
            elif event.type == KEYDOWN and event.key == K_ESCAPE:
                return
            elif event.type == MOUSEBUTTONDOWN:
                bg_color = color2
                disk.picked = True
                redraw()
            elif event.type == MOUSEBUTTONUP:
                bg_color = color1
                disk.picked = False
                redraw()

        allsprites.update()

        # display everything
        screen.blit(background, (0, 0))
        allsprites.draw(screen)
        pygame.display.flip()

if __name__ == '__main__':
    main()
 

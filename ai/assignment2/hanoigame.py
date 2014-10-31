import os
import pygame
import random
from pygame.locals import *
from pygame.compat import geterror

if not pygame.font: print ('Warning, fonts disabled')
if not pygame.mixer: print ('Warning, sound disabled')

main_dir = os.path.split(os.path.abspath(__file__))[0]
res_dir = os.path.join(main_dir, 'res')

color1 = (100, 50, 200)
color2 = (250, 250, 250)
color_white = (255, 255, 255)
font_color_white = (230, 230, 230)
font_color_grey = (68, 68, 68)
font_color_blue = (80, 80, 180)
font_color_red = (190, 90, 100)

def rand_color():
	return [random.randrange(0,230) for i in range(0,3)]

class Disk(pygame.sprite.Sprite):
    def __init__(self, sizelevel, peg, gamearea):
        pygame.sprite.Sprite.__init__(self)
        self.size_level = sizelevel
        self.image = pygame.Surface([20*sizelevel, 20])
        self.image.fill(rand_color())
        self.rect = self.image.get_rect()
        self.rect.x = random.randrange(gamearea.x + 10,
                                       gamearea.width - self.rect.width)
        self.rect.y = random.randrange(gamearea.y + 10,
                                       gamearea.height - self.rect.height)
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
    game_area = Rect(50, 80, 540, 330)

    def redraw():
        background.fill(bg_color)
        background.fill(color_white, game_area)
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
        text = font.render("*  TOWERS OF HANOI  *", 1, font_color_white)
        textpos = text.get_rect(center = (background.get_width()/2,
                                          40))

    redraw()
    screen.blit(background, (0, 0))
    pygame.display.flip()

    clock = pygame.time.Clock()

    # prepare game objects
    i = 0
    disk = []
    while i < 3:
        disk.append(Disk(4-i, 0, game_area))
        i = i + 1
    alldisks = pygame.sprite.RenderPlain((disk[0], disk[1], disk[2]))

    def which_disk_is_mouse_in():
        pos = pygame.mouse.get_pos()
        for d in alldisks:
            if d.rect.collidepoint(pos[0], pos[1]):
                return d
        return None

    while 1:
        clock.tick(60)

        # Handle Input Events
        for event in pygame.event.get():
            if event.type == QUIT:
                return
            elif event.type == KEYDOWN and event.key == K_ESCAPE:
                return
            elif event.type == MOUSEBUTTONDOWN:
                picked_disk = which_disk_is_mouse_in()
                if picked_disk != None:
                    picked_disk.picked = True
                redraw()
            elif event.type == MOUSEBUTTONUP:
                bg_color = color1
                if picked_disk != None:
                    picked_disk.picked = False
                redraw()

        alldisks.update()

        # display everything
        screen.blit(background, (0, 0))
        alldisks.draw(screen)
        pygame.display.flip()

if __name__ == '__main__':
    main()
 

import os
import pygame
import random
import copy
from pygame.locals import *
from pygame.compat import geterror

if not pygame.font: print ('Warning, fonts disabled')
if not pygame.mixer: print ('Warning, sound disabled')

main_dir = os.path.split(os.path.abspath(__file__))[0]

color1 = (100, 50, 200)
color2 = (250, 250, 250)
color_gamearea = (255, 255, 255)
color_peg = (10, 10, 10)
color_active_peg = (255, 201, 14)
color_floor = (63, 72, 204)
font_color_white = (230, 230, 230)
font_color_grey = (68, 68, 68)
font_color_blue = (80, 80, 180)
font_color_red = (190, 90, 100)

M = 20
L = 155
D = 15                          # space between largest disks in adjacent pegs
PEG_W = 10

def rand_color():
    return [random.randrange(0,230) for i in range(0,3)]

DISK_H = 20
class Disk(pygame.sprite.Sprite):
    def __init__(self, sizelevel, gamearea):
        pygame.sprite.Sprite.__init__(self)
        self.size_level = sizelevel
        self.image = pygame.Surface([18*sizelevel+40, DISK_H])
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

class Peg(pygame.sprite.Sprite):
    def __init__(self, gamedata):
        pygame.sprite.Sprite.__init__(self)
        self.image = pygame.Surface([PEG_W, (10*DISK_H)+30])
        self.image.fill(color_peg)
        self.rect = self.image.get_rect()
        self.disks = []
        self.in_place_disks = []
        self.is_focused = False
        self._gamedata = gamedata

    def put_disk(self, d):
        length = len(self.in_place_disks)
        d.rect.centerx = self.rect.centerx
        if length == 0:
            d.rect.y = self.rect.y + self.rect.height - d.rect.height
        else:
            d.rect.y = self.in_place_disks[-1].rect.y - d.rect.height
        self.in_place_disks.append(d)

    def place_disks(self):
        for d in self.disks:    # from the largest to the smallest (in order)
            self.put_disk(d)

    def add_disk(self, d):
        self.disks.append(d)
        self.put_disk(d)

    def become_focused(self, focused):
        self.is_focused = focused
        if focused:
            if not self._gamedata.is_moving:
                self.in_place_disks[-1].picked = True
                self._gamedata.is_moving = True

    def update(self):
        if (self.is_focused):
            self.image.fill(color_active_peg)
        else:
            self.image.fill(color_peg)

class GameData:
    def __init__(self):
        self.normal_stack_list = [[5,4,3], [6,2], [7,1,0]]
        self.tmp_stack_list = copy.deepcopy(self.normal_stack_list)
        self.from_peg = None       # reference to the origin Peg object
        self.to_peg = None         # reference to the target Peg object
        self.is_valid = True
        self.is_moving = False
        self.step_count = 0
        self.current_picked_disk = None # reference to the picked Disk object
        self.active_peg = None          # reference to the active Peg object

    def is_win(self):
        return self.normal_stack_list[0] == []\
            and self.normal_stack_list[1] == []\
            and len(self.normal_stack_list[2]) != 0

        # frompeg, topeg is one of 0, 1, 2
    def move(self, frompeg, topeg):
        if is_picked:
            # pop from frompeg
            x = self.tmp_stack_list[frompeg].pop()
            # push onto topeg
            peg = self.tmp_stack_list[topeg]
            peg[len(peg):] = x

    def move_done(self):
        if self.is_moving:
            self.is_moving = False
            self.normal_stack_list = copy.deepcopy(self.tmp_stack_list)
        else:
            self.normal_stack_list = copy.deepcopy(self.tmp_stack_list)

    def check_valid(self, stack_list):
        for stack in stack_list:
            r = all(stack[i] < stack[i+1] for i in xrange(len(stack)-1))
            if r == False:
                return r
        return True

    def check_move_valid(self, disk_to_be_put, disk_down):
        return disk_to_be_put < disk_down

def render(game_data, pegs_list):
    if game_data.is_picked:
        current_stack_list = game_data.normal_stack_list
    else:
        current_stack_list = game_data.tmp_stack_list

def main():
    pygame.init()
    screen = pygame.display.set_mode((640, 480))
    pygame.display.set_caption('Tower of Hanoi')
    pygame.mouse.set_visible(True)
    bg_color = color1
    game_area = Rect(50, 60, 540, 360)
    floor_area = Rect(game_area.x + M - 10, game_area.y + 30 + 10*DISK_H+30,
                      3*L+D+39, 10)

    def redraw():
        background.fill(bg_color)
        background.fill(color_gamearea, game_area)
        background.fill(color_floor, floor_area)
        if pygame.font:
            background.blit(text, textpos)

    def onMouseButtonDown(event):
        redraw()

    def onMouseButtonUp(event):
        redraw()

    background = pygame.Surface(screen.get_size())
    background = background.convert()

    if pygame.font:
        font = pygame.font.Font(None, 26)
        text = font.render("*  TOWERS OF HANOI  *", 1, font_color_white)
        textpos = text.get_rect(center = (background.get_width()/2, 30))

    redraw()
    screen.blit(background, (0, 0))
    pygame.display.flip()

    clock = pygame.time.Clock()

    # prepare core game data
    gamedata = GameData()

    # prepare game objects
    pegs = []
    dx = L + D
    i = 0
    while i < 3:
        pegs.append(Peg(gamedata))
        pegs[i].rect.x = game_area.x + M + L / 2-PEG_W / 2 + i * dx
        pegs[i].rect.y = game_area.y + 30
        i = i + 1
    pegsgroup = pygame.sprite.RenderPlain(tuple(pegs))

    disks = []
    i = 0
    while i < len(gamedata.normal_stack_list):
        stack = gamedata.normal_stack_list[i]
        j = 0
        while j < len(stack):
            size = stack[j]
            d = Disk(size, game_area)
            disks.append(d)
            pegs[i].disks.append(d)
            j = j + 1
        i = i + 1
    disksgroup = pygame.sprite.RenderPlain(tuple(disks))

    # place disks in each peg
    for p in pegs:
        p.place_disks()

    def which_peg_is_mouse_in():
        d = game_area.width/3
        p0 = game_area.x
        p1 = p0 + d
        p2 = p1 + d
        p3 = p2 + d
        pos = pygame.mouse.get_pos()
        if p0 <= pos and pos[0] < p1:
            return pegs[0]
        elif p1 <= pos[0] and pos[0] < p2:
            return pegs[1]
        elif p2 <= pos[0] and pos[0] < p3:
            return pegs[2]
        else:
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
                gamedata.active_peg = which_peg_is_mouse_in()
                if gamedata.active_peg != None:
                    gamedata.active_peg.become_focused(True)
                gamedata.is_moving = True
                gamedata.from_peg = gamedata.active_peg
                redraw()
            elif event.type == MOUSEBUTTONUP:
                if gamedata.active_peg != None:
                    gamedata.active_peg.become_focused(False)
                    gamedata.active_peg = None
                gamedata.from_peg = None
                gamedata.to_peg = None
                gamedata.move_done()
                redraw()

        if gamedata.is_moving:
            tmp_peg = which_peg_is_mouse_in()
            if tmp_peg != gamedata.active_peg:
                gamedata.active_peg.become_focused(False)
                tmp_peg.become_focused(True)
                gamedata.active_peg = tmp_peg

        disksgroup.update()
        pegsgroup.update()

        # display everything
        screen.blit(background, (0, 0))
        pegsgroup.draw(screen)
        disksgroup.draw(screen)
        pygame.display.flip()

if __name__ == '__main__':
    main()

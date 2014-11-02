#------------------------------------------------------------------------------
# Tower of Hanoi Game
# author: Rui Duan
#------------------------------------------------------------------------------
import os
import pygame
import random
import ctypes

from pygame.locals import *
from pygame.compat import geterror

#------------------------------------------------------------------------------
# GLOBAL DATA
#------------------------------------------------------------------------------
main_dir = os.path.split(os.path.abspath(__file__))[0]

color1 = (100, 50, 200)
color2 = (250, 250, 250)
color_gamearea = (255, 255, 255)
color_peg = (10, 10, 10)
color_active_peg = (255, 201, 14)
color_floor = (63, 72, 204)
color_red = (255, 0, 0)
font_color_white = (230, 230, 230)
font_color_grey = (68, 68, 68)
font_color_blue = (80, 80, 180)
font_color_red = (190, 90, 100)

M = 20
L = 155
D = 15                          # space between largest discs in adjacent pegs
PEG_W = 10
DISC_H = 20

text = [0, 0, 0, 0, 0, 0, 0, 0]
Topic = ("1", "2", "3", "FROM TOWER #",
         "TO TOWER #", "MOVE #", "PRESS F1 TO EXIT")
Coor = ((145, 70), (315, 70),
           (485, 70), (110, 350), (320, 350), (260, 380), (220, 400))
text1 = [0, 0, 0]
L_MOVE = ((260, 350), (440, 350), (340, 380))

#------------------------------------------------------------------------------
# UTILITY FUNCTIONS
#------------------------------------------------------------------------------
def read_config_from_file(filepath):
    result = []
    cnt = 0
    with open(filepath, 'r') as f:
        for line in f.readlines():
            t = line.strip() # remove the leading and trailing whitespaces
            word_list = t.split()
            int_list = map(int, word_list)
            result.append(int_list)
            cnt = cnt + 1
        while cnt < 3:
            result.append([])
            cnt = cnt + 1
        return result

def rand_color():
    return [random.randrange(0,230) for i in range(0,3)]

#------------------------------------------------------------------------------
# CLASSES
#------------------------------------------------------------------------------

class Disc(pygame.sprite.Sprite):
    def __init__(self, sizelevel):
        pygame.sprite.Sprite.__init__(self)
        self.size_level = sizelevel
        self.image = pygame.Surface([18*sizelevel+40, DISC_H])
        self.color = rand_color()
        self.image.fill(self.color)
        self.rect = self.image.get_rect()
        self.picked = False
        self.valid = True

    def __str__(self):
        return str(self.size_level)

    def set_valid(self, isvalid):
        self.valid = isvalid

    def update(self):
        "move the disc based on the mouse position"
        if self.picked:
            pos = pygame.mouse.get_pos()
            self.rect.center = pos
            if self.valid:
                self.image.fill(self.color)
            else:
                self.image.fill(self.color)
                pygame.draw.line(self.image, color_red,
                                 (self.rect.x, self.rect.y),
                                 (self.rect.x + self.rect.width - 1,
                                  self.rect.y + self.rect.height - 1),
                                 4)
                pygame.draw.line(self.image, color_red,
                                 (self.rect.x + self.rect.width - 1,
                                  self.rect.y),
                                 (self.rect.x,
                                  self.rect.y + self.rect.height - 1),
                                 4)

class Peg(pygame.sprite.Sprite):
    def __init__(self, game, index):
        pygame.sprite.Sprite.__init__(self)
        self.image = pygame.Surface([PEG_W, (10*DISC_H)+30])
        self.image.fill(color_peg)
        self.rect = self.image.get_rect()
        self.is_focused = False
        self._game = game
        self.discs = game.disc_stack_list[index]
        self.in_place_discs = []

    def re_put_discs(self):
        self.in_place_disks = []
        self.place_discs()

    def put_disc(self, d):
        length = len(self.in_place_discs)
        d.rect.centerx = self.rect.centerx
        if length == 0:
            d.rect.y = self.rect.y + self.rect.height - d.rect.height
        else:
            d.rect.y = self.in_place_discs[-1].rect.y - d.rect.height
        self.in_place_discs.append(d)

    def place_discs(self):
        for d in self.discs:    # from the largest to the smallest (in order)
            self.put_disc(d)

    def become_focused(self, focused):
        self.is_focused = focused
        if focused:
            if not self._game.is_moving:
                self.in_place_discs[-1].picked = True
                self._game.is_moving = True

    def update(self):
        if (self.is_focused):
            self.image.fill(color_active_peg)
        else:
            self.image.fill(color_peg)

# Core Game Data
class HanoiGame:
    def __init__(self, gameconfig):
        self.is_moving = False
        self.disc_stack_list = []
        for int_stack in gameconfig:
            self.disc_stack_list.append(map(Disc, int_stack))

    def get_disc_list(self):
        r = []
        for stack in self.disc_stack_list:
            for disc in stack:
                r.append(disc)
        return r

    def is_win(self):
        x = self.disc_stack_list[0] == []\
            and self.disc_stack_list[1] == []\
            and len(self.disc_stack_list[2]) != 0
        return x

    def begin_move(self):
        print '\nbegin_move'
        self.is_moving = True

    def end_move(self, from_n, to_n):
        print 'end_move: (', from_n, '->', to_n, ')'
        if self.is_moving:
            self._move(from_n, to_n)
            self.is_moving = False

    # from_n, to_n is one of 0, 1, 2
    # raise an IndexError: pop from empty list
    def _move(self, from_index, to_index):
        if from_index == to_index:
            return
        if self.is_moving:
            # pop from self.from_n, may raise IndexError
            disc = self.disc_stack_list[from_index].pop()
            # push onto self.to_n
            to_stack = self.disc_stack_list[to_index]
            to_stack.append(disc)

    def is_move_valid(self, from_n, to_n):
        stack_of_from = self.disc_stack_list[from_n]
        stack_of_to = self.disc_stack_list[to_n]
        if (len(stack_of_from) == 0):
            result = False
        elif (len(stack_of_to) == 0):
            result = True
        else:
            top_of_from = stack_of_from[-1].size_level
            top_of_to = stack_of_to[-1].size_level
            result = (top_of_from < top_of_to)
        print 'is_move_valid(', from_n, '->', to_n, '): ', result
        return result

#------------------------------------------------------------------------------
# MAIN FUNCTION AND GAME LOOP
#------------------------------------------------------------------------------
def main():
    try:
        game_config = read_config_from_file(main_dir + '/input')
    except IOError:
        game_config = [[3, 2, 1], [], []]

    pygame.init()
    screen = pygame.display.set_mode((640, 480))
    pygame.display.set_caption('Tower of Hanoi')
    pygame.mouse.set_visible(True)
    bg_color = color1
    game_area = Rect(50, 60, 540, 360)
    floor_area = Rect(game_area.x + M - 10, game_area.y + 30 + 10*DISC_H+30,
                      3*L+D+39, 10)

    from_n = 0
    to_n = 0
    count = 0

    def draw_text():
        if pygame.font:
            background.blit(title, titlepos)

    def redraw():
        background.fill(bg_color)
        background.fill(color_gamearea, game_area)
        background.fill(color_floor, floor_area)
        draw_text()

    background = pygame.Surface(screen.get_size())
    background = background.convert()

    if pygame.font:
        font = pygame.font.Font(None, 26)
        title = font.render("*  TOWERS OF HANOI  *", 1, font_color_white)
        titlepos = title.get_rect(center = (background.get_width()/2, 30))

    redraw()
    screen.blit(background, (0, 0))
    pygame.display.flip()

    clock = pygame.time.Clock()

    game = HanoiGame(game_config)

    # create pegs
    pegs = []
    def rebuild_objs():
        dx = L + D
        i = 0
        while i < 3:
            pegs.append(Peg(game, i))
            pegs[i].rect.x = game_area.x + M + L / 2-PEG_W / 2 + i * dx
            pegs[i].rect.y = game_area.y + 30
            i = i + 1
        for p in pegs:
             p.re_put_discs()

    rebuild_objs()
    pegsgroup = pygame.sprite.RenderPlain(tuple(pegs))
    discsgroup = pygame.sprite.RenderPlain(tuple(game.get_disc_list()))

    def which_peg_is_mouse_in():
        d = game_area.width/3
        p0 = game_area.x
        p1 = p0 + d
        p2 = p1 + d
        p3 = p2 + d
        pos = pygame.mouse.get_pos()
        if p0 <= pos and pos[0] < p1:
            return 0
        elif p1 <= pos[0] and pos[0] < p2:
            return 1
        elif p2 <= pos[0] and pos[0] < p3:
            return 2
        else:
            return None

    def get_moving_disc(from_n):
        if game.is_moving:
            return game.disc_stack_list[from_n][-1]
        else:
            return None

    while 1:
        clock.tick(60)

        # handle input events
        for event in pygame.event.get():
            if event.type == QUIT:
                return
            elif event.type == KEYDOWN and event.key == K_ESCAPE:
                return
            elif event.type == KEYDOWN and event.key == 282:
                return
            elif event.type == MOUSEBUTTONDOWN:
                active_peg_index = which_peg_is_mouse_in()
                if active_peg_index != None:
                    active_peg = pegs[active_peg_index]
                    active_peg.become_focused(True)
                game.begin_move()
                from_peg = active_peg
                from_n = active_peg_index
                redraw()
            elif event.type == MOUSEBUTTONUP:
                to_n = which_peg_is_mouse_in()
                if active_peg != None:
                    active_peg.become_focused(False)
                    # temporarily put the picked disc back to original peg
                    game.disc_stack_list[from_n][-1].picked = False
                    from_peg.re_put_discs()
                    active_peg = None
                from_peg = None
                to_peg = None
                if not game.is_move_valid(from_n, to_n):
                    to_n = from_n
                else:
                    count = count + 1
                game.end_move(from_n, to_n)
                pegs = []
                pegsgroup = None
                rebuild_objs()
                pegsgroup = pygame.sprite.RenderPlain(tuple(pegs))
                redraw()

        if game.is_moving:
            tmp_peg_index = which_peg_is_mouse_in()
            if tmp_peg_index != active_peg_index:
                active_peg.become_focused(False)
                tmp_peg = pegs[tmp_peg_index]
                tmp_peg.become_focused(True)
                active_peg_index = tmp_peg_index
                active_peg = tmp_peg
                to_peg = active_peg
                to_n = tmp_peg_index
                is_valid_move = game.is_move_valid(from_n, to_n)
                moving_disc = get_moving_disc(from_n)
                if not is_valid_move:
                    moving_disc.set_valid(False)
                else:
                    moving_disc.set_valid(True)

        discsgroup.update()
        pegsgroup.update()

        # display everything
        screen.blit(background, (0, 0))
        pegsgroup.draw(screen)
        discsgroup.draw(screen)
        for i in range(len(Topic)):
            text[i] = font.render(Topic[i], True, (0, 0, 0))
            screen.blit(text[i], Coor[i])
        move_record = [from_n + 1, to_n + 1, count]
        for i in range(len(move_record)):
            text1[i] = font.render(str(move_record[i]), True, (0, 0, 0))
            screen.blit(text1[i], L_MOVE[i])
        pygame.display.flip()

        if game.is_win():
            MessageBox = ctypes.windll.user32.MessageBoxA
            MessageBox(None, 'Congratulation', 'you win!', 0)
            return

if __name__ == '__main__':
    main()

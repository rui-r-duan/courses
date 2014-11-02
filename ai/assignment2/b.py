import os
import pygame
import random

#------------------------------------------------------------------------------
# GLOBAL DATA
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
D = 15                          # space between largest discs in adjacent pegs
PEG_W = 10

DISC_H = 20


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
        self.image.fill(rand_color())
        self.rect = self.image.get_rect()
        self.picked = False

    def __str__(self):
        return str(self.size_level)

    def update(self):
        "move the disc based on the mouse position"
        if self.picked:
            pos = pygame.mouse.get_pos()
            self.rect.center = pos

class Peg(pygame.sprite.Sprite):
    def __init__(self, game):
        pygame.sprite.Sprite.__init__(self)
        self.image = pygame.Surface([PEG_W, (10*DISC_H)+30])
        self.image.fill(color_peg)
        self.rect = self.image.get_rect()
        self.discs = []
        self.in_place_discs = []
        self.is_focused = False
        self._game = game

    def re_put_discs(self):
        self.in_place_discs = []
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

    def add_disc(self, d):
        self.discs.append(d)
        self.put_disc(d)

    def become_focused(self, focused):
        self.is_focused = focused
        if focused:
            if not self._gamedata.is_moving:
                self.in_place_discs[-1].picked = True
                self._gamedata.is_moving = True

    def update(self):
        if (self.is_focused):
            self.image.fill(color_active_peg)
        else:
            self.image.fill(color_peg)

class HanoiGame:
    def __init__(self, gameconfig):
        self.is_moving = False
        self.disc_stack_list = []
        for int_stack in gameconfig:
            self.disc_stack_list.append(map(Disc, int_stack))

    def is_win(self):
        x = self.disc_stack_list[0] == []\
            and self.disc_stack_list[1] == []\
            and len(self.disc_stack_list[2]) != 0
        print 'is_win?', x
        return x

    def begin_move(self):
        print '\nbegin_move'
        self.is_moving = True

    def end_move(self, from_n, to_n):
        print 'end_move: (', from_n, '->', to_n, ')'
        if self.is_moving:
            self._move(from_n - 1, to_n - 1)
            self.is_moving = False

    # from_n, to_n is one of 0, 1, 2
    # sync internal self.from_n and self.to_n with the input
    # raise an IndexError: pop from empty list
    def _move(self, from_index, to_index):
        if self.is_moving:
            # pop from self.from_n, may raise IndexError
            disc = self.disc_stack_list[from_index].pop()
            # push onto self.to_n
            to_stack = self.disc_stack_list[to_index]
            to_stack.append(disc)

    def check_stacks_valid(self):
        x = True
        for stack in self.disc_stack_list:
            r = all(stack[i].size_level > stack[i+1].size_level\
                    for i in xrange(len(stack)-1))
            if r == False:
                x = r
                break
        print 'check_stacks_valid:', x
        return x

    def is_move_valid(self, from_n, to_n):
        stack_of_from = self.disc_stack_list[from_n - 1]
        stack_of_to = self.disc_stack_list[to_n - 1]
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

    def ps(self):
        print '[',
        for stack in self.disc_stack_list:
            print '[',
            for a in stack:
                print a,
            print ']',
        print ']'

    def pd(self):
        print '==============='
        print ' disc_stack_list:', self.ps()
        print ' is_moving:', self.is_moving
        print '==============='

def main():
    try:
        game_config = read_config_from_file(main_dir + '/input')
    except IOError:
        game_config = [[3, 2, 1], [], []]

    cd = HanoiGame(game_config)
    cd.pd()
    cd.is_win()
    cd.check_stacks_valid()

    cd.begin_move()
    if (cd.is_move_valid(1, 3)):
        cd.end_move(1, 3)
    cd.pd()
    cd.is_win()
    cd.check_stacks_valid()

    cd.begin_move()
    if (cd.is_move_valid(1, 2)):
        cd.end_move(1, 2)
    cd.pd()
    cd.is_win()
    cd.check_stacks_valid()

    cd.begin_move()
    if (cd.is_move_valid(3, 2)):
        cd.end_move(3, 2)
    cd.pd()
    cd.is_win()
    cd.check_stacks_valid()

    cd.begin_move()
    if (cd.is_move_valid(1, 3)):
        cd.end_move(1, 3)
    cd.pd()
    if (cd.is_move_valid(1, 2)):
        cd.end_move(1, 2)               # invalid move
    if (cd.is_move_valid(3, 2)):
        cd.end_move(3, 2)           # invalid move
    cd.pd()
    cd.is_win()
    cd.check_stacks_valid()

    cd.begin_move()
    if (cd.is_move_valid(2, 1)):
        cd.end_move(2, 1)
    cd.pd()
    cd.is_win()
    cd.check_stacks_valid()

    cd.begin_move()
    if (cd.is_move_valid(2, 3)):
        cd.end_move(2, 3)
    cd.pd()
    cd.is_win()
    cd.check_stacks_valid()

    cd.begin_move()
    if (cd.is_move_valid(1, 3)):
        cd.end_move(1, 3)
    cd.pd()
    cd.is_win()
    cd.check_stacks_valid()


if __name__ == '__main__':
    main()

import os
import pygame
import copy

main_dir = os.path.split(os.path.abspath(__file__))[0]

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


class CoreData:
    def __init__(self, gameconfig):
        self.normal_stack_list = gameconfig
        self.tmp_stack_list = copy.deepcopy(self.normal_stack_list)
        self.from_n = 0
        self.to_n = 0
        self.is_moving = False

    def is_win(self):
        x = self.normal_stack_list[0] == []\
            and self.normal_stack_list[1] == []\
            and len(self.normal_stack_list[2]) != 0
        print 'is_win?', x
        return x

    def begin_move(self):
        print '\nbegin_move'
        self.is_moving = True
        self.tmp_stack_list = copy.deepcopy(self.normal_stack_list)

    def end_move(self):
        print '\nend_move'
        if self.is_moving:
            self.is_moving = False
            self.normal_stack_list = copy.deepcopy(self.tmp_stack_list)
        else:
            self.normal_stack_list = copy.deepcopy(self.tmp_stack_list)

    # from_n, to_n is one of 0, 1, 2
    # sync internal self.from_n and self.to_n with the input
    def move(self, from_n, to_n):
        print '\nmove from', from_n, 'to', to_n
        if self.is_moving:
            self.from_n = from_n - 1
            self.to_n = to_n - 1
            # pop from self.from_n
            x = self.tmp_stack_list[self.from_n].pop()
            # push onto self.to_n
            s = self.tmp_stack_list[self.to_n]
            s.append(x)

    def check_valid(self, stack_list):
        for stack in stack_list:
            r = all(stack[i] < stack[i+1] for i in xrange(len(stack)-1))
            if r == False:
                return r
        return True

    def check_move_valid(self, disk_to_be_put, disk_down):
        return disk_to_be_put < disk_down

    def pd(self):
        print '\n== Core Data =='
        print ' normal:   ', self.normal_stack_list
        print ' tmp:      ', self.tmp_stack_list
        print ' from_n:   ', self.from_n
        print ' to_n:     ', self.to_n
        print ' is_moving:', self.is_moving

def main():
    game_config = read_config_from_file(main_dir + '/input')
    cd = CoreData(game_config)

    cd.pd()
    cd.is_win()

    cd.begin_move()
    cd.move(1, 3)
    cd.pd()
    cd.end_move()
    cd.pd()
    cd.is_win()

    cd.begin_move()
    cd.move(1, 2)
    cd.move(2, 1)
    cd.end_move()
    cd.pd()
    cd.is_win()

    cd.begin_move()
    cd.move(3, 2)
    cd.end_move()
    cd.pd()
    cd.is_win()

    cd.begin_move()
    cd.move(1, 3)
    cd.end_move()
    cd.pd()
    cd.is_win()

    cd.begin_move()
    cd.move(2, 1)
    cd.end_move()
    cd.pd()
    cd.is_win()

    cd.begin_move()
    cd.move(2, 3)
    cd.end_move()
    cd.pd()
    cd.is_win()

    cd.begin_move()
    cd.move(1, 3)
    cd.end_move()
    cd.pd()
    cd.is_win()


if __name__ == '__main__':
    main()

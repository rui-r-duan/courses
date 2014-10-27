from semnet import *

from tostr import tostr
import string

# get the global "is-a" relationship
isa = GetIsA()

# inverse of "is-a" is "exampleOf"
example = GetExampleOf()

# declare some entities we want to store knowledge about
thing = Entity("thing")
animal = Entity("animal")
bird = Entity("bird")
fish = Entity("fish")
minnow = Entity("minnow")
trout = Entity("trout")
ape = Entity("ape")

# declare some facts: what's what?
Fact(animal, isa, thing)
Fact(ape, isa, animal)
Fact(bird, isa, animal)
Fact(fish, isa, animal)
Fact(trout, isa, fish)
Fact(minnow, isa, fish)

# rint out some of the things we know (directly or by induction)
print "trout is:", tostr(trout.objects(isa))
print "animal is:", tostr(animal.objects(isa))
print
print "fish:", tostr(fish.objects(example))
print "fish:", tostr(fish.agents(isa))
print "animals:", tostr(animal.agents(isa))

###----------------------------------------------------------------------------
###  Semantic Network
###----------------------------------------------------------------------------

class Entity:
    def __init__(self, id):
        self.id = id            # id is the entity's name, i.e. "fish"
        self.mObjects = {}
        self.mAgents = {}

    def __str__(self):
        return self.id

    def objects(self, relation):
        try: ans = self.mObjects[relation]
        except: ans = []
        if relation.transitive:
            for i in tuple(ans):
                ans = ans + i.objects(relation)
        return ans

    def agents(self, relation):
        try: ans = self.mAgents[relation]
        except: ans = []
        if relation.inverse and relation.inverse.transitive:
            for i in tuple(ans):
                ans = ans + i.agents(relation)
        return ans

    def storeObject(self, relation, object):
        try:
            lst = self.mObjects[relation]
            if object not in lst: lst.append(object)
        except:
            self.mObjects[relation] = [object]

    def storeAgent(self, relation, agent):
        try:
            lst = self.mAgents[relation]
            if agent not in lst: lst.append(agent)
        except:
            self.mAgents[relation] = [agent]

    def getObjects(self, relation):
        out = self.objects(relation)
        # also check type-ancestors (base classes)
        try: parents = self.mObjects[IS_A]
        except: return out
        for p in parents:
            out = out + p.getObjects(relation)
        return out

    def getAgents(self, relation):
        out = self.agents(relation)
        # also check type-ancestors (base classes)
        try: parents = self.mObjects[IS_A]
        except: return out
        for p in parents:
            out = out + p.getAgents(relation)
        return out

class Relation:
    def __init__(self, id, transitive = 1, inverse = None):
        self.id = id

        # a relation @ is transitive if
        # A @ B and B @ C implies A @ C
        self.transitive = transitive

        if inverse:
            self.inverse = inverse
            inverse.inverse = self
        else:
            self.inverse = None

    def __str__(self): return self.id

    def __call__(self, agent, object = None):
        # when used as a function, check to see whether
        # this relation applies
        obs = agent.getObjects(self)
        if not object: return obs
        if not obs or object not in obs: return 0
        else: return 1

class Fact:
    def __init__(self, agent, relation, object):
        self.agent = agent
        self.relation = relation
        self.object = object

        # stuff into dictionaries, for searching
        agent.storeObject(relation, object)
        object.storeAgent(relation, agent)

        # deduce inverse relations as well
        if relation.inverse:
            object.storeObject(relation.inverse, agent)
            agent.storeAgent(relation.inverse, object)

# declare global "is-a" relationship.
# other modules MUST properly use this, rather than
# define their own "is-a", since it has special meaning (inheritance).

IS_A = Relation("is-a", 1)
EXAMPLE_OF = Relation("exampleOf", 1, IS_A)

# functions to allow outside access to these objects more easily:
def GetIsA(): return IS_A
def GetExampleOf(): return EXAMPLE_OF

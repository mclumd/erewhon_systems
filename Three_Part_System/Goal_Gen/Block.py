# single block, a square, a triangle, or a table. These are the blocks of which
# scenes are composed.
# Possible predicates involving blocks:
#   -square(x)
#   -triangle(x)
#   -table(x)
#   -clear(x)
#   -on(x,y)
class Block:
    TRIANGLE = 0
    SQUARE = 1
    TABLE = 2

    def __init__(self, blockid, blocktype, on=None, clear=True):
        self.blocktype = blocktype
        self.on = on
        self.clear = clear
        self.blockid = blockid

    # place self block onto onto block
    def place(self, onto):
        if self.on:
            self.on.clear = True
        self.on = onto
        self.on.clear = False


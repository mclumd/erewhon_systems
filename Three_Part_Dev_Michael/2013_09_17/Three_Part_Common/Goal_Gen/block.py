
# single block, a square, a triangle, or a table. These are the blocks of which
# scenes are composed.
# Possible predicates involving blocks:
#   -square(x)
#   -triangle(x)
#   -table(x)
#   -clear(x)
#   -on(x,y)
class Block:
    SQUARE = 1          # constant
    TRIANGLE = 2
    TABLE = 3

    def __init__(self, blocktype, blockid):
        self.blocktype = blocktype
        self.blockid = blockid
        self.blockon = None
        self.isclear = True
        self.isonfire = False

    def getblocktype(self):
        return self.blocktype

    def getblockon(self):
        return self.blockon

    # place self block onto onto block
    def place(self, onto):
        if self.blockon:
            self.blockon.clear()
        self.blockon = onto
        self.blockon.unclear()

    # set the block to not clear
    def unclear(self):
        self.isclear = False

    # set the block to clear
    def clear(self):
        self.isclear = True    

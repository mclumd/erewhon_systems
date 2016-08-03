import random
from Block import Block
from Ex import Ex

# For generating a single example(of class Ex)
class ProbGen:
    # Note: withtable should be true if toptowers(), squaretower(), groundsquares(), groundtriangles() are ever to be called
    def __init__(self, tag, squaretowermaxheight=8, withtable=True):
        self.tag = tag
        self.squaretowermaxheight = squaretowermaxheight
        self.blocks = []
        self.table = None
        if withtable:
            self.table = self.__maketable()

    # creates a table block
    def __maketable(self):
        table = Block(blocktype=Block.TABLE, blockid=self.tag+str(len(self.blocks)))
        self.blocks.append(table)
        return table

    # Place triangles onto each tower in an array of squaretowers
    def toptowers(self, towers):
        tops = []
        for i in range(len(towers)):
            if not towers[i][-1].blocktype == Block.SQUARE:
                raise Exception("ProbGen.toptowers should be given towers consisting of squares only.")
            top = Block(blocktype=Block.TRIANGLE, blockid=self.tag+str(len(self.blocks)))
            top.blockon = towers[i][-1]
            tops.append(top)
            towers[i][-1].clear = False
            towers[i].append(top)
            self.blocks.append(top)
        return tops

    # Returns an array of stacked squares. height should be at least 2.
    def squaretower(self, height):
        tower = []
        base = Block(blocktype=Block.SQUARE, blockid=self.tag+str(len(self.blocks)))
        base.blockon = self.table
        base.isclear = False
        tower.append(base)
        self.table.clear = False
        self.blocks.append(base)

        for i in range(height - 1):
            nextblock = Block(blocktype=Block.SQUARE, blockid=self.tag+str(len(self.blocks)))
            nextblock.blockon = tower[-1]
            nextblock.isclear = False
            tower.append(nextblock)
            self.blocks.append(nextblock)
        tower[-1].clear=True
        
        return tower

    # Returns an array of single squares lying on the table
    def groundsquares(self, count):
        squares = []

        for i in range(count):
            square = Block(blocktype=Block.SQUARE, blockid=self.tag+str(len(self.blocks)))
            square.blockon = self.table
            square.isclear = True
            squares.append(square)
            self.table.clear = False
            self.blocks.append(square)

        return squares

    # Returns an array of single triangles lying on the table
    def groundtriangles(self, count):
        triangles = []

        for i in range(count):
            triangle = Block(blocktype=Block.TRIANGLE, blockid=self.tag+str(len(self.blocks)))
            triangle.blockon = self.table
            triangle.isclear = True
            triangles.append(triangle)
            self.table.clear = False
            self.blocks.append(triangle)

        return triangles

    def add_blocks(self, blocks):
        self.blocks += blocks

    def get_blocks(self):
        return self.blocks

    # Return an example containing the blocks, but no goal
    def give_ex(self, scenarioname="None"):
        return Ex(scenarioname, blocks = self.blocks)


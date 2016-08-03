import sys
sys.path.append("..")
from block import Block
from Goal_Gen_2013_03_30 import GoalGen20130330

# Scenario_001 -> Scenario_002 -> Scenario_003 -> Scenario_001
# 
# Scenario_001: 3 stacked squares, topped by triangle
# Scenario_002: 2 stacked squares, topped by triangle, square on ground
# Scenario_003: 3 stacked squares, triangle on ground
# 
# Scenario_001 goal: triangle on second square
# Scenario_002 goal: ground square on second square
# Scenario_003 goal: triangle on top square

def main():
    print "\nTest 1:"
    test_001()

    print "\nTest 2:"
    test_002()

def test_001():
    table = Block(Block.TABLE, 1)
    
    # make height 3 tower topped by triangle
    t1 = Block(Block.SQUARE, 2)
    t2 = Block(Block.SQUARE, 3)
    t3 = Block(Block.SQUARE, 4)
    t4 = Block(Block.TRIANGLE, 5)

    t1.place(table)
    t2.place(t1)
    t3.place(t2)
    t4.place(t3)

    t2.isonfire = True
    t4.isonfire = True

    # make problem file
    gg = GoalGen20130330()
    gg.makeshop2pfile([table, t1, t2, t3, t4], "problemfile_001")

def test_002():
    table = Block(Block.TABLE, 1)
    
    # make height 3 tower, not topped by triangle
    t1 = Block(Block.SQUARE, 2)
    t2 = Block(Block.SQUARE, 3)
    t3 = Block(Block.SQUARE, 4)

    t4 = Block(5, Block.TRIANGLE)

    t1.place(table)
    t2.place(t1)
    t3.place(t2)

    t4.place(table)

    t1.isonfire = True
    t3.isonfire = True

    # make problem file
    gg = GoalGen20130330()
    gg.makeshop2pfile([table, t1, t2, t3, t4], "problemfile_002")

if __name__ == "__main__":
    main()


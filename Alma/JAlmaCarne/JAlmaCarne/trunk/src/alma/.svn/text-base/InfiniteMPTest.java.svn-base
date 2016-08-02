package alma;

import alma.util.TestBase;

public class InfiniteMPTest extends TestBase {
	public static void testSimple(){
		MockKnowledgeBase mock = new MockKnowledgeBase();
		InfiniteModusPonens imp = new InfiniteModusPonens(mock);
		
		mock.add(parseString("a(1)"));
		mock.add(parseString("a(X)->b(X)"));
		mock.step();
		
		imp.add(parseString("a(X)->b(X)"));
		
		for(int i=0; i<100; i++){
			imp.step();
			mock.step();
		}
		
		assertTrue(mock.contains(parseString("b(1)")));
	}
	
	public static void testDouble(){
		MockKnowledgeBase mock = new MockKnowledgeBase();
		InfiniteModusPonens imp = new InfiniteModusPonens(mock);
		
		mock.add(parseString("a(1)"));
		mock.add(parseString("a(2)"));
		mock.add(parseString("b(1)"));
		mock.add(parseString("a(X)&b(X)->c(X)"));
		mock.step();
		
		imp.add(parseString("a(X)&b(X)->c(X)"));
		
		for(int i=0; i<100; i++){
			imp.step();
			mock.step();
		}
		
		assertTrue(mock.contains(parseString("c(1)")));
		assertFalse(mock.contains(parseString("c(2)")));
	}
	
	public static void testTriple(){
		MockKnowledgeBase mock = new MockKnowledgeBase();
		InfiniteModusPonens imp = new InfiniteModusPonens(mock);
		
		mock.add(parseString("a(1)"));
		mock.add(parseString("a(2)"));
		mock.add(parseString("a(3)"));
		mock.add(parseString("a(4)"));
		mock.add(parseString("b(1)"));
		mock.add(parseString("b(2)"));
		mock.add(parseString("c(1)"));
		mock.add(parseString("a(X)&b(X)&c(X) -> d(X)"));
		mock.step();
		
		imp.add(parseString("a(X)&b(X)&c(X) -> d(X)"));
				
		for(int i=0; i<100; i++){
			imp.step();
			mock.step();
		}
		
		assertTrue(mock.contains(parseString("d(1)")));
		assertFalse(mock.contains(parseString("d(2)")));
		assertFalse(mock.contains(parseString("d(3)")));
	}
	
	public static void testQuad(){
			java.util.HashSet<Integer> test = new java.util.HashSet<Integer>();
			for(int i=0; i<13; i++){
				test.add(i);
			}
			MockKnowledgeBase mock = new MockKnowledgeBase();
			InfiniteModusPonens imp = new InfiniteModusPonens(mock);
			
			mock.add(parseString("a(1)"));
			mock.add(parseString("a(2)"));
			mock.add(parseString("a(3)"));
			mock.add(parseString("a(4)"));
			mock.add(parseString("a(5)"));
			mock.add(parseString("b(1)"));
			mock.add(parseString("b(2)"));
			mock.add(parseString("b(3)"));
			mock.add(parseString("b(4)"));
			mock.add(parseString("c(1)"));
			mock.add(parseString("c(2)"));
			mock.add(parseString("c(3)"));
			mock.add(parseString("d(1)"));
			mock.add(parseString("d(2)"));
			mock.add(parseString("a(X)&b(X)&c(X)&d(X) -> e(X)"));
			mock.step();
			
			imp.add(parseString("a(X)&b(X)&c(X)&d(X) -> e(X)"));
					
			for(int i=0; i<100; i++){
				imp.step();
				mock.step();
			}
			
			assertTrue(mock.contains(parseString("e(1)")));
			assertTrue(mock.contains(parseString("e(2)")));
			assertFalse(mock.contains(parseString("e(3)")));
			assertFalse(mock.contains(parseString("e(4)")));
	}
}

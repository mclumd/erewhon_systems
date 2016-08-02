package alma;

public class ModusPonensTest extends TestBase {
	
	public static void testModusPonens(){
		MockKnowledgeBase kb = new MockKnowledgeBase();
		
		ModusPonens mp = new ModusPonens(kb);
		mp.add(parseString("(a(X) -> b(X))"));
		mp.add(parseString("a(john)"));
		
		mp.step();
		
		assertTrue(kb.contains(parseString("b(john)")));
	}
	
	public static void testModusPonensComplex(){
		
		MockKnowledgeBase kb = new MockKnowledgeBase();
		
		ModusPonens mp = new ModusPonens(kb);
		mp.add(parseString("( (a(X) & b(X, Y))-> c(X))"));
		mp.add(parseString("a(john)")); 
		mp.add(parseString("b(john, kelly)")); 
		
		mp.step();
		
		assertTrue(kb.contains(parseString("c(john)")));
	}
}

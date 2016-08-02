package alma;

import alma.util.TestBase;

public class GeneralizedModusPonensTest extends TestBase {
	public static void testGeneralizedModusPonens(){
		MockKnowledgeBase kb = new MockKnowledgeBase();
		
		GeneralizedModusPonens mp = new GeneralizedModusPonens(kb);
		kb.add(parseString("(a(X) -> b(X))"));
		kb.add(parseString("a(john)"));
		
		kb.step(); 
		kb.step(); 
		mp.step(); 
		kb.step();
		
		assertTrue(kb.contains(parseString("b(john)")));
	}
	
	public static void testGeneralizedModusPonensComplex1(){
		
		MockKnowledgeBase kb = new MockKnowledgeBase();
		
		GeneralizedModusPonens mp = new GeneralizedModusPonens(kb);
		kb.add(parseString("( (a(X) & b(X, Y)) -> c(Y))"));
		kb.add(parseString("a(john)")); 
		kb.add(parseString("b(john, kelly)")); 
		
		kb.step(); 
		kb.step(); 
		mp.step(); 
		kb.step();
		
		assertTrue(kb.contains(parseString("c(kelly)")));
	}

	public static void testGeneralizedModusPonensComplex2(){
		
		MockKnowledgeBase kb = new MockKnowledgeBase();
		
		GeneralizedModusPonens mp = new GeneralizedModusPonens(kb);
		kb.add(parseString("( (a(X,Y) & b(Y,Z) ) -> d(X,Z) )"));
		kb.add(parseString("a(john, bob)")); 
		kb.add(parseString("b(bob, kelly)"));   
		
		kb.step(); kb.step(); mp.step(); kb.step();
		
		assertTrue(kb.contains(parseString("d(john, kelly)")));
	}

	public static void testGeneralizedModusPonensComplex3(){
		
		MockKnowledgeBase kb = new MockKnowledgeBase();
		
		GeneralizedModusPonens mp = new GeneralizedModusPonens(kb);
		kb.add(parseString("( ( b(Y,Z) & a(X,Y) ) -> d(X,Z) )"));
		kb.add(parseString("a(john, bob)")); 
		kb.add(parseString("b(bob, kelly)"));   
		
		kb.step(); kb.step(); mp.step(); kb.step();
		
		assertTrue(kb.contains(parseString("d(john, kelly)")));
	}

	public static void testGeneralizedModusPonensComplex4(){
		
		MockKnowledgeBase kb = new MockKnowledgeBase();
		
		GeneralizedModusPonens mp = new GeneralizedModusPonens(kb);
		kb.add(parseString("( (a(X) & b(Y) & c(W) ) -> d(W) )"));
		kb.add(parseString("a(john)")); 
		kb.add(parseString("b(bob)")); 
		kb.add(parseString("c(tim)"));  
		
		kb.step(); kb.step(); mp.step(); kb.step();
		
		assertTrue(kb.contains(parseString("d(tim)")));
	}

	public static void testGeneralizedModusPonensComplex5(){	// must not have extra parantheses on left
		
		MockKnowledgeBase kb = new MockKnowledgeBase();
		
		GeneralizedModusPonens mp = new GeneralizedModusPonens(kb);
		kb.add(parseString("( ((a(X) & b(Y)) & c(W) ) -> d(W) )"));
		kb.add(parseString("a(john)")); 
		kb.add(parseString("b(bob)")); 
		kb.add(parseString("c(tim)"));  
		
		kb.step(); kb.step(); mp.step(); kb.step();
		
		assertFalse(kb.contains(parseString("d(tim)")));
	}

	public static void testGeneralizedModusPonensComplex6(){
		
		MockKnowledgeBase kb = new MockKnowledgeBase();
		
		GeneralizedModusPonens mp = new GeneralizedModusPonens(kb);
		kb.add(parseString("( (a(X,Y) & b(Y,Z) & c(Z,W)) -> d(X,W) )"));
		kb.add(parseString("a(john, bob)")); 
		kb.add(parseString("b(bob, kelly)")); 
		kb.add(parseString("c(kelly, tim)"));  
		
		kb.step(); kb.step(); mp.step(); kb.step();
		
		assertTrue(kb.contains(parseString("d(john, tim)")));
	}

	public static void testGeneralizedModusPonensComplex7(){
		
		MockKnowledgeBase kb = new MockKnowledgeBase();
		
		GeneralizedModusPonens mp = new GeneralizedModusPonens(kb);
		kb.add(parseString("( (c(Z,W) & a(X,Y) & b(Y,Z)) -> d(X,W) )"));
		kb.add(parseString("a(john, bob)")); 
		kb.add(parseString("b(bob, kelly)")); 
		kb.add(parseString("c(kelly, tim)"));  
		
		kb.step(); kb.step(); mp.step(); kb.step();
		
		assertTrue(kb.contains(parseString("d(john, tim)")));
	}

}

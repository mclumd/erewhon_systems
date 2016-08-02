package alma;

import java.util.Map;

public class UnifiedMapTest extends TestBase {
	public static void testUnify(){
		UnifiedMap um = new UnifiedMap();
		
		Formula knows = createPredicate("knows", "john, kelly");
		Formula knows2 = createPredicate("knows", "X", "X");
		
		// Unify knows(John, Kelly) and knows(x, x)
		assertFalse(knows.unify(knows2, um));
		um.reset();
		
		assertFalse(knows2.unify(knows, um));
		um.reset();
	}
	
	public static void testUnify2(){
		UnifiedMap um = new UnifiedMap();
		FormulaBuilder fb = new FormulaBuilder();
		
		fb.clear();
		fb.addPredicate("knows");
			fb.add(createPredicate("blah", "A", "kelly").getHead());
			fb.add(createPredicate("blah", "john", "B").getHead());

		Formula knows = fb.getFormula();
		Formula knows2 = createPredicate("knows", "X", "X");

		// Unify knows(blah(a,Kelly), blah(Apple, c)) with knows(x,x)
		assertTrue(knows.unify(knows2, um));
		
		Map<Variable, FormulaNode> m = um.debugGetMap();
		
		Variable a = new Variable("A");
		Variable b = new Variable("B");
		Variable x = new Variable("X");
		
		assertTrue(m.keySet().contains(a));
		assertTrue(m.get(a).equals(new SymbolicConstant("john")));
		
		assertTrue(m.keySet().contains(b));
		assertTrue(m.get(b).equals(new SymbolicConstant("kelly")));
		
		assertTrue(m.keySet().contains(x));
	}
	
	public static void testUnify3(){
		UnifiedMap um = new UnifiedMap();
		
		Formula knows = createPredicate("knows", "john", "john");
		Formula knows2 = createPredicate("knows", "X", "X");
		//Unify knows(x,x) with knows(John, John)
		knows2.unify(knows, um);
		
		Map	m = um.debugGetMap();
		Variable x = new Variable("X");
		assertTrue(m.keySet().contains(x));
		assertTrue(m.get(x).equals(new SymbolicConstant("john")));
	}
}

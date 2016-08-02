package alma;

import java.util.Map;

public class SubstitutionListTest extends TestBase {
	public static void testUnify(){
		SubstitutionList um = new SubstitutionList();
		
		Formula knows = parseString("knows(john, kelly)");
		Formula knows2 = parseString("knows(X,X)");
		
		// Unify knows(John, Kelly) and knows(x, x)
		assertFalse(knows.unify(knows2, um));
		um.reset();
		
		assertFalse(knows2.unify(knows, um));
		um.reset();
	}
	
	public static void testUnify2(){
		SubstitutionList um = new SubstitutionList();
		FormulaBuilder fb = new FormulaBuilder();

		Formula knows = parseString("knows(blah(A, kelly), blah(john, B))");
		Formula knows2 = parseString("knows(X,X)");

		// Unify knows(blah(a,Kelly), blah(Apple, c)) with knows(x,x)
		assertTrue(knows.unify(knows2, um));
		
		Variable a = new Variable("A");
		Variable b = new Variable("B");
		Variable x = new Variable("X");
		
		assertTrue(um.isBound(a));
		assertTrue(um.walk(a).equals(new SymbolicConstant("john")));
		
		assertTrue(um.isBound(b));
		assertTrue(um.walk(b).equals(new SymbolicConstant("kelly")));
		
		assertTrue(um.isBound(x));
	}
	
	public static void testUnify3(){
		SubstitutionList um = new SubstitutionList();
		
		Formula knows = parseString("knows(john,john)");
		Formula knows2 = parseString("knows(X,X)");
		//Unify knows(x,x) with knows(John, John)
		knows2.unify(knows, um);
		
		Variable x = new Variable("X");
		assertTrue(um.isBound(x));
		assertTrue(um.walk(x).equals(new SymbolicConstant("john")));
	}
	
	public static void testUnify4(){
		SubstitutionList um = new SubstitutionList();
		
		Formula knows = parseString("A(X,b, c)");
		Formula knows2 = parseString("A(a, b, X)");

		assertTrue(knows2.unify(knows, um));
	}
}

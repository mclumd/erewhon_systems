package alma;

import alma.util.TestBase;


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

//		assertTrue(knows2.unify(knows, um));
		assertTrue(knows2.getHead().unify(SubstitutionList.standardizeApart(knows2.getHead(),knows.getHead()), um));

	}
	
	/*
	 * Occurs Check Test
	 */
	public static void testUnify5(){
		SubstitutionList um = new SubstitutionList();
		Variable z = new Variable("Z");
		FormulaNode p = parse("p(X, Y)");
		Variable x = new Variable("X");
		
		assertTrue(um.unify(z, p));
		assertFalse(um.unify(z, x));
	}
	
	/*
	 * Occurs Check Test
	 */
	public static void testUnify6(){
		SubstitutionList um = new SubstitutionList();
		Variable z = new Variable("Z");
		FormulaNode p = parse("p(X, Y)");
		Variable x = new Variable("X");
		
		assertTrue(um.unify(z, p));
		assertFalse(um.unify(x, z));
	}
	
	public static void testStandardize(){
		Formula knows = parseString("A(X,P,c)");
		Formula knows2 = parseString("A(P,b,X)");
		System.out.println(knows+" "+SubstitutionList.standardizeApart(knows.getHead(),knows2.getHead()));
		
		Formula f1 = parseString("(%A X (~p(x) | %A Y (~p(Y) | p(f(X,Y)))))");
		Formula f2 = parseString("(%E Y (q(X,Y) & ~P(Y)))");
		System.out.println(f1+" <><><> "+SubstitutionList.standardizeApart(f1.getHead(),f2.getHead()));
	}
	
	/**
	 * Level 1 Unify with functions with preexisting substitution list.
	 *
	 */
	public static void testUnifyFunction1(){
		Formula f1 = parseString("A(f(X))");
		Formula f2 = parseString("A(Y)");
		Formula f3 = parseString("B(X)");
		Formula f4 = parseString("B(1)");
		
		SubstitutionList sl = new SubstitutionList();
		sl.unify(f3.getHead(), f4.getHead());
		sl.unify(f1.getHead(), f2.getHead());
		
		assertTrue(f2.applySubstitution(sl).equals(parseString("A(f(1))")));
	}
	
	/**
	 * Level 2 Unify with functions with pre-existing substitution list.
	 *
	 */
	public static void testUnifyFunction2(){
		Formula f1 = parseString("A(f(f(X)))");
		Formula f2 = parseString("A(Y)");
		Formula f3 = parseString("B(X)");
		Formula f4 = parseString("B(1)");
		
		SubstitutionList sl = new SubstitutionList();
		sl.unify(f3.getHead(), f4.getHead());
		sl.unify(f1.getHead(), f2.getHead());
		
		assertTrue(f2.applySubstitution(sl).equals(parseString("A(f(f(1)))")));
	}
}

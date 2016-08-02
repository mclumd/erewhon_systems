package alma;

import alma.util.TestBase;
import alma.FormulaSet;

public class CNFTest extends TestBase{
	
	//Sanity test. Does not prove CNF, but it checks one 
	//aspect of it.
	public static void testCNF1(){
		//System.out.println("CNF1 test");
		FormulaBuilder fb = new FormulaBuilder();
		
		fb.addOr();
			fb.addAnd();
				fb.addConstant("A");
				fb.addConstant("B");
				fb.addConstant("C");
				fb.endChildren();
			fb.addAnd();
				fb.addConstant("D");
				fb.addConstant("E");
		
		Formula basic = fb.getFormula();
		Formula cnf = FormulaSet.toCNF(basic);
		
		//System.out.println(basic);
		//System.out.println(cnf);
		
		for(FormulaNode fn: ((ComplexNode)cnf.getHead()).getChildren()){
			assertTrue (((ComplexNode)fn).getChildren().size() == 2);
		}
	}
	
	//Another sanity test.
	public static void testSimplify(){		
		FormulaBuilder fb = new FormulaBuilder();
		fb.addOr();
			fb.addOr();
				fb.addConstant("A");
				fb.addConstant("B");
				fb.addConstant("C");
				fb.endChildren();
			fb.addOr();
				fb.addConstant("D");
				fb.addConstant("E");

		Formula basic = fb.getFormula();
		Formula cnf = FormulaSet.toCNF(basic);
		assertTrue(((ComplexNode)cnf.getHead()).getChildren().size() == 5);
	}
	

	public static void testQuantCNF()  {
		FormulaBuilder fb = new FormulaBuilder();
		fb.addPredicate("x");
			fb.addSkolemConstant("\\C0");
			fb.addVariable("B");
			fb.addSkolemFunction("f1");
				fb.addVariable("B");
				fb.endChildren();
			fb.addVariable("D");
			fb.addSkolemFunction("f2");
				fb.addVariable("B");
				fb.addVariable("D");
				fb.endChildren();
			fb.endChildren();
		assert(fb.getFormula().getHead().equals(FormulaSet.toCNF(parseString("%E A ( %A B ( %E C ( %A D ( %E E (x(A,B,C,D,E))))))"))));
		
		fb.clear();
		
		fb.addOr();
			fb.addPredicate("c");
			fb.addSkolemConstant("\\C2");
			fb.addVariable("A");
			fb.endChildren();

			fb.addNot();
				fb.addPredicate("a");
				fb.addSkolemConstant("\\C0");
				fb.endChildren();
			fb.endChildren();

			fb.addNot();
				fb.addPredicate("b");
				fb.addSkolemConstant("\\C0");
				fb.endChildren();
			fb.endChildren();
		fb.endChildren();
		assert(fb.getFormula().equals(FormulaSet.toCNF(parseString("%E X Y Z ((a(X) & b(Y)) -> %A A (c(Z,A)))"))));
		assert(fb.getFormula().equals(FormulaSet.toCNF(parseString("%E X Y Z (%A A((a(X) & b(Y)) -> (c(Z,A))))"))));
	}
	
	
	public static void testQuantEquivCNF() {
		assert((FormulaSet.toCNF(parseString("%E X a(X)"))).equals(FormulaSet.toCNF(parseString("~ %A X ~a(X)"))));
		assert((FormulaSet.toCNF(parseString("~%E X a(X)"))).equals(FormulaSet.toCNF(parseString("%A X ~a(X)"))));
		assert((FormulaSet.toCNF(parseString("%E X ~a(X)"))).equals(FormulaSet.toCNF(parseString("~%A X a(X)"))));
		assert((FormulaSet.toCNF(parseString("~%E X ~a(X)"))).equals(FormulaSet.toCNF(parseString("%A X a(X)"))));
		assert((FormulaSet.toCNF(parseString("~%E X ( ~%A Y ~a(X,Y))"))).equals(FormulaSet.toCNF(parseString("%A X ( %A Y ~a(X,Y))"))));
	}

	/*
	 *  debugging prints
	 * */
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("%E X (a(X, Y) & b(Y,X,Z))")));
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("%E X (a(X)) & %E Y (b(Y,Z))")));
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("%E X (a(X)) & %E Y (b(Y))")));
//
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("%E X Y (a(X,Z) & b(Y))")));
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("%E Y (a(Y,Z) & b(Y))")));
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("%A X (%E Y (a(Y,X,U) & b(Y,X))) &  %E Y (b(Y,Z))")));
//	
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("%E Y ( %A X (a(X,Y)))")));
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("%E A ( %A B ( %E C ( %A D ( %E E (x(A,B,C,D,E))))))")));
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("((%A X (a(X))))-> %E Y (b(Y,X))")));
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("~%E Y ( %A X (A(X,Y)))")));
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("~%A X ( %E Y (A(X,Y)))")));
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("%A X ( ~%E Y (A(X,Y)))")));
//	System.out.println("CNF: "+FormulaSet.toCNF(parseString("%E X ( ~%E Y (A(X,Y)))")));

}

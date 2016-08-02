package alma;

import alma.util.TestBase;


public class PairTest extends TestBase  {

	//Makes sure that the fb builds the correct formula given an input
	public static void testListGenerationNested() {
		Formula f1 = parseString("a(1,[X,[Y,Z]],2)");
		FormulaBuilder fb = new FormulaBuilder();
		//a(1,[X,[Y,Z]],2)
		//a(1,(X.((Y.(Z.NULL)).NULL)),2)
		fb.addPredicate("a");
			fb.addTimeConst(1);
				fb.addPair();
					fb.addVariable("X");
					fb.addPair();
						fb.addPair();
							fb.addVariable("Y");
								fb.addPair();
									fb.addVariable("Z");
									fb.addNullConstant();
								fb.endChildren();
						fb.endChildren();
						fb.addNullConstant();
					fb.endChildren();
				fb.endChildren();		
				fb.addTimeConst(2);
		fb.endChildren();
		//System.out.println(f1);
		//System.out.println(fb.getFormula());
		assertTrue(f1.equals(fb.getFormula()));
	}
	
	
	public static void testListGenerationMixedOperator() {
		Formula f1 = parseString("a([X,[Y.Z]],2)");
		FormulaBuilder fb = new FormulaBuilder();
		fb.addPredicate("a");
				fb.addPair();
					fb.addVariable("X");
					fb.addPair();
						fb.addPair();
							fb.addVariable("Y");
							fb.addVariable("Z");
						fb.endChildren();
						fb.addNullConstant();
					fb.endChildren();
				fb.endChildren();		
				fb.addTimeConst(2);
		fb.endChildren();
		//System.out.println(f1);
		//System.out.println(fb.getFormula());
		assertTrue(f1.equals(fb.getFormula()));
	}
	
	public static void testListGenerationDot() {
		Formula f1 = parseString("a([[X.[Y.Z]].[7.5]],2)");
		FormulaBuilder fb = new FormulaBuilder();
		fb.addPredicate("a");
				fb.addPair();
					fb.addPair();//1
						fb.addVariable("X");//1
						fb.addPair();//2
							fb.addVariable("Y");//1
							fb.addVariable("Z");//2
						fb.endChildren();
					fb.endChildren();
					
					fb.addPair();//2
						fb.addTimeConst(7);
						fb.addTimeConst(5);
					fb.endChildren();
				fb.endChildren();
				fb.addTimeConst(2);
		fb.endChildren();
		//System.out.println(f1);
		//System.out.println(fb.getFormula());
		assertTrue(f1.equals(fb.getFormula()));
	}
	
	public static void testUnify() {
		SubstitutionList um = new SubstitutionList();
		
		Formula f1 = parseString("a([1,2,3])");
		Formula f2 = parseString("a([1.X])");
		assertTrue(f1.unify(f2, um));
		
		f1 = parseString("a([1,2,3])");
		f2 = parseString("a([1,X])");
		assertFalse(f1.unify(f2, um)); //should not unify [1,X] = (1 (X null) ) = (1.(X.null))
		//Not (1.X)
		
		f1 = parseString("a([1,[1,2],3])");
		f2 = parseString("a([1,X,3])");
		assertTrue(f1.unify(f2, um));	
	}


}

package alma;

import alma.util.TestBase;

public class MiscTest extends TestBase {

	//Sanity test. Does not prove CNF, but it checks one 
	//aspect of it.
	public static void testCNF1(){
		System.out.println("CNF1 test");
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
		
		System.out.println(basic);
		System.out.println(cnf);
		
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
	
	
	public static void testComplexNodeClone(){
		AndFormula af = new AndFormula();
		ComplexNode cn=null;
		try{
			cn = (ComplexNode) af.clone();
		} catch(CloneNotSupportedException e){
			fail("Clone should be supported");
		}
		
		assertTrue(cn instanceof AndFormula);
	}
}

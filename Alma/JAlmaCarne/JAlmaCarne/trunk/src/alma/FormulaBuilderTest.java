package alma;

import alma.util.TestBase;

public class FormulaBuilderTest extends TestBase {
	public static void testBuilderPop(){
		FormulaBuilder fb = new FormulaBuilder();
		fb.addPredicate("Knows");
			fb.addConstant("John");
			fb.addConstant("Kelly");
		
		Formula a = fb.getFormula();
		
			fb.addConstant("Jessie");
		Formula b = fb.getFormula();
		
			fb.pop();
		Formula c = fb.getFormula();
		
		assertTrue(a.equals(c));
		assertFalse(a.equals(b));
	}
}

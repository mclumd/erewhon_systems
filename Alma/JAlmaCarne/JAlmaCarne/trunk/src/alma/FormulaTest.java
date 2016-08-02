package alma;

import alma.util.TestBase;

public class FormulaTest extends TestBase {

	public static void testEquals(){
		Formula knowsJK = parseString("knows(john, kelly)");
		Formula knowsJK2 = parseString("knows(john, kelly)");

		assertEquals(knowsJK, knowsJK2);
		
		Formula knowsJJ = parseString("knows(john,john)");
		assertFalse(knowsJJ.equals(knowsJK));
	}
	
	public static void testSubstitution(){
		Formula knowsJK = parseString("knows(john,kelly)");
		Formula knowsxK = parseString("knows(X, kelly)");
		Formula knowsxS = parseString("knows(X,shannon)");
		
		SubstitutionList um = new SubstitutionList();
		
		//unifies knows(John, Kelly) and knows(x, Kelly)
		assertTrue(knowsJK.unify(knowsxK, um));
		
		//Applies x/John to knows(x, Shannon)
		Formula subs = knowsxS.applySubstitution(um);
		Formula knowsJS = parseString("knows(john,shannon)");

		assertTrue(subs.equals(knowsJS));
	}
	
	public static void testSubstitution2(){
		SubstitutionList um = new SubstitutionList();
		
		Formula rain1 = parseString("rain(X)");
		Formula rain2 = parseString("rain(today)");
		Formula wet = parseString("Wet(NextDay(X))");
		Formula wetAfterSubs = parseString("Wet(NextDay(today))");

		um.reset();
		assertTrue(rain1.unify(rain2, um));
		assertTrue(wet.applySubstitution(um).equals(wetAfterSubs));
	}
	
	public static void testAndFormula(){
		System.out.println("TestAndFormula");
		FormulaBuilder fb = new FormulaBuilder();
		fb.addAnd();
			fb.addOr();
				fb.addConstant("A");
				fb.addConstant("B");
				fb.addConstant("C");
				fb.endChildren();
			fb.addNot();
				fb.addConstant("D");
				fb.endChildren();
		
		Formula f = fb.getFormula();
		System.out.println(f);
	}

}

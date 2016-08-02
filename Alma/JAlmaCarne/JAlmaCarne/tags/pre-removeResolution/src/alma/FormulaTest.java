package alma;

public class FormulaTest extends TestBase {

	public static void testEquals(){
		Formula knowsJK = createPredicate("knows", "john", "kelly");
		Formula knowsJK2 = createPredicate("knows", "john", "kelly");

		assertTrue(knowsJK.equals(knowsJK2));
		
		Formula knowsJJ = createPredicate("knows", "john", "john");
		assertFalse(knowsJJ.equals(knowsJK));
	}
	
	public static void testSubstitution(){
		Formula knowsJK = createPredicate("knows", "john", "kelly");
		Formula knowsxK = createPredicate("knows", "X", "kelly");
		Formula knowsxS = createPredicate("knows", "X", "shannon");
		
		UnifiedMap um = new UnifiedMap();
		
		//unifies knows(John, Kelly) and knows(x, Kelly)
		assertTrue(knowsJK.unify(knowsxK, um));
		
		//Applies x/John to knows(x, Shannon)
		Formula subs = knowsxS.applySubstitution(um);
		Formula knowsJS = createPredicate("knows", "john", "shannon");

		assertTrue(subs.equals(knowsJS));
	}
	
	public static void testSubstitution2(){
		UnifiedMap um = new UnifiedMap();
		
		Formula rain1 = createPredicate("rain", "X");
		Formula rain2 = createPredicate("rain", "today");
		
		FormulaBuilder fb = new FormulaBuilder();
		fb.addPredicate("Wet");
			fb.addPredicate("NextDay");
				fb.addVariable("X");
		Formula wet = fb.getFormula();
		
		fb.clear();
		fb.addPredicate("Wet");
			fb.addPredicate("NextDay");
				fb.addConstant("today");
				
		Formula wetAfterSubs = fb.getFormula();

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

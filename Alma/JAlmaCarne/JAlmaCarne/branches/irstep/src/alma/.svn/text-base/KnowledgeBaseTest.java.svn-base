package alma;

public class KnowledgeBaseTest extends TestBase {
	public static void testAdd(){
		FormulaBuilder fb = new FormulaBuilder();
		fb.addAdd();
			fb.addAnd();
				fb.addConstant("1");
				fb.addConstant("2");
				fb.addConstant("3");
				
		Formula f = fb.getFormula();
		
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(f);
		
		fb.clear();
		fb.addAdd();
			fb.addOr();
				fb.addConstant("1");
				fb.addConstant("2");
				fb.addConstant("3");
				
		kb.add(fb.getFormula());
		
		kb.step();
		kb.step();
		
		assertTrue("kbsize:" + kb.size(), kb.size() == 2);
	}
	
	public static void testDelete(){
		FormulaBuilder fb = new FormulaBuilder();
		
		fb.addDelete();
			fb.addPredicate("a");
				fb.addConstant("a");
		Formula todelete = fb.getFormula();
		
		fb.clear();
		fb.addAdd();
			fb.addPredicate("a");
				fb.addConstant("a");

		Formula f = fb.getFormula();
		
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(f);
		kb.step();
		kb.step();
		
		assertTrue("AddFormula not working", kb.size()==1);
		
		kb.add(todelete);
		kb.step();
		kb.step();
		
		assertTrue("KB size should be zero", kb.size() == 0);
	}
	
	public static void testContains(){
		KnowledgeBase kb = new KnowledgeBase();
		FormulaBuilder fb = new FormulaBuilder();
		
		fb.addAdd();
			fb.addPredicate("a");
				fb.addConstant("john");
			fb.endChildren();
		fb.endChildren();
		
		kb.add(fb.getFormula());
		
		kb.step();
		kb.step();
		
		assertTrue(kb.contains(parseString("a(john)")));
	}
}

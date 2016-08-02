package alma;
import junit.framework.TestCase;
import java.util.*;

public class testAll extends TestCase {
	public static void addString(FormulaBuilder fb, String s){
		if(Character.isUpperCase(s.charAt(0))){
			fb.addVariable(s);
		} else fb.addConstant(s);
	}
	public static Formula createPredicate(String name, String x1){
		FormulaBuilder fb = new FormulaBuilder();
		fb.addPredicate(name);
			addString(fb, x1);
		return fb.getFormula();
	}
	public static Formula createPredicate(String name, String x1, String x2){
		FormulaBuilder fb = new FormulaBuilder();
		fb.addPredicate(name);
			addString(fb, x1);
			addString(fb, x2);
		return fb.getFormula();
	}
	public static Formula createPredicate(String name, String x1, String x2, String x3){
		FormulaBuilder fb = new FormulaBuilder();
		fb.addPredicate(name);
			addString(fb, x1);
			addString(fb, x2);
			addString(fb, x3);
		return fb.getFormula();
	}
	
	public static void testUnify(){
		UnifiedMap um = new UnifiedMap();
		
		Formula knows = createPredicate("knows", "john, kelly");
		Formula knows2 = createPredicate("knows", "X", "X");
		
		// Unify knows(John, Kelly) and knows(x, x)
		assertFalse(knows.unify(knows2, um));
		um.showAll();
		um.reset();
		
		assertFalse(knows2.unify(knows, um));
		um.showAll();
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
		assertTrue(m.get(a).equals(new Constant("john")));
		
		assertTrue(m.keySet().contains(b));
		assertTrue(m.get(b).equals(new Constant("kelly")));
		
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
		assertTrue(m.get(x).equals(new Constant("john")));
	}
	
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
		Formula cnf = Database.toCNF(basic);
		
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
		Formula cnf = Database.toCNF(basic);
		assertTrue(((ComplexNode)cnf.getHead()).getChildren().size() == 5);
	}
	
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
	
	public static void testAdd(){
		FormulaBuilder fb = new FormulaBuilder();
		fb.addAdd();
			fb.addAnd();
				fb.addConstant("1");
				fb.addConstant("2");
				fb.addConstant("3");
				
		Formula f = fb.getFormula();
		
		KnowledgeBase kb = new KnowledgeBase();
		kb.eval(f);
		
		fb.clear();
		fb.addAdd();
			fb.addOr();
				fb.addConstant("1");
				fb.addConstant("2");
				fb.addConstant("3");
				
		kb.eval(fb.getFormula());
		
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
		kb.eval(f);
		kb.step();
		
		assertTrue("AddFormula not working", kb.size()==1);
		
		kb.eval(todelete);
		kb.step();
		
		assertTrue("KB size should be zero", kb.size() == 0);
	}
}
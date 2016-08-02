package alma;

import alma.util.TestBase;

public class ContradictionRuleTest extends TestBase {
	public static void testSimpleContradiction(){
		MockKnowledgeBase mkb = new MockKnowledgeBase();
		ContradictionRule cr = new ContradictionRule(mkb);
		cr.add(parseString("wet(today)"));
		cr.add(parseString("~wet(today)"));
		cr.step();
		mkb.step();
		mkb.step();
		mkb.printHistory(System.out);
		
		assertTrue(mkb.contains(parseString("contra(wet(today), ~wet(today))")));
	}
	
	public static void testVariableContradiction(){
		MockKnowledgeBase mkb = new MockKnowledgeBase();
		ContradictionRule cr = new ContradictionRule(mkb);
		cr.add(parseString("wet(X)"));
		cr.add(parseString("~wet(Y)"));
		cr.step();
		mkb.step();
		
		assertTrue(mkb.contains(parseString("contra(wet(X), ~wet(Y))")));
	}
	
	public static void testVariableContradiction2(){
		MockKnowledgeBase mkb = new MockKnowledgeBase();
		ContradictionRule cr = new ContradictionRule(mkb);
		cr.add(parseString("wet(X)"));
		cr.add(parseString("~wety(Y)"));
		cr.add(parseString("~wet(Y,X)"));
		cr.step();
		mkb.step();
		
		assertFalse(mkb.contains(parseString("contra(wet(X), ~wety(Y))")));
		assertFalse(mkb.contains(parseString("contra(wet(X), ~wety(Y,X))")));
	}
}

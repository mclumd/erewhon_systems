package alma;

public class ContradictionRuleTest extends TestBase {
	public static void testSimpleContradiction(){
		MockKnowledgeBase mkb = new MockKnowledgeBase();
		ContradictionRule cr = new ContradictionRule(mkb);
		cr.add(parseString("wet(today)"));
		cr.add(parseString("~wet(today)"));
		cr.step();
		
		assertTrue(mkb.contains(parseString("contra(wet(today), ~wet(today))")));
	}
	
	public static void testVariableContradiction(){
		MockKnowledgeBase mkb = new MockKnowledgeBase();
		ContradictionRule cr = new ContradictionRule(mkb);
		cr.add(parseString("wet(X)"));
		cr.add(parseString("~wet(Y)"));
		cr.step();
		
		assertTrue(mkb.contains(parseString("contra(wet(X), ~wet(Y))")));
	}
}

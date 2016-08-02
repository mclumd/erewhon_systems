package alma;

import alma.util.TestBase;

public class ClockRuleTest extends TestBase {
	public static void testClockRule(){

		MockKnowledgeBase kb = new MockKnowledgeBase();

		ClockRule cr = new ClockRule(kb);		

		cr.step();
		kb.step();
		cr.step();
		kb.step();
		cr.step();
		kb.step();

		assertTrue(kb.contains(parseString("Now(4)")));
 		kb.printHistory(System.out);
		
		cr.step();
		kb.step();
		assertTrue(kb.contains(parseString("Now(5)")));
	}

}

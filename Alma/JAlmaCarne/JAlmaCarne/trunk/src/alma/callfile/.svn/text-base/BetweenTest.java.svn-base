package alma.callfile;

import alma.KnowledgeBase;
import alma.util.TestBase;

public class BetweenTest  extends TestBase{
	public static void testBetween() {
		KnowledgeBase kb = new KnowledgeBase();
		
		kb.loadCall("between", "alma.callfile.Between");
		kb.add(parseString("between(4,X,1202) -> cool(X)"));
		kb.step();
		kb.step();
		kb.step();

		assertTrue(kb.contains(parseString("cool(5)")));
		assertFalse(kb.contains(parseString("cool(3)")));
	}
}

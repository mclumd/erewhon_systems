package alma.callfile;

import alma.KnowledgeBase;
import alma.util.TestBase;

public class UniqueIDTest  extends TestBase{
	public static void testUniqueID() {
		KnowledgeBase kb = new KnowledgeBase();
		
		kb.loadCall("UniqueID", "alma.callfile.UniqueID");

		kb.add(parseString("UniqueID(X) -> cool(X)"));
		kb.step();
		kb.step();
		kb.step();
//		assertTrue(kb.contains(parseString("cool(0)")));
//		assertFalse(kb.contains(parseString("cool(1)")));

		kb.add(parseString("UniqueID(Y) -> cool(Y)"));
		kb.step();
		kb.step();
		kb.step();
//		assertTrue(kb.contains(parseString("cool(1)")));
//		assertFalse(kb.contains(parseString("cool(2)")));

	}
}

package alma;

import java.util.*;
import alma.callfile.*;
public class PositiveIntrospectionTest extends TestBase {
	public static void testBoundBound(){
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("+a(X) -> b(X)."));
		kb.add(parseString("+a(4)."));
		kb.step();
		kb.step();
		kb.step();
		
		Iterator<FormulaNode> iter = PositiveIntrospection.findAnswer(((Predicate)(parseString("pos_int(3,\"a(4)\")").getHead())), kb.history);
		assertTrue(iter.hasNext());
		iter = PositiveIntrospection.findAnswer(((Predicate)(parseString("pos_int(1,\"a(4)\")").getHead())), kb.history);
		assertFalse(iter.hasNext());
	}
}
	
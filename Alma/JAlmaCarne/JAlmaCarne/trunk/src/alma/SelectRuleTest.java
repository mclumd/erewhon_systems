package alma;

import alma.util.TestBase;

public class SelectRuleTest extends TestBase{
	public static void testSimpleSelect() {
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("a(3)"));
		kb.add(parseString("a(4)"));
		kb.add(parseString("b(5)"));
		kb.step();kb.step();
		kb.add(parseString("#{ans(X)}[2]a(X)."));
		kb.step();kb.step();
		assertTrue(kb.contains(parseString("ans(3)")));
		assertTrue(kb.contains(parseString("ans(4)")));
	}
	
	public static void testSimpleSelect2() {
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("a(3)"));
		kb.add(parseString("a(4)"));
		kb.add(parseString("b(5)"));
		kb.step();kb.step();
		kb.add(parseString("#{ans(X)}[4]a(X)."));
		kb.step();kb.step();
		assertTrue(kb.contains(parseString("ans(3)")));
		assertTrue(kb.contains(parseString("ans(4)")));
		assertTrue(kb.size()==5);
	}
	
	public static void testSimpleSelect3() {
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("a(3,7)"));
		kb.add(parseString("a(4,X)"));
		kb.add(parseString("b(5)"));
		kb.step();kb.step();
		kb.add(parseString("#{ans(X,Y)}Y[4]a(X,Y)."));
		kb.step();kb.step();
		assertFalse(kb.contains(parseString("ans(3,7)")));
		assertTrue(kb.contains(parseString("ans(4,Y)")));
	}
	
	public static void testCallSelect() {
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("a(X)"));
		kb.add(parseString("a(\"a\")"));
		kb.add(parseString("b(5)"));
		kb.step();kb.step();
		kb.add(parseString("#{ans(\"a\",X,\"ab\")}[1]combine(\"a\",X,\"ab\")."));
		kb.step();kb.step();
		assertTrue(kb.contains(parseString("ans(\"a\",\"b\",\"ab\")")));
	}
	
	public static void testInfSelect() {
		KnowledgeBase kb = new KnowledgeBase();
		kb.add(parseString("a(2)"));
		kb.add(parseString("a(5)"));
		kb.step();kb.step();
		kb.add(parseString("#{ans(X)}[]a(X)."));
		kb.step();kb.step();
		kb.printHistory(System.out);
		assertTrue(kb.contains(parseString("ans(2)")));

		assertTrue(kb.contains(parseString("ans(5)")));
		
	}
}

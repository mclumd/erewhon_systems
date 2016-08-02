package alma;

import alma.util.*;
import java.util.*;

public class GoalInferenceTest extends TestBase{
	private static class SimpleIterator<T> implements BiIterator<T>{
		ListIterator<T> elements;
		
		public SimpleIterator(List<T> al){
			elements = al.listIterator();
		}
		
		public boolean hasPrevious() {
			return elements.hasPrevious();
		}

		public T previous() {
			return elements.previous();
		}

		public boolean hasNext() {
			return elements.hasNext();
		}

		public T next() {
			return elements.next();
		}

		public void remove() {
			elements.remove();
		}
	}
	
	private static OrFormula toOr(FormulaNode p){
		FormulaBuilder fb = new FormulaBuilder();
		fb.addOr();
			fb.add(p);
		fb.endChildren();
		return (OrFormula)fb.getFormulaNode();
	}
	
	/**
	 * Resolver is a package-private helper-class for GoalInferenceRule. It iterates
	 * over all resolvents. These following tests are "fragile" and are dependant on the
	 * current implementation of Resolver. TODO: make these tests less fragile.
	 *
	 */
	public static void testResolver1(){
		OrFormula f1 = (OrFormula)parse("~b(X) | a(X)");
		OrFormula f2 = toOr(parse("b(1)"));
		GoalInferenceRule.Resolver r = new GoalInferenceRule.Resolver(f1, f2);
		assertTrue(r.next.equals(toOr(parse("a(1)"))));
	}
	
	public static void testResolver2(){
		OrFormula f1 = (OrFormula)parse("~b(X) | a(X) | ~b(Y) | c(Y)");
		OrFormula f2 = toOr(parse("b(1)"));
		GoalInferenceRule.Resolver r = new GoalInferenceRule.Resolver(f1, f2);
		assertTrue(r.next.equals(parse("a(1) | ~b(Y) | c(Y)")));
		r.next();
		assertTrue(r.next.equals(parse("~b(X) | a(X) | c(1)")));
		r.next();
		assertFalse(r.hasNext());
	}
	
	public static void testResolver3(){
		OrFormula f1 = (OrFormula)parseString("~b(X) | a(X) ").getHead();
		OrFormula f2 = (OrFormula)parseString("b(1) | ~a(2)").getHead();
		GoalInferenceRule.Resolver r = new GoalInferenceRule.Resolver(f1, f2);
		assertTrue(r.next.equals((parseString("a(1)|~a(2)").getHead())));
		r.next();
		assertTrue(r.next.equals((parseString("~b(2) | b(1)").getHead())));
		r.next();
		assertFalse(r.hasNext());
	}

	private static <T> ArrayList<T> generateAnswers(Iterator<T> i){
		ArrayList<T> toReturn = new ArrayList<T>();
		while(i.hasNext()){
			toReturn.add(i.next());
		}
		return toReturn;
	}
	
	public static void testMassResolver1(){
		OrFormula[] a = new OrFormula[2];
		a[0] = (OrFormula) parse("a(X) | b(X) | a(Y)");
		a[1] = (OrFormula) parse("a(X) | c(X) | a(Y)");

		OrFormula f1 = toOr(parse("~a(1)"));
		
		GoalInferenceRule.MassResolver r = new GoalInferenceRule.MassResolver(f1, new SimpleIterator<OrFormula>(Arrays.asList(a)));
		ArrayList<OrFormula> answers = generateAnswers(r);
		
		assertTrue(answers.contains(parse("b(1) | a(Y)")));
		assertTrue(answers.contains(parse("c(1) | a(Y)")));
		assertTrue(answers.contains(parse("a(X) | b(X)")));
		assertTrue(answers.contains(parse("a(X) | c(X)")));
	}
	
	public static void testOrIterator1(){
		AndFormula test = (AndFormula) parse(" (a(X) | b(X)) & (c(X)) & (~d(X))");
		BiIterator<FormulaNode> iter = new SingleIterator<FormulaNode> (test);
		GoalInferenceRule.OrIterator i = new GoalInferenceRule.OrIterator(iter);
		ArrayList<OrFormula> answers = generateAnswers(i);
		
		assertTrue(answers.contains(parse("(a(X) | b(X))")));
		
		/*
		 * Explanation: we don't want the answer to be a Predicate or NotFormula... the returned
		 * answer must be an OrFormula
		 */
		assertFalse(answers.contains(parse("c(X)")));
		assertFalse(answers.contains(parse("~d(X)")));
		
		assertTrue(answers.contains(toOr(parse("c(X)"))));
		assertTrue(answers.contains(toOr(parse("~d(X)"))));
	}
	
	/**
	 * ModusPonens for Stepper. Assume in Clausal form already
	 */
	public static void testModusPonensStepper(){
		FormulaNode[] b = new FormulaNode[2];
		b[0] = parseString("~b(X) | a(X)").getHead();
		b[1] = parseString("b(1)").getHead();

		InjectedKnowledgeBase kb = new InjectedKnowledgeBase();
		GoalInferenceRule gir = new GoalInferenceRule(kb);
		
		FormulaNode[] a = new FormulaNode[1];
		a[0] = b[0];
		
		kb.addIR(gir);
		kb.addCandidate(parse("b(X)"), new SimpleIterator<FormulaNode>(Arrays.asList(b)));
		kb.addCandidate(parse("a(X)"), new SimpleIterator<FormulaNode>(Arrays.asList(a)));
		
		GoalInferenceRule.Stepper s = new GoalInferenceRule.Stepper((GoalCommand)parse("?{ans(X)}[1] a(X) ."), kb);
		
		for(int i=0; i<1000; i++)
			s.step();

		kb.step();
		assertTrue(kb.contains(parseString("ans(1)")));
	}
	
	/**
	 * ModusPonens for the whole class
	 */
	
	public static void testModusPonens(){
		FormulaNode[] b = new FormulaNode[2];
		b[0] = parseString("~b(X) | a(X)").getHead();
		b[1] = parseString("b(1)").getHead();

		InjectedKnowledgeBase kb = new InjectedKnowledgeBase();
		GoalInferenceRule gir = new GoalInferenceRule(kb);
		
		FormulaNode[] a = new FormulaNode[1];
		a[0] = b[0];
		
		kb.addIR(gir);
		kb.addCandidate(parse("b(X)"), new SimpleIterator<FormulaNode>(Arrays.asList(b)));
		kb.addCandidate(parse("a(X)"), new SimpleIterator<FormulaNode>(Arrays.asList(a)));
		
		gir.add(parseString("?{ans(X)}[1] a(X) ."));
		gir.step();

		kb.step();
		assertTrue(kb.contains(parseString("ans(1)")));
	}

	/**
	 * Test an Or return value.
	 * b(X) -> a(X)
	 * ~a(1)
	 * 
	 * Therefore: ~b(1).
	 */
	public static void testModusTollens(){
		FormulaNode[] b = new FormulaNode[1];
		b[0] = parseString("~b(X) | a(X)").getHead();

		InjectedKnowledgeBase kb = new InjectedKnowledgeBase();
		GoalInferenceRule gir = new GoalInferenceRule(kb);
		
		FormulaNode[] a = new FormulaNode[2];
		a[0] = b[0];
		a[1] = parse("~a(1)");
		
		kb.addIR(gir);
		kb.addCandidate(parse("b(X)"), new SimpleIterator<FormulaNode>(Arrays.asList(b)));
		kb.addCandidate(parse("a(X)"), new SimpleIterator<FormulaNode>(Arrays.asList(a)));
		
		gir.add(parseString("?{ans(X)}[1] ~b(X) ."));
		gir.step();

		kb.step();
		assertTrue(kb.contains(parseString("ans(1)")));
	}
	
}
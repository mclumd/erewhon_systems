package alma;

import java.util.*;

/**
 * Builder Pattern for Formulas. Formulas are represented
 * by trees with an arbitrary number of children, 
 * and thus this FormulaBuilder is based on building
 * the tree by adding nodes in prefix order, as well as
 * marks to note that there are no more children
 * or that the last node has no children.
 * 
 * @author Percival Tiglao
 */

public class FormulaBuilder {
	ComplexNode dummyhead;
	ComplexNode current;
	Stack<ComplexNode> buildStack = new Stack<ComplexNode>();
	
	public FormulaBuilder(){
		clear();
	}
	
	//Some private helpers
	private void addHelper(ComplexNode cn){
		current.getChildren().add(cn);
		buildStack.push(cn);
		current = cn;
	}
	
	private void addHelper(FormulaNode fn){
		current.getChildren().add(fn);
	}
	
	/**
	 * Does <b>not</b> clone fn when added to Formula
	 * @param fn
	 */
	public void add(FormulaNode fn){
		addHelper(fn);
	}
	
	//Semi-clones the formulaNode. Only preserves its type
	public void addType(ComplexNode fn){
		if(fn instanceof AndFormula){
			addAnd();
		} else if (fn instanceof IfFormula) {
			addIf();
		} else if (fn instanceof IfNewFormula){
			addIfNew();
		} else if (fn instanceof NotFormula){
			addNot();
		} else if (fn instanceof OrFormula){
			addOr();
		} else if (fn instanceof Predicate){
			addPredicate(((Predicate)fn).getName());
		}
	}
	
	public void clear(){
		//dummyhead doesn't matter
		dummyhead = new Predicate("Dummy");
		current = dummyhead;
	}

	public void endChildren(){
		buildStack.pop();
		if(!buildStack.empty()){
			current = buildStack.peek();
		}
	}
	
	public void addIf(){
		addHelper(new IfFormula());
	}
	
	public void addIfNew(){
		addHelper(new IfNewFormula());
	}
	
	public void addAnd(){
		addHelper(new AndFormula());
	}
	
	public void addOr(){
		addHelper(new OrFormula());
	}
	
	public void addNot(){
		addHelper(new NotFormula());
	}
	
	public void addAdd(){
		addHelper(new AddCommand());
	}
	
	public void addDelete(){
		addHelper(new DeleteCommand());
	}
	
	public void addDistrust(){
		addHelper(new DistrustCommand());
	}
	
	/**
	 * Adds a Predicate. Note, internally, the "name"
	 * of the predicate is actually a constant stored
	 * in the children list
	 * @param name
	 */
	public void addPredicate(String name){
		addHelper(new Predicate(name));
	}

	public void addConstant(String name){
		addHelper(new Constant(name));
	}
	public void addVariable(String name){
		addHelper(new Variable(name));
	}
	
	public Formula getFormula(){
		Formula f = new Formula(dummyhead.getChildren().get(1));
		return f;
	}
	
	/**
	 * Removes the last element added to the builder
	 */
	public void pop(){
		current.getChildren().remove(current.getChildren().size()-1);
	}
	
	public FormulaNode getFormulaNode(){
		return getFormula().getHead();
	}
	
}
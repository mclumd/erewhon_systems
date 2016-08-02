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
	
	/**
	 * Temporary builder for lists
	 * @author joey
	 *
	 */
	private class ListNode extends ComplexNode{
		public ListNode() {
		}
		public String toString() {
			String ans = "{";
			for(FormulaNode child: getChildren())
				ans = ans + child.toString();
			return ans+"}";
		}
	}
	
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
	
	/**
	 * Adds the formula that is being built to this builder
	 * @param fb
	 */
	public void add(FormulaBuilder fb){
		add(fb.getFormulaNode());
	}
	
	//Semi-clones the formulaNode. Only preserves its type
	public void addType(ComplexNode fn){
		if(fn instanceof AndFormula){
			addAnd();
		} else if (fn instanceof IfFormula) {
			addIf();
		} else if (fn instanceof NotFormula){
			addNot();
		} else if (fn instanceof OrFormula){
			addOr();
		} else if (fn instanceof Predicate){
			addPredicate(((Predicate)fn).getName());
			pop();
		}
	}
	
	public void clear(){
		//dummyhead doesn't matter
		dummyhead = new Predicate("Dummy");
		current = dummyhead;
	}

	public void finishList() {
		if(current.getChildren().size()>=2) {
			FormulaNode pr = createPair(current.getChildren(),false);
			ComplexNode node = buildStack.pop();
			
			if(!buildStack.empty())  {
				current = buildStack.peek();
				current.getChildren().set(current.getChildren().indexOf(node),pr);
			}
		}
		
	}
	
	public void endChildren(){
		if(current instanceof ListNode) {
				//Collections.reverse(current.getChildren());
				FormulaNode pr = createPair(current.getChildren(), true);
				ComplexNode node =buildStack.pop();
			
				if(!buildStack.empty())  {
					current = buildStack.peek();
					current.getChildren().set(current.getChildren().indexOf(node),pr);
				}
		}
		else {
			if(buildStack.isEmpty())
				System.out.println("AHHHHH the ATMOSPHERE");
			//assert !buildStack.isEmpty(): "endChildren must be called after calling an add with a complex node";
			buildStack.pop();
			if(!buildStack.empty()){
			current = buildStack.peek();
			}
		}
	}
	
	public FormulaNode createPair(List<FormulaNode> nodes, boolean recur) {
		Pair answer = new Pair();
			if(nodes.isEmpty()) {
				return new NullConstant();
			}
			answer.getChildren().add(nodes.remove(0));
			if(recur)
				answer.getChildren().add(createPair(nodes,recur));
			else if(!nodes.isEmpty())
				answer.getChildren().add(nodes.remove(0));
		return answer;
	}
	
	public void addIf(){
		addHelper(new IfFormula());
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
	
	public void addNegationByFailure(){
		addHelper(new NegationByFailureFormula());
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
	
	public void addTimeConst(int time){
		addHelper(new TimeConstant(time));
	}
	
	public void addStringConst(String s){
		addHelper(new StringConstant(s));
	}
	
	public void addSelectCommand(int hits, String ans, ArrayList<Variable> vars ){
		addHelper(new SelectCommand(ans, vars, hits));
	}
	
	public void addGoalCommand(int hits, String ans, ArrayList<Variable> vars){
		addHelper(new GoalCommand(ans, vars, hits));
	}
	
	public void addNow(int time){
		addPredicate("now");
		addTimeConst(time);
	}
	
	public void addSpecificDelete(int id){
		addHelper(new SpecificDeleteCommand(id));
	}
	
	public void addList() {
		addHelper(new ListNode());
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
		addHelper(new SymbolicConstant(name));
	}
	public void addNullConstant() {
		addHelper(new NullConstant());
	}
	
	public void addVariable(String name){
		addHelper(new Variable(name));
	}
	public void addPair() {
		addHelper(new Pair());
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
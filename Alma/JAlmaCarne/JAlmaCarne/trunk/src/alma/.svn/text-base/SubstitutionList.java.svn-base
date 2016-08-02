package alma;
import java.util.*;
import alma.util.IntegerWrapper;


public class SubstitutionList implements Cloneable {
	
	private HashMap<Variable, FormulaNode> bindings = new HashMap<Variable, FormulaNode>();
	
	public SubstitutionList(){	
	}
	
	public SubstitutionList clone(){
		try {
			SubstitutionList sl = (SubstitutionList) super.clone();
			sl.bindings = (HashMap) bindings.clone();
			return sl;
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
			System.exit(1);
		}
		return null;
	}
	
	/**
	 * Adds a bounded variable to the list.
	 * @param v - the bounded variable to be added to the list.
	 * @return true if the add succeeds, false otherwise
	 */
	public boolean addVar(Variable v, FormulaNode t){
		return (bindings.put(v,t) != null);
	}

	/**
	 * Removes a bounded variable from the list.
	 * HashMap uses key as index, but we only have value (myBinding)
	 * @param myBinding - the value to be removed from the list.
	 * @return true if the remove succeeds, false otherwise
	 */
	public void removeVarByValue(FormulaNode myBinding){
		bindings.values().remove(myBinding);
		// not correct, corresponding key needs to be removed using iterator! reverse lookup or save somewhere!
		// does it require walk in practice for GMP?

		
		//return (bindings.remove(key) != null);			if we were to remove by key
		
	}

	/**
	 * Returns true if there are no variables bounded, false otherwise.
	 * @return true if there are no variables bounded, false otherwise.
	 */
	public boolean isEmpty(){
		return bindings.isEmpty();
	}
	
	/**
	 * Resets the bindings of every variable in the list to null so that the
	 * variables can be reused.
	 * @return true if the reset succeeds, false otherwise.
	 */
	public void reset(){
		bindings.clear();
	}
	
	/*
	 * Returns the "last" substitution in the chain of subs. Either a fresh variable
	 * or a constant/predicate/etc. etc. Technically only works on variables, but
	 * returns the parameter if it is not a variable
	 */
	public FormulaNode walk(FormulaNode v){
		FormulaNode fn = v;
		while(bindings.containsKey(fn)){
			fn = bindings.get(fn);
			if (fn instanceof ComplexNode){
				return complexWalk((ComplexNode) fn);
			}
		}
		
		return fn;
	}
	
	/**
	 * Lolz. Tis function is doubly recursive. OMFG wtf?!??!
	 * @param cn
	 * @return
	 */

	private FormulaNode complexWalk(ComplexNode cn){
		FormulaBuilder fb = new FormulaBuilder();
		fb.addType(cn);
			for(FormulaNode fn: cn.getChildren()){
				if(fn instanceof ComplexNode){
					fb.add(complexWalk((ComplexNode) fn));
				} else {
					fb.add(walk(fn));
				}
			}
		fb.endChildren();
		return fb.getFormulaNode();
	}
	
	/**
	 * True if you can walk the FormulaNode. False otherwise.
	 */
	public boolean isBound(FormulaNode fn){
		return bindings.keySet().contains(fn);
	}

	/**
	 * If the FormulaNode is unified, it will be removed from list.
	 */
//	public void remove(FormulaNode fn){									// may require walk ?
//		if ( bindings.keySet().contains(fn) )
//			bindings.remove(fn);
//	}
	
	/**
	 * 
	 * @param f1
	 * @param f2
	 * @return true on sucessful unification. False otherwise
	 * This list is cleared.
	 */
	
	@SuppressWarnings("deprecation")
	public boolean unify(FormulaNode f1, FormulaNode f2){
		return f1.unify(standardizeApart(f1, f2), this);
	}
	/**
	 * Prints out the list of the most recent bounded variables.
	 *
	 */
	public void showAll(){
		for(Variable v : bindings.keySet()){
			System.out.print(v + " bound to " + bindings.get(v) + "\n");
		}
	}
	
	@Override
	public String toString(){
		return bindings.toString();
	}
	
	/**
	 * Standardizes apart two Formulas so that repeated variables are changed
	 * i.e. unifying these two sentences:
	 * friend(X,joe) friend(bob,X)   
	 * would fail because X is shared between them, however, if everyone is joe's friend, 
	 * and bob is everyone's friend, then bob and joe should be friends, yielding friend(bob,joe).
	 * This is done by changing the second X (or the first) into a distinct variable name. so X1
	 * now friend(X,joe) friend(bob,X1) will unify  
	 * 
	 * @return the new "num" value to ensure a unique name for each variable
	 */
	
	private static int findVars(FormulaNode node, SubstitutionList list, int num) {
		if(node instanceof Variable && ! list.isBound(node)) {
			Variable var = (Variable)node;
			list.addVar(var,new Variable(var.toString()+num));
			num += 1;
		} 
		else if(node instanceof ComplexNode) {
			ComplexNode c = (ComplexNode)node;
			for(FormulaNode f : c.getChildren())  {
				num = findVars(f,list,num);
			}
		}
		
		return num;
	}
	
	/**
	 * Returns a clone of f2 where all the variables in f2 are standardized
	 * apart from f1.
	 * 
	 * Percy here: I don't know if this is the best place for this function...
	 * @param f1
	 * @param f2
	 * @return
	 */
	public static FormulaNode standardizeApart(FormulaNode a,FormulaNode b) {
		SubstitutionList sl = new SubstitutionList();
		findVars(a,sl, 0);
		return b.applySubstitution(sl);
	}

	public boolean isAllVars() {
		for(FormulaNode fn: bindings.values()){
			if(! (fn instanceof Variable))
				return false;
		}
		return true;
	}
}


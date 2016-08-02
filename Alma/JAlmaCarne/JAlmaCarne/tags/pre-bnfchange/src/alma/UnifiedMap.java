package alma;
import java.util.*;

public class UnifiedMap {
	
	private HashMap<Variable, FormulaNode> bindings;
	
	public UnifiedMap(){
		bindings = new HashMap();		
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
	public boolean reset(){
		bindings.clear();
		return true;
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
		}
		
		return fn;
	}
	
	/**
	 * True if you can walk the FormulaNode. False otherwise.
	 */
	public boolean isBound(FormulaNode fn){
		return bindings.keySet().contains(fn);
	}
	
	/**
	 * 
	 * @param f1
	 * @param f2
	 * @return true on sucessful unification. False otherwise
	 * This list is cleared.
	 */
	
	public boolean unify(FormulaNode f1, FormulaNode f2){
		return f1.unify(f2, this);
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
	
	/* Debugging routines
	 * 
	 */
	
	public Map<Variable, FormulaNode> debugGetMap(){
		return bindings;
	}
}


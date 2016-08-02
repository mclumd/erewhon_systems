package alma;
import java.util.*;

public class SubstitutionList implements Cloneable {
	
	private HashMap<Variable, FormulaNode> bindings;
	
	public SubstitutionList(){
		bindings = new HashMap();		
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
	
	@Override
	public String toString(){
		return bindings.toString();
	}
}


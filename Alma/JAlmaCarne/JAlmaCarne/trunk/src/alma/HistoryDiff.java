package alma;

import java.util.*;

/**
 * Either you added or removed some Formula from the kb
 *  
 * @author joey
 *
 */
class Operation {
	public Formula val;
	Operation(Formula nv) {
		val = nv;
	}
	
	public String toString() {
		return "OP("+val.toString()+")";
	}
}

class AddOperation extends Operation {
	AddOperation(Formula nv) {
		super(nv);
	}
	public String toString() {
		return "ADD("+val.toString()+")";
	}
}

class SubOperation extends Operation {
	SubOperation(Formula nv) {
		super(nv);
	}
	public String toString() {
		return "SUB("+val.toString()+")";
	}
}

/**  
 * This class allows us to only store changes between one step and another, while this requires
 * n time to figure out what was in the kb at some particular time, it reduces memory usage from
 * O(n*m) where n is the number of steps and m is the amount of data at each step to 
 * O(n*c) where n is the number of steps and c is the number of changes at each step.  
 * The only case where the new data structure uses more memory is where there are more than n/2
 * deletions, otherwise this structure is far superior.   Note that operations such as print are
 * really unaffected as you would have to fully iterate over the structure either way.
 * @author joey
 *
 */
public class HistoryDiff implements Iterable<Operation[]>{
	LinkedList<Operation[]> history;
	Stack<Operation> build;
	
	public HistoryDiff(){
		history = new LinkedList<Operation[]>();
		build = new Stack<Operation>();
	}
	
	public void addStep(){
		Operation[] f = new Operation[build.size()];
		f = build.toArray(f);

		history.add(f);
		
		build.clear();
	}
	
	public void addAdd(Formula f) {
		build.push(new AddOperation(f));
	}
	
	public void addSub(Formula f) {
		build.push(new SubOperation(f));
	}
	
	public int stepNumber(){
		return history.size();
	}

	public Iterator<Operation[]> iterator() {
		return history.iterator();
	}
}
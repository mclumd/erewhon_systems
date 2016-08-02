package alma;

import java.util.*;

public class History implements Iterable<Set<Formula>>{
	LinkedList<Set<Formula>> history;
	
	public History(){
		history = new LinkedList();
	}
	
	public void addStep(Set<Formula> current){
		history.add(current);
	}
	
	public int stepNumber(){
		return history.size();
	}

	public Iterator<Set<Formula>> iterator() {
		return history.iterator();
	}
}

package alma;

import java.util.*;

public class History implements Iterable<Collection<Formula>>{
	LinkedList<Collection<Formula>> history;
	
	public History(){
		history = new LinkedList<Collection<Formula>>();
	}
	
	public void addStep(Collection<Formula> current){
		history.add(current);
	}
	
	public int stepNumber(){
		return history.size();
	}

	public Iterator<Collection<Formula>> iterator() {
		return history.iterator();
	}
}

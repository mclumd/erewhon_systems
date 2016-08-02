package alma;

import java.util.*;

public class History implements Iterable<List<Formula>>{
	LinkedList<List<Formula>> history;
	
	public History(){
		history = new LinkedList<List<Formula>>();
	}
	
	public void addStep(List<Formula> current){
		history.add(current);
	}
	
	public int stepNumber(){
		return history.size();
	}

	public Iterator<List<Formula>> iterator() {
		return history.iterator();
	}
}

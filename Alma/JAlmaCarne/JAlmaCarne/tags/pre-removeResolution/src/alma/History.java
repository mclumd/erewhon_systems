package alma;

import java.util.*;

public class History implements Iterable<Set<FormulaNode>>{
	LinkedList<Set<FormulaNode>> history;
	
	public History(){
		history = new LinkedList();
	}
	
	public void addStep(Set<FormulaNode> current){
		history.add(current);
	}
	
	public int stepNumber(){
		return history.size();
	}

	public Iterator<Set<FormulaNode>> iterator() {
		return history.iterator();
	}
}

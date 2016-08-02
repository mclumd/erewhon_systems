package alma;

import java.util.*;

public class History implements Iterable<Map<FormulaNode,FormulaNode>>{
	LinkedList<Map<FormulaNode,FormulaNode>> history;
	
	public History(){
		history = new LinkedList();
	}
	
	public void addStep(Map<FormulaNode,FormulaNode> current){
		history.add(current);
	}
	
	public int stepNumber(){
		return history.size();
	}

	public Iterator<Map<FormulaNode,FormulaNode>> iterator() {
		return history.iterator();
	}
}

package alma;

import java.util.*;

public class ExistentialFormulaNode extends ComplexNode {
	ArrayList<Variable> vars = new ArrayList<Variable>();
	
	ExistentialFormulaNode(){
	}
	
	ExistentialFormulaNode(ArrayList<Variable> newvars){
		vars = new ArrayList<Variable>(newvars);
	}
	
	public FormulaNode getFormula(){
		return children.get(0);
	}
	
	public ArrayList<Variable> getVariables() {
		return vars;
	}
	
	public String toString(){
		assert(children.size() == 1);
		return "%E" + vars+ "(" + children.get(0) + ")";
	}
}

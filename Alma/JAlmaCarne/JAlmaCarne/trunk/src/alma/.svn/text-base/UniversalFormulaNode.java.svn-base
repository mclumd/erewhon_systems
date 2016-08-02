package alma;

import java.util.*;

public class UniversalFormulaNode extends ComplexNode {
	ArrayList<Variable> vars = new ArrayList<Variable>();
	
	UniversalFormulaNode(){
	}
	
	UniversalFormulaNode(ArrayList<Variable> newvars){
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
		return "%A" + vars+ "(" + children.get(0) + ")";
	}
}
package alma;

public class IfFormula extends ComplexNode {
	IfFormula(){
	}
	
	IfFormula(FormulaNode a, FormulaNode b){
		super(a,b);
	}
	
	public FormulaNode getLeft(){
		return children.get(0);
	}
	public FormulaNode getRight(){
		return children.get(1);
	}
	
	public String toString(){
		assert(children.size() == 2);
		return "(" + children.get(0) + "->" + children.get(1) + ")";
	}
}
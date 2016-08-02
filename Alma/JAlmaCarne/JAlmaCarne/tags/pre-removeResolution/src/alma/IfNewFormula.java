package alma;

public class IfNewFormula extends ComplexNode{
	IfNewFormula(){
	}
		
	IfNewFormula(FormulaNode a, FormulaNode b){
		super(a,b);
	}
	public String toString(){
		assert(children.size() == 2);
		return "(" + children.get(0) + "->" + children.get(1) + ")";
	}
}
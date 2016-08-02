package alma;

public class NotFormula extends ComplexNode {
	NotFormula(){
	}
	
	NotFormula(FormulaNode operand){
		children.add(operand);
	}
	
	
	public FormulaNode getChild(){
		return children.get(0);
	}
	
	public String toString(){
		assert(children.size() == 1);
		return "~(" + children.get(0) + ")";
	}
}

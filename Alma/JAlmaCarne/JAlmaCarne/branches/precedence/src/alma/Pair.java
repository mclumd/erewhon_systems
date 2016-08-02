package alma;

public class Pair extends ComplexNode {
	public FormulaNode head() {
		if(getChildren().size()==2) 
			return getChildren().get(0);
		else
			throw new IllegalArgumentException("This pair does not have two arguments");
	}
	public FormulaNode tail() {
		if(getChildren().size()==2) 
			return getChildren().get(1);
		else
			throw new IllegalArgumentException("This pair does not have two arguments");
	}
	public FormulaNode car() {
		return head();
	}
	public FormulaNode cdr() {
		return tail();	
	}
	public String toString() {
		String ans = "";
		if(getChildren().size()==2) {
			return "("+getChildren().get(0)+"."+getChildren().get(1)+")";
		}
		else 
			return "BAH["+ getChildren()+"]";
	}
}

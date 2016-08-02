package alma;

public class Formula {
	private FormulaNode head;
	
	public Formula(FormulaNode h){
		try {
			head = (FormulaNode) h.clone();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
	
	//public boolean isAddFormula(){
	//	return false ;//head.getOperator() == FormulaNode.ADD;
	//}
	
	public FormulaNode getHead(){
		return head;
	}
	
	public boolean unify(Formula f, UnifiedMap um){
		return f.head.unify(this.head, um);
	}
	
	public Formula applySubstitution(UnifiedMap um){
		Formula toReturn = new Formula(head.applySubstitution(um));
		return toReturn;
	}
	
	public boolean equals(Object o){
		if(o instanceof Formula){
			return ((Formula)o).head.equals(this.head);
		} return false;
	}
	
	public String toString(){
		return head.toString();
	}
}
package alma;

public class Formula {
	private FormulaNode head;
	private final int id;
	private static int idgenerator=0;
	
	public Formula(FormulaNode h, int id){
		try {
			head = (FormulaNode) h.clone();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
			System.exit(1);
		}
		this.id = id;
	}
	
	public Formula(FormulaNode h){
		this(h, idgenerator);
		idgenerator++;
	}
		
	public FormulaNode getHead(){
		return head;
	}
	
	public int getID(){
		return id;
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
	public int hashCode(){
		return head.hashCode();
	}
}
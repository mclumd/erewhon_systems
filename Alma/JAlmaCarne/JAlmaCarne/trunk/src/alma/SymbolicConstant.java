package alma;

public class SymbolicConstant extends Constant {
	private String name;
	private boolean skolem = false;
	
	public SymbolicConstant(String name){
		this.name = name;
		skolem = false;
	}
	
	public SymbolicConstant(String name, boolean skolem){
		this.name = name;
		this.skolem = skolem;
	}
	
	public String getName(){
		return name;
	}
	
	//public Object clone() throws CloneNotSupportedException
	//Superclass default handles the case. Strings are immutible

	@Override
	public boolean equals(Object o){
		if(o instanceof SymbolicConstant){
			return ((SymbolicConstant) o).name.equals(this.name);
		}
		return false;
	}
	
	@Override
	public String toString(){
		return name;
	}
	
	@Override
	public int hashCode(){
		return name.hashCode();
	}
	
	public boolean isSkolem() {
		return skolem;
	}
	
	public FormulaNode applySubstitution(SubstitutionList um){
		return new SymbolicConstant(this.name);
	}
	
	public boolean unify(Constant c, SubstitutionList um){
		if(c instanceof SymbolicConstant){
			return ((SymbolicConstant) c).equals(this);
		}
		return false;
	}
}
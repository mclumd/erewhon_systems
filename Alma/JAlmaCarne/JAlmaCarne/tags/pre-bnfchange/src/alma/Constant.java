package alma;

public class Constant extends FormulaNode {
	private String name;
	public Constant(String name){
		this.name = name;
	}
	
	public String getName(){
		return name;
	}
	
	//public Object clone() throws CloneNotSupportedException
	//Superclass default handles the case. Strings are immutible

	@Override
	public boolean equals(Object o){
		if(o instanceof Constant){
			return ((Constant) o).name.equals(this.name);
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
	
	public FormulaNode applySubstitution(UnifiedMap um){
		return new Constant(this.name);
	}

	@Override
	public boolean unify(Variable v, UnifiedMap um) {
		if(um.isBound(v)){
			return um.walk(v).unify(this, um);
		} else {
			um.addVar(v, this);
			return true;
		}
	}

	public boolean unify(FormulaNode fn, UnifiedMap um){
		return fn.unify(this, um);
	}
	@Override
	public boolean unify(Constant c, UnifiedMap um) {
		return c.name.equals(this.name);
	}

	@Override
	public boolean unify(ComplexNode cn, UnifiedMap um) {
		return false;
	}
}
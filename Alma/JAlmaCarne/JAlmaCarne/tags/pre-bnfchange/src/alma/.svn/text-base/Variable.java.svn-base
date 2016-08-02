package alma;

public class Variable extends FormulaNode {
	String name;
	public Variable(String name){
		this.name = name;
	}
	
	@Override
	public String toString(){
		return name;
	}
	
	//public Object clone() throws CloneNotSupportedException
	//Superclass default handles the case. Strings are immutible
	
	@Override
	public int hashCode(){
		return name.hashCode();
	}
	
	public boolean equals(Object o){
		if(o instanceof Variable){
			return ((Variable) o).name.equals(this.name);
		} else return false;
	}
	
	public FormulaNode applySubstitution(UnifiedMap um){
		return um.walk(this);
	}
	
	public boolean unify(FormulaNode fn, UnifiedMap um){
		if(um.isBound(this)){
			return um.walk(this).unify(fn, um);
		} else {
			um.addVar(this, fn);
			return true;
		}
	}
	@Override
	public boolean unify(Variable v, UnifiedMap um) {
		return this.unify((FormulaNode) v, um);
	}

	@Override
	public boolean unify(Constant c, UnifiedMap um) {
		return this.unify((FormulaNode) c, um);
	}

	@Override
	public boolean unify(ComplexNode cn, UnifiedMap um) {
		return this.unify((FormulaNode) cn, um);
	}
}
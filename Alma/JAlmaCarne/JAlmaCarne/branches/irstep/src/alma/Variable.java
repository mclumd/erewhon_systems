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
	
	public FormulaNode applySubstitution(SubstitutionList um){
		return um.walk(this);
	}
	
	public boolean unify(FormulaNode fn, SubstitutionList um){
		if(um.isBound(this)){
			return um.walk(this).unify(fn, um);
		} else {
			if(! this.equals(fn)) um.addVar(this, fn);
			return true;
		}
	}
	@Override
	public boolean unify(Variable v, SubstitutionList um) {
		return this.unify((FormulaNode) v, um);
	}

	@Override
	public boolean unify(Constant c, SubstitutionList um) {
		return this.unify((FormulaNode) c, um);
	}

	@Override
	public boolean unify(ComplexNode cn, SubstitutionList um) {
		if(cn.getChildren().contains(this)) return false;
		return this.unify((FormulaNode) cn, um);
	}
}
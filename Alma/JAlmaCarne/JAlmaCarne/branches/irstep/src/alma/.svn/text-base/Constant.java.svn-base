package alma;

public abstract class Constant extends FormulaNode {

	@Override
	public boolean unify(Variable v, SubstitutionList um) {
		if(um.isBound(v)){
			return um.walk(v).unify(this, um);
		} else {
			um.addVar(v, this);
			return true;
		}
	}

	public boolean unify(FormulaNode fn, SubstitutionList um){
		return fn.unify(this, um);
	}
	@Override
	public abstract boolean unify(Constant c, SubstitutionList um);

	@Override
	public boolean unify(ComplexNode cn, SubstitutionList um) {
		return false;
	}

}

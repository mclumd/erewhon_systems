package alma;

public abstract class Constant extends FormulaNode {

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
	public abstract boolean unify(Constant c, UnifiedMap um);

	@Override
	public boolean unify(ComplexNode cn, UnifiedMap um) {
		return false;
	}

}

package alma;

public class NullConstant extends Constant {

	@Override
	public boolean unify(Constant c, SubstitutionList um) {
		return c instanceof NullConstant;
	}

	@Override
	public FormulaNode applySubstitution(SubstitutionList um) {
		return this;
	}
	
	@Override
	public String toString() {
		return "NULL";
	}
	
	@Override
	public boolean equals(Object o){
		return o instanceof NullConstant;
	}
	
	@Override
	public int hashCode() {
		return 0x1337C0DE;
	}

}

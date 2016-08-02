package alma;

public class StringConstant extends Constant {
	String string; //what this string holds
	
	public StringConstant(String s){
		this.string =s;
	}
	
	@Override
	public boolean unify(Constant c, SubstitutionList um) {
		if(c instanceof StringConstant){
			StringConstant s = (StringConstant) c;
			return s.string.equals(this.string);
		}
		return false;
	}

	@Override
	public FormulaNode applySubstitution(SubstitutionList um) {
		return new StringConstant(this.string);
	}

	public String toString(){
		return '\"' + string + '\"';
	}
}
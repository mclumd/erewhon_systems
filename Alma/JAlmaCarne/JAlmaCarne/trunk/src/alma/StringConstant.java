package alma;

public class StringConstant extends Constant {
	String string; //what this string holds
	
	public StringConstant(String s){
		this.string =s;
	}
	
	public boolean equals(Object o) {
		return (o instanceof StringConstant) 
		&& ((StringConstant)o).string.equals(this.string);
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
	
	@Override
	public int hashCode(){
		return string.hashCode();
	}
	
}
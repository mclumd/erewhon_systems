package alma;

public class AndFormula extends ComplexNode {
	AndFormula(){
	}
	public String toString(){
		assert(children.size() >= 2);
		String toReturn = "(";
		for(FormulaNode f: children){
			toReturn += f + " & ";
		}
		return toReturn.substring(0, toReturn.length()-3) + ")";
	}
}
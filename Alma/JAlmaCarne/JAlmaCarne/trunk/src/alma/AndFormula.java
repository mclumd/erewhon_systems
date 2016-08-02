package alma;

/**
 * Represents an "and" formula. See ComplexNode for details. And formulas may
 * have multiple children.
 * @author percy
 *
 */
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
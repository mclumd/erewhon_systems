package alma;

public abstract class FormulaNode implements Cloneable{
	/**
	 * This is a general class that represents the formula
	 * "nodes" in the tree. It is a general purpose tree, with an
	 * operator, and an arbitrary amount of expressions.
	 * 
	 * @author Percy Tiglao
	 * @version $Revision$
	 */
	
	public abstract FormulaNode applySubstitution(SubstitutionList um);
	
	@Deprecated
	public abstract boolean unify(FormulaNode fn, SubstitutionList um);
	@Deprecated
	public abstract boolean unify(Variable v, SubstitutionList um);
	@Deprecated
	public abstract boolean unify(Constant c, SubstitutionList um);
	@Deprecated
	public abstract boolean unify(ComplexNode cn, SubstitutionList um);
	
	public Object clone() throws CloneNotSupportedException{
		return super.clone();
	}
	
	public FormulaNode cleanup(){
		return cleanup(this);
	}
	public static FormulaNode cleanup(FormulaNode fn){
		if(fn instanceof OrFormula){
			OrFormula of = (OrFormula) fn;
			if(of.getChildren().size() == 1){
				return of.getChildren().get(0).cleanup();
			}
			for(int i=0; i<of.getChildren().size(); i++){
				if(of.getChildren().get(i) instanceof OrFormula){
					OrFormula child = (OrFormula) of.getChildren().get(i);
					of.getChildren().remove(i);
					for(FormulaNode f: child.getChildren()){
						of.children.add(f.cleanup());
					}
					i--;
				}
			}
		} else if(fn instanceof AndFormula){
			AndFormula af = (AndFormula) fn;
			if(af.getChildren().size() == 1){
				return af.getChildren().get(0).cleanup();
			}
			for(int i=0; i<af.getChildren().size(); i++){
				if(af.getChildren().get(i) instanceof AndFormula){
					OrFormula child = (OrFormula) af.getChildren().get(i);
					af.getChildren().remove(i);
					for(FormulaNode f: child.getChildren()){
						af.children.add(f.cleanup());
					}
					i--;
				}
			}
		}
		
		return fn;
	}
}
package alma;

import java.util.List;
import java.util.ArrayList;

/**
 * This abstract class is the core for many classes. Note that children is
 * protected and thus is shared between all subclasses.
 * 
 * All ComplexNodes share a single similarity: all ComplexNodes have children
 * nodes. What the children mean is precisely up to the subclasses, however the
 * unification and subsitution procedures by default recursively apply the
 * children of the other complexnode to this one. If this functionality is not
 * wanted, then the subclass should override the unification and substitution
 * procedures.
 * @author percy
 *
 */
public abstract class ComplexNode extends FormulaNode{
	protected List<FormulaNode> children;
	
	public ComplexNode(){
		children = new ArrayList<FormulaNode>();
	}
	
	public ComplexNode(FormulaNode a){
		this();
		children.add(a);
	}
	public ComplexNode(FormulaNode a, FormulaNode b){
		this(a);
		children.add(b);
	}
	public ComplexNode(FormulaNode a, FormulaNode b, FormulaNode c){
		this(a,b);
		children.add(c);
	}
	public ComplexNode(List<FormulaNode> lst){
		this();
		children.addAll(lst);
	}
	public ComplexNode(FormulaNode a, List<FormulaNode> lst){
		this();
		children.add(a);
		children.addAll(lst);
	}
	
	public List<FormulaNode> getChildren(){
		return children;
	}
	
	public boolean hasChildren(){
		return getChildren().size() > 0;
	}
	
	public int hashCode(){
		return getClass().hashCode() ^ children.hashCode() ;
	}
	
	public FormulaNode applySubstitution(SubstitutionList um){
		//System.out.println("Current Node is: " + this);
		//System.out.println("SubstitutionList is: " + um);
		List<FormulaNode> list = this.getChildren();
		ComplexNode toReturn = null;
		try{
			toReturn = (ComplexNode) this.clone();
			toReturn.children = new ArrayList<FormulaNode>();
		} catch(CloneNotSupportedException e){
			e.printStackTrace();
			System.exit(1);
		}
		for(FormulaNode fn : list){
			toReturn.children.add(fn.applySubstitution(um));
		}
		return toReturn;
	}
	
	public boolean equals(Object o){
		if (o instanceof ComplexNode){
			ComplexNode cn = (ComplexNode) o;
			boolean toReturn = cn.getClass() == this.getClass();
			for(int i=0; i<children.size() && toReturn; i++){
				toReturn &= cn.children.get(i).equals(children.get(i));
			}
			return toReturn;
		} else return false;
	}
	
	public ComplexNode shallowClone(){
		try{
			ComplexNode toReturn = (ComplexNode) super.clone();
			return toReturn;
		} catch(CloneNotSupportedException e){
			e.printStackTrace();
			System.exit(1);
			return null;
		}
	}
	
	public Object clone() throws CloneNotSupportedException{
		ComplexNode toReturn = (ComplexNode) super.clone();
		toReturn.children = new ArrayList<FormulaNode>();
		for(FormulaNode fn: this.children){
			if(fn!=null)
				toReturn.children.add((FormulaNode)fn.clone());
			else
				toReturn.children.add(null);
		}
		return toReturn;
	}
	public boolean unify(FormulaNode fn, SubstitutionList um){
		return fn.unify(this, um);
	}
	@Override
	public boolean unify(Variable v, SubstitutionList um) {
		return v.unify(this, um);
	}
	@Override
	public boolean unify(Constant c, SubstitutionList um) {
		return false;
	}
	@Override
	public boolean unify(ComplexNode cn, SubstitutionList um) {
		boolean toReturn = this.getClass().equals(cn.getClass());
		if(children.size() != cn.children.size()) return false;
		for(int i=0; i<children.size(); i++){
			if(children.get(i)==null)
				toReturn &= cn.children.get(i)==null;
			else
				toReturn &= children.get(i).unify(cn.children.get(i), um);
		}
		if(! toReturn) um.reset();
		return toReturn;
	}
}

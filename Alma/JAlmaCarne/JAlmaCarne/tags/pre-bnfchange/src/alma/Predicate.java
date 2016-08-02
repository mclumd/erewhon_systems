package alma;

import java.util.*;

public class Predicate extends ComplexNode {
	public Predicate(String name){
		super(new Constant(name));
	}
	public Predicate(String name, FormulaNode a){
		super(new Constant(name), a);
	}
	public Predicate(String name, FormulaNode a, FormulaNode b){
		super( new Constant(name), a, b);
	}
	public Predicate(String name, List<FormulaNode> list){
		super(new Constant(name), list);		
	}
	
	public Object clone() throws CloneNotSupportedException{
		Predicate p = (Predicate) super.clone();
		return p;
	}
	
	public String getName(){
		return ((Constant)(children.get(0))).getName();
	}
	
	public String toString(){
		String toReturn = children.get(0) + "(";
		for(int i=1; i<children.size(); i++){
			toReturn += children.get(i) + ",";
		}
		return toReturn.substring(0, toReturn.length()-1) + ")";
	}
	
	public boolean equals(Object o){
		if(o instanceof Predicate){
			return ((Predicate)o).children.equals(this.children);
		} else return false;
	}
}
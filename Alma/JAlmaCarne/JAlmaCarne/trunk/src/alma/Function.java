package alma;

import java.util.*;

public class Function extends ComplexNode {
	private boolean skolem = false;
	
	public Function(String name){
		super(new SymbolicConstant(name));
		skolem = false;
	}
	public Function(String name, FormulaNode a){
		super(new SymbolicConstant(name), a);
		skolem = false;
	}
	public Function(String name, FormulaNode a, FormulaNode b){
		super( new SymbolicConstant(name), a, b);
		skolem = false;
	}
	public Function(String name, List<FormulaNode> list){
		super(new SymbolicConstant(name), list);		
		skolem = false;
	}
	
	public Function(String name, boolean skolem){
		super(new SymbolicConstant(name));
		this.skolem = skolem;
	}
	public Function(String name, FormulaNode a, boolean skolem){
		super(new SymbolicConstant(name), a);
		this.skolem = skolem;
	}
	public Function(String name, FormulaNode a, FormulaNode b, boolean skolem){
		super( new SymbolicConstant(name), a, b);
		this.skolem = skolem;
	}
	public Function(String name, List<FormulaNode> list, boolean skolem){
		super(new SymbolicConstant(name), list);		
		this.skolem = skolem;
	}
	
	public Object clone() throws CloneNotSupportedException{
		Function p = (Function) super.clone();
		return p;
	}
	
	public String getName(){
		return ((SymbolicConstant)(children.get(0))).getName();
	}
	
	public String toString(){
		String toReturn = children.get(0) + "(";
		for(int i=1; i<children.size(); i++){
			toReturn += children.get(i) + ",";
		}
		return toReturn.substring(0, toReturn.length()-1) + ")";
	}
	
	public boolean isSkolem() {
		return skolem;
	}
	
	public boolean equals(Object o){
		if(o instanceof Function){
			return ((Function)o).isSkolem() == skolem && ((Function)o).children.equals(this.children);
		} else return false;
	}
}
package alma;

import java.io.*;
import java.util.*;

public class KnowledgeBase implements Iterable{
	History history;
	HashMap<FormulaNode, FormulaNode> current;
	
	public KnowledgeBase(){
		history = new History();
		current = new HashMap<FormulaNode,FormulaNode>();
		//history.addStep(current);
	}
	
	//private void add(FormulaNode fn){
	//	current.add(fn);
	//}
	
	private void add(Formula f){
		current.put(Database.toCNF(f).getHead(), f.getHead());
	}
	
	private void delete(Formula f){
		current.remove(Database.toCNF(f).getHead());
	}
	
	public void eval(Formula f){
		FormulaNode fn = f.getHead();
		if(fn instanceof CommandNode){
			CommandNode cn = (CommandNode) fn;
			if(fn instanceof AddCommand){
				add(new Formula(cn.getOperand()));
			} else if(fn instanceof DeleteCommand){
				delete(new Formula(cn.getOperand()));
			}
		}
	}

	public Iterator iterator() {
		return current.values().iterator();
	}
	
	public void printHistory(PrintStream out){
		int step=1;
		for(Map<FormulaNode,FormulaNode> map: history){
			out.println("----- Step: " + step++ + " -----");
			for(FormulaNode fn: map.values()){
				out.println(fn);
			}
		}
		out.println("----- Current -----");
		for(FormulaNode fn: current.values()){
			out.println(fn);
		}
	}
	
	public String toString(){
		String toReturn ="----- Step " + history.stepNumber() + " -----";
		for(FormulaNode n: current.values()){
			toReturn += "\n" + n;
		}
		
		return toReturn;
	}
	
	public void step(){
		HashMap<FormulaNode,FormulaNode> addLater = new HashMap<FormulaNode,FormulaNode>();
		for(FormulaNode fn: current.values()){
			if(fn instanceof IfFormula){
				IfFormula f = (IfFormula)fn;
				FormulaNode left = f.getLeft();
				FormulaNode right = f.getRight();
				UnifiedMap um = new UnifiedMap();
				for(FormulaNode fn2: current.values()){
					if(um.unify(left, fn2)){
						FormulaNode toAdd = right.applySubstitution(um);
						addLater.put(Database.toCNF(new Formula(toAdd)).getHead(), toAdd);
					}
					um.reset();
				}
			}
		}
		history.addStep((HashMap<FormulaNode,FormulaNode>)current.clone());
		current.putAll(addLater);
	}
}
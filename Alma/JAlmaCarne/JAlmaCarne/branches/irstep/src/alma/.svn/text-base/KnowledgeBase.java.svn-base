package alma;

import java.io.*;
import java.util.*;

/**
 * This is a class where most things get done.
 * 
 * When a formula is added to the KnowledgeBase, all InferenceRule classes
 * get a chance to add it to their own databases as well. Overall, the
 * "Reasoning" happens in Inference Rule classes
 * */

public class KnowledgeBase {
	History history;
	HashSet<Formula> rawFormulas; // Formulas in "current" step
	
	HashSet<Formula> toadd; //Formulas to add this step
	HashSet<Formula> todelete; // Formulas to delete this step
	ArrayList<Integer> idDelete = new ArrayList();
	ArrayList<InferenceRule> rules;
	
	public KnowledgeBase(){
		history = new History();
		rawFormulas = new HashSet();
		toadd = new HashSet();
		todelete = new HashSet();
		rules = new ArrayList<InferenceRule>();
		
		/* Add some default inference rules */
		rules.add(new CommandInference(this));
		rules.add(new ModusPonens(this));
		rules.add(new ContradictionRule(this));
		rules.add(new SelectRule(this));
	}
	
	public void add(Formula f){
		toadd.add(f);
	}
	
	public void delete(Formula f){
		todelete.add(f);
	}
	
	public void deleteID(int id){
		idDelete.add(id);
	}
	
	public boolean contains(Formula f){
		return rawFormulas.contains(f);
	}
	
	public int size(){
		return rawFormulas.size();
	}

	public void printHistory(PrintStream out){
		int step=1;
		for(Set<Formula> set: history){
			out.println("----- Step: " + step++ + " -----");
			for(Formula fn: set){
				out.println(fn);
			}
		}
		out.println("----- Current -----");
		for(Formula f: rawFormulas){
			out.println(f.getID() + ": " + f);
		}
	}
	
	public String toString(){
		String toReturn ="----- Step " + history.stepNumber() + " -----";
		for(Formula f: rawFormulas){
			toReturn += "\n" + f.getID() + ": " + f;
		}
		
		return toReturn;
	}
	
	/**
	 * Formulas that need to be deleted or added are added to the current list.
	 * New formulas infered are put into next step's "toadd" set, and the current
	 * step is added to the history.
	 *
	 */
	public void step(){
		history.addStep(rawFormulas);
		
		removeIDs(rawFormulas, idDelete);
		
		for(Formula f: todelete){
			for(InferenceRule ir: rules)
				ir.delete(f);
			toadd.remove(f);
			rawFormulas.remove(f);
		}
		for(Formula f: toadd){
			boolean add = true;
			for(InferenceRule ir: rules){
				add = ir.add(f);
				if(!add) break;
			}
			if(add) rawFormulas.add(f);
		}
		
		toadd.clear();
		todelete.clear();
		
		for(InferenceRule ir: rules){
			ir.step();
		}
		
		idDelete.clear();
	}
	
	private static void removeIDs(Iterable<Formula> c, Collection<Integer> ids){
		Iterator<Formula> i = c.iterator();
		
		while(i.hasNext()){
			Formula next = i.next();
			if(ids.contains(next.getID())){
				i.remove();
			}
		}
	}
}
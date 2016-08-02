package alma;

import java.io.*;
import java.util.*;
import alma.callfile.*;
/**
 * This is a class where most things get done.
 * 
 * When a formula is added to the KnowledgeBase, all InferenceRule classes
 * get a chance to add it to their own databases as well. Overall, the
 * "Reasoning" happens in Inference Rule classes
 * */

public class KnowledgeBase {
	History history;
	ListSet<Formula> rawFormulas; // Formulas in "current" step
	
	HashSet<Formula> toadd; //Formulas to add this step
	HashSet<Formula> todelete; // Formulas to delete this step
	ArrayList<Integer> idDelete = new ArrayList();
	ArrayList<InferenceRule> rules;

	//This rule is "special" This should perhaps be created somewhere else.
	CallInferenceRule callIR;
	
	public KnowledgeBase(){
		history = new History();
		rawFormulas = new ListSet<Formula>();
		toadd = new HashSet();
		todelete = new HashSet();
		rules = new ArrayList<InferenceRule>();
		
		/* Add some default inference rules */
		rules.add(new CommandInference(this));
		rules.add(new ModusPonens(this));
		rules.add(new GeneralizedModusPonens(this));
		rules.add(new ContradictionRule(this));
		rules.add(new SelectRule(this));
		
		//Once again, this should probably be moved
		callIR = new CallInferenceRule(this);
		rules.add(callIR);
		//Load some default callformulas"
		callIR.loadClass("less", "alma.callfile.Less");
		callIR.loadClass("combine", "alma.callfile.Combine");
		//callIR.loadClass(name, classLocation);
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
		for(List<Formula> set: history){
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
	
	private class AllCandidatesIterator implements BiIterator {
		IteratorWrapper kbCandidates;
		BiIterator<FormulaNode> callCandidates;
		boolean usingKB = true;
		
		public AllCandidatesIterator(Class c, FormulaNode template) {
			kbCandidates = new IteratorWrapper(c,rawFormulas);
			try {
				callCandidates = callIR.getAnswers(template);
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
				throw new RuntimeException("Loaded invalid class");
			}
		}
		
		public boolean hasNext() {
			return (kbCandidates.hasNext() || callCandidates.hasNext());
		}
		
		public FormulaNode next() {
			usingKB = kbCandidates.hasNext();
			return (kbCandidates.hasNext() ? kbCandidates.next() : callCandidates.next());
		}
		
		public boolean hasPrevious() {
			if(usingKB)
				return kbCandidates.hasPrevious();
			else
				return callCandidates.hasPrevious();
		}

		public FormulaNode previous() {
			if(usingKB)
				return kbCandidates.previous();
			else {
				FormulaNode i = callCandidates.previous();
				if(!callCandidates.hasPrevious())
					usingKB = true;
				return i;
			}
		}
		
		public void remove() {
			throw new UnsupportedOperationException("Remove not supported");
		}
	}
	
	//Wraps an Iterator<FormulaNode>
	private class IteratorWrapper implements BiIterator {
		Class toSearch;
		ListIterator<Formula> wrapper;
		FormulaNode next;
		FormulaNode last;
		
		//Wraps the Formulas contained in the collection of Class c
		public IteratorWrapper(Class c, List<Formula> collection) {
			toSearch = c;
			wrapper = collection.listIterator();
			next = null;
			last = null;
			next();
			previous();
		}

		public boolean hasNext() {
			return next != null;
		}

		public FormulaNode next() {
			FormulaNode toReturn = next;
			next = null;
			while (wrapper.hasNext() && next == null) {
				next = wrapper.next().getHead();
				if (!toSearch.isInstance(next))
					next = null;
			}
			
			return toReturn;
		}

		public boolean hasPrevious() {
			return last!=null;
		}

		public FormulaNode previous() {
			FormulaNode toReturn = last;
			last = null;
			while (wrapper.hasPrevious() && last == null) {
				last = wrapper.previous().getHead();
				if (!toSearch.isInstance(last))
					last = null;
			}
			
			return toReturn;
		}
		
		public void remove() {
			throw new UnsupportedOperationException("Remove not supported");
		}
	}

	//Returns an iterator to all FormulaNodes that are of the Class c 
	//If we are looking at predicates then this method returns the matching FormulaNodes
	//in both the KnowledgeBase and the CallInferenceRule
	public BiIterator getCandidates(Class c, FormulaNode template){
		if(template!=null && c.equals(Predicate.class) && callIR.contains((Predicate)template))
			return new AllCandidatesIterator(c,template); //KB and CallInferenceRule
		else
			return new IteratorWrapper(c,rawFormulas); //Just look in the KB
	}
	
	public void loadClass(String name, String classLocation) {
		callIR.loadClass(name,classLocation);
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
		history.addStep((ListSet<Formula>)rawFormulas.clone());
		
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
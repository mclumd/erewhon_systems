package alma;

import java.io.*;
import java.util.*;

import alma.callfile.*;
import alma.util.BiIterator;
import alma.util.CrossIterator;
import alma.util.EmptyIterator;
import alma.util.ListSet;
/**
 * This is a class where most things get done.
 * 
 * When a formula is added to the KnowledgeBase, all InferenceRule classes
 * get a chance to add it to their own databases as well. Overall, the
 * "Reasoning" happens in Inference Rule classes
 * */

public class KnowledgeBase {
	HistoryDiff history;
	FormulaSet  cnfFormulas = new FormulaSet();
	ListSet<Formula> rawFormulas; // Formulas in "current" step
	
	
	HashSet<Formula> toadd = new HashSet<Formula>(); //Formulas to add this step
	HashSet<Formula> todelete = new HashSet<Formula>(); // Formulas to delete this step
	ArrayList<Integer> idDelete = new ArrayList<Integer>();
	ArrayList<InferenceRule> rules;

	//This rule is "special" This should perhaps be created somewhere else.
	CallInferenceRule callIR;
	CallAction callAct;
	LabelController labelControl;
	
	public KnowledgeBase(){
		history = new HistoryDiff();
		rawFormulas = new ListSet<Formula>();
		rules = new ArrayList<InferenceRule>();
		
		/* Add some default inference rules */
		rules.add(new CommandInference(this));
		//rules.add(new ModusPonens(this));
		//rules.add(new GeneralizedModusPonens(this));
		rules.add(new InfiniteModusPonens(this));
		rules.add(new ContradictionRule(this));
		rules.add(new SelectRule(this));
		rules.add(new GoalInferenceRule(this));
		
		//Once again, this should probably be moved
		callIR = new CallInferenceRule(this);
		rules.add(callIR);
		//Load some default callformulas"
		callIR.loadClass("less", "alma.callfile.Less");
		callIR.loadClass("combine", "alma.callfile.Combine");
		callIR.loadClass("eval", "alma.callfile.Eval");
		callIR.loadClass("number_to_string", "alma.callfile.NumberToString");
		callIR.loadClass("constant_to_string", "alma.callfile.SymbolicConstantToString");
		//callIR.loadClass(name, classLocation);
		//Load some default callactions
		callAct = new CallAction();
		callAct.loadClass("printf","alma.callfile.Print");
		labelControl = new LabelController(this);
	}
	
	/**
	 * Useful for MockKnowledgeBases that extend this class. Make the KB "clear".
	 * No rules, no calls, no call actions. 
	 */
	protected void clearAll(){
		callIR = new CallInferenceRule(this);
		rules.clear();
		callAct = new CallAction();
	}
	
	/**
	 * Useful for MockKnowledgeBases
	 */
	protected void addIR(InferenceRule ir){
		rules.add(ir);
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
		normalize(f.getHead());
		return rawFormulas.contains(f);
	}
	
	public int size(){
		return rawFormulas.size();
	}

	public void printHistory(PrintStream out){ //modified by Shomir to print differential history
		int step=1;
		ArrayList<Formula> toPrint = new ArrayList<Formula>();
		ArrayList<String> printFlag = new ArrayList<String>();
		for(Operation[] set: history){	
			out.println("\n----- Step: " + step++ + " -----");
			for(Operation fn: set){
				if(fn instanceof AddOperation) {
					toPrint.add(fn.val);
					printFlag.add("ADD");
				}
				else if(fn instanceof SubOperation)
				{
					//toPrint.remove(fn.val);
					toPrint.add(fn.val);
					printFlag.add("SUB");
				}
			}
			for(int i = 0; i < toPrint.size(); i++) {
				out.println(printFlag.get(i) + " " + toPrint.get(i));
			}
			/*for(Formula fn : toPrint) {
				out.println(fn);
			}	*/
			toPrint.clear();
			printFlag.clear();
		}
		out.println("----- Current -----");
		for(Formula f: rawFormulas){
			out.println("#" + f.getID() + ": " + f);
		}
	}
	
	private boolean matches(Class<?> type, Object ob1, Object ob2){
		if(ob1 == null || ob2 == null)
			return true;
		else if(type.equals(Predicate.class))
			return (((Predicate)ob1).getName().equals(((Predicate)ob2).getName()));
		return true;
	}
	
	private class AllCandidatesIterator implements BiIterator<FormulaNode> {
		IteratorWrapper kbCandidates;
		BiIterator<FormulaNode> callCandidates;
		boolean usingKB = true;
		
		public AllCandidatesIterator(Class<?> c, FormulaNode template) {
			kbCandidates = new IteratorWrapper(c, rawFormulas, template);
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
	private class IteratorWrapper implements BiIterator<FormulaNode> {
		Class<?> toSearch;
		BiIterator<Formula> wrapper;
		FormulaNode template;
		FormulaNode next = null;
		FormulaNode last = null;
		
		//Wraps the Formulas contained in the collection of Class c
		public IteratorWrapper(Class<?> c, ListSet<Formula> collection, FormulaNode template) {
			toSearch = c;
			this.template = template;
			wrapper = collection.biIterator();
			next = findNext();
			last = findLast();
		}


		public boolean hasNext() {
			return next != null;
		}

		public FormulaNode next() {
			last = next;
			next = findNext();
			return last;
		}
		
		private FormulaNode findNext() {
			Formula temp;
			FormulaNode holder = null;
			while (wrapper.hasNext() && holder == null) {
				temp = wrapper.next();
				holder = cnfFormulas.get(temp).getHead();
				if (!toSearch.isInstance(holder) || temp.getGroups().contains("*invalid*") ||
						!matches(toSearch, template, holder))
					holder = null;
			}
			return holder;
		}

		public boolean hasPrevious() {
			return last!=null;
		}

		public FormulaNode previous() {
			next = last;
			last = findLast();
			return next;
		}
		
		private FormulaNode findLast() {
			Formula temp;
			FormulaNode holder = null;
			while (wrapper.hasPrevious() && holder == null) {
				temp = wrapper.previous();
				holder = cnfFormulas.get(temp).getHead();
				if (!toSearch.isInstance(last) || temp.getGroups().contains("*invalid*"))
					holder = null;
			}
			return holder;
		}
		
		public void remove() {
			throw new UnsupportedOperationException("Remove not supported");
		}
	}

	//Returns an iterator to all FormulaNodes that are of the Class c 
	//If we are looking at predicates then this method returns the matching FormulaNodes
	//in both the KnowledgeBase and the CallInferenceRule
	public BiIterator<FormulaNode> getCandidates(Class<?> c, FormulaNode template){
		if(template!=null && c.equals(Predicate.class) && callIR.contains((Predicate)template)) {
			return new AllCandidatesIterator(c,template); //KB and CallInferenceRule
		}
		else if(template!=null && c.equals(Predicate.class) && ((Predicate)template).getName().equals("pos_int")) {
			BiIterator<FormulaNode> iter = PositiveIntrospection.findAnswer((Predicate)template, history);
			return iter;
		}
		else
			return new IteratorWrapper(c,rawFormulas, template); //Just look in the KB
	}
	
	private boolean contains(FormulaNode f, Predicate c) {
		boolean ans = false;
		if(f instanceof ComplexNode & !(f instanceof Predicate)) {
			for(FormulaNode child: ((ComplexNode)f).getChildren()) {
				ans |= contains(child,c);
			}
		}
		else if(f instanceof Predicate) {
			ans |= ((Predicate)f).getName().equals(c.getName());
		}
		return ans;
	}
	
	class CNFIterator implements BiIterator<FormulaNode> {
		Predicate template;
		BiIterator<Formula> wrapper= rawFormulas.biIterator();
		FormulaNode next = null;
		FormulaNode last = null;
		
		
		public CNFIterator(Predicate template) {
			this.template = template;
			next = findNext();
			last = findLast();
		}
		

		public boolean hasNext() {
			return next != null;
		}

		public FormulaNode next() {
			last = next;
			next = findNext();
			return last;
		}
		
		private FormulaNode findNext() {
			Formula temp;
			FormulaNode holder = null;
			while (wrapper.hasNext() && holder == null) {
				temp = wrapper.next();
				holder = cnfFormulas.get(temp).getHead();
				if (!contains(holder,template) || temp.getGroups().contains("*invalid*") ||
						holder.equals(last))
					holder = null;
			}
			return holder;
		}

		public boolean hasPrevious() {
			return last!=null;
		}

		public FormulaNode previous() {
			next = last;
			last = findLast();
			return next;
		}
		
		private FormulaNode findLast() {
			Formula temp;
			FormulaNode holder = null;
			while (wrapper.hasPrevious() && holder == null) {
				temp = wrapper.previous();
				holder = cnfFormulas.get(temp).getHead();
				if (!contains(cnfFormulas.get(temp).getHead(),template) || temp.getGroups().contains("*invalid*") ||
						holder.equals(next))
					holder = null;
			}
			return holder;
		}
		
		public void remove() {
			throw new UnsupportedOperationException("Remove not supported");
		}
		
	}
	
	public BiIterator<FormulaNode> getCNFCandidates(List<Predicate> variables){
		Set<BiIterator<FormulaNode>> toCross = new HashSet<BiIterator<FormulaNode>>();
		for(Predicate p: variables) {
			if(callIR.contains(p)) 
				toCross.add(getCandidates(Predicate.class,p));
			else
			toCross.add(new CNFIterator(p));
		}
		List<BiIterator<FormulaNode>> build = new ArrayList<BiIterator<FormulaNode>>();
		for(BiIterator<FormulaNode> bi : toCross) {
			build.add(bi);
			if(build.size()==2) {
				build.set(0,new CrossIterator<FormulaNode>(build.get(0),build.get(1)));
				build.remove(1);
			}
		}

		if(build.size()>0)
			return build.get(0);
		else
			return new EmptyIterator<FormulaNode>();
	}	

	
	public BiIterator<Formula> getAllFormulas() {
		return rawFormulas.biIterator();
	}
	
	public void call(FormulaNode template) {
		if(template instanceof Predicate) {
			if(callAct.contains((Predicate)template)) {
				callAct.callAction(template);
			}
		}
	}

	public boolean isCallAction(FormulaNode template) {
		return (template instanceof Predicate) && callAct.contains((Predicate) template);
	}
	
	public void loadCall(String name, String classLocation) {
		callIR.loadClass(name,classLocation);
	}
	
	public void loadAction(String name, String classLocation) {
		callAct.loadClass(name,classLocation);
	}
	
	public String toString(){
		String toReturn ="----- Step " + history.stepNumber() + " -----";
		for(Formula f: rawFormulas){
			toReturn += "\n" + f.getID() + ": " + f;
		}
		
		return toReturn;
	}
	
 	public void label(String oper, FormulaNode formulaNode, String label){
 		labelControl.eval(oper, formulaNode, label);
	}
	
	/**
	 * 
	 * Required so that formulas always are in the kb in a consistent form
	 * i.e. a(X) & b(X) is the same as b(X) & a(X)
	 */
	
	private class hashCompare implements Comparator<Object> {

		public int compare(Object o1, Object o2) {
			return o2.hashCode() - o1.hashCode();
		}
		
	}
	
	/**
	 * TODO: There is a deep bug here. IfFormulas should not be normalized, but they should
	 * be. InfiniteModusPonens requires that AndFormulas exist in the order the user 
	 * specified. However, for equality across the project, we need normalization.
	 * For now, I'll disable normalization. --Percy
	 * @param fn
	 */
	public void normalize(FormulaNode fn) {
/*		if(fn instanceof ComplexNode) {
			ComplexNode cn = (ComplexNode)fn;
			for(int i=0;i<cn.getChildren().size();i++) {
				if(i!=0 || !(cn instanceof Predicate))
				normalize(cn.getChildren().get(i));
			}
			if(!(cn instanceof IfFormula) && !(cn instanceof Predicate)) 
			Collections.sort(((ComplexNode)fn).getChildren(),   new hashCompare());
		}*/
	}
	
	/**
	 * Formulas that need to be deleted or added are added to the current list.
	 * New formulas inferred are put into next step's "toadd" set, and the current
	 * step is added to the history.
	 *
	 */
	public void step(){		
		removeIDs(rawFormulas, idDelete);
		for(Formula form: todelete){
			SubstitutionList sl = new SubstitutionList();
			BiIterator<Formula> iter = rawFormulas.biIterator();
			Formula f;
			while(iter.hasNext()) {
				sl.reset();
				f = iter.next();
				if(!(f.getHead() instanceof CommandNode) &&
				   !(form.getHead() instanceof CommandNode) &&
				   sl.unify(form.getHead(),f.getHead())) {
					normalize(f.getHead());
					for(InferenceRule ir: rules)
						ir.delete(f);
					toadd.remove(f);
					normalize(f.getHead());
					if(rawFormulas.remove(f) && !rawFormulas.contains(f)) {
						history.addSub(f);
						cnfFormulas.remove(f);
					}
				}
			}
			
		}
		for(Formula f: toadd){
			boolean add = true;
			normalize(f.getHead());
			for(InferenceRule ir: rules){
				add = ir.add(f);
				if(!add) break;
			}
			if(add) { 
				if(rawFormulas.add(f)) {
					history.addAdd(f);
					cnfFormulas.add(f);
				}
			}
		}
		history.addStep();

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
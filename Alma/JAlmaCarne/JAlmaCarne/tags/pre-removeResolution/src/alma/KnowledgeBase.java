package alma;

import java.io.*;
import java.util.*;

public class KnowledgeBase {
	History history;
	CNFset formulas; //Impiled "and" between all of these
	HashSet<Formula> rawFormulas; // for sake of keeping the names and so forth
	
	HashSet<Formula> toadd; //To be executed during "step"
	HashSet<Formula> todelete;
	ArrayList<Integer> idDelete = new ArrayList();
	
	private class CNFset implements Iterable<Formula>{
		HashSet<Formula> set = new HashSet();
		public CNFset(){
		}
		
		public CNFset(HashSet<Formula> toAdd){
			for(Formula f: toAdd){
				this.add(f);
			}
		}
		
		public void add(Formula f){
			Formula cnf = FormulaSet.toCNF(f);
			FormulaNode head = cnf.getHead();
			
			if(head instanceof AndFormula){
				AndFormula ahead = (AndFormula) head;
				List<FormulaNode> children = ahead.getChildren();
				for(FormulaNode fn: children){
					set.add(new Formula(fn, f.getID()));
				}
			} else {
				set.add(new Formula(head, f.getID()));
			}
		}
		
		public void remove(Formula f){
			Iterator<Formula> i = set.iterator();
			
			while(i.hasNext()){
				Formula iterate = i.next();
				if(iterate.getID() == f.getID()){
					i.remove();
				}
			}
		}
		
		public Iterator<Formula> iterator(){
			return set.iterator();
		}
	}
	
	public KnowledgeBase(){
		history = new History();
		formulas = new CNFset();
		rawFormulas = new HashSet();
		toadd = new HashSet();
		todelete = new HashSet();
	}
	
	private void add(Formula f){
		toadd.add(f);
	}
	
	private void delete(Formula f){
		todelete.add(f);
	}
	
	public void eval(Formula f){
		FormulaNode fn = f.getHead();
		if(fn instanceof CommandNode){
			CommandNode cn = (CommandNode) fn;
			if(fn instanceof AddCommand){
				add(new Formula(cn.getOperand()));
			} else if(fn instanceof DeleteCommand){
				delete(new Formula(cn.getOperand()));
			} else if(fn instanceof SpecificDeleteCommand){
				idDelete.add(((SpecificDeleteCommand)fn).getID());
			}
		}
	}
	
	public int size(){
		return rawFormulas.size();
	}

	public void printHistory(PrintStream out){
		int step=1;
		for(Set<FormulaNode> set: history){
			out.println("----- Step: " + step++ + " -----");
			for(FormulaNode fn: set){
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
	
	public HashSet<FormulaNode> toFormulaNodeSet(Set<Formula> tochange){
		HashSet<FormulaNode> toReturn = new HashSet();
		for(Formula f: tochange){
			toReturn.add(f.getHead());
		}
		return toReturn;
	}
	
	public void step(){
		history.addStep(toFormulaNodeSet(rawFormulas));
		
		removeIDs(rawFormulas, idDelete);
		removeIDs(formulas, idDelete);
		
		for(Formula f: todelete){
			toadd.remove(f);
			rawFormulas.remove(f);
			formulas.remove(f);
		}
		for(Formula f: toadd){
			rawFormulas.add(f);
			formulas.add(f);
		}
		
		HashSet<Formula> newAdd = new HashSet();
		
		CNFset cnfadd = new CNFset(toadd);
		
		newAdd.addAll(resolve(cnfadd, cnfadd));
		newAdd.addAll(resolve(cnfadd, formulas));
		
		todelete.clear();
		toadd.clear();
		
		toadd.addAll(newAdd);
		
		idDelete.clear();
	}
	
	private HashSet<Formula> resolve(CNFset a, CNFset b){
		HashSet<Formula> toReturn = new HashSet<Formula>();
		UnifiedMap um = new UnifiedMap();
		
		for(Formula af: a){
			for(Formula bf: b){
				assertResolvable(af.getHead()); assertResolvable(bf.getHead());
				um.reset();
				ArrayList<FormulaNode> newChildren = new ArrayList();
				if(af.getHead() instanceof OrFormula){
					newChildren.addAll(((OrFormula)af.getHead()).getChildren());
				} else {
					newChildren.add(af.getHead());
				}
				
				if(bf.getHead() instanceof OrFormula){
					boolean complement = false;
					
		outer:		for(FormulaNode fn: newChildren){
						for(FormulaNode fn2: ((OrFormula)bf.getHead()).getChildren()){
							if(complement(fn, fn2, um)){
								newChildren.addAll(((OrFormula)bf.getHead()).getChildren());
								newChildren.remove(fn);
								newChildren.remove(fn2);
								
								Formula toAdd = generateOrFormula(newChildren);
								toReturn.add(toAdd.applySubstitution(um));
								
								break outer;
							} else um.reset();
						}
					}
				} else { //(if bf.getHead() is not an OrFormula
					for(FormulaNode fn: newChildren){
						if(complement(fn, bf.getHead(), um)){
							newChildren.remove(fn);
							toReturn.add(generateOrFormula(newChildren).applySubstitution(um));
							break;
						}
					}
				}
			}
		}
		
		return toReturn;
	}
	
	private Formula generateOrFormula(List<FormulaNode> lst){
		FormulaBuilder fb = new FormulaBuilder();
		fb.addOr();
			for(FormulaNode f: lst)
				fb.add(f);
		return fb.getFormula();
	}
	
	private boolean complement(FormulaNode a, FormulaNode b, UnifiedMap um){
		if((a instanceof NotFormula && !(b instanceof NotFormula))){
			NotFormula aa = (NotFormula)a;
			return aa.getChild().unify(b, um);
		} else if ( !(a instanceof NotFormula) && b instanceof NotFormula){
			NotFormula bb = (NotFormula)b;
			return bb.getChild().unify(a, um);
		} else {
			return false;
		}
	}
	
	private void assertResolvable(FormulaNode fn){
		assert(fn instanceof OrFormula || fn instanceof Predicate || fn instanceof CommandNode);
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
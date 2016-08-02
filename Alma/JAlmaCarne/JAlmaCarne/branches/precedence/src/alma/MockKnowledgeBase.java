package alma;

import alma.callfile.*;
import java.io.*;
import java.util.*;

/**
 * This class exists purely for the purposes of testing. Google "Mock Objects" for details.
 * 
 * @author percy
 *
 */

public class MockKnowledgeBase extends KnowledgeBase {
	ArrayList<Formula> formulaArrayList = new ArrayList();
	ArrayList<Formula> toAdd = new ArrayList();
	
	public void add(Formula f){
		toAdd.add(f);
	}

	public void delete(Formula f){
		formulaArrayList.remove(f);
	}
	
	public void deleteID(int id){
	}
	
	public boolean contains(Formula f){
		return formulaArrayList.contains(f);
	}
	
	@Override
	public BiIterator getCandidates(Class c, FormulaNode template){
		return new BiIterator(){
			Iterator<Formula> i = formulaArrayList.iterator();

			public boolean hasNext() {
				return i.hasNext();
			}

			public FormulaNode next() {
				return i.next().getHead();
			}

			public void remove() {
				i.remove();
			}

			public boolean hasPrevious() {
				// TODO Auto-generated method stub
				return false;
			}

			public FormulaNode previous() {
				// TODO Auto-generated method stub
				return null;
			}
			
		};
	}
	
	@Override
	public void step(){
		for(Formula f: toAdd){
			formulaArrayList.add(f);
		}
		
		toAdd.clear();
	}
	
	public int size(){
		return 0;
	}

	public void printHistory(PrintStream out){
	}
	
	public String toString(){
		return null;
	}
}

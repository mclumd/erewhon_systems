package alma;

import java.io.*;
import java.util.*;


public class MockKnowledgeBase extends KnowledgeBase {
	ArrayList<Formula> formulaArrayList = new ArrayList();
	
	public void add(Formula f){
		formulaArrayList.add(f);
	}

	public void delete(Formula f){
		formulaArrayList.remove(f);
	}
	
	public void deleteID(int id){
	}
	
	public boolean contains(Formula f){
		return formulaArrayList.contains(f);
	}
	
	public int size(){
		return 0;
	}

	public void printHistory(PrintStream out){
	}
	
	public String toString(){
		return null;
	}
	
	public void step(){
	}
}

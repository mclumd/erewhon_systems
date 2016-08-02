package alma;

import java.util.HashSet;

/**
 * Formula is a wrapper for the FormulaNode object. Additionally, every formula
 * created has a unique id associated with it.
 * @author percy
 *
 */

public class Formula {
	private FormulaNode head;
	private final int id;
	private HashSet<String> groups = new HashSet<String>();
	private static int idgenerator=0;
	
	public Formula(FormulaNode h, int id, HashSet<String> groups ){
		try {
			head = (FormulaNode) h.clone();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
			System.exit(1);
		}
		this.id = id;
		this.groups = groups;
	}
	
	public Formula(FormulaNode h){
		this(h, idgenerator,new HashSet<String>(5));
		idgenerator++;
	}
		
	public FormulaNode getHead(){
		return head;
	}
	
	public int getID(){
		return id;
	}
	
	public void setGroup(HashSet<String> newGroup) {
		groups = newGroup;
	}
	
	public HashSet<String> getGroups() {
		return groups;
	}
	
	public boolean unify(Formula f, SubstitutionList um){
		return f.head.unify(this.head, um);
	}
	
	public Formula applySubstitution(SubstitutionList um){
		Formula toReturn = new Formula(head.applySubstitution(um));
		return toReturn;
	}
	
	public boolean equals(Object o){
		if(o instanceof Formula){
			return ((Formula)o).head.equals(this.head);
		} return false;
	}
	
	public String toString(){
		return head.toString();
	}
	public int hashCode(){
		return head.hashCode();
	}
}
package alma;

public abstract class CommandNode extends ComplexNode {
	
	public FormulaNode getOperand(){
		return children.get(0);
	}
	
	@Override
	public FormulaNode applySubstitution(SubstitutionList um) {
		throw new UnsupportedOperationException("CommandNodes do not support substitution");
	}

	@Override
	public boolean unify(FormulaNode fn, SubstitutionList um) {
		throw new UnsupportedOperationException("CommandNodes do not unify");
	}

	@Override
	public boolean unify(Variable v, SubstitutionList um) {
		throw new UnsupportedOperationException("CommandNodes do not unify");
	}

	@Override
	public boolean unify(Constant c, SubstitutionList um) {
		throw new UnsupportedOperationException("CommandNodes do not unify");
	}

	@Override
	public boolean unify(ComplexNode cn, SubstitutionList um) {
		throw new UnsupportedOperationException("CommandNodes do not unify");
	}
}

class AddCommand extends CommandNode {
	AddCommand(){
	}
	
	AddCommand(FormulaNode toAdd){
		children.add(toAdd);
	}
	
	public String toString(){
		return "+" + children.get(0);
	}
}

class DeleteCommand extends CommandNode {
	DeleteCommand(){
	}
	
	DeleteCommand(FormulaNode toDelete){
		children.add(toDelete);
	}
	
	public String toString(){
		return "-" + children.get(0);
	}
}

class SpecificDeleteCommand extends CommandNode{
	int idToDelete;
	SpecificDeleteCommand(int toDelete){
		idToDelete = toDelete;
	}
	
	public String toString(){
		return "-" + idToDelete;
	}
	public int getID(){
		return idToDelete;
	}
}

class DistrustCommand extends CommandNode {
	DistrustCommand(){
		throw new UnsupportedOperationException("DistrustCommand not yet built");
	}
	
	DistrustCommand(FormulaNode toDistrust){
		//children.add(toDistrust);
		throw new UnsupportedOperationException("DistrustCommand not yet built");
	}
	
	public String toString(){
		return "*" + children.get(0);
	}
}

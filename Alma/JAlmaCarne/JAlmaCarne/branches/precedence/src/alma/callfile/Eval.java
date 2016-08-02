package alma.callfile;

import java.util.NoSuchElementException;
import alma.*;
import alma.callfile.*;

public class Eval {
	public static BiIterator findAnswer(Predicate template) {
		BiIterator iter = new NoAnswer(template);
		if(template.getChildren().size() == 4) { 
				
		}

		return (iter);
	}


	public static class NoAnswer implements BiIterator{

		public NoAnswer(Predicate template) {
			
		}
		
		public boolean hasNext() {
			// TODO Auto-generated method stub
			return false;
		}

		public FormulaNode next() {
			// TODO Auto-generated method stub
			throw new NoSuchElementException("This does not exist");
		}

		public void remove() {
			// TODO Auto-generated method stub
			
		}

		public boolean hasPrevious() {
			// TODO Auto-generated method stub
			return false;
		}

		public FormulaNode previous() {
			// TODO Auto-generated method stub
			return null;
		}
		
	}

}

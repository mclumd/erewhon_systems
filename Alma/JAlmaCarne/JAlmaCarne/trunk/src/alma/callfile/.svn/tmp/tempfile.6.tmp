package alma.callfile;

import java.lang.reflect.*;
import java.util.*;


import alma.*;
import alma.util.AlmaLong;
import alma.util.BiIterator;
import alma.util.EmptyIterator;

public class Eval implements CallFormula{
	static HashMap<Class<?>, Class<?>> bridge = new HashMap<Class<?>,Class<?>>();
	

	public BiIterator<FormulaNode> findAnswer(Predicate template) {
		BiIterator<FormulaNode> iter = new EmptyIterator<FormulaNode>();
		//Initializes our bridge between types

		//eval(java.lang.String.substring, "ABCD", [1,2], [X,Y])
		initBridge();
		//We have to have five parameters
		if(template.getChildren().size() == 5) { 
			/*****************************************/
			/***This section simply decodes the 
			 * template into what we need, class, method
			 * etc...
			 */
			Class<?> templateClass = null; //Which class to use
			try {
				//Try to load the class, the substrings are to get rid of the "s
				templateClass = Class.forName(template.getChildren().get(1).toString().substring(1,template.getChildren().get(1).toString().lastIndexOf(".")));
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			//Where to split the method off of the class
			int index =  template.getChildren().get(1).toString().lastIndexOf(".")+1;
			String method = (template.getChildren().get(1)).toString().substring(index,template.getChildren().get(1).toString().length()-1);
			//Figure out the initial value
			FormulaNode initval = template.getChildren().get(2);
			if(!(initval instanceof Constant)) return (iter); //If its not bound we can't do much
			//Figure out the parameters
			Pair params = new Pair(); //List of parameters
			try {
				params = (Pair)template.getChildren().get(3).clone(); //Get a copy of the parameters
			} catch (CloneNotSupportedException e) {
				e.printStackTrace();
			}
			/*****************************************/
			
			Object toInvoke = null; Object initObject = getValue(templateClass,initval);
			//We are looking for a constructor that takes the correct type
			Class<?> lookingFor = bridge.get(initval.getClass());

			if(lookingFor != null) { 
				//We are looking for a parameter which is of the correct type
				//i.e. if we want a String with an initial value of "hello" we
				//want to find the String(String) constructor
				Constructor<?>[] clist = templateClass.getConstructors();
				for(Constructor<?> c: clist) {
					if(c.getParameterTypes().length==1 && c.getParameterTypes()[0].equals(lookingFor)) {
						//We have found a copy constructor which takes an initial value
						try {
							toInvoke = c.newInstance(initObject);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
			} else { 
				//We have a void constructor, meaning that we just need to find an answer for params
				try {
					toInvoke = templateClass.newInstance();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			//Converts the pair structure into a java style list
			//i.e. (1 (2 NULL)) becomes (1,2) 
			ArrayList<Object> listFromPair = new ArrayList<Object>();
			fillParams(templateClass,listFromPair, params);
			//We need both to identify the correct method based on the class of the
			//parameters as well as actually pass in object of those types
			Class<?>[] args= new Class[listFromPair.size()];
			Object[] argvals= new Object[listFromPair.size()];
			for(int i=0;i<listFromPair.size();i++) {
				args[i] = listFromPair.get(i).getClass();
				if(args[i].equals(Integer.class)) //An odd little reflection issue
					args[i] = Integer.TYPE;
				argvals[i] = listFromPair.get(i);
			}
			//Get the method
			Method m = null;
			try {
				m = templateClass.getMethod(method,args);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//If its a void return the value of the object, otherwise return whatever was returned
			Class<?> returnType = m.getReturnType();	
			try {
				
				if(!returnType.equals(void.class))
					iter = new Answer(template,m.invoke(toInvoke,argvals));
				else {
					m.invoke(toInvoke,argvals);
					iter = new Answer(template,toInvoke);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return (iter);
	}

	//Recursively fills a flat list with data from pairs
	public void fillParams(Class<?> context, ArrayList<Object> toFill, Pair p) {
		if(!(p.getChildren().get(0) instanceof NullConstant))
		toFill.add(getValue(context,p.getChildren().get(0)));
		if(p.getChildren().get(1) instanceof Pair)
			fillParams(context,toFill,(Pair)(p.getChildren().get(1)));
		else if(!(p.getChildren().get(1) instanceof NullConstant))
			toFill.add(getValue(context,p.getChildren().get(1)));
	}
	
	//Converts from our Alma Formula types like StringConstant and TimeConstant to appropriate 
	//java counterparts
	public Object getValue(Class<?> context, FormulaNode node) {
		if(node instanceof StringConstant)
			return node.toString().substring(1,node.toString().length()-1);
		if(node instanceof TimeConstant) {
			//This check is just so that we use Alma types with Alma functions
			if(context.getPackage().getName().equals("alma.util"))
				return new AlmaLong (new Long(((TimeConstant)node).toLong()));
			return ((int)(((TimeConstant)node).toLong()));
		}
		else 
			return node.toString();
	}
	
	/**If you make changes here PLEASE MAKE CHANGES in Answer's constructor so that it can deal with what
	 * ever type you are adding
	 * 
	 * This just ties alma types to java types
	 * @author joey
	 */
	public void initBridge() {
		bridge.put(StringConstant.class,String.class);
		bridge.put(TimeConstant.class,AlmaLong.class);
		bridge.put(SymbolicConstant.class,String.class);
		bridge.put(NullConstant.class,null);
		bridge.put(AlmaLong.class,Integer.class);
		bridge.put(AlmaLong.class,Long.class);
	}


	/**
	 * Remember to update the back conversion below in the constructor
	 * 
	 * This is a class which takes an Object (Which could be a String, Integer, AlmaLong, etc..
	 * and tries to make an answer out of it.
	 * 
	 * @author joey
	 */

	public class Answer implements BiIterator<FormulaNode>{
		Predicate nextPred;
		boolean next = true;
		
		public Answer(Predicate template, Object answer) {
			FormulaNode ans = new NullConstant();
				//If you want additional ability to handle things other than numbers and strings, please modfiy 
				//the below if else structure
				if(answer != null) {
					Class<?> c = answer.getClass();
					if(c.equals(Integer.class)){
						ans = new TimeConstant((Integer)answer);
					}
					else if(c.equals(Long.class)) {
						ans = new TimeConstant((Long)answer);
					}
					else if(c.equals(AlmaLong.class)) {
						ans = new TimeConstant(((AlmaLong)answer).getValue());
					}
					else if(c.equals(String.class)) {
						ans = new StringConstant((String)answer);
					}
					else if(c.equals(StringBuilder.class)) {
						ans = new StringConstant(((StringBuilder)answer).toString());
					}
				}
			ArrayList<FormulaNode> args = new ArrayList<FormulaNode>(template.getChildren());
			args.remove(0);
			args.set(args.size()-1,ans);
			nextPred = new Predicate(template.getName(),args);
		}
		
		public boolean hasPrevious() {
			return !hasNext() && nextPred!=null;
		}

		public FormulaNode previous() {
			next = true;
			return nextPred;
		}

		public boolean hasNext() {
			return next && nextPred!=null;
		}

		public FormulaNode next() {
			next = false;
			return nextPred;
		}

		public void remove() {
		}

	}
	
}

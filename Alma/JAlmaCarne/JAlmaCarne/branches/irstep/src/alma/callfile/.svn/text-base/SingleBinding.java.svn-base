package alma.callfile;

import java.util.*;
import java.lang.reflect.Method;

/**
 * A SingleBinding represents how to change the order of the parameters
 * to make a proper method call. Ex. 
 * 
 * substring(string, start, end, substring) (a predicate in form of logic)
 * 
 * substring("test", 0, 3, X) would make a call to 
 * X = java.lang.String.substring(0, 3) on the object "test".
 * 
 * Here, string would be the primary class (in this case "test"), 
 * start would be param1 (in this case 0), end would be param2 (in this case 3), 
 * and X would be the answer_binding (in this case, "tes")
 * 
 * There can be multiple methods to call in a given binding. 
 * 
 * For consistancy sake, a "term" in this file refers to a predicate terms. 
 * And a "parameter" refers to method calls.
 * 
 */

public class SingleBinding{
	Map<Integer, MethodBinding> bindingsMap = new HashMap<Integer, MethodBinding>();
	List<Method> methods = new ArrayList<Method>();
	
	private class MethodBinding{
		int first, second;
		MethodBinding(){
		}
		MethodBinding(int a, int b){
			this.first = a;
			this.second = b;
		}
		
		int getFirst(){
			return first;
		}
		
		int getSecond(){
			return second;
		}
		
		MethodBinding createBinding(int methodNum, int paramNum){ return null;}
	}
	
	private class InvokerBinding extends MethodBinding{
	}

	public SingleBinding(){
	}
	
	public boolean call(Object [] terms){
		try{
			Object [][] parameters = new Object[methods.size()][];
			Object [] invokers = new Object[methods.size()];
			for(int i=0; i<parameters.length; i++){
				parameters[i] = new Object[methods.get(i).getParameterTypes().length];
			}
			
			for(int i=0; i<terms.length; i++){
				parameters[bindingsMap.get(i).getFirst()][bindingsMap.get(i).getSecond()] = terms[i];
			}
			
			for(int i=0; i<methods.size(); i++){
				//methods.get(i).invoke(obj, args);
			}
			
			return true;
		}catch (Exception e){
			return false;
		}
	}
	
	public void addMethod(Method m){
		methods.add(m);
	}
	
	public void addBinding(int termNum, int parameterNum){
		bindingsMap.put(termNum, new MethodBinding(0, parameterNum));
	}
	
	public void addBindings(int termNum, int[][] coordinates){
		for(int methodNum = 0; methodNum < coordinates.length; methodNum++){
			for(int parameterNum: coordinates[methodNum]){
				addBinding(termNum, methodNum, parameterNum);
			}
		}
	}
	
	public void addBinding(int termNum, int methodNum, int parameterNum){
		bindingsMap.put(termNum, new MethodBinding(methodNum, parameterNum));
	}
	
	public int getMethodNum(int termNum){
		return bindingsMap.get(termNum).getFirst();
	}
	
	public int getParameterNum(int termNum){
		return bindingsMap.get(termNum).getSecond();
	}
}
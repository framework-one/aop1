/**
*
* @author  @markdrew
* @description I am a proxy for the beans, means I can run the methods on the interceptor
*
*/

component output="false" displayname="beanProxy"  {

	variables.interceptors = [];
	variables.targetBean = ""; //the actual bean 
	variables.methodList = ""; //A list of methods. if blank defaults to * (which means all);
	

	function init(Component targetBean, Array interceptors = []){
		variables.targetBean = arguments.targetBean;
		variables.interceptors = arguments.interceptors;
	}

	public function onMissingMethod(methodName,args){
		var organizedArgs = cleanupArguments(methodName,args);
		var result = "";
		try{
			
			if(!hasAround()){
				runBeforeStack(methodName, organizedArgs, variables.targetBean);
				//runOnMethodCallStack(argumentCollection=arguments);
				//if there isn't a onMethod, original call
				result = variables.targetBean[arguments.methodName](argumentCollection=organizedArgs);
			//arguments.result = results;
				runAfterStack(result , methodName, organizedArgs, variables.targetBean);

			}
			else{
				result = runAroundStack(methodName, organizedArgs, variables.targetBean);
			}

			
			return result;
		}catch(Any e){

			if(!hasErrorStack()){
				throw(e);
			}

			runOnErrorStack(argumentCollection=arguments);
		}
		
		
		//return results;
	}

	private function cleanupArguments(methodName, args){
		var organizedArgs = {};
		var positionCount = 1;
		var p = "";
		var targetArgInfo = getMetaData(targetBean[methodName]).parameters;
		loop collection="#args#" item="p"{
			//They are usually numeric here
			var keyName = positionCount;
			if(isNumeric(p) && p LTE ArrayLen(targetArgInfo)){
				keyname = targetArgInfo[p].name;
			}
			organizedArgs[keyname] = args[p];
			positionCount++;

		}
		return organizedArgs;
	}

	private function hasAround(){
		for(var inter in variables.interceptors){
			if(StructKeyExists(inter, "around")){
				return true;
			}
		}
		return false;
	}
	private function hasErrorStack(){

		//loop through the interceptros finding the error methods;

		for(var inter in variables.interceptors){
			if(StructKeyExists(inter, "onError")){
				return true;
			}	
		}
		return false;
	}




	private function runBeforeStack(methodName, args, targetBean){
		for(var inter in variables.interceptors){
			if(StructKeyExists(inter, "before")){
				inter.before(methodName, args, targetBean);
			}
		}
	}

	private function getAroundInterceptorCount(){
		var total = 0;
		for(var inter in variables.interceptors){
			if(StructKeyExists(inter, "around")){
				total++
			}
		}
		return total;
	}

	 
	private function runAroundStack(methodName, args, targetBean) {
		var result = "";
		var totalInterceptors = getAroundInterceptorCount();

		//count around intercept
		var hitCount = 1;
	
		for(var inter in variables.interceptors){
			if(StructKeyExists(inter, "around")){
				
				if(hitCount EQ totalInterceptors){
					inter.last = true;
				}
				else{
					inter.last = false;
					
				}
				result = inter.around(methodName, args, targetBean);
				hitCount++;
			}
		}
		
		return result;
	}

	private function runAfterStack(result, methodName, args, targetBean) {
		for(var inter in variables.interceptors){
			if(StructKeyExists(inter, "after")){
				var retvar = inter.after(result, methodName, args, targetBean);
			}
		}
	}

	private function runOnErrorStack(methodName, args) {
		
		return;
	}
	
}
/**
*
* @author  @markdrew
* @description I am a proxy for the beans, means I can run the methods on the interceptor
* Ohh, all variables are scoped? yes, we are being real careful here. Let's be really pedantic about this here.
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


		var organizedArgs = cleanupArguments(arguments.methodName,arguments.args);
		var result = "";
		try{
			
			if(!hasAround()){
				runBeforeStack(arguments.methodName, organizedArgs, variables.targetBean);
				//runOnMethodCallStack(argumentCollection=arguments);
				//if there isn't a onMethod, original call
				result = variables.targetBean[arguments.methodName](argumentCollection=organizedArgs);
			//arguments.result = results;
				runAfterStack(local.result , arguments.methodName, local.organizedArgs, variables.targetBean);

			}
			else{
				result = runAroundStack(arguments.methodName, local.organizedArgs, variables.targetBean);
			}

			
			return result;
		}catch(Any e){

			if(!hasErrorStack()){
				throw(e);
			}

			runOnErrorStack(arguments.methodName, local.organizedArgs, variables.targetBean, e);
		}
		
		
		//return results;
	}

	private function cleanupArguments(methodName, args){
		var organizedArgs = {};
		var positionCount = 1;
		var p = "";
		var targetArgInfo = getMetaData(variables.targetBean[arguments.methodName]).parameters;
		loop collection="#arguments.args#" item="p"{
			//They are usually numeric here
			var keyName = positionCount;
			if(isNumeric(p) && p LTE ArrayLen(targetArgInfo)){
				keyname = targetArgInfo[p].name;
			}
			organizedArgs[keyname] = arguments.args[p];
			positionCount++;

		}
		return organizedArgs;
	}

	private function hasAround(){
		for(var inter in variables.interceptors){
			if(StructKeyExists(inter.bean, "around")){
				return true;
			}
		}
		return false;
	}
	private function hasErrorStack(){

		//loop through the interceptros finding the error methods;

		for(var inter in variables.interceptors){
			if(StructKeyExists(inter.bean, "onError")){
				return true;
			}	
		}
		return false;
	}




	private function runBeforeStack(methodName, args, targetBean){

		for(var inter in variables.interceptors){
			if(StructKeyExists(inter.bean, "before")){

				if(methodMatches(arguments.methodName, inter.methods)){
					inter.bean.before(arguments.methodName, arguments.args, arguments.targetBean);
				}
			}
		}
	}


	
	public boolean function methodMatches (methodName, matchers) output=false{
		
		//Empty list
		if(!ListLen(arguments.matchers)){
			return true;
		}
		
		if(arguments.methodName EQ arguments.matchers){
			return true;
		}

	
		if(listFindNoCase(arguments.matchers, arguments.methodName, ",", false)){

			return true;
		}
		return false;
	}
	
	

	private function getAroundInterceptorCount(){
		var total = 0;
		for(var inter in variables.interceptors){
			if(StructKeyExists(inter.bean, "around")){
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
			if(StructKeyExists(inter.bean, "around")){
				
				if(hitCount EQ totalInterceptors){
					inter.bean.last = true;
				}
				else{
					inter.bean.last = false;
					
				}
				result = inter.bean.around(arguments.methodName, arguments.args, arguments.targetBean);
				hitCount++;
			}
		}
		
		return result;
	}

	private function runAfterStack(result, methodName, args, targetBean) {
		for(var inter in variables.interceptors){
			if(StructKeyExists(inter.bean, "after")){
				var retvar = inter.bean.after(arguments.result, arguments.methodName, arguments.args, arguments.targetBean);
			}
		}
	}

	private function runOnErrorStack(methodName, organizedArgs, targetBean, error) {

		for(var inter in variables.interceptors){
			if(StructKeyExists(inter.bean, "onError")){
				result = inter.bean.onError(arguments.methodName, arguments.organizedArgs, arguments.targetBean, arguments.error);

			}
		}
	}
	
}
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

		try{
			runBeforeStack(argumentCollection=arguments);
			//runOnMethodCallStack(argumentCollection=arguments);
			var results = variables.targetBean[arguments.methodName](argumentCollection=arguments.args);
			arguments.result = results;
			trace;
			runAfterStack(argumentCollection=arguments);

		}catch(Any e){
			runOnErrorStack(argumentCollection=arguments);
		}
		
		
		return arguments.result;
	}


	private function runBeforeStack(methodName, args){

		for(var inter in variables.interceptors){
			if(StructKeyExists(inter, "before")){
				inter.before(argumentCollection=arguments);
			}
			
		}
	}

	 
	private function runOnMethodCallStack(methodName, args) {
		
		return;
	}

	private function runAfterStack(methodName, args) {
		for(var inter in variables.interceptors){
			if(StructKeyExists(inter, "after")){
				inter.after(argumentCollection=arguments);
			}
			
		}
	}

	private function runOnErrorStack(methodName, args) {
		
		return;
	}
	
}
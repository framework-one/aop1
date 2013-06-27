/*
	I wrap all the functionality of the ioc bean factory and decorate it so that we can use interceptors

*/
component extends="di1.ioc" {

	variables.bf = ""; // our beanFactory

	variables.iStack = {}; //Interceptor stack. This keeps a list of who is intercepting what

	variables.proxies = {};

	function init(){
		super.init(argumentCollection=arguments);

		//Also need to check if there is a "interceptors" folder, and add these as <componentName>Interceptor

		//var InterceptorPath = expandPath("/interceptors");
		//var Interceptors = directoryExists(InterceptorPath) ? directoryList(InterceptorPath,false,"query", "*.cfc") : [];

		return this;
	}

	/*
		returns the original beanFactory
	*/
	function getIOC(){
		return variables.bf;
	}

	function intercept(beanName, interceptorName, methodnames=""){

		if(!StructKeyExists(variables.iStack, arguments.beanName)){
			variables.iStack[arguments.beanName] = ArrayNew(1);
		}

		var InterceptionDefinition = {
				name: arguments.interceptorName,
				methods : arguments.methodNames
		};

		ArrayAppend(variables.iStack[arguments.beanName], InterceptionDefinition);


		return this;
	}

	function hasInterceptors(String BeanName){

		if(StructKeyExists(variables.iStack, arguments.BeanName) && ArrayLen(variables.iStack[arguments.BeanName])){
			return true;
		}

		return false;
	}


	function getInterceptors(String BeanName){
		if(StructKeyExists(variables.iStack, arguments.BeanName)){
			return variables.iStack[arguments.BeanName];
		}
		return [];
	}


	function getBean(BeanName){
		//IF it doesn't have Interceptors just call it au-naturel
		if(!hasInterceptors(arguments.BeanName)){
			return super.getBean(arguments.BeanName);
		}
		
		//It has interceptors so return the beanProxy
		var targetBean = super.getBean(arguments.BeanName);

		//let's go get and instantiate the interceptors!
		var interceptors= [];

		for(var inter in getInterceptors(arguments.BeanName)){

			var interceptorPacket = {bean:super.getBean(inter.name), methods:inter.methods} ;
			ArrayAppend(interceptors,interceptorPacket);
		}
		var beanProxy = new beanProxy(targetBean, interceptors);

		return beanProxy ;

	}

	function onMissingMethod(methodname, args){
		//see if we have this method in the beanFactory

		

			if(structKeyExists(super, arguments.methodname)){
				return super[arguments.methodname](argumentCollection=arguments.args);
			}

			
			
			throw("Method #methodname# doesn't exist");


	}


}
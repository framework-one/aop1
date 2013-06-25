/*
	I wrap all the functionality of the ioc bean factory and decorate it so that we can use interceptors

*/
component {

	variables.bf = ""; // our beanFactory

	variables.iStack = {}; //Interceptor stack. This keeps a list of who is intercepting what

	variables.proxies = {};

	function init(string folders, struct config = { }, string iocPath = ""){

		var iocPath = Len(arguments.iocPath) ? arguments.iocPath & "." : "";
		var ioc = CreateObject("component", "#iocPath#ioc");
		var args = duplicate(arguments);
			StructDelete(args, "iocPath");

		variables.bf = ioc.init(argumentCollection=args);

		//Also need to check if there is a "interceptors" folder, and add these as <componentName>Interceptor

		var InterceptorPath = expandPath("/interceptors");
		var Interceptors = directoryExists(InterceptorPath) ? directoryList(InterceptorPath,false,"query", "*.cfc") : [];

		return this;
	}

	/*
		returns the original beanFactory
	*/
	function getIOC(){
		return variables.bf;
	}

	function intercept(beanName, interceptorName){

		if(!StructKeyExists(variables.iStack, arguments.beanName)){
			variables.iStack[arguments.beanName] = ArrayNew(1);
		}

		ArrayAppend(variables.iStack[arguments.beanName], arguments.interceptorName);


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
			return getIOC().getBean(arguments.BeanName);
		}
		
		//It has interceptors so return the beanProxy
		var targetBean = getIOC().getBean(arguments.BeanName);

		//let's go get and instantiate the interceptors!
		var interceptors= [];

		for(var inter in getInterceptors(arguments.BeanName)){
			ArrayAppend(interceptors,getIOC().getBean(inter));
		}
		var beanProxy = new beanProxy(targetBean, interceptors);

		return beanProxy ;

	}

	function onMissingMethod(methodname, args){
		//see if we have this method in the beanFactory
		if(structKeyExists(variables.bf, arguments.methodname)){
			return variables.bf[arguments.methodname](argumentCollection=arguments.args);
		}
		
		throw("Method #methodname# doesn't exist");
	}


}
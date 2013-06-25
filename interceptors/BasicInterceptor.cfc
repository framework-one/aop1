/**
*
* @author   @markdrew
* @description This is a demo interceptor
*
*/
component output="false" displayname="BasicInterceptor"  {

	public function init(){
		return this;
	}


	//basically it's onMissingMethod!
	function before(){
		arguments.args.1 = "before" & arguments.args.1
	}

	function after(){
		arguments.result = arguments.result & "after";
		
	}

	function onMethodCall(){
		dump(var=arguments, label="onMethod");
	}

	function onError(){
		dump(var=arguments, label="onError");
	}
}
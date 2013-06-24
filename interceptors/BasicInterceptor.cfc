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
		dump(var=arguments, label="before");

	}

	function after(){
		dump(var=arguments, label="after");
	}

	function onMethodCall(){
		dump(var=arguments, label="onMethod");
	}

	function onError(){
		dump(var=arguments, label="onError");
	}
}
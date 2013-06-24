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
		dump(arguments);


	}

	function after(){

	}
}
/**
*
* @file  /Users/markdrew/Sites/aop1/interceptors/BasicAfterAdvice.cfc
* @author
* @description
*
*/

component output="false" {

	this.name = "after";
	function init(name="after"){
		this.name=name;
	}

	function AfterReturning(returnVal, method, args, target){
		ArrayAppend(request.callstack, this.name);
	}
}
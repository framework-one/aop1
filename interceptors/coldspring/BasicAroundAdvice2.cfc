/**
*
* @file  /Users/markdrew/Sites/aop1/interceptors/BasicAroundAdvice.cfc
* @author
* @description
*
*/

component output="false" {

	public function invokeMethod(methodInvocation){

		ArrayAppend(request.callstack, "around2");
		return methodInvocation.proceed();
	}
}
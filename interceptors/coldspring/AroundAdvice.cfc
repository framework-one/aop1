/**
*
* @author
* @description
*
*/

component output="false" {

	this.name = "around";
	function init(name="around"){
		this.name=name;
	}

	public function invokeMethod(methodInvocation){

		ArrayAppend(request.callstack, this.name);
		return methodInvocation.proceed();
	}
}
/**
*
* @file  /Users/markdrew/Sites/aop1/services/Reverse.cfc
* @author  
* @description
*
*/

component output="false" displayname="ReverseService"  {

	public function doReverse(String input){
		param name="request.callstack" default="#[]#";
		ArrayAppend(request.callstack, "doReverse");
		return Reverse(arguments.input);
	}
}
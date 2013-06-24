/**
*
* @file  /Users/markdrew/Sites/aop1/services/Reverse.cfc
* @author  
* @description
*
*/

component output="false" displayname="ReverseService"  {

	public function doReverse(String input){
		return Reverse(input);
	}
}
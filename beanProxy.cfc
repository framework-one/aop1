/**
*
* @file  /Users/markdrew/Sites/aop1/beanProxy.cfc
* @author  @markdrew
* @description I am a bean proxy
*
*/

component output="false" displayname="beanProxy"  {

	public function onMissingMethod(){

		return this;
	}
}
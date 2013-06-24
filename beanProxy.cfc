/**
*
* @author  @markdrew
* @description I am a proxy for the beans, means I can run the methods on the interceptor
*
*/

component output="false" displayname="beanProxy"  {

	public function onMissingMethod(){

		return this;
	}
}
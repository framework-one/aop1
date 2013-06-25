// caution: requires FW/1 2.0 Alpha 5 or later!!
component extends="fw1.org.corfield.framework" {

	
	function setupApplication() {
		var bf = new aop( '/services',{}, "di1");
		setBeanFactory( bf );
		
	}


	function setupRequest(){
		setupApplication();
	}


	function AssertHasMethod(object, method, message="", testname=""){
		Assert(StructKeyExists(arguments.object, arguments.method), true, "Method #arguments.method# doesn't exist in object #getMetaData(arguments.object).fullname#", arguments.testname);
	}

	function Assert(actual,expected , message="", testname=""){
		param name="request.unittests" default="#[]#";


		var utest = {
					expected:arguments.expected
					, actual:arguments.actual
					, passed:true
					, message=""
					, testname=arguments.testname
					, detail=""};

		try{

			if(arguments.expected NEQ arguments.actual){
				
				utest.passed = false;
				utest.message = Len(arguments.message) ? arguments.message : "Expected #arguments.expected# but got #arguments.actual#";
			}
		}
		catch(any e){
			utest.passed = false;
			utest.message = e.message;
			utest.actual = "";
			utest.expected = "";
			utest.detail = e;
		}

		ArrayAppend(request.unittests, utest);
	}
}
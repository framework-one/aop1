// caution: requires FW/1 2.0 Alpha 5 or later!!
component extends="fw1.org.corfield.framework" {

	
	function setupApplication() {
		
		
	}


	function setupRequest(){
	
	}


	function AssertHasMethod(object, method,testname="", message=""){
		Assert(StructKeyExists(arguments.object, arguments.method), true, "Method #arguments.method# doesn't exist in object #getMetaData(arguments.object).fullname#", arguments.testname);
	}

	function AssertTrue(testcase, testname="", message=""){
		Assert(testcase, true, testname, message);
	}

	function AssertEquals(actual, expected, testname="", errormessage=""){
		Assert(actual, expected , testname, errormessage);		
	}

	function Assert(actual, expected , testname="", errormessage=""){
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
				utest.message = Len(arguments.errormessage) ? arguments.errormessage : "Expected #arguments.expected# but got #arguments.actual#";
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
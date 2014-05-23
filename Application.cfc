/*
	Copyright (c) 2013, Mark Drew

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/
component extends="fw1.org.corfield.framework" {
	//Current Assertions, TODO:replace with MXUnit tests

	variables.framework = {
		unhandledPaths="/mxunit"
	};

	function AssertHasMethod(object, method,testname="", message=""){
		Assert(StructKeyExists(arguments.object, arguments.method), true, "Method #arguments.method# doesn't exist in object #getMetaData(arguments.object).fullname#", arguments.testname);
	}

	function AssertTrue(testcase, testname="", message=""){
		Assert(testcase, true, testname, message);
	}

	function AssertEquals(actual, expected, testname="", errormessage=""){
		Assert(arguments.actual, arguments.expected , arguments.testname, arguments.errormessage);
	}

	function Assert(actual, expected , testname="", errormessage=""){
		param name="request.unittests" default="#[]#";


		var utest = {
					expected=arguments.expected
					, actual=arguments.actual
					, passed=true
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
<cfscript>
	param name="attributes.include" default="false";
	param name="attributes.template";
	echo('<pre  class="prettyprint linenums">');
	echo(HTMLEditFormat(FileRead("#attributes.template#")));
	echo("</pre>");
	
	if(attributes.include){
		include template="#attributes.template#";
	}
</cfscript>

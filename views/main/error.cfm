<cfset request.layout = false />
<!--- courtesy of Andreas Schuldhaus --->
<div style="width: 50%; color: red; border: 2px dotted red; background-color: #f9f9f9; padding: 10px;">
	<h1 style="color: red;">ERROR!</h1>
	<cfoutput>	
	<h2 style="color: red;">#request.exception.message#</h2>
	</cfoutput>
	<div style="width: 100%; text-align: left;">
		<p><b>An error occurred!</b></p>
		<cfoutput>
			<cfif structKeyExists( request, 'failedAction' )>
				<b>Action:</b> #request.failedAction#<br/>
			<cfelse>
				<b>Action:</b> unknown<br/>
			</cfif>

<!--- If view doesn't exist, lets use sublime to create it. 
	/home/views/main/createaccount.cfm

	How do we find out if there is a controller?

 --->
 
 	<cfif request.exception.type EQ "FW1.viewNotFound">
 		<cfset filePath = request.exception.Detail>
 		<cfset filePath = ReplaceNoCase(filePath, "' does not exist.", "")>
 		<cfset filePath = ReplaceNoCase(filePath, "'", "")>
 		Create View (<a href="subl://open/?url=file://#expandPath(filePath)#">#filePath#</a>)
 	</cfif>
<!--- 
			<b>Error:</b> #request.exception.cause.message#<br/>
			<b>Type:</b> #request.exception.cause.type#<br/>
			<b>Details:</b> #request.exception.cause.detail#<br/>
			 --->
			 <cfdump var="#request.exception#" />
		</cfoutput>
	</div>
</div>



<cfdump var="#request.exception#" />
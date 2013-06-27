<cfparam name="request.unittests" default="#[]#">
<style type="text/css">
	
.failed{
	color: red;
}
.passed{
	color: green;
}

</style>
<cfoutput>
<table>
	<thead>
		<th>Passed?</th>
		<th>Name</th>
		<th>Message</th>
		<th>Expected</th>
		<th>Actual</th>
	</thead>
	<tbody>
	<cfloop array="#request.unittests#" item="ut" index="t">

		<cfset class = ut.passed?"passed":"failed">
		<tr class="#class#">
			<td>#ut.passed#</td>
			<td>#ut.testname#</td>
			<td>#ut.message#
				<cfif Len(ut.detail)>
					<cfdump var="#ut.detail#" expand="false">
				</cfif>

			</td>
			<td>#ut.expected#</td>
			<td>#ut.actual#</td>
		</tr>
	</cfloop>
	</tbody>
</table>
</cfoutput>
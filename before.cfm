<cfsilent>

<cfif thisTag.executionMode eq "start">
  <cfset exitMethod = caller.__cfspecRunner.beforeStartTag(attributes)>
  <cfif exitMethod neq "">
    <cfexit method="#exitMethod#">
  </cfif>
<cfelse>
  <cfset exitMethod = caller.__cfspecRunner.beforeEndTag(attributes)>
  <cfif exitMethod neq "">
    <cfexit method="#exitMethod#">
  </cfif>
</cfif>

</cfsilent>
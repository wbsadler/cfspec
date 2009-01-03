<cfcomponent output="false"><cfscript>

	function inspect(value) {
		var keys = "";
		var data = "";
		var row = "";
		var s = "";
		var i = "";
		var j = "";
		if (isSimpleValue(value)) {
			if (isNumeric(value)) return value;
			if (isDate(value)) return dateFormat(value, "yyyy-mm-dd") & " " & timeFormat(value, "hh:mm tt");
			if (listFindNoCase("true,false,yes,no", value)) return iif(value, 'true', 'false');
			return "'#replace(replace(value, '\', '\\', 'all'), "'", "\'", 'all')#'";
		} else if (isObject(value)) {
			return value.inspect();
		} else if (isStruct(value)) {
			keys = listToArray(listSort(structKeyList(value), "textnocase"));
			for (i = 1; i <= arrayLen(keys); i++) {
				s = listAppend(s, "#keys[i]#=#inspect(value[keys[i]])#");
			}
			return "{#s#}";
		} else if (isArray(value)) {
			for (i = 1; i <= arrayLen(value); i++) {
				s = listAppend(s, inspect(value[i]));
			}
			return "[#s#]";
		} else if (isQuery(value)) {
			keys = listToArray(listSort(value.columnList, "textnocase"));
			for (i = 1; i <= arrayLen(keys); i++) {
				s = listAppend(s, "#inspect(keys[i])#");
			}
			for (i = 1; i <= value.recordCount; i++) {
				row = "";
				for (j = 1; j <= arrayLen(keys); j++) {
					row = listAppend(row, inspect(value[keys[j]][i]));
				}
				data = listAppend(data, "[#row#]");
			}
			return "{COLUMNS=[#s#],DATA=[#data#]}";
		}
		return serializeJson(value);
	}

	function isDelayed() {
		return false;
	}

</cfscript>

  <cffunction name="throw">
    <cfargument name="type" default="Application">
    <cfargument name="message" default="">
    <cfargument name="detail" default="">
    <cfthrow type="#type#" message="#message#" detail="#detail#">
  </cffunction>

  <cffunction name="rethrow">
    <cfargument name="object">
    <cfthrow object="#object#">
  </cffunction>

</cfcomponent>
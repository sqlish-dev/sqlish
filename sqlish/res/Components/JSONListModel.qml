/* JSONListModel - a QML ListModel with JSON and JSONPath support
 *
 * Copyright (c) 2012 Romain Pokrzywka (KDAB) (romain@kdab.com)
 * Licensed under the MIT licence (http://opensource.org/licenses/mit-license.php)
 */

import QtQuick 2.0
import "jsonpath.js" as JSONPath

Item {
	property string source: ""
	property string json: ""
	property string query: ""

	property ListModel model : ListModel { id: jsonModel }
	property alias count: jsonModel.count

	onSourceChanged: {
		var xhr = new XMLHttpRequest;
		xhr.open("GET", source);
		xhr.onreadystatechange = function() {
			if (xhr.readyState === XMLHttpRequest.DONE)
				json = xhr.responseText;
		}
		xhr.send();
	}

	onJsonChanged: updateJSONModel()
	onQueryChanged: updateJSONModel()

	function updateJSONModel() {
		jsonModel.clear();

		if(!json)
			return;

		var jsonObject
		
		if(json)
			jsonObject = JSON.parse(json);

		if(query)
			jsonObject = JSONPath.jsonPath(jsonObject, query);

		console.log(JSON.stringify(jsonObject))
		for(var key in jsonObject) {
			var jo = jsonObject[key];
			jsonModel.append(jo);
		}
	}
}

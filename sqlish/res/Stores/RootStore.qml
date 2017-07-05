import QtQuick 2.0
import QuickFlux 1.1
import "../actions"
import "../components"

Store {
	bindSource: AppDispatcher

	property ListModel userInfoModel : ListModel {}

	function setUserInfoModel(jsonObject) {
		userInfoModel.clear()
		for(var key in jsonObject) {
			userInfoModel.append(jsonObject[key]);
		}
	}

	Filter {
		type: ActionTypes.setUserInfo
		onDispatched: {
			setUserInfoModel(message.jsonObject.data)
		}
	}
}

import QtQuick 2.0
import QuickFlux 1.1
import QtQuick.Dialogs 1.2
import "../actions"
import "../views"
import "../stores"

Middleware {
	filterFunctionEnabled: true

	function noError(jsonObject) {
		if(jsonObject.command.result === false) {
			quitMessageBox(qsTr("서버와 통신에 실패하였습니다.<BR/>") + qsTr("관리자에게 문의하여 주십시오."))
			return false
		} else if(jsonObject.command.errorMessage) {
			messageBox(jsonObject.command.errorMessage)
			return false
		}
		return true
	}

	function reqLogin(message) {
		var jsonObject = JSON.parse(SvrCon.reqLogin(message.id, message.pw))
		if(noError(jsonObject)) {
			var param = {
				item: mainWindow.mainView
				, properties: {
					visible: true
				}
			}
			next(ActionTypes.navigateTo, param)
		}
	}

	function reqUserInfo(message) {
		var jsonObject = JSON.parse(SvrCon.reqUserInfo(message.refresh))
		if(noError(jsonObject)) {
			next(ActionTypes.setUserInfo, {jsonObject: jsonObject})
		}
	}

	function reqChangePassword(message) {
		var jsonObject = JSON.parse(SvrCon.reqChangePassword(message.currentPw, message.newPw))
		if(noError(jsonObject)) {
			var param = {
				item: mainWindow.mainView
				, properties: {
					visible: true
				}
			}
			next(ActionTypes.navigateTo, param)
		}
	}
}

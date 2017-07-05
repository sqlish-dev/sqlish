pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import "."

ActionCreator {
	function navigateTo(item, properties) {
		dispatch(ActionTypes.navigateTo,
							   {item: item,
								properties: properties});
	}

	function navigateBack() {
		dispatch(ActionTypes.navigateBack);
	}

	signal reqLogin(string id, string pw)
	signal reqUserInfo(bool refresh)
	signal reqChangePassword(string currentPw, string newPw)
}

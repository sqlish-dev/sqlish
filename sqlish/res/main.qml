import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "Components"

ApplicationWindow {
	visible: true
	width: 800
	height: 600
	title: Qt.application.name

	SystemTrayIcon {}

	RowLayout {
		id: rowLayout
		anchors.fill: parent

		ObjectBrowser {}
	}
}

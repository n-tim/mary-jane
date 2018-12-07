import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    visible: true
    width: 300
    height: 500
    title: qsTr("Stack")

//    header: ToolBar {
//        contentHeight: toolButton.implicitHeight

//        ToolButton {
//            id: toolButton
//            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
//            font.pixelSize: Qt.application.font.pixelSize * 1.6
//            onClicked: {
//                if (stackView.depth > 1) {
//                    stackView.pop()
//                } else {
//                    drawer.open()
//                }
//            }
//        }

//        Label {
//            text: stackView.currentItem.title
//            anchors.centerIn: parent
//        }
//    }

//    Drawer {
//        id: drawer
//        width: window.width * 0.66
//        height: window.height

//        ColumnLayout {
//            anchors.fill: parent

//            ItemDelegate {
//                text: qsTr("Settings")
//                Layout.fillWidth: true
//                onClicked: {
//                    //stackView.push()
//                    drawer.close()
//                }
//            }
//            Item {
//                Layout.fillHeight: true
//                Layout.fillWidth: true

//                Label {
//                    text: "about"
//                    anchors.centerIn: parent
//                }
//            }
//        }
//    }

    StackView {
        id: stackView
        initialItem: Component {
            WelcomePage {
                stack: stackView
            }
        }
        anchors.fill: parent
    }
}

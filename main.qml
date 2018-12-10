import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    visible: true
    width: 300
    height: 500
    title: qsTr("Stack")

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    header: ToolBar {
        RowLayout {
            ToolButton {
                id: toolButton
                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop()
                    }
                }

            }

            Label {
                text: "Page text"
                font.italic: true

                horizontalAlignment: Qt.AlignRight
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }
    }

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

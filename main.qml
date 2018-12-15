import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    visible: true
    width: 300
    height: 533
    title: "Articulus et Bahila"

    Material.theme: Material.Light
    //Material.background: Material.White
    Material.primary: "#0020ff"
    Material.foreground: Material.White
    Material.accent: "#0020ff"

    header: ToolBar {
        visible: stackView.depth > 1
        RowLayout {
            Button {
                id: toolButton
                flat: true
                padding: 0
                //enabled: stackView.depth > 1
                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop()
                    }
                }

                icon.source: "qrc:/icons/baseline_arrow_back_ios_white_48dp.png"
                Material.theme: Material.Dark

//                indicator: Image {
//                    visible: stackView.depth > 1
//                    anchors.fill: parent
//                    anchors.margins: parent.width * 0.2
//                    fillMode: Image.PreserveAspectFit
//                    source: "qrc:/icons/baseline_arrow_back_ios_white_48dp.png"
//                }
            }

            Label {
                text: "Articulus et Bahila"

                elide: Label.ElideRight
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                //Layout.fillWidth: true

                //Layout.alignment: Qt.AlignRight
                Layout.fillWidth: true

                Material.theme: Material.Dark

            }
        }
    }

    StackView {
        id: stackView
        initialItem: Component {
            WelcomePage {
                stack: stackView
            }
        }
        anchors.fill: parent
    }

    onClosing: {
        if (stackView.depth > 1) {
            close.accepted = false
            stackView.pop();
        } else {
            return;
        }
    }
}

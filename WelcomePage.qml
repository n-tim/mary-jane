import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.2

Page {
    property var stack: null

    Rectangle {
        anchors.fill: parent

        color: "#0020ff"

        Button {
            anchors.fill: parent
            flat: true

            AnimatedImage {
                anchors.fill: parent

                fillMode: Image.PreserveAspectFit


                autoTransform: true

                asynchronous: true
                source: "qrc:/cost.gif"
            }

            onClicked: {
                stack.push(Qt.resolvedUrl("FrameChoosePage.qml"), { "stack": stack });
            }
        }
    }
}

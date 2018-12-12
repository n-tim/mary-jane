import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.2

Page {
    property var stack: null

    Button {
        anchors.centerIn: parent
        text: "start"
        flat: true
        onClicked: {
            stack.push(Qt.resolvedUrl("FrameChoosePage.qml"), { "stack": stack });
        }
    }
}

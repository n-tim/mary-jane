import QtQuick 2.9
import QtQuick.Controls 2.4

Page {
    property var stack: null
    Button {
        //sanchors.centerIn: parent
        text: "start"
        onClicked: {
            stack.push(Qt.resolvedUrl("FrameChoosePage.qml"), { "stack": stack });
        }
    }
}

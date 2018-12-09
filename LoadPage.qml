import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtQuick.Dialogs 1.2

Page {
    property var stack: null
    ColumnLayout {
        anchors.fill: parent

        Image {
            id: preview
            Layout.fillWidth: true
            Layout.minimumHeight: width

            sourceSize.width: width
            sourceSize.height: height
            autoTransform: true

            asynchronous: true
            source: "storage/emulated/0/Pictures/MaryJane_20181202_201044_3233264120936053090.png"
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "camera"
            onClicked: {
                maryJane.cameraButtonPressed();
                //preview.source = maryJane.getImagePath();
            }
        }
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "load"
            onClicked: {
                maryJane.loadButtonPressed();
                //preview.source = maryJane.getImagePath();
            }
        }
        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "continue"
            onClicked: {
                stack.push(Qt.resolvedUrl("EditPage.qml"), {"photoPath": preview.source, "stack": stack});
            }
        }
    }

    Connections {
        target: maryJane
        onImageLoaded: {
            console.log("image loaded: " + path);
            preview.source = /*"file:///" + */path;
        }
    }
}

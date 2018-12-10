import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtQuick.Dialogs 1.2

Page {
    property var stack: null

    property string framePath;
    property string photoPath;

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
            source: "~/test.jpg"
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
                stack.push(Qt.resolvedUrl("EditPage.qml"), {"photoPath": preview.source, "framePath": framePath, "stack": stack});
            }
        }
    }

    Connections {
        target: maryJane
        onImageLoaded: {
            console.log("image loaded: " + path);
            photoPath = path;
            preview.source = /*"file:///" + */path;
        }
    }
}

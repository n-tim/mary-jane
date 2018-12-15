import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtQuick.Dialogs 1.2

Page {
    property var stack: null

    property string framePath;
    property string photoPath;

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            flat: true
            onClicked: {
                maryJane.cameraButtonPressed();
            }

            icon.source: "qrc:/icons/baseline_photo_camera_white_48dp.png"

//            indicator: Image {
//                anchors.centerIn: parent
//                fillMode: Image.PreserveAspectFit
//                source: "qrc:/icons/baseline_photo_camera_white_48dp.png"
//            }
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            flat: true
            onClicked: {
                maryJane.loadButtonPressed();
            }

            indicator: Image {
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                source: "qrc:/icons/baseline_photo_library_white_48dp.png"
            }
        }
    }

    Connections {
        target: maryJane
        onImageLoaded: {
            console.log("image loaded: " + path);
            photoPath = path;
            stack.push(Qt.resolvedUrl("EditPage.qml"), {"photoPath": photoPath, "framePath": framePath, "stack": stack});
        }
    }
}

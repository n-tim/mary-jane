import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtQuick.Dialogs 1.2

Page {

    property var stack: null

    property string photoPath;

    ColumnLayout {
        anchors.fill: parent

        Item {
            Layout.fillWidth: true
            Layout.minimumHeight: width

            clip: true

            antialiasing: true

            Image {
                id: target

                width: parent.width

                x: (parent.width - width) / 2
                y: (parent.height - height) / 2

                source: photoPath
                asynchronous: true
                autoTransform: true

                antialiasing: true
                fillMode: Image.PreserveAspectFit

                onRotationChanged: {
                    console.log("rotation = " + rotation);
                }
            }

            PinchArea {
                anchors.fill: parent

                pinch.target: target

                pinch.minimumRotation: -360
                pinch.maximumRotation: 360
                pinch.minimumScale: 0.001
                pinch.maximumScale: 100
                pinch.dragAxis: Pinch.XAndYAxis



                MouseArea {
                    anchors.fill: parent

                    drag.target: target
                    scrollGestureEnabled: false
                }

                Rectangle {
                    anchors.fill: parent

                    color: "transparent"
                    border.width: width * 0.05
                    border.color: "black"

                    Label {
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right

                        anchors.bottomMargin: 20
                        anchors.rightMargin: 20

                        text: "frame"
                        font.pixelSize: 30
                    }
                }

            }
        }

        RowLayout {
            Layout.fillWidth: true

            Button {
                text: "save"
                flat: true

                onClicked: {
                    maryJane.saveButtonPressed();
                }
            }

            Button {
                text: "share"
                flat: true

                onClicked: {
                    maryJane.shareButtonPressed();
                }
            }

            Button {
                text: "reset"
                flat: true
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

}

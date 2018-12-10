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

        Item {
            id: scene
            Layout.fillWidth: true
            Layout.minimumHeight: frame.height

            clip: true

            antialiasing: true

            Image {
                id: target

                width: parent.width

                x: 0
                y: 0

                source: photoPath
                asynchronous: true
                autoTransform: true

                antialiasing: true
                fillMode: Image.PreserveAspectFit

                onRotationChanged: {
                    console.log("rotation = " + rotation);
                }

                onScaleChanged: {
                    console.log("scale = " + scale);
                }

                onXChanged: {
                    console.log("x = " + x);
                }

                onYChanged: {
                    console.log("y = " + y);
                }

                onWidthChanged: {
                    console.log("width = " + width);
                }
            }

            PinchArea {
                anchors.fill: parent

                pinch.target: target

                pinch.minimumRotation: -360
                pinch.maximumRotation: 360
                pinch.minimumScale: 0.1
                pinch.maximumScale: 10
                pinch.dragAxis: Pinch.XAndYAxis



                MouseArea {
                    anchors.fill: parent

                    drag.target: target
                    scrollGestureEnabled: false
                }

                Image {
                    id: frame
                    width: parent.width

                    fillMode: Image.PreserveAspectFit


                    autoTransform: true

                    asynchronous: true
                    source: framePath
                }

//                Rectangle {
//                    anchors.fill: parent

//                    color: "transparent"
//                    border.width: width * 0.05
//                    border.color: "black"

//                    Label {
//                        anchors.bottom: parent.bottom
//                        anchors.right: parent.right

//                        anchors.bottomMargin: 20
//                        anchors.rightMargin: 20

//                        text: "frame"
//                        font.pixelSize: 30
//                    }
//                }

            }
        }

        RowLayout {
            Layout.fillWidth: true

            Button {
                text: "save"
                flat: true

                onClicked: {
                    console.log("targetX = " + target.x);
                    console.log("targetY = " + target.y);
                    var mappedPoint = mapToItem(target, frame.x, frame.y);

                    console.log("mappedX = " + mappedPoint.x);
                    console.log("mappedY = " + mappedPoint.y);

                    maryJane.saveButtonPressed(photoPath, framePath, target.rotation, target.scale, mappedPoint.x / frame.width, mappedPoint.y / frame.height);

                    //var fileName = maryJane.getImagePath();

//                    scene.grabToImage(function(result) {
//                        result.saveToFile(fileName);
//                    });
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


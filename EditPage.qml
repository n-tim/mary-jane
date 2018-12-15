import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtQuick.Dialogs 1.2

Page {
    id: root

    property var stack: null

    property string framePath;
    property string photoPath;

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 10

        spacing: 10

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
                    console.log("rotation.x = " + x);
                    console.log("rotation.y = " + y);
                }

                onScaleChanged: {
                    console.log("scale = " + scale);
                    console.log("scale.x = " + x);
                    console.log("scale.y = " + y);
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
            }
        }

        RowLayout {
            Layout.fillWidth: true

            spacing: 0

            Button {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                Layout.fillWidth: true
                flat: true

                icon.source: "qrc:/icons/baseline_save_alt_white_48dp.png"

                text: "сохранить"

                onClicked: {
                    console.log("targetX = " + target.x);
                    console.log("targetY = " + target.y);
                    busyPopup.open();
                    maryJane.saveButtonPressed(photoPath, framePath, target.rotation, target.scale, (target.x + target.width * 0.5) / frame.width, (target.y  + target.height * 0.5) / frame.height);
                }
            }



//            Button {
//                flat: true

//                onClicked: {
//                    target.width = scene.width
//                    target.x = 0;
//                    target.y = 0;
//                    target.scale = 1;
//                    target.rotation = 0;
//                }

//                indicator: Image {
//                    anchors.fill: parent
//                    //anchors.margins: parent.width * 0.2
//                    fillMode: Image.PreserveAspectFit
//                    source: "qrc:/icons/baseline_clear_white_48dp.png"
//                }
//            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    Popup {
        id: busyPopup

        focus: false
        modal: true

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        padding: 0

        background: Rectangle { color: "transparent" }

        BusyIndicator {
            id: busyIndicator
            //parent: ApplicationWindow.overlay
            anchors.centerIn: parent
            running: busyPopup.visible
        }

        closePolicy: Popup.NoAutoClose
    }

    Popup {
        id: popup
        parent: root
        property string path: null
        width: parent.width * 0.7
        height: parent.height * 0.7
        modal: true
        focus: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        ColumnLayout {
            anchors.fill: parent

//            Rectangle {
//                Layout.fillWidth: true
//                Layout.fillHeight: true

//                color: "blue"
//            }

            Image {
                Layout.fillWidth: true
                Layout.fillHeight: true

                fillMode: Image.PreserveAspectFit


                autoTransform: true

                asynchronous: true
                source: "file:///" + popup.path
            }

            Button {
                flat: true

                icon.source: "qrc:/icons/baseline_share_white_48dp.png"

                text: "поделиться"

                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

//                RowLayout {
//                    Image {
//                        //anchors.margins: parent.width * 0.2
//                        fillMode: Image.PreserveAspectFit
//                        source: "qrc:/icons/baseline_share_white_48dp.png"
//                    }
//                    Label {
//                        text: "поделиться"
//                    }
//                }



                onClicked: {
                    maryJane.shareButtonPressed(popup.path);
                    popup.close();
                }
            }

        }
    }

    Connections {
        target: maryJane
        onSaved: {
            busyPopup.close();
            popup.path = path
            popup.open();
        }
    }

}


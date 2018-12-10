import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtQuick.Dialogs 1.2

Page {

    property var stack: null
    //anchors.fill: parent

    ListModel {
        id: framesModel

        ListElement {
            path: "qrc:/frames/10_ba.png"
        }

        ListElement {
            path: "qrc:/frames/1_fountain.png"
        }

        ListElement {
            path: "qrc:/frames/2_tiger.png"
        }

        ListElement {
            path: "qrc:/frames/3_clumba.png"
        }

        ListElement {
            path: "qrc:/frames/4_derevo.png"
        }

        ListElement {
            path: "qrc:/frames/5_birthday.png"
        }

        ListElement {
            path: "qrc:/frames/8_seno.png"
        }

        ListElement {
            path: "qrc:/frames/9_shlyapki.png"
        }
    }

    Component {
        id: delegate

        Item {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            Image {
                anchors.fill: parent
                anchors.margins: 10

                sourceSize.width: width
                sourceSize.height: height
                autoTransform: true

                asynchronous: true
                source: model.path

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        //GridView.view.currentIndex = index;

                        console.log("clicked!");
                        stack.push(Qt.resolvedUrl("LoadPage.qml"), { "framePath": model.path, "stack": stack });
                    }
                }
            }
        }
    }

    GridView {
        anchors.fill: parent

        property int columns: 2

        cellWidth: width / columns
        cellHeight: cellWidth

        model: framesModel
        delegate: delegate
    }

}

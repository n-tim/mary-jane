import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtQuick.Dialogs 1.2

Page {
    property var stack: null

    ListModel {
        id: framesModel

        ListElement { path: "qrc:/frames/1.png"; }
        ListElement { path: "qrc:/frames/2.png"; }
        ListElement { path: "qrc:/frames/3.png"; }
        ListElement { path: "qrc:/frames/4.png"; }
        ListElement { path: "qrc:/frames/5.png"; }
        ListElement { path: "qrc:/frames/6.png"; }
        ListElement { path: "qrc:/frames/7.png"; }
        ListElement { path: "qrc:/frames/8.png"; }
        ListElement { path: "qrc:/frames/9.png"; }
        ListElement { path: "qrc:/frames/10.png"; }
        ListElement { path: "qrc:/frames/11.png"; }
        ListElement { path: "qrc:/frames/12.png"; }
        ListElement { path: "qrc:/frames/13.png"; }
        ListElement { path: "qrc:/frames/14.png"; }
        ListElement { path: "qrc:/frames/15.png"; }
        ListElement { path: "qrc:/frames/16.png"; }
        ListElement { path: "qrc:/frames/17.png"; }
    }

    Component {
        id: delegate

        Item {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            Button {
                anchors.fill: parent
                flat: true
                padding: 0

                Image {
                    anchors.fill: parent
                    anchors.margins: 15

                    sourceSize.width: width
                    sourceSize.height: height
                    autoTransform: true

                    fillMode: Image.PreserveAspectFit

                    asynchronous: true
                    source: model.path
                }

                onClicked: {
                    //GridView.view.currentIndex = index;

                    console.log("clicked!");
                    stack.push(Qt.resolvedUrl("LoadPage.qml"), { "framePath": model.path, "stack": stack });
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

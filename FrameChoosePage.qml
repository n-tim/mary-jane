import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtQuick.Dialogs 1.2

Page {

    property var stack: null
    //anchors.fill: parent

    ListModel {
        id: testModel

        ListElement {
            color: "red"
        }

        ListElement {
            color: "blue"
        }

        ListElement {
            color: "yellow"
        }

        ListElement {
            color: "black"
        }

        ListElement {
            color: "red"
        }

        ListElement {
            color: "blue"
        }

        ListElement {
            color: "yellow"
        }

        ListElement {
            color: "black"
        }
    }

    Component {
        id: delegate

        Item {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight
            Rectangle {
                anchors.fill: parent
                anchors.margins: 10
                //width: height
                //height: PathView.view.height

                //y: PathView.isCurrentItem && !PathView.view.moving ? 50 : 0

                //scale: PathView.isCurrentItem && !PathView.view.moving ? 1.2 : 1// PathView.iconScale
                //opacity: PathView.iconOpacity
                //z: PathView.iconOrder

                border.color: "black"
                border.width: 2
                //color: model.color
                //Behavior on scale { NumberAnimation {}}

                //property real rot: PathView.isCurrentItem ? 0 : (PathView.iconAngle > 0 ? 45 : -45)

                //transform: Rotation { origin.x: width/2; origin.y: 0; axis { x: 0; y: 1; z: 0 } angle: rot }
                //Behavior on transform { NumberAnimation {} }

                Label {
                    anchors.centerIn: parent
                    font.pixelSize: parent.width / 3
                    text: index
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        //GridView.view.currentIndex = index;

                        console.log("clicked!");
                        stack.push(Qt.resolvedUrl("LoadPage.qml"), { "stack": stack });
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

        model: 20
        delegate: delegate
    }

}

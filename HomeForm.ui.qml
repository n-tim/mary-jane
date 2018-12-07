import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    width: 600
    height: 400

    title: qsTr("Home")
    ListModel {
          ListElement {
              name: "Bill Jones"
              icon: "pics/qtlogo.png"
          }
          ListElement {
              name: "Jane Doe"
              icon: "pics/qtlogo.png"
          }
          ListElement {
              name: "John Smith"
              icon: "pics/qtlogo.png"
          }
      }ListModel {
        ListElement {
            name: "Bill Jones"
            icon: "pics/qtlogo.png"
        }
        ListElement {
            name: "Jane Doe"
            icon: "pics/qtlogo.png"
        }
        ListElement {
            name: "John Smith"
            icon: "pics/qtlogo.png"
        }
    }ListModel {
        ListElement {
            name: "Bill Jones"
            icon: "pics/qtlogo.png"
        }
        ListElement {
            name: "Jane Doe"
            icon: "pics/qtlogo.png"
        }
        ListElement {
            name: "John Smith"
            icon: "pics/qtlogo.png"
        }
    }ListElement {
        color: "red"
    }ListElement {
        color: "red"
    }ListElement {
        color: "red"
    }ListElement {
        color: "red"
    }ListElement {
        color: "red"
    }ListElement {
        color: "red"
    }ListElement {
        color: "red"
    }
    PathView {
              anchors.fill: parent
              model: ContactModel {}
              delegate: delegate
              path: Path {
                  startX: 120; startY: 100
                  PathQuad { x: 120; y: 25; controlX: 260; controlY: 75 }
                  PathQuad { x: 120; y: 100; controlX: -20; controlY: 75 }
              }
          }PathView {
        anchors.fill: parent
        model: ContactModel {}
        delegate: delegate
        path: Path {
            startX: 120; startY: 100
            PathQuad { x: 120; y: 25; controlX: 260; controlY: 75 }
            PathQuad { x: 120; y: 100; controlX: -20; controlY: 75 }
        }
    }PathView {
        anchors.fill: parent
        model: ContactModel {}
        delegate: delegate
        path: Path {
            startX: 120; startY: 100
            PathQuad { x: 120; y: 25; controlX: 260; controlY: 75 }
            PathQuad { x: 120; y: 100; controlX: -20; controlY: 75 }
        }
    }PathView {
        model: testModel

    }PathView {
        model: testModel

    }PathView {
        model: testModel

    }PathView {
        model: testModel

    }PathView {
        model: testModel

    }PathView {
        model: testModel

    }
    path: Path {
        startX: 120; startY: 100
        PathQuad { x: 120; y: 25; controlX: 260; controlY: 75 }
        PathQuad { x: 120; y: 100; controlX: -20; controlY: 75 }
    }
    path: Path {
        startX: 120; startY: 100
        PathQuad { x: 120; y: 25; controlX: 260; controlY: 75 }
        PathQuad { x: 120; y: 100; controlX: -20; controlY: 75 }
    }
    Label {
        text: qsTr("You are on the home page.")
        anchors.centerIn: parent
    }
}

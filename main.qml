import QtQuick
import QtQuick.Controls 2.0
import QtQuick.Dialogs
import QtQuick.Layouts 1.3
import myImage 1.0
Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Simple Gallery")
    color: "#262626"

    Rectangle{
        id: bar
        height: 30
        color:"#1a1a1a"
        visible:true
        anchors.left: parent.left
        anchors.right: parent.right

        FolderDialog{
            id: folderDialog
            onCurrentFolderChanged:tableModel.changeDirectory(folderDialog.currentFolder)

        }

        MyButton{
            id:openButton
            onClicked: folderDialog.open()
            anchors.left: parent.left
        }

        Text{
            id: location
            text: folderDialog.currentFolder
            anchors.left: openButton.right
            height: parent.height
            width: parent.width-openButton.width-listMode.width-tableMode.width-tableMode.anchors.leftMargin-pathMode.width-pathMode.anchors.leftMargin
            elide: Text.ElideLeft
            verticalAlignment: Text.AlignVCenter
            color: "#f2f2f2"
        }

        MyButton{
            id:listMode
            text:"L"
            anchors.left: location.right
            onClicked:{
                tableView.visible = false
                pathView.visible = false
                tableModel.changeColumnCount(1)
                listView.forceLayout()
                listView.visible = true

            }
        }

        MyButton{
            id:tableMode
            text:"T"
            anchors.left: listMode.right
            anchors.leftMargin: 2
            onClicked:{
                listView.visible = false
                pathView.visible = false
                tableModel.changeColumnCount(3)
                tableView.forceLayout()
                tableView.visible = true

            }
        }

        MyButton{
            id:pathMode
            text:"P"
            anchors.left: tableMode.right
            anchors.leftMargin: 2
            onClicked:{
                listView.visible = false
                tableView.visible = false
                tableModel.changeColumnCount(1)
                pathView.visible = true

            }
        }

    }

    ImageTable{
       id:tableModel
    }

    ListView{
        id: listView
        anchors.top: bar.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width/2
        height:parent.height-bar.height
        clip: true
        model:tableModel
        delegate: MyDelegate{
            implicitWidth: listView.width
        }
    }

    TableView{
        id: tableView
        anchors.top: bar.bottom
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width
        height:parent.height-bar.height
        clip: true
        model: tableModel
        onWidthChanged: forceLayout()
        onHeightChanged: forceLayout()
        delegate: MyDelegate{
            implicitWidth: tableView.width/3
        }

        Popup{
            id: popup
            width: parent.width >= 40 ? parent.width - 40 : 0
            height: parent.height >= 40 ? parent.height - 40 : 0
            x: Math.round((parent.width - width) / 2)
            y: Math.round((parent.height - height) / 2)
            padding:2
            background: Rectangle {
                    anchors.fill: popup
                    color: "#000000"
                    opacity: 0.9
            }
            Image{
                id: poimage
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        }

    }

    PathView{
        id: pathView
        visible:false
        anchors.top: bar.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width
        height:parent.height-bar.height
        clip: true
        property int delegateWidth:parent.width/2
        property int delegateHeight:parent.height/2
        model: tableModel
        delegate: MyDelegate{
            id: pathDelegate
            scale: PathView.scale
            z: PathView.z
            opacity:PathView.opacity
            implicitWidth : pathView.delegateWidth
            implicitHeight: pathView.delegateHeight

        }
        path: Path {
            //center
            startX: pathView.width/2  ; startY: pathView.height/2 + pathView.delegateHeight/4
            PathAttribute{name: "opacity"; value: 1.0}
            PathAttribute{name: "scale"; value: 1.0}
            PathAttribute{name: "z"; value:0}
            //Right top
            PathLine {x: pathView.width/16 ; y:pathView.delegateHeight/8;}
            PathAttribute{name: "opacity"; value: 0.75}
            PathAttribute{name: "scale"; value: 0.25}
            PathAttribute{name: "z"; value:-1}
            //center top
            PathLine {x: pathView.width/2 ; y: pathView.delegateHeight/40;}
            PathAttribute{name: "opacity"; value: 0.5}
            PathAttribute{name: "scale"; value: 0.05}
            PathAttribute{name: "z"; value:-2}
            //LeftTop
            PathLine {x:pathView.width - pathView.width/16; y:pathView.delegateHeight/8 ;}
            PathAttribute{name: "opacity"; value: 0.75}
            PathAttribute{name: "scale"; value: 0.25}
            PathAttribute{name: "z"; value:-1}
            //center
            PathLine {x: pathView.width/2; y:pathView.height/2 + pathView.delegateHeight/4;}

        }
    }
}

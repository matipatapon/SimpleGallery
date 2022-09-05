import QtQuick

Rectangle{
    implicitHeight: width/16*9
    color:"transparent"
    id: rect
        Image{
            id: img
            width:parent.width-10
            height:parent.height-10
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: model.source
            MouseArea{
                onClicked:{

                    source !== "" ? popup.open() : 0
                    poimage.source = source
                }
                anchors.fill: parent
            }
        }
}

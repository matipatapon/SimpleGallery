import QtQuick
import QtQuick.Controls 2.0
import QtQuick.Dialogs
import QtQuick.Layouts 1.3

Button{
    text:"Browse"
    height: parent.height
    background: Rectangle{
        color: parent.down ? "#666666" : (parent.hovered ? "#595959" : "#4d4d4d")
    }
    contentItem: Text{
        color:"#f2f2f2"
        text: parent.text
        font: parent.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
   }
}




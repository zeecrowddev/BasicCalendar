import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2


Rectangle
{
    id : oneEventDelegate
    border.width: 1
    border.color: "black"
    radius : 3

    height : 50
    width : parent.width

    state : "consultation"

    signal deleteEvent(variant model)
    signal editEvent(variant model)

    Label
    {
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left : parent.left
        anchors.leftMargin : 5

        font.pixelSize: 14
        font.bold: true

        text : modelData.sH + ":" + modelData.sM + " - " + modelData.eH + ":" + modelData.eM
    }

    Label
    {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.left : parent.left
        anchors.leftMargin : 5
        anchors.right : parent.left
        anchors.rightMargin : 5

        font.pixelSize: 14
        font.bold: true

        text : modelData.title
    }

    Image
    {
        id : createdUser
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right : parent.right
        anchors.rightMargin : 5

        width : 20
        height : 20
        source : activity.getParticipantImageUrl(modelData.cU)
    }

    Label
    {
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right : createdUser.left
        anchors.rightMargin : 5

        font.pixelSize: 14
        font.bold: true

        anchors.verticalCenter: createdUser.verticalCenter

        horizontalAlignment: Text.AlignRight

        text : modelData.cU
    }

    MouseArea
    {
        anchors.fill: parent

        onPressAndHold:
        {
            oneEventDelegate.state = "buttons"
        }
    }

    Rectangle
    {
        anchors.fill: parent
        visible : oneEventDelegate.state !== "consultation"
        radius : 3
        color : "lightgrey"
        opacity : 0.9

        ToolButton
        {

            action : Action
            {
            id : back
            iconSource  : "qrc:/BasicCalendar/Resources/back.png"
            tooltip     : "back"
            onTriggered :
            {
                oneEventDelegate.state = "consultation"
            }
        }

        anchors.left : parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
    }

    ToolButton
    {
        action : Action
        {
        id : editmode
        iconSource  : "qrc:/BasicCalendar/Resources/editmode.png"
        tooltip     : "Edit"
        onTriggered :
        {
        //    deleteEvent(modelData.id);

            editEvent(modelData);
            oneEventDelegate.state = "consultation"
        }
    }

    anchors.right : removeButton.left
    anchors.rightMargin: 5
    anchors.verticalCenter: parent.verticalCenter
    }


    ToolButton
    {
        id : removeButton
        action : Action
        {
        id : remove
        iconSource  : "qrc:/BasicCalendar/Resources/close.png"
        tooltip     : "Back"
        onTriggered :
        {
            deleteEvent(modelData);
            oneEventDelegate.state = "consultation"
        }
    }

    anchors.right : parent.right
    anchors.rightMargin: 5
    anchors.verticalCenter: parent.verticalCenter
}


}



}

/**
* Copyright (c) 2010-2014 "Jabber Bees"
*
* This file is part of the BasicCalendar application for the Zeecrowd platform.
*
* Zeecrowd is an online collaboration platform [http://www.zeecrowd.com]
*
* WebApp is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

import "Tools.js" as Tools

Rectangle
{
    id : oneEventDelegate
    border.width: 1
    border.color: "black"
    radius : 3

    height : 50
    width : parent.width

    state : "consultation"

    signal deleteEvent(variant eventElement)
    signal editEvent(variant eventElement)

    Label
    {
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left : parent.left
        anchors.leftMargin : 5

        font.pixelSize: 12
        font.bold: true

        text : Tools.intHourToString(modelData.sH,modelData.sM) + " - " + Tools.intHourToString(modelData.eH,modelData.eM)
    }

    Label
    {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.left : parent.left
        anchors.leftMargin : 5
        anchors.right : parent.left
        anchors.rightMargin : 5

        font.pixelSize: 12
        //font.bold: true

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

        onClicked:
        {
            editEvent(modelData);
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
            deleteEvent(modelData.id);

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

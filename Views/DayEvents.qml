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
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.1
import ZcClient 1.0 as Zc

Item
{
    width: 100
    height: 62

    id : dayEventsPanel

    state  : "allevents"

    property date currentDate : null
    property bool isNew : false

    Zc.ResourceDescriptor
    {
        id : zcResourceDescriptor
    }

    Row {
        id: eventDateRow
        anchors.top : parent.top
        anchors.left : parent.left

        width: parent.width
        height: eventDayLabel.height
        spacing: 10

        Label {
            id: eventDayLabel
            text: currentDate.getDate()
            font.pointSize: 35
        }

        Column {
            height: eventDayLabel.height

            Label {
                readonly property var options: { weekday: "long" }
                text: Qt.locale().standaloneDayName(currentDate.getDay(), Locale.LongFormat)
                font.pointSize: 18
            }
            Label {
                text: Qt.locale().standaloneMonthName(currentDate.getMonth())
                      + currentDate.toLocaleDateString(Qt.locale(), " yyyy")
                font.pointSize: 12
            }
        }
    }


    ToolBar
    {
        id : toolBar

        anchors.top : eventDateRow.bottom
        anchors.topMargin : 5
        width : parent.width

        style : ToolBarStyle{}

        RowLayout
        {
            ToolButton
            {
                action : Action
                {
                id : plusOrBack
                iconSource  : dayEventsPanel.state === "allevents" ? "qrc:/BasicCalendar/Resources/plus.png" : "qrc:/BasicCalendar/Resources/back.png"
                tooltip     : dayEventsPanel.state === "allevents" ? "Add a date" : "Cancel"
                onTriggered :
                {
                    oneEventPanel.clear();

                    isNew =  dayEventsPanel.state === "allevents" ? true : false
                    dayEventsPanel.state = dayEventsPanel.state === "allevents" ? "oneevent" : "allevents"
                }
            }

        }
        ToolButton
        {

            visible     : dayEventsPanel.state === "oneevent"

            action : Action
            {
            id : validate
            iconSource  : "qrc:/BasicCalendar/Resources/ok.png"
            tooltip     : "Validate"


            onTriggered :
            {
                oneEventPanel.validateEvent();
                dayEventsPanel.state = dayEventsPanel.state === "allevents" ? "oneevent" : "allevents"
            }

        }
    }
        ToolButton
        {

            visible : dayEventsPanel.state === "oneevent" && !isNew

            action : Action
            {
            id : addRessource
            iconSource  : "qrc:/BasicCalendar/Resources/addResource.png"
            tooltip     : "AddRessource"

            onTriggered :
            {
                fileDialog.open()
            }

        }
    }

}
}

//Label
//{
//    id : currentDateLabel
//    height : 16
//    anchors.right: toolBar.right
//    anchors.verticalCenter: toolBar.verticalCenter

//    font.pixelSize: 16
//    font.bold: true
//}


function updateEvents(date,dates)
{
    currentDate = date
    //currentDateLabel.text = date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear() + " "
    listView.model = dates;

}

/*
** accés de l'exterieur
*/

function updateOneEventData(model)
{
    oneEventPanel.updateData(model)
}


OneEvent
{
    id : oneEventPanel

    anchors
    {
        top : toolBar.bottom
        topMargin : 10
        bottom : parent.bottom
        bottomMargin : 10
        left : parent.left
        leftMargin : 5
        right : parent.right
        rightMargin : 10
    }

    currentDate : dayEventsPanel.currentDate
    visible: dayEventsPanel.state === "oneevent"

}


ListView
{
    id : listView

    visible: dayEventsPanel.state === "allevents"

    spacing: 5

    anchors
    {
        top : toolBar.bottom
        bottom : parent.bottom
        left : parent.left
        right : parent.right
    }

    delegate :  OnEventDelegate { onDeleteEvent: {

            mainView.deleteEvent(eventElement);
        }
                                  onEditEvent:
                                    {
                                        isNew = false
                                        oneEventPanel.updateData(eventElement)
                                        dayEventsPanel.state = "oneevent";
                                    }
                                }
                }


FileDialog
{
    id: fileDialog

    selectFolder   : false
    selectMultiple : false

    onAccepted:
    {
            zcResourceDescriptor.fromLocalFile(fileUrl);
            mainView.addRessoureOnEvent(oneEventPanel.idItem,zcResourceDescriptor.name,fileUrl)
    }
}

}

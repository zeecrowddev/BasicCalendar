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

Item
{
    id : oneEvent
    width: 100
    height: 62


    EventModel
    {
        id : eventModel;
    }

    property alias idItem: eventModel.idItem

    /*
    ** On valide un event
    */
    function validateEvent()
    {

        graphiqueToEventModel();
        mainView.addOrModifyEvent(eventModel)
    }

    function clearView()
    {
        eventModel.clear()
        eventModel.date = currentDate;
        eventModelToGraphique()
    }

    function graphiqueToEventModel()
    {
        eventModel.startHour = startHour.text;
        eventModel.endHour = endHour.text;
        eventModel.title = titleId.text
        eventModel.description = descriptionId.text

        if (gbRepeat.checked)
        {
            if (rbEachMonth.checked)
            {
                eventModel.repeatType = "EM"
            }
            else if (rbEachDay.checked)
            {
                eventModel.repeatType = "ED"
            } else if (rbEachYear.checked)
            {
                eventModel.repeatType = "EY"
            } else if (rbEachWeekDay.checked)
            {
                eventModel.repeatType = "EWD"
            }
            else
            {
                eventModel.repeatType = ""
            }

            if (gbDaysSelector.checked === true)
            {
                var splitRb = repeatBegin.text.split("/")
                eventModel.repeatBegin = new Date(parseInt(splitRb[2]),parseInt(splitRb[1]),parseInt(splitRb[0]))
                var splitRe = repeatEnd.text.split("/")
                eventModel.repeatEnd = new Date(parseInt(splitRe[2]),parseInt(splitRe[1]),parseInt(splitRe[0]))
            }
            else
            {
                eventModel.repeatBegin = null;
                eventModel.repeatEnd = null;
            }
        }
        else
        {
            eventModel.repeatType = ""
        }
    }

    function eventModelToGraphique()
    {
        startHour.text = eventModel.startHour
        endHour.text = eventModel.endHour
        titleId.text = eventModel.title
        descriptionId.text = eventModel.description
        attachedFilesListId.model = null
        attachedFilesListId.model = eventModel.attachedFiles

        if (eventModel.repeatType === "")
        {
            gbRepeat.checked = false
            rbEachDay.checked = false;
            rbEachMonth.checked = false;
            rbEachYear.checked = false;
            rbEachWeekDay.checked = false;

            gbDaysSelector.checked = false
            repeatBegin.text = "01/01/2000"
            repeatEnd.text = "01/01/2000"
        }
        else
        {


            gbRepeat.checked = true
            if (eventModel.repeatType === "EM")
            {
                rbEachMonth.checked = true;
            }
            else if (eventModel.repeatType === "ED")
            {
                rbEachDay.checked = true;
            }
            else if (eventModel.repeatType === "EY")
            {
                rbEachYear.checked = true;
            }
            else if (eventModel.repeatType === "EWD")
            {
                rbEachWeekDay.checked = true;

            }

            if (eventModel.repeatBegin === null && eventModel.repeatEnd === null)
            {
                gbDaysSelector.checked = false
                repeatBegin.text = "01/01/2000"
                repeatEnd.text = "01/01/2000"
            }
            else
            {
                gbDaysSelector.checked = true
            }

            console.log(">> eventModel.repeatBegin " + eventModel.repeatBegin)

            if (eventModel.repeatBegin === null)
            {
                repeatBegin.text = "01/01/2000"
            }
            else
            {
                repeatBegin.text = eventModel.repeatBegin.getDate() + "/" + eventModel.repeatBegin.getMonth() + "/" + eventModel.repeatBegin.getFullYear()
            }

            if (eventModel.repeatEnd === null)
            {
                repeatEnd.text = "01/01/2000"
            }
            else
            {
                repeatEnd.text = eventModel.repeatEnd.getDate() + "/" + eventModel.repeatEnd.getMonth() + "/" + eventModel.repeatEnd.getFullYear()
            }
        }
    }

    function updateData(model)
    {
        eventModel.fromJSObject(model)
        eventModelToGraphique();
    }


    property date currentDate : null

    // Propriété bindée avec le graphique
    property alias startHourValue : startHour.text
    property alias endHourValue : endHour.text
    property string titleValue : titleId.text
    property string descriptionValue : descriptionId.text

    Column
    {
        anchors.fill: parent

        spacing: 5

        Row
        {
            spacing: 5

            height : 20
            width : parent.width

            Label
            {
                id : labelTitle
                height : 14
                width : 40

                font.pixelSize: 12
                font.bold: true

                text : "Title : "

                anchors.verticalCenter: parent.verticalCenter
            }

            TextField
            {
                style: TextFieldStyle {}
                id : titleId
                height : 20

                //                text: titleValue

                width : parent.width - labelTitle.width - 10

                font.pixelSize: 12

                anchors.verticalCenter: parent.verticalCenter

            }
        }

        Row
        {
            spacing: 5
            height : 20
            width : parent.width

            Label
            {
                id : labelStart
                height : 14
                width : 40

                font.pixelSize: 12
                font.bold: true

                text : "Start : "

                anchors.verticalCenter: parent.verticalCenter
            }

            TimeWidget
            {
                id : startHour
                height : 20
                width : 45

                anchors.verticalCenter: parent.verticalCenter

                //    text : startHourValue
            }

            Label
            {
                id : labelTo
                height : 14
                width : 21

                font.pixelSize: 12
                font.bold: true

                text : " to "

                anchors.verticalCenter: parent.verticalCenter
            }

            TimeWidget
            {
                id : endHour
                height : 20
                width : 45

                anchors.verticalCenter: parent.verticalCenter

                // text : endHourValue


            }
        }

        // Repeat
        GroupBox
        {
            id: gbRepeat
            width : parent.width
            height: 112
            title: "Repeat"
            flat: false
            checkable: true
            checked: false

            Column
            {
                id : columnRbRepeat

                width : 140
                height : parent.height
                clip : true
                ExclusiveGroup { id: repeatGroup }

                spacing: 2

                RadioButton {
                    id: rbEachDay
                    text: qsTr("Every Day")
                    exclusiveGroup: repeatGroup
                    style : RadioButtonStyle {}
                }
                RadioButton {
                    id: rbEachWeekDay
                    text: qsTr("Every Week Day")
                    style : RadioButtonStyle {}
                    exclusiveGroup: repeatGroup
                }
                RadioButton {
                    id: rbEachMonth
                    text: qsTr("Every Month")
                    style : RadioButtonStyle {}
                    exclusiveGroup: repeatGroup
                }
                RadioButton {
                    id: rbEachYear
                    text: qsTr("Every Year")
                    style : RadioButtonStyle {}
                    exclusiveGroup: repeatGroup
                }

            }

            GroupBox
            {
                id : gbDaysSelector
                width: 137
                height: 91

                title: "Period"

                checkable: true
                checked: false

                anchors.left  : columnRbRepeat.right
                anchors.top   : parent.top
                anchors.bottom: parent.bottom

                Column
                {
                    anchors.fill: parent
                    spacing : 2

                    Row
                    {
                        width : parent.width
                        height : 20

                        Label
                        {
                            id : labelBegin
                            height : 18
                            width : 37

                            font.pixelSize: 12
                            font.bold: true

                            text : "Begin"

                            anchors.verticalCenter: parent.verticalCenter
                        }

                        DateWidget
                        {
                            id : repeatBegin
                            height : 20
                            width : 82
                        }
                    }
                    Row
                    {
                        width : parent.width
                        height : 20

                        Label
                        {
                            id : labelEnd
                            height : 14
                            width : 37

                            font.pixelSize: 12
                            font.bold: true

                            text : "End"

                            anchors.verticalCenter: parent.verticalCenter
                        }

                        DateWidget
                        {
                            id : repeatEnd

                            height : 20
                            width : 82
                        }
                    }
                }

            }

        }


        Label
        {
            id : labelDecription
            height : 20
            width : 60

            font.pixelSize: 12
            font.bold: true

            text : "Description : "
        }

        TextArea
        {
            style: TextAreaStyle {}
            id : descriptionId
            height : 80
            width : parent.width

            font.pixelSize: 12
            //text :  descriptionValue
        }

        Label
        {
            id : attachedFilesId
            height : 30
            width : 60

            font.pixelSize: 12
            font.bold: true

            text : "Attached Files : "

        }

        ScrollView
        {
            width : parent.width
            height : 200

            style :  ScrollViewStyle { transientScrollBars : false }

            ListView
            {

                id : attachedFilesListId

                anchors.fill: parent

                //                model : eventModel.attachedFiles

                delegate : AttachedFileDelegate
                {
                onDeleteAttachedFile : mainView.deleteRessourceOnEvent(oneEvent.idItem,idResource);
                onOpenAttachedFile : mainView.openRessourceOnEvent(oneEvent.idItem,idResource);
            }

            spacing: 5
        }
    }
}

}

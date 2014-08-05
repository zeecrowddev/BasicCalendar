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


    function validateEvent()
    {
        var startdate = new Date(currentDate.getFullYear(),currentDate.getMonth(),currentDate.getDate(),startHour.value,startMinute.value,0,0);
        var enddate = new Date(currentDate.getFullYear(),currentDate.getMonth(),currentDate.getDate(),endHour.value,endMinute.value,0,0);
        var who = idItem === "" ? mainView.context.nickname : oneEvent.who
        mainView.addOrModifyEvent(idItem,startdate,enddate,title.text,descriptionId.text,who)
    }

    function clear()
    {
        oneEvent.idItem = ""
        oneEvent.eventTitle = ""
        oneEvent.sH = 7
        oneEvent.sM = 0
        oneEvent.eH = 8
        oneEvent.eM = 0
        oneEvent.eventTitle = ""
        oneEvent.who = ""
        oneEvent.description = ""
    }

    function updateData(model)
    {
        oneEvent.idItem = model.id
        oneEvent.who = model.cU
        oneEvent.sH = model.sH
        oneEvent.sM = model.sM
        oneEvent.eH = model.eH
        oneEvent.eM = model.eM

        if (model.title !== undefined && model.title !== null)
            oneEvent.eventTitle = model.title
        else
            oneEvent.eventTitle = ""

        if (model.description !== undefined && model.description !== null)
            oneEvent.description = model.description
        else
            oneEvent.description = ""

        attachedFiles.clear();

        if (model.attachedFiles !== null && model.attachedFiles !== undefined)
        {
           Tools.forEachInArray(model.attachedFiles, function (x) { attachedFiles.append({"name" : x}) })
        }

    }

    ListModel
    {
        id : attachedFiles
    }

    property date currentDate : null
    property string idItem : ""
    property string who : ""
    property string eventTitle : ""
    property string description : ""
    property int sH : 0
    property int sM : 0
    property int eH : 0
    property int eM : 0



    Column
    {
        anchors.fill: parent

        spacing: 5

        Row
        {
            spacing: 5
            height : 25
            width : parent.width

            Label
            {
                id : labelStart
                height : 20
                width : 60

                font.pixelSize: 16
                font.bold: true

                text : "Start : "

                anchors.verticalCenter: parent.verticalCenter
            }


            SpinBox
            {
                id : startHour
                height : 25
                width : 60

                font.pixelSize: 16

                minimumValue : 1
                maximumValue : 24
                stepSize : 1

                style : SpinBoxStyle{}

                anchors.verticalCenter: parent.verticalCenter

                value :  oneEvent.sH
            }

            Label
            {
                id : separtor
                height : 20
                width : 10


                font.pixelSize: 16
                font.bold: true

                text : ":"

                verticalAlignment: Text.AlignHCenter

                anchors.verticalCenter: parent.verticalCenter
            }

            SpinBox
            {
                id : startMinute

                height : 25
                width : 60

                font.pixelSize: 16

                minimumValue : 0
                maximumValue : 60
                stepSize : 15

                style : SpinBoxStyle{}

                anchors.verticalCenter: parent.verticalCenter

                value :  oneEvent.sM
            }

        }

        Row
        {
            height : 25
            width : parent.width

            spacing: 5

            Label
            {
                id : labelEnd
                height : 25
                width : 60

                font.pixelSize: 16
                font.bold: true

                text : "End : "

                anchors.verticalCenter: parent.verticalCenter
            }


            SpinBox
            {
                id : endHour
                height : 25
                width : 60

                font.pixelSize: 16

                minimumValue : startHour.value
                maximumValue : 24
                stepSize : 1

                style : SpinBoxStyle{}

                anchors.verticalCenter: parent.verticalCenter

                value :  oneEvent.eH
            }

            Label
            {
                height : 20
                width : 10

                font.pixelSize: 16
                font.bold: true

                text : ":"

                anchors.verticalCenter: parent.verticalCenter
            }

            SpinBox
            {
                id : endMinute
                height : 25
                width : 60

                font.pixelSize: 16

                minimumValue : 0
                maximumValue : 60
                stepSize : 15

                style : SpinBoxStyle{}

                anchors.verticalCenter: parent.verticalCenter

                value :  oneEvent.eM
            }


        }

        Row
        {
            spacing: 5

            height : 40
            width : parent.width

            Label
            {
                id : labelTitle
                height : 20
                width : 60

                font.pixelSize: 16
                font.bold: true

                text : "Title : "

                anchors.verticalCenter: parent.verticalCenter
            }

            TextField
            {
                style: TextFieldStyle {}
                id : title
                height : 40
                width : parent.width - labelTitle.width - 10

                font.pixelSize: 16

                anchors.verticalCenter: parent.verticalCenter


                text :  oneEvent.eventTitle
            }
        }

        Label
        {
            id : labelDecription
            height : 20
            width : 60

            font.pixelSize: 16
            font.bold: true

            text : "Description : "

        }

        TextArea
        {
            style: TextAreaStyle {}
            id : descriptionId
            height : 80
            width : parent.width

            font.pixelSize: 16
            text :  oneEvent.description
        }

        Label
        {
            id : attachedFilesId
            height : 30
            width : 60

            font.pixelSize: 16
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

                anchors.fill: parent

                model : attachedFiles

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

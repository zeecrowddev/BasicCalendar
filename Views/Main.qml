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
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.1

import ZcClient 1.0 as Zc


import "Main.js" as Presenter
import "Tools.js" as Tools


Zc.AppView
{
    id : mainView

    property string _1 : ""
    property string _2 : ""
    property string _3 : ""
    property string _4 : ""
    property string _5 : ""
    property string _6 : ""
    property string _7 : ""
    property string _8 : ""
    property string _9 : ""
    property string _10 : ""
    property string _11 : ""
    property string _12 : ""
    property string _13 : ""
    property string _14 : ""
    property string _15 : ""
    property string _16 : ""
    property string _17 : ""
    property string _18 : ""
    property string _19 : ""
    property string _20 : ""
    property string _21 : ""
    property string _22 : ""
    property string _23 : ""
    property string _24 : ""
    property string _25 : ""
    property string _26 : ""
    property string _27 : ""
    property string _28 : ""
    property string _29 : ""
    property string _30 : ""
    property string _31 : ""
    property string _32 : ""
    property string _33 : ""
    property string _34 : ""
    property string _35 : ""
    property string _36 : ""
    property string _37 : ""
    property string _38 : ""

    property string _39 : ""
    property string _40 : ""
    property string _41 : ""
    property string _42 : ""

    property string _100 : ""


    toolBarActions :
        [
        Action {
            id: closeAction
            shortcut: "Ctrl+X"
            iconSource: "qrc:/BasicCalendar/Resources/close.png"
            tooltip : "Close Application"
            onTriggered:
            {
                mainView.close();
            }
        }
    ]


    Zc.AppNotification
    {
        id : appNotification
    }

    /*
    ** Clean all external notifications
    ** Set the focus
    */

    onIsCurrentViewChanged :
    {
        if (isCurrentView == true)
        {
            appNotification.resetNotification();
        }
    }

    property int dayOfWeek : 0;
    property int daysInMonth : 0;
    property int currentMonth : 0;

    function updateAll()
    {
        var all = items.getAllItems();

        Tools.forEachInArray(all,function(x)
        {
            updateDayPropertyFromItem(x,"")}
        );

    }

    function clearDayProperties()
    {
        for (var i = 1;i <= 42;i++)
        {
            mainView["_"+ i] = "";
        }

    }

    function dayPropertyFromIdItem(idItem)
    {
        for (var i = 1;i <= 42;i++)
        {

            var strListEvent = mainView["_"+ i];

            if (strListEvent === ""  || strListEvent === undefined)
                continue;

            var listEvent = Tools.parseDatas(strListEvent)

            if (listEvent.dates === null || listEvent.dates === undefined)
                continue

            if (Tools.existsInArray( listEvent.dates, function (x)
            { return x.id === idItem})
                    )
            {
                return i;
            }
        }

        return 100;
    }

    function calculateParameters()
    {
        clearDayProperties()

        var date = new Date(calendar.visibleYear,calendar.visibleMonth,1,0,0,0,0);
        dayOfWeek = date.getDay();
        if (dayOfWeek === 0)
            dayOfWeek = 7
        else if (dayOfWeek === 1)
            dayOfWeek = 8
        daysInMonth = Tools.days_in_month(date.getMonth() + 1,date.getFullYear());
        currentMonth = date.getMonth()
    }

    function generateKey()
    {
        return Date.now();
    }

    SplitView
    {
        id : splitView

        anchors.fill: parent
        orientation: Qt.Horizontal

        Component
        {
            id : handleDelegateDelegate
            Rectangle
            {
                width : 3
                color :  styleData.hovered ? "grey" :  "lightgrey"

                Rectangle
                {
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    width : 1
                    color :  "grey"
                }
            }
        }

        handleDelegate : handleDelegateDelegate


        DayEvents
        {
            id : dayEvents

            width : 350

        }

        Calendar
        {
            id : calendar

            Layout.fillWidth : true


            Component.onCompleted:
            {

                dayEvents.currentDate = calendar.selectedDate
            }

            style : CalendarStyle
            {

            background : Item {}

            dayDelegate:
                Item
            {
            readonly property color sameMonthDateTextColor: "#444"
            readonly property color selectedDateColor: Qt.platform.os === "osx" ? "#3778d0" : __syspal.highlight
            readonly property color selectedDateTextColor: "white"
            readonly property color differentMonthDateTextColor: "#bbb"
            readonly property color invalidDatecolor: "#dddddd"


            property string dayProperty : calculateDayProperty(styleData.date)


            function calculateModel(value)
            {
                var o = Tools.parseDatas(value)

                if (o.dates !== undefined || o.dates !== null)
                {
                    return o.dates
                }
                return null;
            }

            function calculateColor(selected,visibleMonth)
            {

                if (selected)
                {
                    return selectedDateColor
                }

                if (!visibleMonth)
                {
                    return differentMonthDateTextColor;
                }


                return "transparent"
            }

            function calculateTextColor(selected,visibleMonth)
            {

                if (selected)
                {
                    return selectedDateTextColor
                }

                if (!visibleMonth)
                {
                    return invalidDatecolor;
                }

                return "white"
            }


            Rectangle
            {
                id : dayHeader
                anchors.top : parent.top
                anchors.left : parent.left
                anchors.right : parent.right
                height: 25
                color:  styleData.today ? "orange" : "grey"
                border.color: "grey"
                border.width: 1
                Label {
                    id: dayDelegateText
                    text: styleData.date.getDate()
                    font.pixelSize: 14
                    anchors.centerIn: parent
                    color: calculateTextColor(styleData.selected,styleData.visibleMonth)
                }
            }

            Rectangle
            {
                anchors.fill: listEvent
                color : "lightgrey"
                opacity : 0.5
            }

            ListView
            {
                id : listEvent

                anchors
                {
                    top : dayHeader.bottom
                    topMargin : 3
                    bottom : parent.bottom
                    bottomMargin : 3
                    left : parent.left
                    leftMargin : 3
                    right : parent.right
                    rightMargin : 3
                }

                model : calculateModel(mainView["_" + dayProperty])

                spacing : 3

                delegate : Rectangle {     color : index % 2 ? "#f2f2f2" : "white" ;
                    height : 15; width : parent.width;
                    clip : true
                    Label
                    {
                        text : "<b>"  + modelData.sH + ":" + modelData.sM + "-" + modelData.eH + ":" + modelData.eM + "</b> " + modelData.title
                        width : parent.width
                        height : parent.height
                        anchors.left : parent.left
                        elide : Text.ElideRight
                    }
                }
                interactive: false
            }


            Rectangle
            {
                id : backColor

                anchors
                {
                    top : dayHeader.bottom
                    bottom : parent.bottom
                    right : parent.right
                    left : parent.left
                }

                radius : 5
                border.color: "lightgrey"
                border.width: 1
                color:  calculateColor(styleData.selected,styleData.visibleMonth) //"grey" //calculateBackcolorAndOthers(mainView["_" + dayProperty])
                anchors.margins: styleData.selected ? -1 : 0
                opacity : 0.8
            }




            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {

                    calendar.selectedDate = styleData.date
                    calendar.clicked(styleData.date)
                }
            }
        }
    }


    onClicked:
    {
        if ( dayEvents.state === "allevents" )
            updateDayEventsList(date);
    }

    onVisibleMonthChanged:
    {
        calculateParameters()
        mainView.updateAll();
    }



}

}

/*
** Return le numero de la case affichée
** 100 si pas trouvé
*/


function calculateDayFromItem(idItem)
{
    var o = Tools.parseDatas(items.getItem(idItem,"{}"));
    if (o.date === undefined || o.date === null || o.date === "")
        return;
    var split = o.date.split("/");
    var date = new Date(parseInt(split[1]),parseInt(split[2]),parseInt(split[3]),0,0,0);

    return mainView.calculateDayProperty(date);
}

function calculateDayProperty(date)
{
    var daydate = date.getDate();
    var month = date.getMonth();
    var year = date.getFullYear();

    var val = 0;
    if (month === mainView.currentMonth)
    {
        return (mainView.dayOfWeek + daydate);
    }
    else if (month === mainView.currentMonth + 1 ||
             (mainView.currentMonth === 11 && month === 0))
    {
        val = mainView.dayOfWeek + mainView.daysInMonth - 1 + daydate;
        if (val <= 42)
            return val;
    }
    else if (month + 1 === mainView.currentMonth ||
             (mainView.currentMonth === 0 && month === 11))
    {
        var days = Tools.days_in_month(month,year);

        val = mainView.dayOfWeek - (days - daydate);
        if (val >= 1)
            return val;
    }

    return 100;

}

function deleteItemFromItem(idItem)
{
    var dayProperty = mainView.dayPropertyFromIdItem(idItem)

    if (dayProperty === 100)
        return;


    var allday = Tools.parseDatas(mainView["_" + dayProperty]);

    if (allday.dates === undefined || allday.dates === null)
    {
        allday.dates = [];
    }

    Tools.removeInArray(allday.dates,function (x) { return x.id === idItem})

    mainView["_" + dayProperty] = JSON.stringify(allday)

    if (dayEvents.currentDate.getDate() === allday.dD &&
            dayEvents.currentDate.getMonth() === allday.dM &&
            dayEvents.currentDate.getFullYear() === allday.dY)
    {
        updateDayEventsList(dayEvents.currentDate)
    }
}

function updateDayPropertyFromItem(idItem)
{
    try
    {
        var stro = items.getItem(idItem,"{}")

        var o = Tools.parseDatas(stro);

        if (o.date === undefined || o.date === null || o.date === "")
            return;

        // on vérouille toujours l'id
        o.id = idItem

        var split = o.date.split("/");

        if ( split[0] === "NaN")
            return;
        if ( split[1] === "NaN")
            return;
        if ( split[2] === "NaN")
            return;

        var date = new Date(parseInt(split[0]),parseInt(split[1]),parseInt(split[2]),0,0,0);

        var dayProperty = mainView.calculateDayProperty(date);

        if (dayProperty === 100)
            return;


        var allday = Tools.parseDatas(mainView["_" + dayProperty]);

        if (allday.dates === undefined || allday.dates === null)
        {
            allday.dates = [];
        }

        allday.dY = date.getFullYear()
        allday.dM = date.getMonth()
        allday.dD = date.getDate()

        var found = Tools.indexInArray(allday.dates, function (x) { return x.id === idItem})

        if (found !== -1)
        {
            allday.dates[found] = o;
        }
        else
        {
            allday.dates.push(o);
        }

        mainView["_" + dayProperty] = JSON.stringify(allday)

        if (dayEvents.currentDate.getDate() === allday.dD &&
                dayEvents.currentDate.getMonth() === allday.dM &&
                dayEvents.currentDate.getFullYear() === allday.dY)
        {
            // on met à jour la liste des events à cette date si c'est celle courant
            updateDayEventsList(date)

            // Si on est en train d'editer cette date : o nla met à jour
            if (dayEvents.state === "oneevent")
            {
                dayEvents.updateOneEventData(o)
            }
        }

    }
    catch(e)
    {

    }
}

function updateDayEventsList(date)
{
    var dayProperty = calculateDayProperty(date)

    if (dayProperty === 100)
        return;

    var o = Tools.parseDatas(mainView["_" + dayProperty])

    dayEvents.updateEvents(date,o.dates)
}



function deleteEvent(modelElement)
{
    if (modelElement.attachedFiles !== null || modelElement.attachedFiles !== undefined)
    {
        Tools.forEachInArray(modelElement.attachedFiles, function(x) { documentFolder.deleteFile(modelElement.id + "/" + x,null) })
    }
    // quand cela sera implémenté coté serveur
    //   documentFolder.deleteFile(modelElement.id + "/uploads/",null)
    //   documentFolder.deleteFile(modelElement.id + "/",null)
    items.deleteItem(modelElement.id,null)
}


function addRessoureOnEvent(id,idRessource,pathToUpload)
{
    uploadScreenId.visible = true;
    uploadScreenId.idItem = id;
    uploadScreenId.resourceName = idRessource;

    if (!documentFolder.uploadFile(id + "/" + idRessource,pathToUpload,queryStatusForAddRessourceDocumentFolder))
        uploadScreenId.visible = false;
}

function deleteRessourceOnEvent(id,idRessource)
{
    deleteScreenId.visible = true;
    deleteScreenId.idItem = id;
    deleteScreenId.resourceName = idRessource;

    if (!documentFolder.deleteFile(id + "/" + idRessource,queryStatusForDeleteRessourceDocumentFolder))
        deleteScreenId.visible = false;
}

function saveAsRessourceOnEvent(id,idRessource)
{
    downloadScreenId.visible = true;
    downloadScreenId.idItem = id;
    downloadScreenId.idRessource = idRessource;
    downloadScreenId.fullPath = id + "/" + idRessource;
    downloadScreenId.open = false;

    fileDialog.title = "Save " + idRessource + " on : "

    fileDialog.folder = idRessource;
    fileDialog.open()

}


function openRessourceOnEvent(id,idRessource)
{
    downloadScreenId.visible = true;
    downloadScreenId.idItem = id;
    downloadScreenId.idRessource = idRessource;
    downloadScreenId.fullPath = mainView.context.temporaryPath + idRessource
    downloadScreenId.open = true;

    if (!documentFolder.downloadFileTo(id + "/" + idRessource,mainView.context.temporaryPath + idRessource,queryStatusForDownloadRessourceDocumentFolder))
        downloadScreenId.visible = false;
}

function addOrModifyEvent(id,startDate,endDate,title,description,who)
{

    var o = {}
    o.id = id === "" ? generateKey() : id
    o.date = startDate.getFullYear() + "/" + startDate.getMonth() + "/" + startDate.getDate()
    o.sH = startDate.getHours();
    o.sM = startDate.getMinutes();
    o.eH = endDate.getHours();
    o.eM = endDate.getMinutes();
    o.title = title
    o.description = description;


    o.cU = id === "" ? mainView.context.nickname : who

    if (id !== "")
    {
        var existingItem = items.getItem(id,"")
        if (existingItem!=="")
        {
            var existingItemElement = Tools.parseDatas(existingItem)
            if (existingItemElement.attachedFiles !== undefined)
            {
                o.attachedFiles = existingItemElement.attachedFiles
            }
        }
    }


    items.setItem(o.id,JSON.stringify(o),null)
}

Zc.CrowdActivity
{
    id : activity

    Zc.CrowdActivityItems
    {
        Zc.QueryStatus
        {
            id : itemQueryStatus

            onCompleted :
            {
                updateAll();

                splashScreenId.visible = false;
                splashScreenId.width = 0;
                splashScreenId.height = 0;

            }
        }

        id          : items
        name        : "CalendarItems"
        persistent  : true

        onItemChanged :
        {
            updateDayPropertyFromItem(idItem)
        }

        onItemDeleted :
        {
            deleteItemFromItem(idItem)

            var dayProperty = mainView.calculateDayFromItem(idItem);
        }
    }


    Zc.CrowdSharedResource
    {
        id   : documentFolder
        name : "BasicCalendar"

        Zc.StorageQueryStatus
        {
            id : queryStatusForAddRessourceDocumentFolder

            onErrorOccured :
            {
                uploadScreenId.visible = false
            }

            onProgress :
            {
                uploadScreenId.progressValue = value
            }

            onCompleted :
            {

                var str = items.getItem(uploadScreenId.idItem,"")
                if (str === "")
                    return;

                var element = Tools.parseDatas(str);

                if (element.attachedFiles === null || element.attachedFiles === undefined)
                    element.attachedFiles = [];

                element.attachedFiles.push(uploadScreenId.resourceName)

                items.setItem(element.id,JSON.stringify(element),null)

                uploadScreenId.visible = false;
            }
        }

        Zc.StorageQueryStatus
        {
            id : queryStatusForDownloadRessourceDocumentFolder

            onErrorOccured :
            {
                downloadScreenId.visible = false;
            }

            onProgress :
            {
                downloadScreenId.progressValue = value
            }



            onCompleted :
            {
                if (downloadScreenId.open)
                {
                    Qt.openUrlExternally(downloadScreenId.fullPath)
                }
                downloadScreenId.visible = false;
            }
        }


        Zc.QueryStatus
        {
            id : queryStatusForDeleteRessourceDocumentFolder

            onErrorOccured :
            {
                deleteScreenId.visible = false;
            }

            onCompleted :
            {
                var str = items.getItem(deleteScreenId.idItem,"")
                if (str === "")
                    return;

                var element = Tools.parseDatas(str);

                if (element.attachedFiles === null || element.attachedFiles === undefined)
                    element.attachedFiles = [];

                Tools.removeInArray(element.attachedFiles , function (x) {return x === deleteScreenId.resourceName})

                items.setItem(element.id,JSON.stringify(element),null)

                deleteScreenId.visible = false;
            }
        }
    }


    onStarted :
    {
        items.loadItems(itemQueryStatus);
    }

    onContextChanged :
    {
    }
}


onLoaded :
{
    activity.start();
}

onClosed :
{
    activity.stop();
}

SplashScreen
{
    id : splashScreenId
    width : parent.width
    height: parent.height
}

UploadScreen
{
    id : uploadScreenId
    width : parent.width
    height: parent.height
    visible : false

    z : 1000
}

DownloadScreen
{
    id : downloadScreenId
    width : parent.width
    height: parent.height
    visible : false

    z : 1000
}

DeleteScreen
{
    id : deleteScreenId
    width : parent.width
    height: parent.height
    visible : false

    z : 1000
}

FileDialog
{
    id: fileDialog

    selectFolder   : true
    selectMultiple : false

    onRejected:
    {
        downloadScreenId.visible = false
    }

    onAccepted:
    {
        downloadScreenId.fullPath = folder + "/" + downloadScreenId.idRessource
        if ( !documentFolder.downloadFileTo(downloadScreenId.idItem + "/" + downloadScreenId.idRessource,folder + "/" + downloadScreenId.idRessource,queryStatusForDownloadRessourceDocumentFolder))
        {
                downloadScreenId.visible = false;
        }
    }
}

}

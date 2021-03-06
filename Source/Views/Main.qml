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
    property int currentYear : 0;

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

            if (Tools.stringIsNullOrEmpty(strListEvent))
                continue;

            var listEvent = Tools.parseDatas(strListEvent)

            if (Tools.objectIsNullOrUndefined(listEvent.dates))
                continue

            if (Tools.existsInArray( listEvent.dates, function (x) { return x.id === idItem}))
            {
                return i;
            }
        }
        return 100;
    }

    function calculateParameters()
    {

        clearDayProperties()

        var yy = calendar.visibleYear;
        if (yy === 0)
            yy = new Date().getFullYear();

        var date = new Date(yy,calendar.visibleMonth,1,0,0,0,0);
        dayOfWeek = date.getDay();
        if (dayOfWeek === 0)
            dayOfWeek = 7
        else if (dayOfWeek === 1)
            dayOfWeek = 8
        daysInMonth = Tools.days_in_month(date.getMonth() + 1,yy);
        currentMonth = date.getMonth()


        currentYear = yy
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
                height: 18
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
                    height : 14; width : parent.width;
                    clip : true
                    Label
                    {
                        text : Tools.intHourToString(modelData.sH,modelData.sM) + " ... " + modelData.title
                        width : parent.width
                        height : parent.height
                        anchors.left : parent.left
                        elide : Text.ElideRight
                        font.pixelSize: 12
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

/*
** Supprimme dans toutes les dates visible les occurences
** de l'idItem
*/

function clearItemDayProperties(idItem)
{

    for (var i = 1;i <= 42;i++)
    {
        var allday = Tools.parseDatas(mainView["_" + i]);

        if ( Tools.objectIsNullOrUndefined(allday.dates) )
        {
            allday.dates = [];
        }

        Tools.removeInArray(allday.dates,function (x) { return x.id === idItem})

        mainView["_" + i] = JSON.stringify(allday)

        if (dayEvents.currentDate.getDate() === allday.dD &&
                dayEvents.currentDate.getMonth() === allday.dM &&
                dayEvents.currentDate.getFullYear() === allday.dY)
        {
            updateDayEventsList(dayEvents.currentDate)
        }
    }
}
/*
** Determine si un event unitaire doit être ajouté au calendrier visible
*/
function resolveOneEvent(o)
{

    var date =  Tools.jsonToDate(o.date);

    // on determine si on est dans une date validsi c'est un repeat
    if (!Tools.objectIsNullOrUndefined(o.repeat))
    {
        if (!Tools.objectIsNullOrUndefined(o.repeat.rB))
        {
            var dB = Tools.jsonToDate(o.repeat.rB);
            if (date.getTime() < dB.getTime())
            {
                return;
            }
        }
        if (!Tools.objectIsNullOrUndefined(o.repeat.rE))
        {
            var dE = Tools.jsonToDate(o.repeat.rE);
            if (date.getTime() > dE.getTime())
            {
              return;
            }

        }

    }

    var dayProperty = mainView.calculateDayProperty(date);

    if (dayProperty === 100)
        return;

    var allday = Tools.parseDatas(mainView["_" + dayProperty]);

    if (Tools.objectIsNullOrUndefined(allday.dates))
    {
        allday.dates = [];
    }

    allday.dY = date.getFullYear()
    allday.dM = date.getMonth()
    allday.dD = date.getDate()

    var found = Tools.indexInArray(allday.dates, function (x) { return x.id === o.id})


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

        // Si on est en train d'editer cette date : on la met à jour
        if (dayEvents.state === "oneevent")
        {
            dayEvents.updateOneEventData(o)
        }
    }
}

/*
** recuperation d'un item
** résolution des repeats
**     call resolveOneEvent
*/

function updateDayPropertyFromItem(idItem)
{
    try
    {
        // Le Json en string
        var stro = items.getItem(idItem,"{}")

        // le Json en objet
        var o = Tools.parseDatas(stro);
        // Pas de date associé : on peut rien faire
        if ( Tools.stringIsNullOrEmpty(o.date))
            return;

        // on verrouille toujours l'id
        o.id = idItem

        var listObject = [];

        if (  !Tools.objectIsNullOrUndefined(o.repeat) && !Tools.stringIsNullOrEmpty(o.repeat.rT) )
        {
            var split = o.date.split("/");
            var day = split[2]
            if ( day === "NaN")
                return;
            var month = split[1]
            if ( month === "NaN")
                return;
            var year = split[0]
            if ( year === "NaN")
                return;

            var nMonth = currentMonth + 1
            var pMonth = currentMonth - 1
            var nYear = mainView.currentYear;
            var pYear = mainView.currentYear;

            if (pMonth === -1)
            {
                pMonth = 11
                pYear = pYear - 1
            }

            if (nMonth == 12)
            {
                nMonth = 0
                nYear = nYear + 1
            }

            if (o.repeat.rT === "EM")
            {

                o.date = currentYear + "/" + currentMonth + "/" + day
                var pMonthObject = Tools.clone(o)
                pMonthObject.date = pYear + "/" + pMonth + "/" + day
                var nMonthObject = Tools.clone(o)
                nMonthObject.date = nYear + "/" + nMonth + "/" + day

                listObject.push(o)
                listObject.push(pMonthObject)
                listObject.push(nMonthObject)
            }
            else  if (o.repeat.rT === "ED")
            {

                for (var i = 0 ; i <= 31 ; i++)
                {

                    var ocDay = Tools.clone(o)
                    ocDay.date = currentYear + "/" + currentMonth + "/" + i
                    listObject.push(ocDay)
                    var opDay = Tools.clone(o)
                    opDay.date = pYear + "/" + pMonth + "/" + i
                    listObject.push(opDay)
                    var onDay = Tools.clone(o)
                    onDay.date = nYear + "/" + nMonth + "/" + i
                    listObject.push(onDay)
                }
            } else  if (o.repeat.rT === "EWD")
            {

                var d = new Date(year,month,day,0,0,0);
                var dow = d.getDay();

                for (var j = 0 ; j <= 31 ; j++)
                {

                    var cd = new Date(currentYear,currentMonth,j,0,0,0);
                    if (cd.getDay() === dow)
                    {
                        var ocDayOfWeek = Tools.clone(o)
                        ocDayOfWeek.date = currentYear + "/" + currentMonth + "/" + j
                        listObject.push(ocDayOfWeek)
                    }
                    cd = new Date(pYear,pMonth,j,0,0,0);
                    if (cd.getDay() === dow)
                    {
                        var opDayOfWeek = Tools.clone(o)
                        opDayOfWeek.date = pYear + "/" + pMonth + "/" + j
                        listObject.push(opDayOfWeek)
                    }
                    cd = new Date(nYear,nMonth,j,0,0,0);
                    if (cd.getDay() === dow)
                    {
                        var onDayOfWeek = Tools.clone(o)
                        onDayOfWeek.date = nYear + "/" + nMonth + "/" + j
                        listObject.push(onDayOfWeek)
                    }
                }
            }
            else  if (o.repeat.rT === "EY")
            {
                o.date = currentYear + "/" + month + "/" + day
                var pYearObject = Tools.clone(o)
                pYearObject.date = currentYear - 1 + "/" + month + "/" + day
                var nYearObject = Tools.clone(o)
                nYearObject.date = currentYear + 1 + "/" + month + "/" + day
                listObject.push(o)
                listObject.push(pYearObject)
                listObject.push(nYearObject)
            }
        }
        else
        {
            listObject.push(o);
        }

        var validListObject = [];

        Tools.forEachInArray(listObject,
                             function (x)
                             {
                                 resolveOneEvent(x)
                             }
                             )

        clearItemDayProperties(o.id)


        Tools.forEachInArray(listObject, function (x) { resolveOneEvent(x) } )
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

function addOrModifyEvent(eventModel)
{
    // convertit le model en object JavaScriptScript
    // en recuperant la liste existante de fichiers attachés
    var jsObject = eventModel.toJSObject(mainView.context.nickname,items.getItem(eventModel.id,""))

    var ismodify =  items.getItem(jsObject.id,"") !== "";
    // On met à jour tout le temps
    items.setItem(jsObject.id,JSON.stringify(jsObject),null)

    appNotification.logEvent(ismodify ? Zc.AppNotification.Modify : Zc.AppNotification.Add,jsObject.date + "\n" +jsObject.title ,jsObject.description,"")
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
            // on ne sait jamais c'etait peut etre un Repeater
            // alors dans le doute on clean tout les jours
            clearItemDayProperties(idItem);
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

                appNotification.logEvent(Zc.AppNotification.Add,"Document\n" + uploadScreenId.resourceName,element.title + "\n" + element.date,"image://icons/" + "file:///" + uploadScreenId.resourceName)
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


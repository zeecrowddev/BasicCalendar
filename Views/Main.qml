/**
* Copyright (c) 2010-2014 "Jabber Bees"
*
* This file is part of the Wywb application for the Zeecrowd platform.
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

            console.log(">> dayPropertyFromIdItem i " + i)

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


                function calculateBackcolorAndOthers(value ,valid, selected)
                {
                    var o = Tools.parseDatas(value)

                    if (o.dates !== undefined || o.dates !== null)
                    {
                        listEvent.model = o.dates
                    }
                    else
                    {
                        listEvent.model = null;
                    }

                    console.log(">> calculateBackcolorAndOthers list " + listEvent.model)

                    if (!valid)
                    {
                        listEvent.model = null
                    }

                    if ( selected )
                    {
                        console.log(">> selectedDateColor")
                        return selectedDateColor;
                    }
                    else if (!valid)
                    {
                        console.log(">> !styleData.isValid")
                        return invalidDatecolor
                    }


                    return "transparent"
                }



                function calculateHeaderColor(date)
                {
                    var now = new Date()
                    if (date.getDate() !== now.getDate())
                        return "grey"
                    if (date.getMonth() !== now.getMonth())
                        return "grey"
                    if (date.getYear() !== now.getYear())
                        return "grey"

                    return "orange"
                }

                Rectangle
                {
                    id : dayHeader
                    anchors.top : parent.top
                    anchors.left : parent.left
                    anchors.right : parent.right
                    height: 25
                    color:  calculateHeaderColor(styleData.date)
                    border.color: "grey"
                    border.width: 1
                    Label {
                        id: dayDelegateText
                        text: styleData.date.getDate()
                        font.pixelSize: 14
                        anchors.centerIn: parent
                        color: "white"
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
                    spacing : 3
                    delegate : Rectangle {  color : "white" ;
                                            height : 15; width : parent.width;
                                            clip : true
                                            Label
                                            {
                                                text : modelData.sH + ":" + modelData.sM + " - " + modelData.eM + ":" + modelData.eM + " " + modelData.title
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
                    anchors.fill: parent
                    radius : 5
                    border.color: "lightgrey"
                    border.width: 1
                    color:  calculateBackcolorAndOthers(mainView["_" + dayProperty],styleData.valid,styleData.selected)
                    anchors.margins: styleData.selected ? -1 : 0
                    opacity : 0.8
                }




            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    //if (styleData.valid)
                    console.log(">> on cliked " + styleData.date)
                    calendar.selectedDate = styleData.date
                //    styleData.selected = true
                    calendar.clicked(styleData.date)
                }
            }
        }
    }


    onClicked:
    {
        if ( dayEvents.state === "allevents" )
            updateDayEventsList(date);

//        var key = generateKey(date) ;

//        if (items.getItem(key,"___") === "___")
//        {
//            items.setItem(key,"",null)
//        }
//        else
//        {
//            items.deleteItem(key)
//        }
    }

    onVisibleMonthChanged:
    {
        calculateParameters()
        mainView.updateAll();
    }

    onVisibleYearChanged:
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
    console.log(">> calculateDayProperty " + date)

    var daydate = date.getDate();
    var month = date.getMonth();
    var year = date.getFullYear();

    console.log(">> calculateDayProperty : day : "  + daydate  + " month " + month + " fullyear " + year)



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
    console.log(">> deleteItemFromItem " + idItem)

    var dayProperty = mainView.dayPropertyFromIdItem(idItem)

    console.log(">> deleteItemFromItem dayProperty " + dayProperty)

    if (dayProperty === 100)
        return;


    var allday = Tools.parseDatas(mainView["_" + dayProperty]);

    if (allday.dates === undefined || allday.dates === null)
    {
        allday.dates = [];
    }

    Tools.removeInArray(allday.dates,function (x) { return x.id === idItem})

    mainView["_" + dayProperty] = JSON.stringify(allday)

    console.log(">> dayEvents.currentDate " + dayEvents.currentDate + " " + allday.dD  + " " + allday.dM + " " + allday.dM + " " + allday.dY)

    if (dayEvents.currentDate.getDate() === allday.dD &&
        dayEvents.currentDate.getMonth() === allday.dM &&
        dayEvents.currentDate.getFullYear() === allday.dY)
    {
        console.log(">> call  updateDayEventsList)");
        updateDayEventsList(dayEvents.currentDate)
    }
}

function updateDayPropertyFromItem(idItem)
{
    var stro = items.getItem(idItem,"{}")
    console.log(" >> updateDayPropertyFromItem " + stro)

    var o = Tools.parseDatas(stro);

    console.log(">> update at date : " + o.date)

    if (o.date === undefined || o.date === null || o.date === "")
        return;

    // on vérouille toujours l'id
    o.id = idItem

    var split = o.date.split("/");
    var date = new Date(parseInt(split[0]),parseInt(split[1]),parseInt(split[2]),0,0,0);

    var dayProperty = mainView.calculateDayProperty(date);

    console.log(">> dayProperty " + dayProperty)

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


    console.log(">> allday.date " + date)

    var found = Tools.indexInArray(allday.dates, function (x) { return x.id === idItem})

    console.log(">> found " + found);

    if (found !== -1)
    {
        allday.dates[found] = o;
    }
    else
    {
        console.log(">> allday push " + allday)
        allday.dates.push(o);
    }

    mainView["_" + dayProperty] = JSON.stringify(allday)

    if (dayEvents.currentDate.getDate() === allday.dD &&
        dayEvents.currentDate.getMonth() === allday.dM &&
        dayEvents.currentDate.getFullYear() === allday.dY)
    {
        updateDayEventsList(date)
    }
}

function updateDayEventsList(date)
{

    console.log(">> in updateDayEventsList " + date)
    var dayProperty = calculateDayProperty(date)

    console.log(">> updateDayEventsList " + dayProperty)

    if (dayProperty === 100)
        return;

    var o = Tools.parseDatas(mainView["_" + dayProperty])

    dayEvents.updateEvents(date,o.dates)
}



function deleteEvent(model)
{
    console.log(">> deleteEvent " + model.id)

    items.deleteItem(model.id,null)
}

function addOrModifyEvent(id,startDate,endDate,title,who)
{
    console.log(">> addEvent ")
    var o = {}
    o.id = id === "" ? generateKey() : id
    o.date = startDate.getFullYear() + "/" + startDate.getMonth() + "/" + startDate.getDate()
    o.sH = startDate.getHours();
    o.sM = startDate.getMinutes();
    o.eH = endDate.getHours();
    o.eM = endDate.getMinutes();
    o.title = title


    o.cU = id === "" ? mainView.context.nickname : who

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
            console.log(">> onItemDeleted " + idItem)
            deleteItemFromItem(idItem)

            var dayProperty = mainView.calculateDayFromItem(idItem);
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

}

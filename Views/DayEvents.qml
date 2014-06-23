import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Item
{
    width: 100
    height: 62

    id : dayEventsPanel

    state  : "allevents"

    property date currentDate : null

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
                    dayEventsPanel.state = dayEventsPanel.state === "allevents" ? "oneevent" : "allevents"
                }
            }

        }
        ToolButton
        {


            action : Action
            {
            id : validate
            iconSource  : dayEventsPanel.state === "oneevent" ?  "qrc:/BasicCalendar/Resources/ok.png" : ""
            enabled     : dayEventsPanel.state === "oneevent"
            tooltip     : "Validate"


            onTriggered :
            {
                oneEventPanel.validateEvent();
                dayEventsPanel.state = dayEventsPanel.state === "allevents" ? "oneevent" : "allevents"
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

    delegate :  OnEventDelegate { onDeleteEvent: mainView.deleteEvent(model);
                                  onEditEvent:
                                    {
                                        oneEventPanel.updateData(model)
                                        dayEventsPanel.state = "oneevent";
                                    }
                                }
                }

}

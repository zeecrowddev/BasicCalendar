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


    ToolBar
    {
        id : toolBar

        anchors.top : parent.top

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

Label
{
    id : currentDateLabel
    height : 16
    anchors.right: toolBar.right
    anchors.verticalCenter: toolBar.verticalCenter

    font.pixelSize: 16
    font.bold: true
}


function updateEvents(date,dates)
{
    currentDate = date
    currentDateLabel.text = date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear() + " "
    listView.model = dates;
}

OneEvent
{
    id : oneEventPanel

    anchors
    {
        top : toolBar.bottom
        bottom : parent.bottom
        left : parent.left
        right : parent.right
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

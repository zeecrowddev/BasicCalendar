import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item
{
    id : oneEvent
    width: 100
    height: 62

    function validateEvent()
    {

        var startdate = new Date(currentDate.getFullYear(),currentDate.getMonth(),currentDate.getDate(),startHour.value,startMinute.value,0,0);
        var enddate = new Date(currentDate.getFullYear(),currentDate.getMonth(),currentDate.getDate(),endHour.value,endMinute.value,0,0);

        console.log(">> validateEvent "  + startdate + " " + enddate)

        var who = id === "" ? mainView.context.nickname : oneEvent.who

        console.log(">> validate with who " + who)

        mainView.addOrModifyEvent(id,startdate,enddate,title.text,who)
    }

    function clear()
    {
        oneEvent.id = ""
        oneEvent.eventTitle = ""
        oneEvent.sH = 7
        oneEvent.sM = 0
        oneEvent.eH = 8
        oneEvent.eM = 0
        oneEvent.who = ""
    }

    function updateData(model)
    {
        console.log(">> update " + model)

        console.log(">> update " + model.id)

        oneEvent.id = model.id
        oneEvent.who = model.cU
        oneEvent.sH = model.sH
        oneEvent.sM = model.sM
        oneEvent.eH = model.eH
        oneEvent.eM = model.eM
        oneEvent.eventTitle = model.title
    }

    property date currentDate : null
    property string id : ""
    property string who : ""
    property string eventTitle : ""
    property int sH : 0
    property int sM : 0
    property int eH : 0
    property int eM : 0


    Label
    {
        id : labelStart
        height : 20
        width : 60

        text : "Start : "

        anchors.top : parent.top
        anchors.topMargin : 5
        anchors.left : parent.left
        anchors.leftMargin : 5
    }

    SpinBox
    {
        id : startHour
        height : 40
        width : 40

        minimumValue : 1
        maximumValue : 12
        stepSize : 1

        style : SpinBoxStyle{}

        anchors.top  : labelStart.top
        anchors.left : labelStart.right
        anchors.leftMargin: 5

        value :  oneEvent.sH
    }

    Label
    {
        id : separtor
        height : 20
        width : 30

        text : ":"

        anchors.top  : labelStart.top
        anchors.left : startHour.right
    }

    SpinBox
    {
        id : startMinute
        height : 20
        width : 40

        minimumValue : 0
        maximumValue : 60
        stepSize : 1

        style : SpinBoxStyle{}

        anchors.top  : labelStart.top
        anchors.left : startHour.right
        anchors.leftMargin: 5

        value :  oneEvent.sM
    }

    Label
    {
        id : labelEnd
        height : 20
        width : 60

        text : "End : "

        anchors.top : labelStart.bottom
        anchors.topMargin : 5
        anchors.left : parent.left
        anchors.leftMargin : 5
    }

    SpinBox
    {
        id : endHour
        height : 20
        width : 40

        minimumValue : 1
        maximumValue : 12
        stepSize : 1

        style : SpinBoxStyle{}

        anchors.top  : labelEnd.top
        anchors.left : labelEnd.right
        anchors.leftMargin: 5

        value :  oneEvent.eH
    }

    Label
    {
        height : 20
        width : 30

        text : ":"

        anchors.top  : labelEnd.top
        anchors.left : startHour.right
    }

    SpinBox
    {
        id : endMinute
        height : 20
        width : 40

        minimumValue : 0
        maximumValue : 60
        stepSize : 1

        style : SpinBoxStyle{}

        anchors.top  : labelEnd.top
        anchors.left : endHour.right
        anchors.leftMargin: 5

        value :  oneEvent.eM
    }


    Label
    {
        id : labelTitle
        height : 20
        width : 60

        text : "Title : "

        anchors.top : labelEnd.bottom
        anchors.topMargin : 5
        anchors.left : parent.left
        anchors.leftMargin : 5
    }

    TextField
    {
        style: TextFieldStyle {}
        id : title
        height : 20

        anchors.top  : labelTitle.top
        anchors.left : labelEnd.right
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5

        text :  oneEvent.eventTitle

    }
}

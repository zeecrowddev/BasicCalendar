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

    Column
    {
        anchors.fill: parent

        spacing: 10

        Row
        {
            spacing: 5
            height : 40
            width : parent.width

            Label
            {
                id : labelStart
                height : 20
                width : 60

                font.pixelSize: 20
                font.bold: true

                text : "Start : "

                anchors.verticalCenter: parent.verticalCenter
            }

            SpinBox
            {
                id : startHour
                height : 40
                width : 60

                font.pixelSize: 20

                minimumValue : 1
                maximumValue : 12
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


                font.pixelSize: 20
                font.bold: true

                text : ":"

                verticalAlignment: Text.AlignHCenter

                anchors.verticalCenter: parent.verticalCenter
            }

            SpinBox
            {
                id : startMinute

                height : 40
                width : 60

                font.pixelSize: 20

                minimumValue : 0
                maximumValue : 60
                stepSize : 1

                style : SpinBoxStyle{}

                anchors.verticalCenter: parent.verticalCenter

                value :  oneEvent.sM
            }

        }

        Row
        {
            height : 40
            width : parent.width

            spacing: 5

            Label
            {
                id : labelEnd
                height : 20
                width : 60

                font.pixelSize: 20
                font.bold: true

                text : "End : "

                anchors.verticalCenter: parent.verticalCenter
            }

            SpinBox
            {
                id : endHour
                height : 40
                width : 60

                font.pixelSize: 20

                minimumValue : 1
                maximumValue : 12
                stepSize : 1

                style : SpinBoxStyle{}

                anchors.verticalCenter: parent.verticalCenter

                value :  oneEvent.eH
            }

            Label
            {
                height : 20
                width : 10

                font.pixelSize: 20
                font.bold: true

                text : ":"

                anchors.verticalCenter: parent.verticalCenter
            }

            SpinBox
            {
                id : endMinute
                height : 40
                width : 60

                font.pixelSize: 20

                minimumValue : 0
                maximumValue : 60
                stepSize : 1

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

                font.pixelSize: 20
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

                font.pixelSize: 20

                anchors.verticalCenter: parent.verticalCenter


                text :  oneEvent.eventTitle
            }
        }
    }




}


import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1

Rectangle
{
    id : oneEvent
    width: 300
    height: 600

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
                width : 38

                font.pixelSize: 12
                font.bold: true

                text : "Title : "

                anchors.verticalCenter: parent.verticalCenter
            }

            TextField
            {
                style: TextFieldStyle {}
                id : title
                height : 20
                text: "default title"
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
            }
        }

        GroupBox
        {
            width : parent.width
            height: 200
            title: "Repeat"
            flat: false
            checkable: true

            ColumnLayout
            {
                RadioButton {
                    id: rbEachDay
                    x: 9
                    y: 26
                    text: qsTr("Radio Button")

                    style : RadioButtonStyle {}
                }
                RadioButton {
                    id: rbEachDayOfWeek
                    text: qsTr("Radio Button")
                }
                RadioButton {
                    id: rbEachDayOfMonth
                    text: qsTr("Radio Button")
                }

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
            text :  ""
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

//        ScrollView
//        {
//            width : parent.width
//            height : 200

//            style :  ScrollViewStyle { transientScrollBars : false }

//            ListView
//            {

//                anchors.fill: parent

//                model : attachedFiles

//                delegate : AttachedFileDelegate
//                {
////                onDeleteAttachedFile : mainView.deleteRessourceOnEvent(oneEvent.idItem,idResource);
////                onOpenAttachedFile : mainView.openRessourceOnEvent(oneEvent.idItem,idResource);
//            }

//            spacing: 5
//        }
//    }


}




}

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

Item {
    width: parent.width
    height: 30

    signal deleteAttachedFile(string idResource);
    signal openAttachedFile(string idResource);

    Rectangle
    {
        anchors.fill: parent
        color : "lightgrey"
        opacity : 0.5
        radius : 3
    }

    Label
    {
        height : 20
        width : parent.width - 35
        anchors.verticalCenter: parent.verticalCenter

        text : "<a href=\" \">"+modelData+"</a>"

        onLinkActivated:
        {
            openAttachedFile(modelData)
        }
    }

    Image
    {
        id          :   close
        source                      : "qrc:/BasicCalendar/Resources/bin.png"
        width           : 30
        height          : 30

        anchors.right : parent.right
        anchors.verticalCenter: parent.verticalCenter

        MouseArea
        {
            id : closeMouseArea

            anchors.fill    : parent
            onClicked       : deleteAttachedFile(modelData);
        }
    }

    Image
    {
        id          :   saveAs
        source                      : "qrc:/BasicCalendar/Resources/saveAs.png"
        width           : 30
        height          : 30

        anchors.right : close.left
        anchors.margins: 3
        anchors.verticalCenter: parent.verticalCenter

        MouseArea
        {
            id : saveAsMouseArea

            anchors.fill    : parent
            onClicked       : mainView.saveAsRessourceOnEvent(idItem,modelData);
        }
    }

}

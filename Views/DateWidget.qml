import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.2
import "Tools.js" as Tools

TextField
{
    width: 100
    height: 12

    style: TextFieldStyle {}

    inputMask : "00/00/0000"

    text : "01/01/2000"
    font.pixelSize: 12

    validator : RegExpValidator
    {
     regExp: /([012]?[0-9]|3[0-1])\/[0]?[0-9]|1[0-2])\/[2][0-1][0-1][0-1]/
    }

    function setDate(date)
    {
        text = Tools.dateToString(date);
    }

    function getDate()
    {
        return Tools.stringToDate(text);
    }

}

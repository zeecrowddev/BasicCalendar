import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.2

TextField
{
    width: 100
    height: 62

    style: TextFieldStyle {}

    inputMask : "00:00"

    text : "00:00"

    validator : RegExpValidator
    {
     regExp: /([01]?[0-9]|2[0-3]):[0-5][0-9]/
    }

}

import QtQuick 2.2
import "Tools.js" as Tools


Item
{
    property string idItem : ""
    property var date : null;
    property string startHour : "07:00"
    property string endHour : "08:00"
    property string title : ""
    property string description : ""
    property string who : ""
    property string repeatType : ""
    property var repeatBegin : null;
    property var repeatEnd : null;

    property alias attachedFiles : attachedFilesModel

    ListModel
    {
        id : attachedFilesModel
    }

    function clear()
    {
        idItem = "";
        date = null;
        startHour = "07:00";
        endHour = "08:00";
        title = "";
        description = "";
        who = "";
        attachedFilesModel.clear();
        repeatType = ""
        repeatBegin = null;
        repeatEnd = null;
    }


    // le model ne contien que des string et des int
    function fromJSObject(model)
    {
        idItem = model.id
        who = model.cU

        date = Tools.jsonToDate(model.date)

        startHour =  Tools.intHourToString(model.sH,model.sM)
        endHour =  Tools.intHourToString(model.eH,model.eM)

        title = Tools.stringIsNullOrEmpty(model.title) ? "" : model.title
        description = Tools.stringIsNullOrEmpty(model.description) ? "" : model.description

        attachedFilesModel.clear();
        Tools.forEachInArray(model.attachedFiles, function (x) {
            attachedFilesModel.append({"name" : x}) })

        if (!Tools.objectIsNullOrUndefined(model.repeat))
        {
            repeatType = Tools.stringIsNullOrEmpty(model.repeat.rT) ? "" : model.repeat.rT
            repeatBegin = Tools.stringIsNullOrEmpty(model.repeat.rB) ? null : Tools.jsonToDate(model.repeat.rB)
            repeatEnd = Tools.stringIsNullOrEmpty(model.repeat.rE) ? null : Tools.jsonToDate(model.repeat.rE)
        }
        else
        {
            repeatType = ""
        }
    }

    function toJSObject(myNickName,existingItem)
    {
        var o = {}
        o.id = idItem === "" ? generateKey() : idItem

        o.date =  Tools.dateTojson(date);
        o.sH = parseInt(startHour.split(":")[0])
        o.sM = parseInt(startHour.split(":")[1])
        o.eH = parseInt(endHour.split(":")[0])
        o.eM = parseInt(endHour.split(":")[1])
        o.title = title
        o.description = description;

        o.cU = idItem === "" ? myNickName : who

        if (idItem !== "")
        {
            if (existingItem !== "")
            {
                var existingItemElement = Tools.parseDatas(existingItem)
                if (existingItemElement.attachedFilesModel !== undefined)
                {
                    o.attachedFilesModel = existingItemElement.attachedFilesModel
                }
            }
        }

        if (repeatType !== null && repeatType !== "")
        {
            o.repeat = {}
            o.repeat.rT = repeatType;

            if ( repeatBegin !== null)
                o.repeat.rB = Tools.dateTojson(repeatBegin)
            if ( repeatEnd !== null)
                o.repeat.rE = Tools.dateTojson(repeatEnd)
        }

        return o;
    }

    function generateKey()
    {
        return Date.now();
    }

}

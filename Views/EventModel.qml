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

    property alias attachedFiles : attachedFilesModel

    ListModel
    {
        id : attachedFilesModel
    }

    function clear()
    {
        console.log(">> Clear ")
        idItem = "";
        date = null;
        startHour = "07:00";
        endHour = "08:00";
        title = "";
        description = "";
        who = "";
        attachedFilesModel.clear();
        repeatType = ""
    }


    function fromJSObject(model)
    {
        idItem = model.id
        who = model.cU

        var split = model.date.split("/");
        var dateModel = new Date(parseInt(split[0]),parseInt(split[1]),parseInt(split[2]),0,0,0);

        date = dateModel

        var strSH = model.sH  < 9 ? "0" + model.sH : model.sH
        var strSM = model.sM  < 9 ? "0" + model.sM : model.sM

        var strEH = model.eH < 9 ? "0" + model.eH : model.eH
        var strEM = model.eM < 9 ? "0" + model.eM : model.eM

        startHour = strSH + ":" + strSM;
        endHour = strEH + ":" + strEM;

        if (model.title !== undefined && model.title !== null)
            title = model.title
        else
            title = ""

        if (model.description !== undefined && model.description !== null)
            description = model.description
        else
            description = ""

        attachedFilesModel.clear();

        console.log(">> fromJSObject " + model.attachedFiles)

        if (model.attachedFiles !== null && model.attachedFiles !== undefined)
        {

           console.log(">> Attachedfiled exists")
           Tools.forEachInArray(model.attachedFiles, function (x) { attachedFilesModel.append({"name" : x}) })
        }

        if (model.repeat !== null && model.repeat !== undefined)
        {
            if (model.repeat.rT !== undefined )
            {
                repeatType = model.repeat.rT
            }
            else
            {
                repeatType = ""
            }
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

        console.log(">> toJSObject date " + date)

        o.date = date.getFullYear() + "/" + date.getMonth() + "/" + date.getDate()

        console.log(">> startHour " + startHour)
        console.log(">> toJSObject title " + title)

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

        console.log(">> toJSObject repeatType " + repeatType)
        if (repeatType !== null && repeatType !== "")
        {
            o.repeat = {}
            o.repeat.rT = repeatType;
        }


        return o;
    }

    function generateKey()
    {
        return Date.now();
    }

}

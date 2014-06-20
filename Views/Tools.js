/**
* Copyright (c) 2010-2014 "Jabber Bees"
*
* This file is part of the WebApp application for the Zeecrowd platform.
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

.pragma library


function foreachInListModel(listModel, delegate)
{
    for (var i=0;i<listModel.count;i++)
    {
        delegate(listModel.get(i));
    }
}

function removeInArray(array, findDelegate)
{
    var index = -1;
    for (var i=0;i<array.length;i++)
    {
        if ( findDelegate(array[i]) )
        {
            index = i;
            break;
        }
    }

    if (index !=-1)
    {
        var result = array[index];
        array.splice(index,1);
        return result;
    }
    return null;
}


function indexInArray(array, findDelegate)
{
    for (var i=0;i<array.length;i++)
    {
        if ( findDelegate(array[i]) )
        {
            return i;
        }
    }
    return -1;
}

function findInArray(array, findDelegate)
{
    for (var i=0;i<array.length;i++)
    {
        if ( findDelegate(array[i]) )
        {
            return array[i];
        }
    }
    return null;
}

function existsInArray(array, findDelegate)
{
    for (var i=0;i<array.length;i++)
    {
        if ( findDelegate(array[i]) )
        {
            return true;
        }
    }
    return false;
}

function removeInArray(array, findDelegate)
{
    var index = -1;
    for (var i=0;i<array.length;i++)
    {
        if ( findDelegate(array[i]) )
        {
            index = i;
            break;
        }
    }

    if (index !=-1)
    {
        var result = array[index];
        array.splice(index,1);
        return result;
    }
    return null;
}

function forEachInArray(array, delegate)
{
    for (var i=0;i<array.length;i++)
    {
        delegate(array[i]);
    }
}


function parseDatas(datas)
{
    if (datas === null || datas === undefined)
        return {}


    var objectDatas = null;

    try
    {

        objectDatas = JSON.parse(datas);
    }
    catch (e)
    {
        objectDatas = {}
    }

    if (objectDatas === null)
        return {};

    if (objectDatas === undefined)
        return {};

    objectDatas.testparse = "testparse"
    if (objectDatas.testparse !== "testparse")
    {
        return {}
    }

    objectDatas.testparse = undefined;

    return objectDatas;

}

function days_in_month(month,year) {
    var m = [31,28,31,30,31,30,31,31,30,31,30,31];
    if (month != 2) return m[month - 1]; //tout sauf février
    if (year%4 != 0) return m[1]; //février normal non bissextile
    if (year%100 == 0 && year%400 != 0) return m[1];  //février bissextile siècle non divisible par 400
    return m[1] + 1; //tous les autres févriers = 29 jours
}


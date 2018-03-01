/**
 * @Author: Cecurio
 * @Date: 2016/12/3 12:57
 * @Last Modified by: Cecurio
 * @Last Modified time: 2016/12/3 12:57
 * @Function:
 */
var express = require('express'),
    router = express.Router(),
    url = require('url'),
    config = appRequire('config/config');

//菜单业务逻辑组件
var datadictionaryService = appRequire('service/backend/datadictionary/datadictionaryservice'),
    logger = appRequire("util/loghelper").helper;


//查看字典
router.get('/plain',function (req,res) {
     var query = JSON.parse(req.query.f);

     var page = req.query.pageindex || query.pageindex || 1,
         pageNum = req.query.pagesize || query.pagesize || 20,
         applicationID = query.ApplicationID || '',
         dictionaryID = query.DictionaryID || '',
         dictionaryLevel = query.DictionaryLevel || '',
         parentID = query.ParentID || '',
         category = query.Category || '',
         dictionaryCode = query.DictionaryCode || '',
         dictionaryValue = query.DictionaryValue || '',
         isActive = query.IsActive || '',
         isPaging = query.isPaging || 0;  //是否分页

    page = page>0 ? page : 1;

    if (pageNum == undefined) {
        pageNum = config.pageCount;
    }
    if(isActive == undefined || isActive == ''){
        isActive = 1;
    }
    var data = {
        "page": page,
        "pageNum": pageNum,
        "ApplicationID" : applicationID,
        "DictionaryID" : dictionaryID,
        "DictionaryLevel" : dictionaryLevel,
        "ParentID" : parentID,
        "Category" : category,
        "DictionaryCode" : dictionaryCode,
        "DictionaryValue" : dictionaryValue,
        "IsActive" : isActive,
        "isPaging" : isPaging
    };

    //用于查询结果总数的计数
    var countNum = 0;

    //查询所有数据总数
    datadictionaryService.countAllDataDicts(data, function (err, results) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: "服务器内部错误！"
            });
            return;
        }
        if (results != undefined && results.length != 0) {
            countNum = results[0]['num'];

            //查询所需的详细数据
            datadictionaryService.queryDatadictionary(data, function (err, result) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: "服务器内部错误！"
                    });
                }

                if (result != undefined && result.length != 0 && countNum != -1) {
                    var resultBack = {
                        code: 200,
                        isSuccess: true,
                        msg: '查询成功！',
                        dataNum: countNum,
                        curPage: page,
                        curPageNum:pageNum,
                        totalPage: Math.ceil(countNum/pageNum),
                        data: result
                    };
                    if(resultBack.curPage == resultBack.totalPage) {
                        resultBack.curPageNum = resultBack.dataNum - (resultBack.totalPage-1)*pageNum;
                    }
                    res.status(200);
                    return res.json(resultBack);
                } else {
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        msg: "未查询到相关字典信息！"
                    });
                }
            });
        } else {
            res.status(404);
            return res.json({
                code: 404,
                isSuccess: false,
                msg: "未查询到相关字典信息！"
            });
        }
    });
});

//subcode
router.get('/subcode',function (req,res) {
    var query = JSON.parse(req.query.f);

    var page = query.pageindex || 1,
        pageNum = query.pagesize || 20,
        dictionaryCode = query.DictionaryCode || '',
        isActive = query.IsActive || '';

    page = page>0 ? page : 1;

    if (pageNum == undefined) {
        pageNum = config.pageCount;
    }
    if(isActive == undefined || isActive == ''){
        isActive = 1;
    }
    var data = {
        "page": page,
        "pageNum": pageNum,
        "DictionaryCode" : dictionaryCode,
        "IsActive" : isActive
    };

    //用于查询结果总数的计数
    var countNum = 0;

    //查询所有数据总数
    datadictionaryService.countAllDataDictsBySubcode(data, function (err, results) {
        if (err) {
            res.status(500);
            res.json({
                code: 500,
                isSuccess: false,
                msg: "查询失败，服务器内部错误"
            });
            return;
        }
        if (results !== undefined && results.length != 0) {
            countNum = results[0]['num'];

            //查询所需的详细数据
            datadictionaryService.queryDatadictionaryBySubcode(data, function (err, result) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: "查询失败，服务器内部错误"
                    });
                }

                if (result !== undefined && result.length != 0 && countNum != -1) {
                    var resultBack = {
                        code: 200,
                        isSuccess: true,
                        msg: '查询成功',
                        dataNum: countNum,
                        curPage: page,
                        curPageNum:pageNum,
                        totalPage: Math.ceil(countNum/pageNum),
                        data: result
                    };
                    if(resultBack.curPage == resultBack.totalPage) {
                        resultBack.curPageNum = resultBack.dataNum - (resultBack.totalPage-1)*pageNum;
                    }
                    res.status(200);
                    return res.json(resultBack);
                } else {
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        msg: "未查询到相关字典信息"
                    });
                }
            });
        } else {
            res.status(404);
            return res.json({
                code: 404,
                isSuccess: false,
                msg: "未查询到相关字典信息"
            });
        }
    });
});

//查看字典
router.get('/tree',function (req,res) {
    var query = JSON.parse(req.query.f);

    var page = query.pageindex || 1,
        pageNum = query.pagesize || 20,
        applicationID = query.ApplicationID || '',
        dictionaryID = query.DictionaryID || '',
        dictionaryLevel = query.DictionaryLevel || '',
        parentID = query.ParentID || '',
        category = query.Category || '',
        dictionaryCode = query.DictionaryCode || '',
        dictionaryValue = query.DictionaryValue || '',
        memo = query.Memo || '',
        isActive = query.IsActive || '';

    page = page>0 ? page : 1;

    if (pageNum === undefined) {
        pageNum = config.pageCount;
    }

    if(isActive === undefined || isActive == ''){
        isActive = 1;
    }

    var data = {
        "page": page,
        "pageNum": pageNum,
        "ApplicationID" : applicationID,
        "DictionaryID" : dictionaryID,
        "DictionaryLevel" : dictionaryLevel,
        "ParentID" : parentID,
        "Category" : category,
        "DictionaryCode" : dictionaryCode,
        "DictionaryValue" : dictionaryValue,
        "IsActive" : isActive
    };

    //用于查询结果总数的计数
    var countNum = 0;

    //查询所有数据总数
    datadictionaryService.countAllDataDicts(data, function (err, results) {
        if (err) {
            res.status(500);
            res.json({
                code: 500,
                isSuccess: false,
                msg: "查询失败，服务器内部错误"
            });
            return;
        }
        if (results !== undefined && results.length != 0) {
            countNum = results[0]['num'];

            //查询所需的详细数据
            datadictionaryService.queryDatadictionaryFormTree(data, function (err, result) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: "查询失败，服务器内部错误"
                    });
                }

                if (result !== undefined && result.length != 0 && countNum != -1) {
                    var resultBack = {
                        code: 200,
                        isSuccess: true,
                        msg: '查询成功',
                        dataNum: countNum,
                        curPage: page,
                        curPageNum:pageNum,
                        totalPage: Math.ceil(countNum/pageNum),
                        data: result
                    };
                    if(resultBack.curPage == resultBack.totalPage) {
                        resultBack.curPageNum = resultBack.dataNum - (resultBack.totalPage-1)*pageNum;
                    }
                    res.status(200);
                    return res.json(resultBack);
                } else {
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        result : result,
                        msg: "未查询到相关字典信息"
                    });
                }
            });
        } else {
            res.status(404);
            return res.json({
                code: 404,
                isSuccess: false,
                msg: "未查询到相关字典信息"
            });
        }
    });
});

//新增字典
router.post('/',function (req,res) {
    var data = ['ApplicationID', 'DictionaryLevel', 'ParentID', 'Category','DictionaryCode','DictionaryValue'],
        err = 'required: ';

    var applicationID = req.body.ApplicationID,
        dictionaryLevel = req.body.DictionaryLevel,
        parentID = req.body.ParentID,
        category = req.body.Category,
        dictionaryCode = req.body.DictionaryCode,
        dictionaryValue = req.body.DictionaryValue,
        memo = req.body.Memo,
        isActive = req.body.IsActive;

    if(memo === undefined || memo == ''){
        memo = "memo";
    }

    if(isActive === undefined || isActive == ''){
        isActive = 1;
    }

    for(var value in data)
    {
        if(!(data[value] in req.body))
        {
            console.log("require " + data[value]);
            err += data[value] + ' ';
        }
    }

    if(err != 'required: ')
    {
        res.status(400);
        return res.json({
            code: 400,
            isSuccess: false,
            msg: err
        });
    };

    var insertData = {
        ApplicationID : applicationID,
        DictionaryLevel:dictionaryLevel,
        ParentID : parentID,
        Category : category,
        DictionaryCode : dictionaryCode,
        DictionaryValue : dictionaryValue,
        Memo : memo,
        IsActive : isActive
    };

    datadictionaryService.datadictionaryInsert(insertData,function (err, result) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: "服务器内部错误"
            });
        }

        if(result !== undefined && result.affectedRows != 0){
            res.status(200);
            return res.json({
                code : 200,
                isSuccess : true,
                insertId : result.insertId,
                msg : '字典新增成功'
            });
        }else{
            res.status(404);
            return res.json({
                code : 404,
                isSuccess : false,
                msg : '字典新增失败'
            });
        }
    })
});

//字典编辑
router.put('/',function (req,res) {
    var data = ['ApplicationID','DictionaryID', 'DictionaryLevel', 'ParentID', 'Category','DictionaryCode','DictionaryValue'],
        err = 'required: ';

    var applicationID = req.body.ApplicationID,
        dictionaryID = req.body.DictionaryID,
        dictionaryLevel = req.body.DictionaryLevel,
        parentID = req.body.ParentID,
        category = req.body.Category,
        dictionaryCode = req.body.DictionaryCode,
        dictionaryValue = req.body.DictionaryValue,
        memo = req.body.Memo,
        isActive = req.body.IsActive;

    if(memo === undefined || memo == ''){
        memo = "memo";
    }

    if(isActive === undefined || isActive == ''){
        isActive = 1;
    }

    for(var value in data)
    {
        if(!(data[value] in req.body))
        {
            console.log("require " + data[value]);
            err += data[value] + ' ';
        }
    }

    if(err != 'required: ')
    {
        res.status(404);
        return res.json({
            code: 404,
            isSuccess: false,
            msg: err
        });
    };

    var updateData = {
        ApplicationID : applicationID,
        DictionaryID : dictionaryID,
        DictionaryLevel:dictionaryLevel,
        ParentID : parentID,
        Category : category,
        DictionaryCode : dictionaryCode,
        DictionaryValue : dictionaryValue,
        Memo : memo,
        IsActive : isActive
    };

    var checkData = {
        DictionaryID : dictionaryID
    };
    //判断是否有此字典
    datadictionaryService.countAllDataDicts(checkData, function (err, result) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: "服务器内部错误"
            });
        }
        //如果有，则可以修改
        if (result !== undefined && result[0]['num'] != 0) {
            datadictionaryService.datadictionaryUpdate(updateData,function (err, results) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: "修改失败，服务器内部错误"
                    });
                }

                if(results!== undefined && results.affectedRows != 0){
                    res.status(200);
                    return res.json({
                        code : 200,
                        isSuccess : true,
                        successResult : results,
                        msg : '字典修改成功'
                    });
                }else{
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        msg: "字典修改失败"
                    });
                }
            });
        }else {
            res.status(404);
            return res.json({
                code: 404,
                isSuccess: false,
                msg: "此字典不存在，不能修改"
            });
        }
    });


});

//物理删除字典
router.delete('/',function (req,res) {
    //DictionaryID是主键，只需要此属性就可准确删除，不必传入其他参数
    var dictionaryID = req.body.DictionaryID;
    if (dictionaryID === undefined) {
        res.status(404);
        return res.json({
            code: 404,
            isSuccess: false,
            msg: 'require DictionaryID'
        });
    }
    if(isNaN(dictionaryID)){
        res.status(400);
        return res.json({
            code: 400,
            isSuccess: false,
            msg: 'DictionaryID不是数字'
        });
    }
    var data = {
        "DictionaryID" : dictionaryID
    };

    //判断是否有此字典
    datadictionaryService.countAllDataDicts(data, function (err, result) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: "服务器内部错误"
            });
        }
        //如果有，则可以删除
        if (result !== undefined && result[0]['num'] != 0) {
            datadictionaryService.datadictionaryDelete(data,function (err,results) {
                if(err){
                    res.status(500);
                    return res.json({
                        code :500,
                        isSuccess : false,
                        msg : '服务器出错'
                    });
                }

                //判断是否删除成功
                if(results !== undefined && results.affectedRows != 0){
                    res.status(200);
                    return res.json({
                        code : 200,
                        isSuccess : true,
                        deleteResult : results,
                        msg : '字典删除成功'
                    });
                }else {
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        msg: "字典删除失败"
                    });
                }
            });
        }else {
            res.status(404);
            return res.json({
                code: 404,
                isSuccess: false,
                msg: "此字典不存在，删除失败"
            });
        }
    });

});

//逻辑删除字典
router.delete('/logical',function (req,res) {
    //MenuID是主键，只需要此属性就可准确删除，不必传入其他参数
    var dictionaryID = req.body.DictionaryID;

    if (dictionaryID === undefined) {
        res.status(404);
        return res.json({
            code: 404,
            isSuccess: false,
            msg: 'require DictionaryID'
        });
    }
    if(isNaN(dictionaryID)){
        res.status(400);
        return res.json({
            code: 400,
            isSuccess: false,
            msg: 'DictionaryID不是数字'
        });
    }
    var data = {
        "DictionaryID" : dictionaryID
    };

    var formData = {
        "DictionaryID" : dictionaryID,
        "IsActive" : 0
    };
    //判断是否有此字典
    datadictionaryService.countAllDataDicts(data, function (err, result) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: "服务器内部错误"
            });
        }
        //如果有，则可以删除
        if (result !== undefined && result[0]['num'] != 0) {
            datadictionaryService.datadictionaryDeleteLogically(formData,function (err,results) {
                if(err){
                    res.status(500);
                    return res.json({
                        code :500,
                        isSuccess : false,
                        msg : '服务器出错'
                    });
                }

                //判断是否删除成功
                if(results !== undefined && results.affectedRows != 0){
                    res.status(200);
                    return res.json({
                        code : 200,
                        isSuccess : true,
                        deleteResult : results,
                        msg : '字典删除成功'
                    });
                }else {
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        msg: "字典删除失败"
                    });
                }
            });
        }else {
            res.status(404);
            return res.json({
                code: 404,
                isSuccess: false,
                msg: "此字典不存在，删除失败"
            });
        }
    });

});

module.exports = router;
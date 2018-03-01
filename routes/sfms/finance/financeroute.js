/**
 * @Author: bitzo
 * @Date: 2016/12/3 19:53
 * @Last Modified by: bitzo
 * @Last Modified time: 2016/12/3 19:53
 * @Function: 财务管理
 */

var express = require('express'),
    router = express.Router(),
    financeService = appRequire('service/sfms/finance/financeservice'),
    projectservice = appRequire('service/sfms/project/projectservice'),
    dataservice = appRequire('service/backend/datadictionary/datadictionaryservice'),
    projectuserservice = appRequire('service/sfms/project/projectuserservice'),
    userservice = appRequire('service/backend/user/userservice'),
    config = appRequire('config/config'),
    moment = require('moment'),
    logger = appRequire("util/loghelper").helper,
    functionConfig = appRequire('config/functionconfig'),
    nodeExcel = require('excel-export'),
    userFuncService = appRequire('service/backend/user/userfuncservice');

/**
 * 财务信息新增
 *  1. 验证申报财务的项目是否存在
 *  2. 查询fiType、inOutType、fiName是否在字典表中
 *  3. 获取userID的username
 *  4. 存入数据
 */
router.post('/', function (req, res) {
    var data = {
        userID: req.query.jitkey,
        functionCode: functionConfig.sfmsApp.financeManage.financeAdd.functionCode
    };

    userFuncService.checkUserFunc(data, function(err, results) {
        if (err) {
            res.status(500);

            return res.json({
                code: 500,
                isSuccess: false,
                msg: '查询失败，服务器出错'
            });
        }

        if (!(results !== undefined && results.isSuccess)) {
            res.status(400);

            return res.json({
                code: 400,
                isSuccess: false,
                msg: results.msg
            });
        }

        var query = req.body.formdata,
            fiName = query.FIName,
            fiType = query.FIType,
            inOutType = query.InOutType,
            fiPrice = query.FIPrice,
            projectID = query.ProjectID,
            userID = query.UserID || req.query.jitkey,
            userName = query.UserName,
            operateUser = req.query.jitkey,
            remark = query.Remark,
            isActive = 1,
            //前端需要传输的数据
            temp = ['FIName', 'FIType', 'InOutType', 'FIPrice', 'ProjectID','UserID','Remark'],
            temp1 = ['财务名称', '财务类型', '财务收支', '财务金额','所属项目', '用户名', '财务描述'];

        err = '缺少值: ';

        //数据全部验证完毕后存入数据
        var data = {
            'FIName': fiName,
            'FIType': fiType,
            'InOutType': inOutType,
            'FIPrice': fiPrice,
            'ProjectID': projectID,
            'UserID': userID,
            'UserName': userName,
            'OperateUser': operateUser,
            'OperateUserID': req.query.jitkey,
            'FIStatu': '待审核',
            'Remark': remark,
            'IsActive': isActive
        };

        for(var value in temp)
        {
            if(!(temp[value] in data))
            {
                logger.writeInfo("缺少值 " + temp[value]);
                err += temp1[value] + ' ';
            }
        }

        if(err!='缺少值: ')
        {
            res.status(400);
            return res.json({
                status: 400,
                isSuccess: false,
                msg: err
            });
        }

        projectuserservice.judgeUserProject({userID:userID,projectID:projectID,operateUserID:req.query.jitkey},function (err, results) {
            if (err) {
                res.status(500);

                return res.json({
                    status: 500,
                    isSuccess: false,
                    msg: '操作失败，服务器出错'
                });
            }

            if (!results.isSuccess) {
                res.status(400);

                return res.json({
                    status: 404,
                    isSuccess: false,
                    msg: '操作失败，用户不在所在的项目中'
                });
            }

            //验证申报财务的项目是否存在
            var temp_data = {
                'ID': projectID,
                'IsActive': 1,
                'OperateUserID': req.query.jitkey
            };

            projectservice.queryProject(temp_data, function (err, results) {
                if (err) {
                    res.status(500);

                    return res.json({
                        status: 500,
                        isSuccess: false,
                        msg: '操作失败，服务器出错'
                    });
                }

                if (!(results !== undefined && results.length > 0)) {
                    res.status(400);

                    return res.json({
                        status: 404,
                        isSuccess: false,
                        msg: '项目信息有误'
                    });
                }

                //查询fiType、inOutType是否在字典表中
                var DicID = {
                    'DictionaryID': [fiType, inOutType]
                };

                dataservice.queryDatadictionaryByID(DicID, function (err, results) {
                    if (err) {
                        res.status(500);

                        return res.json({
                            status: 500,
                            isSuccess: false,
                            msg: '操作失败，服务器出错'
                        });
                    }

                    if (!(results !== undefined && results.length == DicID.DictionaryID.length)) {
                        res.status(400);

                        return res.json({
                            status: 404,
                            isSuccess: false,
                            msg: '操作失败，财务类型或财务名称有误'
                        });
                    }

                    //获取userid的username
                    userservice.querySingleID(userID, function (err, results) {
                        if (err) {
                            res.status(500);

                            return res.json({
                                status: 500,
                                isSuccess: false,
                                msg: '操作失败，服务器出错'
                            });
                        }

                        if (!(results !== undefined && results.length > 0)) {
                            res.status(400);

                            return res.json({
                                status: 404,
                                isSuccess: false,
                                msg: '操作失败，用户无效'
                            });
                        }

                        data.UserName = results[0].UserName;

                        userservice.querySingleID(userID, function (err, results) {
                            if (err) {
                                res.status(500);

                                return res.json({
                                    status: 500,
                                    isSuccess: false,
                                    msg: '操作失败，服务器出错'
                                });
                            }

                            if (!(results !== undefined && results.length > 0)) {
                                res.status(400);

                                return res.json({
                                    status: 404,
                                    isSuccess: false,
                                    msg: '操作失败，用户无效'
                                });
                            }

                            data.OperateUser = results[0].UserName;

                            if (isNaN(data.FIPrice)||data.FIPrice<0) {
                                res.status(400);

                                return res.json({
                                    code: 400,
                                    isSuccess: false,
                                    msg: '财务金额不是正确的数值'
                                });
                            }

                            if (data.FIName.length>45) {
                                res.status(400);

                                return res.json({
                                    code: 400,
                                    isSuccess: false,
                                    msg: '财务名称过长,请勿超过45个字符'
                                });
                            }
                            if (data.Remark.length>45) {
                                res.status(400);

                                return res.json({
                                    code: 400,
                                    isSuccess: false,
                                    msg: '备注过长,请勿超过45个字符'
                                });
                            }

                            financeService.addFinance(data, function (err, results) {
                                if (err) {
                                    res.status(500);

                                    return res.json({
                                        status: 500,
                                        isSuccess: false,
                                        msg: '操作失败，服务器出错'
                                    });
                                }

                                if(results !== undefined && results.insertId > 0) {
                                    res.status(200);

                                    return res.json({
                                        status: 200,
                                        isSuccess: true,
                                        msg: '操作成功'
                                    });
                                } else {
                                    res.status(400);

                                    return res.json({
                                        status: 404,
                                        isSuccess: false,
                                        msg: results
                                    });
                                }
                            })
                        });
                    });
                });
            });
        })
    });
});

//财务信息重新启用
router.put('/reuse', function (req, res) {
    var data = {
        userID: req.query.jitkey,
        functionCode: functionConfig.sfmsApp.financeManage.financeEdit.functionCode
    };

    userFuncService.checkUserFunc(data, function (err, results) {
        if (err) {
            res.status(500);

            return res.json({
                code: 500,
                isSuccess: false,
                msg: '查询失败，服务器出错'
            });
        }

        if (!(results !== undefined && results.isSuccess === true)) {
            res.status(400);

            return res.json({
                code: 400,
                isSuccess: false,
                msg: results.msg
            });
        }

        data = req.body.formdata;
        data.OperateUserID = req.query.jitkey;

        financeService.updateFinance(data, function (err, results) {
            if (err) {
                res.status(500);

                return res.json({
                    status: 500,
                    isSuccess: false,
                    msg: '操作失败，服务器出错'
                });
            }

            if(results !== undefined && results.affectedRows > 0) {
                res.status(200);

                return res.json({
                    status: 200,
                    isSuccess: true,
                    msg: '操作成功'
                });
            } else {
                res.status(400);

                return res.json({
                    status: 404,
                    isSuccess: false,
                    msg: '操作失败'
                });
            }
        });
    });
});

/**
 * 财务基本信息编辑
 * 1. 先验证所要编辑的财务信息是否已经被审核
 * 2. 检查项目ID是否有效
 * 3. 查询字典表，验证fiName,fiType,inOutType
 * 4. 查询用户ID 的 username
 * 5. 全部核实并查询完，存入数据
 */
router.put('/', function (req, res) {
    var data = {
        userID: req.query.jitkey,
        functionCode: functionConfig.sfmsApp.financeManage.financeEdit.functionCode
    };

    userFuncService.checkUserFunc(data, function(err, results) {
        if (err) {
            res.status(500);

            return res.json({
                code: 500,
                isSuccess: false,
                msg: '查询失败，服务器出错'
            });
        }

        if (!(results !== undefined && results.isSuccess === true)) {
            res.status(400);

            return res.json({
                code: 400,
                isSuccess: false,
                msg: results.msg
            });
        }

        var query = req.body.formdata,
            ID = query.ID,
            fiName = query.FIName,
            fiType = query.FIType,
            inOutType = query.InOutType,
            fiPrice = query.FIPrice,
            projectID = query.ProjectId,
            userID = query.UserID,
            userName = query.UserName,
            operateUser = req.query.jitkey,
            remark = query.Remark || '',
            isActive = 1,
            //前端需要传输的数据
            temp = ['ID', 'FIName', 'FIType', 'InOutType', 'FIPrice', 'ProjectId','UserID','Remark'],
            temp1 = ['财务ID', '财务名称', '财务类型', '财务收支', '财务金额','所属项目', '用户名', '财务描述'];

        err = '缺少值: ';

        for(var value in temp)
        {
            if(!(temp[value] in query))
            {
                logger.writeInfo("缺少值 " + temp[value]);
                err += temp1[value] + ' ';
            }
        }

        if(err!='缺少值: ')
        {
            res.status(400);

            return res.json({
                status: 400,
                isSuccess: false,
                msg: err
            })
        }

        projectuserservice.judgeUserProject({userID:userID,projectID:projectID,operateUserID:operateUser},function (err, results) {
            if (err) {
                res.status(500);

                return res.json({
                    status: 500,
                    isSuccess: false,
                    msg: '操作失败，服务器出错'
                });
            }

            if (!results.isSuccess) {
                res.status(400);

                return res.json({
                    status: 404,
                    isSuccess: false,
                    msg: '操作失败，用户不在所在的项目中'
                });
            }


            financeService.queryFinance({'ID':ID,'OperateUserID':req.query.jitkey}, function (err, results) {
                if (err) {
                    res.status(500);

                    return res.json({
                        status: 500,
                        isSuccess: false,
                        msg: '操作失败，服务器出错'
                    });
                }

                if (results.length>0 && results[0].IsActive === 0 ) {
                    res.status(400);

                    return res.json({
                        status: 400,
                        isSuccess: false,
                        msg: '操作失败，该财务信息已无效'
                    });
                }

                if (!(results[0].FIStatu == '待审核')) {
                    res.status(400);

                    return res.json({
                        status: 404,
                        isSuccess: false,
                        msg: '操作失败，项目已审核或无效，不可编辑'
                    });
                }

                //验证申报财务的项目是否存在
                data = {
                    'ID': projectID,
                    'IsActive': 1,
                    'OperateUserID': req.query.jitkey
                };

                projectservice.queryProject(data, function (err, results) {
                    if (err) {
                        res.status(500);

                        return res.json({
                            status: 500,
                            isSuccess: false,
                            msg: '操作失败，服务器出错'
                        });
                    }

                    if (!(results !== undefined && results.length > 0)) {
                        res.status(400);

                        return res.json({
                            status: 404,
                            isSuccess: false,
                            msg: '操作失败，项目信息有误'
                        });
                    }

                    //查询fiType、inOutType是否在字典表中
                    var DicID = {
                        'DictionaryID': [fiType, inOutType]
                    };

                    dataservice.queryDatadictionaryByID(DicID, function (err, results) {
                        if (err) {
                            res.status(500);

                            return res.json({
                                status: 500,
                                isSuccess: false,
                                msg: '操作失败，服务器出错'
                            });
                        }

                        if (!(results !== undefined && results.length == DicID.DictionaryID.length)) {
                            res.status(400);

                            return res.json({
                                status: 404,
                                isSuccess: false,
                                msg: '操作失败，财务类型或财务名称有误'
                            });
                        }

                        //获取userid的username
                        userservice.querySingleID(userID, function (err, results) {
                            if (err) {
                                res.status(500);

                                return res.json({
                                    status: 500,
                                    isSuccess: false,
                                    msg: '操作失败，服务器出错'
                                });
                            }

                            if (!(results !== undefined && results.length > 0)) {
                                res.status(400);

                                return res.json({
                                    status: 404,
                                    isSuccess: false,
                                    msg: '操作失败，用户无效'
                                });
                            }

                            userName = results[0].UserName;

                            userservice.querySingleID(operateUser, function (err, results) {
                                if (err) {
                                    res.status(500);

                                    return res.json({
                                        status: 500,
                                        isSuccess: false,
                                        msg: '操作失败，服务器出错'
                                    });
                                }

                                if (results !== undefined && results.length > 0) {
                                    operateUser = results[0].UserName;
                                    //数据全部验证完毕后存入数据
                                    var data = {
                                        'ID': ID,
                                        'FIName': fiName,
                                        'FIType': fiType,
                                        'InOutType': inOutType,
                                        'FIPrice': fiPrice,
                                        'ProjectID': projectID,
                                        'UserID': userID,
                                        'UserName': userName,
                                        'OperateUser': operateUser,
                                        'OperateUserID': req.query.jitkey,
                                        'FIStatu': '待审核',
                                        'Remark': remark,
                                        'IsActive': isActive
                                    };

                                    if (isNaN(data.FIPrice)||data.FIPrice<0) {
                                        res.status(400);

                                        return res.json({
                                            code: 400,
                                            isSuccess: false,
                                            msg: '财务金额不是正确的数值'
                                        });
                                    }

                                    if (data.FIName.length>45) {
                                        res.status(400);

                                        return res.json({
                                            code: 400,
                                            isSuccess: false,
                                            msg: '财务名称过长,请勿超过45个字符'
                                        });
                                    }

                                    if (data.Remark.length>45) {
                                        res.status(400);

                                        return res.json({
                                            code: 400,
                                            isSuccess: false,
                                            msg: '备注过长,请勿超过45个字符'
                                        });
                                    }

                                    financeService.updateFinance(data, function (err, results) {
                                        if (err) {
                                            res.status(500);

                                            return res.json({
                                                status: 500,
                                                isSuccess: false,
                                                msg: '操作失败，服务器出错'
                                            });
                                        }

                                        if(results !== undefined && results.affectedRows > 0) {
                                            res.status(200);

                                            return res.json({
                                                status: 200,
                                                isSuccess: true,
                                                msg: '操作成功'
                                            });
                                        } else {
                                            res.status(400);

                                            return res.json({
                                                status: 404,
                                                isSuccess: false,
                                                msg: results
                                            });
                                        }
                                    });
                                } else {
                                    res.status(400);

                                    return res.json({
                                        status: 404,
                                        isSuccess: false,
                                        msg: '操作失败，用户无效'
                                    });
                                }
                            });
                        });
                    });
                });
            });
        })
    });
});

//财务统计导出excel
router.get('/excel', function(req, res) {
    var data = {
        userID: req.query.jitkey,
        functionCode: functionConfig.sfmsApp.financeManage.financeCount.functionCode
    };

    userFuncService.checkUserFunc(data, function(err, results) {
        if (err) {
            return res.send("数据异常");
        }

        if (!(results !== undefined && results.isSuccess)) {
            return res.send("数据异常");
        }
        var query = req.query,
            startTime = query.startTime || '',
            endTime = query.endTime || '',
            isActive = query.isActive || '';

        if (startTime!=='') startTime = startTime.slice(1,-1);
        if (endTime!=='') endTime = endTime.slice(1,-1);

        var filename = moment().format('YYYYMMDDHHmmss').toString(),
            data = {
                'startTime': startTime,
                'endTime': endTime,
                'IsActive': isActive,
                'isPage': 1,
                'OperateUserID': req.query.jitkey
            };

        financeService.countQuery(data, function (err, results) {
            if (err) {
                return res.send("数据异常");
            }

            var totalNum = results[0].num;

            if(totalNum <= 0) {
                return res.send("暂无数据");
            }

            //查询所需的详细数据
            financeService.queryFinance(data, function (err, results) {
                if (err) {
                    return res.send("数据异常");
                }

                if (!(results !== undefined && results.length > 0)) {
                    return res.send("暂无数据");
                }
                for (var i in results) {
                    results[i].CreateTime = moment(results[i].CreateTime).format('YYYY-MM-DD HH:mm');
                    if(results[i].CheckTime !== null)
                        results[i].CheckTime = moment(results[i].CheckTime).format('YYYY-MM-DD HH:mm');
                }

                //替换用户名
                var ID = [],DicID = [];

                for (var i=0;i<results.length;++i) {
                    if (results[i].CheckUser == null) continue;
                    if (i==0) ID[i] = results[i].CheckUser;
                    else {
                        var j = 0;
                        for (j=0;j<ID.length;++j) {
                            if (ID[j] == results[i].CheckUser) break;
                        }
                        if (j == ID.length) ID[j] = results[i].CheckUser;
                    }
                }

                for (var i=0;i<results.length;++i) {
                    if (i==0) {
                        DicID[0] = results[i].FIType;
                        DicID[1] = results[i].InOutType;
                    }
                    else {
                        var k=0;
                        for (k=0;k<DicID.length;++k) {
                            if (DicID[k] == results[i].FIType) break;
                        }
                        if (k == DicID.length) DicID[k] = results[i].FIType;
                        for (k=0;k<DicID.length;++k) {
                            if (DicID[k] == results[i].InOutType) break;
                        }
                        if (k == DicID.length) DicID[k] = results[i].InOutType;
                    }
                }

                userservice.queryAccountByID(ID, function (err, data) {
                    if (err) {
                        return res.send("数据异常");
                    }

                    for (var i in results) {
                        for (var j in data) {
                            if (results[i].CheckUser == data[j].AccountID) {
                                results[i].CheckUser = data[j].UserName;
                                break;
                            }
                        }
                    }

                    //查询字典表 更新所有字典表数据
                    dataservice.queryDatadictionaryByID({"DictionaryID":DicID}, function (err, data) {
                        if (err) {
                            return res.send("数据异常");
                        }

                        if (!(data!==undefined && data.length>0)) {
                            return res.send("暂无数据");
                        }
                        for (var i in results) {
                            var j=0;
                            for (j=0;j<data.length;++j) {
                                if (results[i].FIType == data[j].DictionaryID) results[i].FITypeValue = data[j].DictionaryValue;
                                if (results[i].InOutType == data[j].DictionaryID) results[i].InOutTypeValue = data[j].DictionaryValue;
                            }
                            results[i].IsActive = results[i].IsActive == 1 ? '是' : '否';
                        }

                        var conf ={};

                        conf.cols = [{
                            caption:'序号',
                            type:'string',
                        },{
                            caption:'财务名称',
                            type:'string',
                        },{
                            caption:'财务类型',
                            type:'string'
                        },{
                            caption:'收支类型',
                            type:'string'
                        },{
                            caption:'财务金额',
                            type:'string'
                        },{
                            caption:'所属项目',
                            type:'string'
                        },{
                            caption:'申请人帐号',
                            type:'string'
                        },{
                            caption:'申请人',
                            type:'string'
                        },{
                            caption:'申请时间',
                            type:'string'
                        },{
                            caption:'审核状态',
                            type:'string'
                        },{
                            caption:'审核人',
                            type:'string'
                        },{
                            caption:'审核时间',
                            type:'string'
                        },{
                            caption:'备注',
                            type:'string'
                        },{
                            caption:'是否有效',
                            type:'string'
                        }];

                        conf.rows = [];

                        for(var i=0;i<results.length;++i) {
                            conf.rows.push([(i+1).toString(), results[i].FIName, results[i].FITypeValue,
                                results[i].InOutTypeValue, results[i].FIPrice, results[i].ProjectName,
                                results[i].UserID.toString(), results[i].UserName, results[i].CreateTime,
                                results[i].FIStatu, results[i].CheckUser, results[i].CheckTime,
                                results[i].Remark, results[i].IsActive]);
                        }

                        var result = nodeExcel.execute(conf);

                        res.setHeader('Content-Type', 'application/vnd.openxmlformats');
                        res.setHeader("Content-Disposition", "attachment; filename="+filename+".xlsx");

                        return res.end(result, 'binary');

                    });
                });
            });
        });
    });
});

//财务统计
router.get('/count', function(req, res) {
    var data = {
        userID: req.query.jitkey,
        functionCode: functionConfig.sfmsApp.financeManage.financeCount.functionCode
    };

    userFuncService.checkUserFunc(data, function(err, results) {
        if (err) {
            res.status(500);

            return res.json({
                code: 500,
                isSuccess: false,
                msg: '查询失败，服务器出错'
            });
        }

        if (results !== undefined && results.isSuccess === true) {
            var startTime = req.query.startTime || '',
                endTime = req.query.endTime || '';

            if (startTime!=='') startTime = startTime.slice(1,-1);
            if (endTime!=='') endTime = endTime.slice(1,-1);

            var data = {
                'startTime': startTime,
                'endTime': endTime,
                'OperateUserID': req.query.jitkey
            };

            financeService.financeCount(data, function (err, results) {
                if (err) {
                    res.status(500);

                    return res.json({
                        status: 500,
                        isSuccess: false,
                        msg: '操作失败，服务器出错'
                    });
                }

                if (results!==undefined&&results.length>0) {
                    var DicID = [];

                    for (var i=0;i<results.length;++i) {
                        if (i==0) {
                            DicID[0] = results[i].FIType;
                            DicID[1] = results[i].InOutType;
                        } else {
                            var k=0;

                            for (k=0;k<DicID.length;++k) {
                                if (DicID[k] == results[i].FIType) break;
                            }

                            if (k == DicID.length) DicID[k] = results[i].FIType;

                            for (k=0;k<DicID.length;++k) {
                                if (DicID[k] == results[i].InOutType) break;
                            }

                            if (k == DicID.length) DicID[k] = results[i].InOutType;
                        }
                    }

                    //查询字典表 更新所有字典表数据
                    dataservice.queryDatadictionaryByID({"DictionaryID":DicID}, function (err, data) {
                        if (err) {
                            res.status(500);

                            return res.json({
                                status: 500,
                                isSuccess: false,
                                msg: '操作失败，服务器出错'
                            });
                        }

                        if (data!==undefined && data.length>0) {
                            for (var i in results) {
                                var j=0;
                                for (j=0;j<data.length;++j) {
                                    if (results[i].FIType == data[j].DictionaryID) results[i].FITypeValue = data[j].DictionaryValue;
                                    if (results[i].InOutType == data[j].DictionaryID) results[i].InOutTypeValue = data[j].DictionaryValue;
                                }
                            }

                            data = {
                                'InSum': 0,
                                'OutSum': 0,
                                'detail': results
                            };

                            for (var i in results) {
                                if (results[i].InOutTypeValue == '收入') data.InSum +=  results[i].sum;
                                if (results[i].InOutTypeValue == '支出') data.OutSum +=  results[i].sum;
                            }

                            res.status(200);

                            return res.json({
                                code: 200,
                                isSuccess: true,
                                data: data
                            });
                        } else {
                            res.status(200)

                            return res.json({
                                status: 200,
                                isSuccess: false,
                                msg: '无数据'
                            });
                        }
                    });
                } else {
                    res.status(200);

                    return res.json({
                        status: 200,
                        isSuccess: true,
                        msg: '暂无数据'
                    })
                }
            });
        } else {
            res.status(400);

            return res.json({
                code: 400,
                isSuccess: false,
                msg: results.msg
            });
        }
    });
});

//财务信息查询-个人界面
router.get('/person', function (req, res, next) {
    var data = {
        userID: req.query.jitkey,
        functionCode: functionConfig.sfmsApp.financeManage.financePersonQuery.functionCode
    };

    userFuncService.checkUserFunc(data, function(err, results) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '查询失败，服务器出错'
            });
        }

        if (!(results !== undefined && results.isSuccess)) {
            res.status(400);

            return res.json({
                code: 400,
                isSuccess: false,
                msg: results.msg
            });
        }

        var query = JSON.parse(req.query.f),
            ID = query.ID || '',
            startTime = query.startTime || '',
            endTime = query.endTime || '',
            fiType = query.FIType || '',
            inOutType = query.InOutType || '',
            projectID = query.ProjectID || '',
            userID = req.query.jitkey,
            fiStatus = query.FIStatus || '',
            fiName = query.FIName || '',
            isActive = query.IsActive || '',
            page = req.query.pageindex || 1,
            pageNum = req.query.pagesize || config.pageCount,
            totalNum = 0;

        page = page > 0 ? page : 1;

        var data = {
            'ID':ID,
            'UserID': userID,
            'InOutType': inOutType,
            'FIName': fiName,
            'ProjectID': projectID,
            'FIType': fiType.trim(),
            'FIStatus': fiStatus.trim(),
            'startTime': startTime,
            'endTime': endTime,
            'OperateUserID': req.query.jitkey,
            'page': page,
            'pageNum': pageNum,
            'IsActive': isActive
        };

        if (moment(data.startTime).isValid())
            data.startTime = moment(data.startTime).format("YYYY-MM-DD HH:mm:ss");

        if (moment(data.endTime).isValid())
            data.endTime = moment(data.endTime).format("YYYY-MM-DD HH:mm:ss");

        financeService.countQuery(data, function (err, results) {
            if (err) {
                res.status(500);

                return res.json({
                    status: 500,
                    isSuccess: false,
                    msg: '操作失败，服务器出错'
                });
            }

            logger.writeInfo(results);
            totalNum = results[0].num;

            if(totalNum > 0) {
                //查询所需的详细数据
                financeService.queryFinance(data, function (err, results) {
                    if (err) {
                        res.status(500);

                        return res.json({
                            status: 500,
                            isSuccess: false,
                            msg: '操作失败，服务器出错'
                        });
                    }

                    if (results !== undefined && results.length > 0) {
                        for (var i in results) {
                            results[i].CreateTime = moment(results[i].CreateTime).format('YYYY-MM-DD HH:mm');
                            if(results[i].CheckTime !== null)
                                results[i].CheckTime = moment(results[i].CheckTime).format('YYYY-MM-DD HH:mm');
                        }

                        var result = {
                            status: 200,
                            isSuccess: true,
                            dataNum: totalNum,
                            curPage: page,
                            totalPage: Math.ceil(totalNum/pageNum),
                            curPageNum: pageNum,
                            data: results
                        };

                        if(result.curPage == result.totalPage) {
                            result.curPageNum = result.dataNum - (result.totalPage-1)*pageNum;
                        }

                        //替换用户名
                        var ID = [],DicID = [];

                        for (var i=0;i<results.length;++i) {
                            if (results[i].CheckUser == null) continue;
                            if (i==0) ID[i] = results[i].CheckUser;
                            else {
                                var j = 0;
                                for (j=0;j<ID.length;++j) {
                                    if (ID[j] == results[i].CheckUser) break;
                                }
                                if (j == ID.length) ID[j] = results[i].CheckUser;
                            }
                        }

                        for (var i=0;i<results.length;++i) {
                            if (i==0) {
                                DicID[0] = results[i].FIType;
                                DicID[1] = results[i].InOutType;
                            }
                            else {
                                var k=0;
                                for (k=0;k<DicID.length;++k) {
                                    if (DicID[k] == results[i].FIType) break;
                                }
                                if (k == DicID.length) DicID[k] = results[i].FIType;
                                for (k=0;k<DicID.length;++k) {
                                    if (DicID[k] == results[i].InOutType) break;
                                }
                                if (k == DicID.length) DicID[k] = results[i].InOutType;
                            }
                        }

                        userservice.queryAccountByID(ID, function (err, data) {
                            if (err) {
                                res.status(500);

                                return res.json({
                                    status: 500,
                                    isSuccess: false,
                                    msg: '操作失败，服务器出错'
                                });
                            }

                            for (var i in results) {
                                for (var j in data) {
                                    if (results[i].CheckUser == data[j].AccountID) {
                                        results[i].CheckUser = data[j].UserName;
                                        break;
                                    }
                                }
                            }

                            //查询字典表 更新所有字典表数据
                            dataservice.queryDatadictionaryByID({"DictionaryID":DicID}, function (err, data) {
                                if (err) {
                                    res.status(500);

                                    return res.json({
                                        status: 500,
                                        isSuccess: false,
                                        msg: '操作失败，服务器出错'
                                    });
                                }

                                if (data!==undefined && data.length>0) {
                                    for (var i in results) {
                                        var j=0;
                                        for (j=0;j<data.length;++j) {
                                            if (results[i].FIType == data[j].DictionaryID) results[i].FITypeValue = data[j].DictionaryValue;
                                            if (results[i].InOutType == data[j].DictionaryID) results[i].InOutTypeValue = data[j].DictionaryValue;
                                        }
                                    }

                                    res.status(200);

                                    return res.json(result);
                                } else {
                                    res.status(200);

                                    return res.json({
                                        status: 200,
                                        isSuccess: false,
                                        msg: '无数据'
                                    });
                                }
                            });
                        });
                    } else {
                        res.status(200);

                        return res.json({
                            status: 200,
                            isSuccess: false,
                            msg: '无数据'
                        });
                    }
                });
            } else {
                res.status(200);

                return res.json({
                    status: 200,
                    isSuccess: false,
                    msg: '无数据'
                });
            }
        });
    });
});

//财务信息查询
router.get('/', function (req, res) {
    var data = {
        userID: req.query.jitkey,
        functionCode: functionConfig.sfmsApp.financeManage.financeQuery.functionCode
    };

    userFuncService.checkUserFunc(data, function(err, results) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '查询失败，服务器出错'
            });
        }

        if (!(results !== undefined && results.isSuccess)) {
            res.status(400);

            return res.json({
                code: 400,
                isSuccess: false,
                msg: results.msg
            });
        }

        var query = JSON.parse(req.query.f),
            ID = query.ID || '',
            startTime = query.startTime || '',
            endTime = query.endTime || '',
            fiType = query.FIType || '',
            inOutType = query.InOutType || '',
            projectID = query.ProjectID || '',
            userID = query.userID || '',
            fiStatus = query.FIStatus || '',
            fiName = query.FIName || '',
            isActive = query.IsActive || '',
            page = req.query.pageindex || 1,
            pageNum = req.query.pagesize || config.pageCount,
            totalNum = 0;

        page = page > 0 ? page : 1;

        var data = {
            'ID':ID,
            'UserID': userID,
            'InOutType': inOutType,
            'FIName': fiName,
            'ProjectID': projectID,
            'FIType': fiType.trim(),
            'FIStatus': fiStatus.trim(),
            'startTime': startTime,
            'endTime': endTime,
            'OperateUserID': req.query.jitkey,
            'page': page,
            'pageNum': pageNum,
            'IsActive': isActive
        };

        if (moment(data.startTime).isValid())
            data.startTime = moment(data.startTime).format("YYYY-MM-DD HH:mm:ss");

        if (moment(data.endTime).isValid())
            data.endTime = moment(data.endTime).format("YYYY-MM-DD HH:mm:ss");

        financeService.countQuery(data, function (err, results) {
            if (err) {
                res.status(500);

                return res.json({
                    status: 500,
                    isSuccess: false,
                    msg: '操作失败，服务器出错'
                });
            }

            logger.writeInfo(results);
            totalNum = results[0].num;

            if(totalNum > 0) {
                //查询所需的详细数据
                financeService.queryFinance(data, function (err, results) {
                    if (err) {
                        res.status(500);

                        return res.json({
                            status: 500,
                            isSuccess: false,
                            msg: '操作失败，服务器出错'
                        });
                    }

                    if (results !== undefined && results.length > 0) {
                        for (var i in results) {
                            results[i].ProjectID = results[i].ProjectId;
                            results[i].CreateTime = moment(results[i].CreateTime).format('YYYY-MM-DD HH:mm');
                            if(results[i].CheckTime !== null)
                                results[i].CheckTime = moment(results[i].CheckTime).format('YYYY-MM-DD HH:mm');
                        }

                        var result = {
                            status: 200,
                            isSuccess: true,
                            dataNum: totalNum,
                            curPage: page,
                            totalPage: Math.ceil(totalNum/pageNum),
                            curPageNum: pageNum,
                            data: results
                        };

                        if(result.curPage == result.totalPage) {
                            result.curPageNum = result.dataNum - (result.totalPage-1)*pageNum;
                        }

                        //替换用户名
                        var ID = [],DicID = [];

                        for (var i=0;i<results.length;++i) {
                            if (results[i].CheckUser == null) continue;
                            if (i==0) ID[i] = results[i].CheckUser;
                            else {
                                var j = 0;
                                for (j=0;j<ID.length;++j) {
                                    if (ID[j] == results[i].CheckUser) break;
                                }
                                if (j == ID.length) ID[j] = results[i].CheckUser;
                            }
                        }

                        for (var i=0;i<results.length;++i) {
                            if (i==0) {
                                DicID[0] = results[i].FIType;
                                DicID[1] = results[i].InOutType;
                            }
                            else {
                                var k=0;
                                for (k=0;k<DicID.length;++k) {
                                    if (DicID[k] == results[i].FIType) break;
                                }
                                if (k == DicID.length) DicID[k] = results[i].FIType;
                                for (k=0;k<DicID.length;++k) {
                                    if (DicID[k] == results[i].InOutType) break;
                                }
                                if (k == DicID.length) DicID[k] = results[i].InOutType;
                            }
                        }

                        userservice.queryAccountByID(ID, function (err, data) {
                            if (err) {
                                res.status(500);

                                return res.json({
                                    status: 500,
                                    isSuccess: false,
                                    msg: '操作失败，服务器出错'
                                });
                            }

                            for (var i in results) {
                                for (var j in data) {
                                    if (results[i].CheckUser == data[j].AccountID) {
                                        results[i].CheckUser = data[j].UserName;
                                        break;
                                    }
                                }
                            }

                            //查询字典表 更新所有字典表数据
                            dataservice.queryDatadictionaryByID({"DictionaryID":DicID}, function (err, data) {
                                if (err) {
                                    res.status(500);

                                    return res.json({
                                        status: 500,
                                        isSuccess: false,
                                        msg: '操作失败，服务器出错'
                                    });
                                }

                                if (data!==undefined && data.length>0) {
                                    for (var i in results) {
                                        var j=0;
                                        for (j=0;j<data.length;++j) {
                                            if (results[i].FIType == data[j].DictionaryID) results[i].FITypeValue = data[j].DictionaryValue;
                                            if (results[i].InOutType == data[j].DictionaryID) results[i].InOutTypeValue = data[j].DictionaryValue;
                                        }
                                    }

                                    res.status(200);

                                    return res.json(result);
                                } else {
                                    res.status(200);

                                    return res.json({
                                        status: 200,
                                        isSuccess: false,
                                        msg: '无数据'
                                    });
                                }
                            });
                        });
                    } else {
                        res.status(200);

                        return res.json({
                            status: 200,
                            isSuccess: false,
                            msg: '无数据'
                        });
                    }
                });
            } else {
                res.status(200);

                return res.json({
                    status: 200,
                    isSuccess: false,
                    msg: '无数据'
                });
            }
        });
    });
});

//财务审核
router.put('/check', function (req, res) {
    var data = {
        userID: req.query.jitkey,
        functionCode: functionConfig.sfmsApp.financeManage.financeCheck.functionCode
    };

    userFuncService.checkUserFunc(data, function(err, results) {
        if (err) {
            res.status(500);

            return res.json({
                code: 500,
                isSuccess: false,
                msg: '查询失败，服务器出错'
            });
        }

        if (results !== undefined && results.isSuccess === true) {
            var data = req.body.formdata,
                temp = ['ID', 'FIStatu'],
                temp1 = ['财务ID', '审核结果'];
            err = '缺少值: ';

            for (var key in temp) {
                if (!(temp[key] in data)) {
                    logger.writeInfo("缺少值: " + temp[key]);
                    err += temp1[key];
                }
            }

            if (err != '缺少值: ') {
                res.status(400);

                return res.json({
                    status: 400,
                    isSuccess: false,
                    msg: err
                });
            }

            data.OperataUserID = req.query.jitkey;

            if (data.FIStatu != '不通过' && data.FIStatu != '通过' ) {
                res.status(400);
                return res.json({
                    status: 400,
                    isSuccess: false,
                    msg: '操作失败,未选择审核结果'
                });
            }

            if(data.FIStatu == '不通过' && (data.Memo === undefined || data.Memo.trim()==='')) {
                res.status(400);

                return res.json({
                    status: 400,
                    isSuccess: false,
                    msg: '操作失败，不通过的审核需填写备注信息'
                });
            }

            if(data.FIStatu == '不通过') data.Remark = data.Memo;

            if (data.Remark.length>45) {
                res.status(400);
                return res.json({
                    code: 400,
                    isSuccess: false,
                    msg: '备注过长,请勿超过45个字符'
                });
            }

            data.CheckUser = req.query.jitkey;

            var ID = data.ID;

            //查看该财务信息是否已经被审核
            financeService.queryFinance({ID:ID,OperateUserID: req.query.jitkey}, function (err, results) {
                if (err) {
                    res.status(500);

                    return res.json({
                        status: 500,
                        isSuccess: false,
                        msg: '操作失败，服务器出错'
                    });
                }

                if (results !== undefined && results.length>0 && results[0].IsActive === 1) {
                    //所有结果均为未审核状态
                    if (results[0].FIStatu == '待审核') {
                        financeService.checkFinance(data, function (err, results) {
                            if (err) {
                                res.status(500);

                                return res.json({
                                    status: 500,
                                    isSuccess: false,
                                    msg: '操作失败，服务器出错'
                                });
                            }

                            if(results !== undefined && results.affectedRows > 0) {
                                res.status(200);

                                return res.json({
                                    status: 200,
                                    isSuccess: true,
                                    msg: '操作成功'
                                });
                            } else {
                                res.status(400);

                                return res.json({
                                    status: 404,
                                    isSuccess: false,
                                    msg: '操作失败'
                                });
                            }
                        });
                    } else {
                        res.status(400);

                        return res.json({
                            status: 400,
                            isSuccess: false,
                            msg: '当前财务已审核！'
                        });
                    }
                } else {
                    res.status(400);

                    return res.json({
                        status: 400,
                        isSuccess: false,
                        msg: '审核的财务信息不存在或无效'
                    });
                }
            });
        } else {
            res.status(400);

            return res.json({
                code: 400,
                isSuccess: false,
                msg: results.msg
            });
        }
    });
});

//财务删除
router.delete('/', function (req, res) {
    var data = {
        userID: req.query.jitkey,
        functionCode: functionConfig.sfmsApp.financeManage.financeDelete.functionCode
    };

    userFuncService.checkUserFunc(data, function(err, results) {
        if (err) {
            res.status(500);

            return res.json({
                code: 500,
                isSuccess: false,
                msg: '查询失败，服务器出错'
            });
        }

        if (results !== undefined && results.isSuccess === true) {
            var ID = JSON.parse(req.query.d).ID;

            if (ID == '' || ID === undefined) {
                res.status(400);

                return res.json({
                    status: 400,
                    isSuccess: false,
                    msg: "缺少财务ID"
                });
            }

            var data = {
                'ID': ID,
                'OperateUserID': req.query.jitkey
            };

            financeService.delFinance(data, function (err, results) {
                if (err) {
                    res.status(500);

                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: "操作失败，服务器出错"
                    });
                }

                if(results !== undefined && results.affectedRows > 0) {
                    res.status(200);

                    return res.json({
                        status: 200,
                        isSuccess: true,
                        msg: "操作成功"
                    });
                } else {
                    res.status(400);

                    return res.json({
                        status: 400,
                        isSuccess: true,
                        msg: "操作失败"
                    });
                }
            });
        } else {
            res.status(400);

            return res.json({
                code: 400,
                isSuccess: false,
                msg: results.msg
            });
        }
    });
});

module.exports = router;
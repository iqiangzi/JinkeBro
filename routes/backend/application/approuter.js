/**
 * @Author: Spring
 * @Date: 16-11-27 下午6:58
 * @Last Modified by: Spring
 * @Last Modified time: 16-11-27 下午6:58
 * @Function: application router
 */

var express = require('express'),
    router = express.Router(),
    userSpring = appRequire('service/backend/application/applicationservice'),
    logger = appRequire('util/loghelper').helper,
    config = appRequire('config/config'),
    functionConfig = appRequire('config/functionconfig'),
    userFuncService = appRequire('service/backend/user/userfuncservice');

router.post('/', function (req, res) {
    var functionCode = functionConfig.backendApp.appManage.appAdd.functionCode,
        data = {
            userID: req.query.jitkey,
            functionCode: functionCode
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

        if (results !== undefined&& results.isSuccess === true) {
            var query = req.body.formdata;

            err = '缺少值: ';
            data = ['ApplicationCode', 'ApplicationName', 'IsActive'];
            var temp = ['应用代码','应用名称','是否有效'];

            for(var value in data)
            {
                if(!(data[value] in query))
                {
                    err += temp[value] + ' ';
                }
            }

            if (err != '缺少值: ') {
                res.status(400);
                res.json({
                    code: 400,
                    isSuccess: false,
                    msg: err
                });
                return;
            }

            var ApplicationCode = query.ApplicationCode,
                ApplicationName = query.ApplicationName,
                IsActive = query.IsActive,
                memo = query.Memo || '';

            data = {
                'ApplicationName': ApplicationName,
                'OperateUserID': req.query.jitkey,
                'pageNum': config.pageCount
            };

            //检查是否有该应用
            userSpring.queryAllApp(data, function (err, results) {
                if (err) {
                    res.status(500);
                    res.json({
                        code: 500,
                        isSuccess: false,
                        msg: '查询失败，服务器出错'
                    });
                    logger.writeError('新增应用,出错信息: ' + err);
                    return;
                }

                if (results === undefined || results.length == 0) {
                    data = {
                        'ApplicationCode': ApplicationCode,
                        'ApplicationName': ApplicationName,
                        'Memo': memo,
                        'IsActive': IsActive,
                        'OperateUserID': req.query.jitkey,
                    };

                    if (data.ApplicationCode.length>50) {
                        res.status(400);

                        return res.json({
                            code: 400,
                            isSuccess: false,
                            msg: '应用代码过长,请勿超过50个字符'
                        });
                    }

                    if (data.ApplicationName.length>50) {
                        res.status(400);

                        return res.json({
                            code: 400,
                            isSuccess: false,
                            msg: '应用名称过长,请勿超过50个字符'
                        });
                    }

                    if (data.Memo!==undefined&&data.Memo.length>200) {
                        res.status(400);

                        return res.json({
                            code: 400,
                            isSuccess: false,
                            msg: '备注过长,请勿超过200个字符'
                        });
                    }

                    userSpring.insert(data, function (err, results) {
                        if (err) {
                            res.status(500);
                            res.json({
                                code: 500,
                                isSuccess: false,
                                msg: '服务器出错'
                            });
                            logger.writeError('新增应用,出错信息: ' + err);
                            return;
                        }

                        res.status(200);
                        res.json({
                            code: 200,
                            isSuccess: true,
                            data: {
                                ID: results.insertId,
                                ApplicationCode: data.ApplicationCode,
                                ApplicationName: data.ApplicationName,
                                Memo: data.Memo,
                                IsActive: data.IsActive
                            },
                            msg: '操作成功'
                        });
                    });
                } else {
                    res.status(400);
                    res.json({
                        code: 404,
                        isSucess: false,
                        msg: '应用已存在'
                    });
                    logger.writeError('新增应用,出错信息: 新增用户已存在');
                    return;
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
    })
});

router.get('/', function (req, res) {
    var functionCode = functionConfig.backendApp.appManage.appQuery.functionCode,
        data = {
            userID: req.query.jitkey,
            functionCode: functionCode
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

        if (results !== undefined&& results.isSuccess === true) {
            var query = JSON.parse(req.query.f),
                page = req.query.pageindex || 1,
                pageNum = req.query.pagesize || config.pageCount,
                ApplicationName = query.ApplicationName || '',
                selectType = req.query.isPaging || '',
                ID = query.ID || '',
                isActive = query.isActive || '';

            page = page>0?page:1;

            data = {
                'page': page,
                'pageNum': pageNum,
                'ApplicationName': ApplicationName,
                'SelectType': selectType,
                'ID': ID,
                'OperateUserID': req.query.jitkey,
                'IsActive': isActive
            };

            //查找该应用
            var countNum = 0;

            userSpring.countAllapps(data, function (err, results) {
                if (err) {
                    res.status(500);
                    res.json({
                        code: 500,
                        isSuccess: false,
                        msg: '查询失败，服务器出错'
                    });
                    logger.writeError('查询应用,出错信息: ' + err);
                    return;
                }

                if (results !==undefined && results.length != 0) {
                    countNum = results[0]['num'];
                }

                userSpring.queryAllApp(data, function (err, results) {
                    if (err) {
                        res.status(500);
                        res.json({
                            code: 500,
                            isSuccess: false,
                            msg: '查询失败，服务器出错'
                        });
                        logger.writeError('查询应用,出错信息: ' + err);
                        return;
                    }

                    if (results !== undefined && results.length != 0) {
                        if (page == Math.ceil(countNum/pageNum)) {
                            var curpageNum = countNum - (page-1) * pageNum;
                        } else {
                            var curpageNum = pageNum;
                        }

                        res.status(200);
                        res.json({
                            code:200,
                            isSuccess: true,
                            curPage: page,
                            dataNum: countNum,
                            curPageNum: curpageNum,
                            totalPage: Math.ceil(countNum/pageNum),
                            data: results,
                            msg: '查找成功'
                        });
                    } else {
                        res.status(200);
                        res.json({
                            code: 404,
                            isSuccess: false,
                            msg: '应用不存在'
                        });
                        logger.writeError('查询应用,出错信息: 查询应用不存在');
                        return;
                    };
                });
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

//编辑应用
router.put('/', function(req, res) {
    var data = {
        userID: req.query.jitkey,
        functionCode: functionConfig.backendApp.appManage.appEdit.functionCode
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
            var err = '缺少值: ',
                query = req.body.formdata,
                ApplicationCode = query.ApplicationCode,
                ApplicationName = query.ApplicationName,
                IsActive = query.IsActive,
                ID = query.ID,
                Memo = query.Memo||'';

            data = ['ApplicationCode', 'ApplicationName', 'IsActive', 'ID'];
            temp = ['应用代码', '应用名称', '是否有效','应用ID']

            for (var index in data) {
                if (!(data[index] in query)) {
                    err += data[index] + ' ';
                }
            }

            if (err != '缺少值: ') {
                res.status(400);
                res.json({
                    code: 400,
                    isSuccess: false,
                    msg: err
                });
                return;
            }

            data = {
                'ID': ID,
                'OperateUserID': req.query.jitkey
            };

            userSpring.queryAllApp(data, function (err, results) {
                if (err) {
                    res.status(500);
                    res.json({
                        code: 500,
                        isSuccess: false,
                        msg: '查询失败，服务器出错'
                    });
                    logger.writeError('编辑应用,出错信息: ' + err);
                    return;
                }

                if (results !== undefined && results.length != 0) {

                    data = {
                        'ID': ID,
                        'ApplicationCode': ApplicationCode,
                        'ApplicationName': ApplicationName,
                        'Memo': Memo,
                        'IsActive': IsActive,
                        'OperateUserID': req.query.jitkey
                    };

                    if (data.ApplicationCode.length>50) {
                        res.status(400);
                        return res.json({
                            code: 400,
                            isSuccess: false,
                            msg: '应用代码过长,请勿超过50个字符'
                        });
                    }

                    if (data.ApplicationName.length>50) {
                        res.status(400);
                        return res.json({
                            code: 400,
                            isSuccess: false,
                            msg: '应用名称过长,请勿超过50个字符'
                        });
                    }

                    if (data.Memo.length>200) {
                        res.status(400);
                        return res.json({
                            code: 400,
                            isSuccess: false,
                            msg: '备注过长,请勿超过200个字符'
                        });
                    }

                    userSpring.update(data, function (err, results) {
                        if (err) {
                            res.status(500);
                            res.json({
                                code: 500,
                                isSuccess: false,
                                msg: '操作失败,服务器失败'
                            });
                            logger.writeError('编辑应用,出错信息: ' + err);
                            return;
                        }

                        res.status(200);
                        res.json({
                            code:200,
                            isSuccess: true,
                            data: {
                                ID: data.ID,
                                ApplicationCode: data.ApplicationCode,
                                ApplicationName: data.ApplicationName,
                                Memo: data.Memo,
                                IsActive: data.IsActive
                            },
                            msg: '操作成功'
                        });
                    });
                } else {
                    res.status(400);
                    res.json({
                        code: 404,
                        isSuccess: false,
                        msg: '应用不存在'
                    });
                    logger.writeError('编辑应用,出错信息: 编辑应用不存在');
                    return;
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

//删除应用
router.delete('/', function (req, res) {
    var data = {
        userID: req.query.jitkey,
        functionCode: functionConfig.backendApp.appManage.appDel.functionCode
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
            var query = JSON.parse(req.query.d),
                ID = query.ID;

            data = {
                'ID': ID,
                'IsActive': 0,
                'pageNum': config.pageCount,
                'OperateUserID': req.query.jitkey
            };

            userSpring.queryAllApp(data, function (err, results) {
                if (err) {
                    res.status(500);
                    res.json({
                        code: 500,
                        isSuccess: false,
                        msg: '查询失败，服务器出错'
                    });
                    logger.writeError('删除应用,出错信息: ' + err);
                    return;
                }

                if (results !== undefined && results.length != 0) {
                    data = {
                        'ID': results[0].ID,
                        'ApplicationCode': results[0].ApplicationCode,
                        'ApplicationName': results[0].ApplicationName,
                        'Memo': results[0].Memo,
                        'IsActive': 0,
                        'OperateUserID': req.query.jitkey
                    };

                    userSpring.update(data, function (err, results) {
                        if (err) {
                            res.status(500);
                            res.json({
                                code: 500,
                                isSuccess: false,
                                msg: '操作失败,服务器失败'
                            });
                            logger.writeError('删除应用,出错信息: ' + err);
                            return;
                        }

                        if (results !== undefined && results.affectedRows > 0) {
                            res.status(200);
                            res.json({
                                code: 200,
                                isSuccess: true,
                                data: {
                                    ID: data.ID,
                                    ApplicationCode: data.ApplicationCode,
                                    ApplicationName: data.ApplicationName,
                                    Memo: data.Memo,
                                    IsActive: data.IsActive
                                },
                                msg: '操作成功'
                            });
                        } else {
                            res.status(400);
                            return res.json({
                                code: 400,
                                isSuccess: false,
                                msg: "操作失败，应用信息有误"
                            })
                        }
                    });
                } else {
                    res.status(400);
                    res.json({
                        code: 400,
                        isSuccess: false,
                        msg: '操作失败，应用不存在'
                    });
                    logger.writeError('删除应用,出错信息: 删除应用不存在');
                    return;
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
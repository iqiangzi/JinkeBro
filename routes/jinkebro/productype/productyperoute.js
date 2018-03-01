/**
 * @Author: luozQ
 * @Date: 2017/1/4 20:40
 * @Last Modified by: luozQ
 * @Last Modified time:  2017/1/4 20:50
 * @Function: 商品类别管理
 */
var express = require('express'),
    router = express.Router(),
    productypeService = appRequire('service/jinkebro/productype/productypeservice'),
    moment = require('moment'),
    logger = appRequire("util/loghelper").helper,
    functionConfig = appRequire('config/functionconfig'),
    userFuncService = appRequire('service/backend/user/userfuncservice'),
    config = appRequire('config/config');

//查看产品类别
router.get('/', function (req, res) {
    var functionCode = functionConfig.jinkeBroApp.productType.productTypeQuery.functionCode;
    var funcData = {
        userID: req.query.jitkey,
        functionCode: functionCode
    }

    userFuncService.checkUserFunc(funcData, function (err, funcResult) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '服务器内部错误！'
            });
        }
        if (funcResult !== undefined && funcResult.isSuccess === true) {
            var data = {};
            var pageNum = 0;
            var page = 0;
            var isPaging = 0;
            if (req.query.f != undefined) {
                var query = JSON.parse(req.query.f);
                page = (req.query.pageindex) ? (req.query.pageindex) : 1;
                pageNum = (req.query.pagesize) ? (req.query.pagesize) : (config.pageCount);
                isPaging = (req.query.isPaging) ? (req.query.isPaging) : 0;
                data = {
                    page : page,
                    pageNum : pageNum,
                    isPaging : isPaging,
                    ID: query.ID || '',
                    ProductTypeName: query.ProductTypeName || ''
                };
            }
            var countNum = -1;
            productypeService.countAllProType(data, function (err, results) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        errorMsg: "查询失败，服务器内部错误"
                    });
                }
                if (results !== undefined && results.length != 0) {
                    countNum = results[0]['num'];

                    //查询所需的详细数据
                    productypeService.queryAllProType(data, function (err, result) {
                        if (err) {
                            res.status(500);
                            return res.json({
                                code: 500,
                                isSuccess: false,
                                msg: "查询失败，服务器内部错误"
                            });

                            //这边要记录operationlog日志
                        }

                        if (result !== undefined && result.length != 0 && countNum != -1) {
                            var resultBack = {
                                code: 200,
                                isSuccess: true,
                                msg: '查询成功',
                                dataNum: countNum,
                                curPage: page,
                                curPageNum: pageNum,
                                totalPage: Math.ceil(countNum / pageNum),
                                data: result
                            };
                            if (resultBack.curPage == resultBack.totalPage) {
                                resultBack.curPageNum = resultBack.dataNum - (resultBack.totalPage - 1) * pageNum;
                            }
                            res.status(200);
                            return res.json(resultBack);
                        } else {
                            res.status(200);
                            return res.json({
                                code: 200,
                                isSuccess: true,
                                msg: "未查询到相应产品类型"
                            });
                        }
                    });
                } else {
                    res.status(200);
                    return res.json({
                        code: 200,
                        isSuccess: true,
                        msg: "未查询到相应产品类型"
                    });
                }
            });

        } else {
            res.status(400);
            return res.json({
                code: 400,
                isSuccess: false,
                msg: funcResult.msg
            });
        }
    });
});

//产品类别的新增
router.post('/', function (req, res) {
    var functionCode = functionConfig.jinkeBroApp.productType.productTypeAdd.functionCode;
    var funcData = {
        userID: req.query.jitkey,
        functionCode: functionCode
    }

    userFuncService.checkUserFunc(funcData, function (err, funcResult) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '服务器内部错误！'
            });
        }
        if (funcResult !== undefined && funcResult.isSuccess === true) {
            console.log(req.body)
            if (req.body.formdata == undefined) {
                res.status(400);
                return res.json({
                    code: 404,
                    isSuccess: false,
                    msg: '存在未填写的必填字段'
                });
            }

            var formdata = req.body.formdata;

            //检查所需要的字段是否都存在
            var data = ['ProductTypeName'];
            var err = 'require: ';
            for (var value in data) {
                if (!(data[value] in formdata)) {
                    err += data[value] + ' ';
                }
            }
            //如果要求的字段不在req的参数中
            if (err !== 'require: ') {
                logger.writeError(err);
                res.status(400);
                return res.json({
                    code: 404,
                    isSuccess: false,
                    msg: '存在未填写的必填字段' + err
                });
            }

            var ProductTypeName = formdata.ProductTypeName || '';

            // 存放接收的数据
            var data = {
                "ProductTypeName": ProductTypeName
            };

            //执行插入操作
            productypeService.insert(data, function (err, result) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: results
                    });
                }


                if (result !== undefined && result.affectedRows != 0) {
                    res.status(200);
                    return res.json({
                        code: 200,
                        isSuccess: true,
                        data: result,
                        msg: '产品类别添加成功'
                    });
                } else {
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        msg: "产品类别添加操作失败"
                    });
                }
            });
        } else {
            res.status(400);
            return res.json({
                code: 400,
                isSuccess: false,
                msg: funcResult.msg
            });
        }
    });
});

//修改产品类别
router.put('/', function (req, res) {
    var functionCode = functionConfig.jinkeBroApp.productType.productTypeEdit.functionCode;
    var funcData = {
        userID: req.query.jitkey,
        functionCode: functionCode
    }

    userFuncService.checkUserFunc(funcData, function (err, funcResult) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '服务器内部错误！'
            });
        }
        if (funcResult !== undefined && funcResult.isSuccess === true) {
            var formdata = req.body.formdata;

            var updatedata = {
                "ID": formdata.ID,
                'ProductTypeName': formdata.ProductTypeName
            };

            productypeService.update(updatedata, function (err, results) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: results
                    });
                }

                if (results.msg) {
                    res.status(400);
                    return res.json({
                        code: 400,
                        isSuccess: false,
                        msg: results.msg
                    });
                }

                if (results !== undefined && results.affectedRows != 0) {
                    res.status(200);
                    return res.json({
                        code: 200,
                        isSuccess: true,
                        msg: '产品类别修改成功'
                    });
                } else {
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        msg: "产品类别修改失败"
                    });
                }
            });
        } else {
            res.status(400);
            return res.json({
                code: 400,
                isSuccess: false,
                msg: funcResult.msg
            });
        }
    });
});

//产品类别的删除
router.delete('/', function (req, res) {
    var functionCode = functionConfig.jinkeBroApp.productType.productTypeDel.functionCode;
    var funcData = {
        userID: req.query.jitkey,
        functionCode: functionCode
    }

    userFuncService.checkUserFunc(funcData, function (err, funcResult) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '服务器内部错误！'
            });
        }
        if (funcResult !== undefined && funcResult.isSuccess === true) {
            var d = JSON.parse(req.query.d);
            var ID = d.ID;
            if (ID === undefined) {
                res.status(404);
                return res.json({
                    code: 404,
                    isSuccess: false,
                    msg: 'require ID'
                });
            }
            if (isNaN(ID)) {
                res.status(400);
                return res.json({
                    code: 400,
                    isSuccess: false,
                    msg: 'ID不是数字'
                });
            }
            var deleteData = {
                "ID": ID
            };
            productypeService.delete(deleteData, function (err, results) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: results,
                    });
                }
                //判断是否删除成功
                if (results !== undefined && results.affectedRows != 0) {
                    res.status(200);
                    return res.json({
                        code: 200,
                        isSuccess: true,
                        msg: '产品类别删除操作成功'
                    });
                } else {
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        msg: "产品类删除操作失败"
                    });
                }
            });
        } else {
            res.status(400);
            return res.json({
                code: 400,
                isSuccess: false,
                msg: funcResult.msg
            });
        }
    });
});
module.exports = router;
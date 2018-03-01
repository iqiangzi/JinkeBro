/**
 * @Author: Cecurio
 * @Date: 2016/12/30 20:35
 * @Last Modified by: Cecurio
 * @Last Modified time: 2016/12/30 20:35
 * @Function:
 */
var express = require('express'),
    router = express.Router(),
    url = require('url');

//商品业务逻辑组件
var productService = appRequire('service/jinkebro/product/productservice'),
    logger = appRequire("util/loghelper").helper,
    config = appRequire('config/config'),
    functionConfig = appRequire('config/functionconfig'),
    userFuncService = appRequire('service/backend/user/userfuncservice'),
    moment = require('moment'),
    validator = require('validator'),
    dataCheck = appRequire('util/dataverify'),
    formidable=require('formidable'),
    fs = require('fs'),
    path = require('path');

//商品图片上传
router.post('/imgupload',function (req,res) {

    var form = new formidable.IncomingForm(),
                files=[],
                fields=[],
                docs=[];

    console.log('start upload in address: jinkeBro/product/imgupload');

    var ID = 0,
        fileID = 0,
        baseID = -1,
        filePath = '',
        reqParams = [],
        fileName = '',
        productID = 0;
    //存放目录
    form.uploadDir = 'public/imgs/uploads';

    var fileUrl = 'public/imgs/uploads';

    form.on('field', function(field, value) {
        if(field == 'SKU') {
            reqParams = value.split(",");
            ID = reqParams[0];
            productID = parseInt(reqParams[1]);
            fileName = ID;
        } else {
            fileID = value;
        }
    }).on('file', function(field, file) {

        files.push([field, file]);
        docs.push(file);

        var types = file.name.split('.')[file.name.split('.').length-1];
        var date = moment().format("YYYYMMDD");
        fs.readdir(fileUrl,function(err,files) {
            if (err) {
                console.log('file dir error');
                return res.json({
                    code: 500,
                    isSuccess: false,
                    msg: '错误'
                })
            }

            for (var i in files) {
                if (ID === files[i].split('_')[1]) {
                    // console.log(files[i].split('_')[2].split('.')[0])
                    if (baseID < files[i].split('_')[2].split('.')[0]) {
                        baseID = files[i].split('_')[2].split('.')[0];
                    }
                }
            }
            // console.log('======= ' + baseID)
            if(baseID != -1){
                fileID = parseInt(fileID) + parseInt(baseID) + 1;
            }
            // console.log('fileID: ' + fileID)
            fs.renameSync(file.path, "public/imgs/uploads/" + fileName + '.' + types);
            filePath += 'imgs/uploads/' + ID + '.' + types;
            console.log('上传的filePath:' + filePath);
            var formdata = {
                ProductID : productID,
                ProductImgPath : filePath
            };
            productService.updateProductImgPath(formdata,function (err,updateImgPathResult) {
                if(err) {
                    console.log(err);
                }

                //console.log(updateImgPathResult);
                if (updateImgPathResult.affectedRows == 1) {
                    console.log("修改图片路径成功!");
                }
            });
        });
    }).on('end', function() {
        res.writeHead(200, {
            'content-type': 'text/plain'
        });
        var out = {
            Resopnse : {
                'result-code':0,
                 timeStamp : new Date(),
            },
            files:docs
        };
        var sout = JSON.stringify(out);
        res.end(sout);
    });

    form.parse(req, function(err, fields, files) {
        err && console.log('formidabel error : ' + err);
        // console.log('parsing done');
    });
});

//商品新增
router.post('/', function (req, res) {
    var functionCode = functionConfig.jinkeBroApp.product.productAdd.functionCode;
    var funcData = {
        userID: req.query.jitkey,
        functionCode: functionCode
    };

    userFuncService.checkUserFunc(funcData, function (err, funcResult) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '服务器内部错误！'
            });
        }

        // 用户没有此功能点
        if (!(funcResult != undefined && funcResult.isSuccess)) {
            res.status(400);
            return res.json({
                code: 400,
                isSuccess: false,
                msg: funcResult.msg
            });
        }

        var formdata = req.body.formdata;

        var ProductName = formdata.ProductName,
            ProductDesc = formdata.ProductDesc || '',
            ProductImgPath = formdata.ProductImgPath || '',
            ExpireTime = formdata.ExpireTime,
            ProducTime = formdata.ProducTime,
            newProductTypeName = formdata.newProductTypeName,
            SupplierID = formdata.SupplierID,
            ProductPrice = formdata.ProductPrice,
            OnSale = formdata.OnSale,
            TotalNum = formdata.TotalNum,
            StockAreaID = formdata.StockAreaID,
            CreateUserID = req.query.jitkey,
            CreateTime = moment().format("YYYY-MM-DD HH:mm:ss"); // 创建库存时间

        var insertdata = {
            "ProductName": ProductName,
            "ProductDesc": ProductDesc,
            "ProductImgPath": ProductImgPath,
            "ExpireTime": ExpireTime,
            "ProducTime": ProducTime,
            "SupplierID": SupplierID,
            "ProductPrice": ProductPrice,
            "OnSale": OnSale,
            "TotalNum" : TotalNum,
            "StockAreaID" :  StockAreaID,
            "CreateUserID" : CreateUserID,
            "CreateTime" : CreateTime,
            "newProductTypeName" : newProductTypeName,
            "OperateUserID" : req.query.jitkey
        };

        productService.getMaxSKUNext(function (err,skuResult) {
            if (err) {
                res.status(500);
                return res.json({
                    code: 500,
                    isSuccess: false,
                    msg: '服务器内部错误！'
                });
            }

            if (skuResult == undefined || skuResult.length != 1) {
                res.status(404);
                return res.json({
                    code : 404,
                    isSuccess : false,
                    msg : '获得最大SKU失败！'
                });
            }

            insertdata.SKU = skuResult[0].SKU;

            productService.insertProduct(insertdata, function (err, result) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: '服务器内部错误！'
                    });
                }


                if (result !== undefined && result.affectedRows != 0 && result.affectedRows != undefined) {
                    res.status(200);
                    return res.json({
                        code: 200,
                        isSuccess: true,
                        addProductResult: result,
                        msg: '一条产品记录添加成功！'
                    });
                } else {
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        msg: result.msg
                    });
                }
            });
        });
    });
});

router.delete('/', function (req, res) {
    var functionCode = functionConfig.jinkeBroApp.product.productDel.functionCode;
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

        if (!(funcResult != undefined && funcResult.isSuccess)) {
            res.status(400);
            return res.json({
                code: 400,
                isSuccess: false,
                msg: funcResult.msg
            });
        }

        var d = JSON.parse(req.query.d);

        var productID = d.ProductID;

        if (productID == undefined) {
            res.status(404);
            return res.json({
                code: 404,
                isSuccess: false,
                msg: 'require productID'
            });
        }

        if (isNaN(productID)) {
            res.status(400);
            return res.json({
                code: 400,
                isSuccess: false,
                msg: 'ProductID不是数字'
            });
        }

        var deleteData = {
            "ProductID": productID,
            "OperateUserID" : req.query.jitkey
        };

        productService.CountProducts({ "ProductID" : productID}, function (err, result) {
            if (err) {
                res.status(500);
                return res.json({
                    code: 500,
                    isSuccess: false,
                    deleteResult: result,
                    msg: '操作失败，服务器出错'
                });
            }

            //所要删除的产品存在，执行删除操作
            if (result == undefined || result[0]['num'] <= 0 || result.length <= 0 || result.length == undefined) {
                res.status(404);
                return res.json({
                    code: 404,
                    isSuccess: false,
                    deleteResult: result,
                    msg: '操作失败，所要删除的产品不存在'
                });
            }

            productService.deleteProduct(deleteData, function (err, results) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: '服务器出错，操作失败'
                    });
                }

                //判断是否删除成功
                if (results !== undefined && results.affectedRows != 0 && results.affectedRows != undefined) {
                    res.status(200);
                    return res.json({
                        code: 200,
                        isSuccess: true,
                        deleteResult: results,
                        msg: '商品删除操作成功！'
                    });
                } else {
                    res.status(404);
                    if (results.msg != undefined) {
                        return res.json({
                            code: 404,
                            isSuccess: false,
                            msg: results.msg
                        });
                    } else {
                        return res.json({
                            code: 404,
                            isSuccess: false,
                            msg: '商品删除操作失败！'
                        });
                    }
                }
            });
        });
    });
});

router.put('/', function (req, res) {
    var functionCode = functionConfig.jinkeBroApp.product.productEdit.functionCode;
    var funcData = {
        userID: req.query.jitkey,
        functionCode: functionCode
    };

    userFuncService.checkUserFunc(funcData, function (err, funcResult) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '服务器内部错误！'
            });
        }

        if (!(funcResult != undefined && funcResult.isSuccess)) {
            res.status(400);
            return res.json({
                code: 400,
                isSuccess: false,
                msg: funcResult.msg
            });
        }

        var formdata = req.body.formdata;

        var SKU = formdata.SKU,
            ProductID = formdata.ProductID,
            ProductName = formdata.ProductName,
            ProductDesc = formdata.ProductDesc ? formdata.ProductDesc : '', //can be null
            ProductImgPath = formdata.ProductImgPath ? formdata.ProductImgPath : '', // can be null
            ExpireTime = formdata.ExpireTime,
            ProducTime = formdata.ProducTime,
            SupplierID = formdata.SupplierID,
            ProductTypeID = formdata.ProductTypeID,
            ProductPrice = formdata.ProductPrice,
            OnSale = formdata.OnSale;

        // 存放接收的数据
        var updatedata = {
            "SKU" : SKU,
            "ProductID": ProductID,
            "ProductName": ProductName,
            "ProductDesc": ProductDesc,
            "ProductImgPath": ProductImgPath,
            "ExpireTime": ExpireTime,
            "ProducTime": ProducTime,
            "SupplierID": SupplierID,
            "ProductTypeID": ProductTypeID,
            "ProductPrice": ProductPrice,
            "OnSale": OnSale,
            "OperateUserID" : req.query.jitkey
        };

        productService.queryProducts({ ProductID : ProductID,}, function (err, result) {
            if (err) {
                res.status(500);
                return res.json({
                    code: 500,
                    isSuccess: false,
                    updateResult: result,
                    msg: '操作失败，服务器出错'
                });
            }

            if (result == undefined || result.length <= 0 || result.length == undefined) {
                res.status(404);
                return res.json({
                    code: 404,
                    isSuccess: false,
                    msg: "修改的产品不存在，修改失败！"
                });
            }

            productService.updateProduct(updatedata, function (err, results) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: '服务器出错，产品修改操作失败'
                    });
                }

                if (results !== undefined && results.affectedRows != 0 && results.affectedRows != undefined) {
                    res.status(200);
                    return res.json({
                        code: 200,
                        isSuccess: true,
                        msg: '修改产品成功！'
                    });
                } else {
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        msg: results.msg
                    });
                }
            });
        });
    });
});

//查看产品
router.get('/', function (req, res) {

    // req.query的内容如下：
    // {
    //     access_token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0ODc0MjgyODkwMTN9._kAZlxEinELePO5vfnW2ckhGaoiLy0ogGmqKDgGcG6s',
    //     jitkey: '1',
    //     f: '{
    //
    //     }',
    //     pageindex: '1',
    //     pagesize: '10'
    // }

    var functionCode = functionConfig.jinkeBroApp.product.productQuery.functionCode;
    var funcData = {
        userID: req.query.jitkey,
        functionCode: functionCode
    };

    userFuncService.checkUserFunc(funcData, function (err, funcResult) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '服务器内部错误！'
            });
        }

        if (!(funcResult != undefined && funcResult.isSuccess)) {
            res.status(400);
            return res.json({
                code: 400,
                isSuccess: false,
                msg: funcResult.msg
            });
        }

        var query = JSON.parse(req.query.f);
        var page = (req.query.pageindex != undefined) ? (req.query.pageindex) : 1,
            pageNum = (req.query.pagesize != undefined) ? (req.query.pagesize) : (config.pageCount),
            SKU = query.SKU || '',
            ProductID = query.ProductID || '',
            ProductName = query.ProductName || '',
            ExpireTime = query.ExpireTime || '',
            SupplierID = query.SupplierID || '',
            ProductTypeID = query.ProductTypeID || '',
            ProductPrice = query.ProductPrice || '',
            OnSale = query.OnSale || '',
            minProductPrice = query.minProductPrice || '',
            maxProductPrice = query.maxProductPrice || '',
            earlyExpireTime = query.earlyExpireTime || '',
            lateExpireTime = query.lateExpireTime || '',
            isPaging = (req.query.isPaging !== undefined) ? (req.query.isPaging) : 0; //是否分页 0表示分页,1表示不分页

        page = page > 0 ? page : 1;

        if (pageNum == '') {
            pageNum = config.pageCount;
        }

        //用于查询结果总数的计数
        var countNum = 0;

        var data = {
            page: page || 1,
            pageNum: pageNum || config.pageCount,
            SKU: SKU || '',
            ProductID: ProductID || '',
            ProductName: ProductName || '',
            ExpireTime: ExpireTime || '',
            SupplierID: SupplierID || '',
            ProductTypeID: ProductTypeID || '',
            ProductPrice: ProductPrice || '',
            OnSale: OnSale || '',
            isPaging: isPaging || '',
            OperateUserID : req.query.jitkey,
            minProductPrice : minProductPrice || '',
            maxProductPrice : maxProductPrice || '',
            earlyExpireTime : earlyExpireTime || '',
            lateExpireTime : lateExpireTime || ''
        };

        var intdata = {
            page: page,
            pageNum: pageNum,
            ProductID: ProductID,
            SupplierID: SupplierID,
            ProductTypeID: ProductTypeID,
            OnSale: OnSale,
            isPaging: isPaging
        };

        for (var key in intdata) {
            if (isNaN(intdata[key]) && intdata[key] != '') {
                res.status(400);
                return res.json({
                    code: 400,
                    isSuccess: false,
                    msg: key + ": " + intdata[key] + '不是数字'
                });
            }
        }

        productService.CountProducts(data, function (err, results) {
            if (err) {
                res.status(500);
                return res.json({
                    code: 500,
                    isSuccess: false,
                    errorMsg: "查询失败，服务器内部错误"
                });
            }

            if (results == undefined || results.length <= 0 || results[0]['num'] <= 0 || results.length == undefined) {
                res.status(404);
                return res.json({
                    code: 404,
                    isSuccess: false,
                    msg: "未查询到相应商品！"
                });
            }

            countNum = results[0]['num'];

            //查询所需的详细数据
            productService.queryProducts(data, function (err, result) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: "查询失败，服务器内部错误"
                    });
                }

                if (result == undefined || result.length == 0 && result.length == undefined) {
                    res.status(404);
                    return res.json({
                        code: 404,
                        isSuccess: false,
                        msg: "未查询到相应商品！"
                    });
                }

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
            });
        });
    });
});

//查看产品
router.get('/wechat', function (req, res) {

    var query = JSON.parse(req.query.f);
    var page = (req.query.pageindex != undefined) ? (req.query.pageindex) : 1,
        pageNum = (req.query.pagesize != undefined) ? (req.query.pagesize) : (config.pageCount),
        ProductID = query.ProductID || '',
        OnSale = query.OnSale ? query.OnSale : 1,
        isPaging = (req.query.isPaging !== undefined) ? (req.query.isPaging) : 0; //是否分页 0表示分页,1表示不分页

    page = page > 0 ? page : 1;

    if (pageNum == '') {
        pageNum = config.pageCount;
    }

    //用于查询结果总数的计数
    var countNum = 0;

    var data = {
        page: page || 1,
        pageNum: pageNum || config.pageCount,
        ProductID: ProductID || '',
        OnSale: OnSale || '',
        isPaging: isPaging || '',
        OperateUserID : req.query.jitkey
    };

    var intdata = {
        page: page,
        pageNum: pageNum,
        ProductID: ProductID,
        OnSale: OnSale,
        isPaging: isPaging
    };

    for (var key in intdata) {
        if (isNaN(intdata[key]) && intdata[key] != '') {
            res.status(400);
            return res.json({
                code: 400,
                isSuccess: false,
                msg: key + ": " + intdata[key] + '不是数字'
            });
        }
    }

    productService.CountProducts(data, function (err, results) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                errorMsg: "查询失败，服务器内部错误"
            });
        }

        if (results == undefined || results.length <= 0 || results[0]['num'] <= 0 || results.length == undefined) {
            res.status(404);
            return res.json({
                code: 404,
                isSuccess: false,
                msg: "未查询到相应商品！"
            });
        }

        countNum = results[0]['num'];

        productService.queryProducts(data, function (err, result) {
            if (err) {
                res.status(500);
                return res.json({
                    code: 500,
                    isSuccess: false,
                    msg: "查询失败，服务器内部错误"
                });
            }

            if (result == undefined || result.length == 0 && result.length == undefined) {
                res.status(404);
                return res.json({
                    code: 404,
                    isSuccess: false,
                    msg: "未查询到相应商品！"
                });
            }

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
        });
    });

});

module.exports = router;
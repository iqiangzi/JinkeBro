var orderdeliveryDAL = appRequire('dal/jinkebro/orderdelivery/orderdeliverydal'),
	moment = require('moment'),
	logService = appRequire('service/backend/log/logservice'),
	config = appRequire('config/config'),
	operationConfig = appRequire ('config/operationconfig'),
	logModel = appRequire('model/jinkebro/log/logmodel'),
    operationConfig = appRequire('config/operationconfig'),
    logger = appRequire('util/loghelper').helper;

delete logModel.ID;

var OrderDelivery = function () {
	
};

//新增一个订单给配送员
OrderDelivery.prototype.insertOrderDelivery = function (data, callback) {
    //要写入operationlog表的
    logModel = logService.generateLogModel(
        operationConfig.jinkeBroApp.applicationID,
        operationConfig.jinkeBroApp.applicationName,
        operationConfig.operationType.error,
        operationConfig.jinkeBroApp.orderDelivery.orderdeliveryAdd.actionName,
        operationConfig.jinkeBroApp.orderDelivery.orderdeliveryAdd.actionName,
        operationConfig.jinkeBroApp.orderDelivery.orderdeliveryAdd.identifier
    );
    
    var formdata = {
        "OrderID" : data.OrderID,
        "DeliveryUserID" : data.DeliveryUserID,
        "DeliveryBeginTime" : data.DeliveryBeginTime || '',
        "DeliveryEndTime" : data.DeliveryEndTime || ''
    }

	orderdeliveryDAL.insertOrderDelivery (formdata, function (err, insertResult) {
		if (err) {
			logModel.Type = operationConfig.operationType.error;
            logModel.CreateUserID = data.CustomerID || 0;//0为管理员的操作
            logModel.Memo = "订单配送员新增失败";
            logService.insertOperationLog(logModel, function (err, logResult) {
                if (err) {
                    logger.writeError("订单新增失败，生成操作日志失败 " + logModel.CreateTime);
                }
            });
            return callback(true, '订单配送员新增失败');
		}
        
        //新增成功
        logModel.Type = operationConfig.operationType.operation;
        logModel.CreateUserID = data.CustomerID || 0;//0为管理员的操作
        logModel.Memo = "订单新增成功";
        logService.insertOperationLog(logModel, function (err, logResult) {
            if (err) {
                logger.writeError("订单新增成功，生成操作日志失败" + logModel.CreateTime);
            }
        });
        logger.writeInfo('订单新增成功');
        callback(false, insertResult);
        return;
    });
}
	
//订单配送员的查询
OrderDelivery.prototype.queryOrderDelivery = function (data, callback) {
    logModel = logService.generateLogModel(
        operationConfig.jinkeBroApp.applicationID,
        operationConfig.jinkeBroApp.applicationName,
        operationConfig.operationType.error,
        operationConfig.jinkeBroApp.orderDelivery.orderdeliveryAdd.actionName,
        operationConfig.jinkeBroApp.orderDelivery.orderdeliveryAdd.actionName,
        operationConfig.jinkeBroApp.orderDelivery.orderdeliveryAdd.identifier,
        0
    );
    //要写入operationlog表的
    
    var formdata = {
        "jit_orderdelivery.OrderID" : data.OrderID || '',
        "jit_orderdelivery.DeliveryUserID" : data.DeliveryUserID || '',
        "jit_orderdelivery.DeliveryBeginTime" : data.DeliveryBeginTime || '',
        "jit_orderdelivery.DeliveryEndTime" : data.DeliveryEndTime || '',
        pagedata : {
            page : data.page || 1,
            pageNum : data.pageNum || (config.pageCount),
            isPaging : (data.isPaging != undefined) ? (data.isPaging) : 0,
        }
    };

// console.log("********************************************");
// console.log(formdata);
    orderdeliveryDAL.queryOrderDelivery (formdata, function (err, queryResult) {
        
		if (err) {
			logModel.Type = operationConfig.operationType.error;
            logModel.CreateUserID = data.CustomerID || 0;//0为管理员的操作
            logModel.Memo = "订单配送员查询失败";
            logService.insertOperationLog(logModel, function (err, logResult) {
                if (err) {
                    logger.writeError("订单查询失败，生成操作日志失败 " + logModel.CreateTime);
                }
            });
            callback(true, '订单配送员查询失败');
            return;
		}
        //查询成功
        logModel.Type = operationConfig.operationType.operation;
        logModel.CreateUserID = data.CustomerID || 0;//0为管理员的操作
        logModel.Memo = "订单配送员查询成功";
        logService.insertOperationLog(logModel, function (err, logResult) {
            if (err) {
                logger.writeError("订单配送员查询成功，生成操作日志失败" + logModel.CreateTime);
            }
        });
        logger.writeInfo('订单查询成功');

        var resultLength = queryResult.length;
        for (var i = 0; i < resultLength; i++) {
            queryResult[i].DeliveryBeginTime = (queryResult[i].DeliveryBeginTime == undefined) ? '' : moment(queryResult[i].DeliveryBeginTime).format('YYYY-MM-DD');
            queryResult[i].DeliveryEndTime = (queryResult[i].DeliveryEndTime == undefined) ? '' : moment(queryResult[i].DeliveryEndTime).format('YYYY-MM-DD');
        }

        return callback(false, queryResult);
    });
}

//订单配送员的计数
OrderDelivery.prototype.countOrderDelivery = function (data, callback) {
    var formdata = {
        "jit_orderdelivery.OrderID" : data.OrderID || '',
        "jit_orderdelivery.DeliveryUserID" : data.DeliveryUserID || '',
        "jit_orderdelivery.DeliveryBeginTime" : data.DeliveryBeginTime || '',
        "jit_orderdelivery.DeliveryEndTime" : data.DeliveryEndTime || '',
    };

    orderdeliveryDAL.countOrderDelivery (formdata, function (err, countResult) {
        if (err) {
            callback(true, '订单配送员查询失败！');
            return;
        }

        logger.writeInfo('订单配送员查询成功！');
        callback(false, countResult);
    });
}

//订单配送员的修改
OrderDelivery.prototype.updateOrderDelivery = function (data, callback) {
    //要写入operationlog表的
    logModel = logService.generateLogModel(
        operationConfig.jinkeBroApp.applicationID,
        operationConfig.jinkeBroApp.applicationName,
        operationConfig.operationType.error,
        operationConfig.jinkeBroApp.orderDelivery.orderdeliveryUpd.actionName,
        operationConfig.jinkeBroApp.orderDelivery.orderdeliveryUpd.actionName,
        operationConfig.jinkeBroApp.orderDelivery.orderdeliveryUpd.identifier,
        0
    );
    
    var formdata = {
        "OrderID" : data.OrderID,
        "DeliveryUserID" : data.DeliveryUserID || '',
        "DeliveryBeginTime" : data.DeliveryBeginTime || '',
        "DeliveryEndTime" : data.DeliveryEndTime || ''
    };

    var returnResult = {
        msg : '参数不能为空!'
    };

    if (formdata.DeliveryBeginTime && formdata.DeliveryEndTime) {
        if (moment(formdata.DeliveryEndTime).isBefore(formdata.DeliveryBeginTime)) {
            returnResult.msg = '配送结束时间不能比配送开始时间早!';
            return callback(false,returnResult);
        }
    }


	orderdeliveryDAL.updateOrderDelivery (formdata, function (err, insertResult) {
		if (err) {
			logModel.Type = operationConfig.operationType.error;
            logModel.CreateUserID = data.CustomerID || 0;//0为管理员的操作
            logModel.Memo = "订单配送单修改失败";
            logService.insertOperationLog(logModel, function (err, logResult) {
                if (err) {
                    logger.writeError("订单修改失败，生成操作日志失败 " + logModel.CreateTime);
                }
            });
            callback(true, '订单配送单修改失败');
            return;
		}

        logModel.Type = operationConfig.operationType.operation;
        logModel.CreateUserID = data.CustomerID || 0;//0为管理员的操作
        logModel.Memo = "订单配送单修改成功";
        logService.insertOperationLog(logModel, function (err, logResult) {
            if (err) {
                logger.writeError("订单修改成功，生成操作日志失败" + logModel.CreateTime);
            }
        });
        
        logger.writeInfo('订单修改成功');
        return callback(false, insertResult);
    });
};

OrderDelivery.prototype.checkDeliveryIsFinished = function (data, callback) {

    var formdata = {
        "OrderID" : data.OrderID
    };

    orderdeliveryDAL.checkDeliveryIsFinished(formdata, function (err, checkResult) {
        if (err) {
            return callback(true);
        }

        return callback(false, checkResult);
    });
};


OrderDelivery.prototype.checkDeliveryIsStarted = function (data, callback) {

    var formdata = {
        "OrderID" : data.OrderID
    };

    orderdeliveryDAL.checkDeliveryIsStarted(formdata, function (err, checkResult) {
        if (err) {
            return callback(true);
        }

        return callback(false, checkResult);
    });
};


module.exports = new OrderDelivery();
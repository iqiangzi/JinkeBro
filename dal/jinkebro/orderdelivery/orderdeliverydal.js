/**
 * @Author: Duncan
 * @Date: 2017/1/21 21:23
 * @Last Modified by: Duncan
 * @Last Modified time: 
 * @Function: 加入那个orderdelivery的表
 */

var db_jinkebro = appRequire('db/db_jinkebro'),
    orderdelivery = appRequire('model/jinkebro/orderdelivery/orderdeliverymodel'),
    logger = appRequire('util/loghelper').helper,
    moment = require('moment'); 
	 
/**
 * @param {Object} data
 * @param {function} callback
 * function: 订单的配送员分配
 */
exports.insertOrderDelivery = function (data, callback) {
    var sql = 'INSERT INTO jit_orderdelivery SET ';
    var  i = 0;

    for (var key in data) {
        if (key != 'ID' && data[key] != '') {
            if (i == 0) {
                
                if (!isNaN(data[key])) {
                    sql += key + " = " + data[key] + " ";
                    i++;
                    
                } else {
                    sql += key + " = '" + data[key] + "' ";
                    i++;
                }
            } else {               
                if (!isNaN(data[key])) {
                    
                    sql += " , " + key + " = " + data[key] + " ";
                } else {
                    
                    sql += " , " + key + " = '" + data[key] + "' ";
                }
            }
        }
    }

    logger.writeInfo('[dal/jinkebro/orderdelivery]商品配送员的新增');
  
    db_jinkebro.mysqlPool.getConnection(function (err, connection) {
        if (err) {
            callback(true);
            logger.writeError("[dal/jinkebro/customer/customerdal]数据库的链接失败");
            return;
        }
        
        connection.query(sql, function (err, results) {
            connection.release();
            if (err) {
                callback(true);
                logger.writeError("[dal/jinkebro/customer/customerdal]订单的配送员的插入的时候失败");
                return;
            }

            callback(false, results);
            return;
        });
    });
}

/**
 * @function: 订单配送员表的查询工作
 */
exports.queryOrderDelivery = function (data, callback) {
    var num = data.pagedata.pageNum;
    var page = data.pagedata.page;
    var isPaging = data.pagedata.isPaging;
    delete data.pagedata;

    var arr = new Array();
    arr.push('select jit_orderdelivery.ID,jit_orderdelivery.OrderID,jit_orderdelivery.DeliveryUserID,jit_orderdelivery.DeliveryBeginTime,jit_orderdelivery.DeliveryEndTime,');
    arr.push('jit_staff.StaffName');
    arr.push('from jit_orderdelivery,jit_staff');
    arr.push('where jit_orderdelivery.DeliveryUserID = jit_staff.StaffID');
    arr.push('and  jit_staff.StaffType = 2 ');

    var sql = arr.join(' ');
    
    for (var key in data) {
        if (key == 'jit_orderdelivery.DeliveryBeginTime' && data[key] != '')
        {
            sql += " and " + key + " > '" + data[key] + "' ";
            
        } else if(key == 'jit_orderdelivery.DeliveryEndTime' && data[key] != '')      
        {
            sql += " and " + key  + " < '" + data[key] + "' ";
        }
        else if (data[key] != '') {                            
            sql += " and " + key + " = '" + data[key] + "' ";
        }
    }

    sql += ' order by jit_orderdelivery.OrderID desc ';

    if (isPaging == 0) {
        sql += " LIMIT " + (page - 1) * num + "," + num + " ;";
    }

    logger.writeInfo("[dal/jinkebro/orderdelivery]订单配送员查询:" + sql);
    
    db_jinkebro.mysqlPool.getConnection(function (err, connection) {
        if (err) {
            callback(true);
            return;
        }

        connection.query(sql, function (err, results) {
            connection.release();
            if (err) {
                return callback(true);
            }
            
            return callback(false, results);
        });
    });
}

/**
 * @function: 订单配送员表的查询工作
 */
exports.countOrderDelivery = function (data, callback) {
 
    var arr = new Array();
    arr.push('select count(1) as num');
    arr.push('from jit_orderdelivery,jit_staff');
    arr.push('where jit_orderdelivery.DeliveryUserID = jit_staff.StaffID');
    arr.push('and  jit_staff.StaffType = 2');

    var sql = arr.join(' ');

    for (var key in data) {
        if (key == 'jit_orderdelivery.DeliveryBeginTime' && data[key] != '')
        {
            sql += " and " + key + " > '" + data[key] + "' ";
        } else if(key == 'jit_orderdelivery.DeliveryEndTime' && data[key] != '')
        {
            sql += " and " + key  + " < '" + data[key] + "' ";
        }
        else if (data[key] != '') {                            
            sql += " and " + key + " = '" + data[key] + "' ";
        }
    }

    logger.writeInfo("[dal/jinkebro/orderdelivery]订单配送员计数:" + sql);

    db_jinkebro.mysqlPool.getConnection(function (err, connection) {
        if (err) {
            callback(true);
            return;
        }

        connection.query(sql, function (err, results) {
            connection.release();
            if (err) {
                callback(true);
                return;
            }
            
            callback(false, results);
            return;
        });
    });
}


/**
 * function: 修改配送员
 */
exports.updateOrderDelivery = function (data, callback) {
    var upd_sql = "update jit_orderdelivery set ";
    var i = 0;
    for (var key in data) {
        if (key != undefined && data[key] != '') {
            if (i == 0) {
                if (!isNaN(data[key])) {
                    upd_sql += key + " = " + data[key] + " ";
                    i++;
                } else {
                    upd_sql += key + " = '" + data[key] + "' ";
                    i++;
                }
            } else {
                if (!isNaN(data[key])) {
                    upd_sql += " , " + key + " = " + data[key] + " ";
                } else {
                    upd_sql += " , " + key + " = '" + data[key] + "' ";
                }
            }
        }
    }

    upd_sql += 'WHERE OrderID ' + ' = ' + data['OrderID'] + ' ';

    logger.writeInfo('修改配送员： ' + upd_sql);
    db_jinkebro.mysqlPool.getConnection(function (err, connection) {
        if (err) {
            callback(true);
            return;
        }

        connection.query(upd_sql, function (err, results) {
            connection.release();
            if (err) {
                callback(true);
                return;
            }

            callback(false, results);
            return;
        });
    });
}


/**
 * function: 查看配送是否结束
 */
exports.checkDeliveryIsFinished = function (data, callback) {
    var check_sql = "select count(1) as num from jit_orderdelivery where jit_orderdelivery.OrderID = " + data.OrderID + " and jit_orderdelivery.DeliveryEndTime IS NOT NULL;";

    db_jinkebro.mysqlPool.getConnection(function (err, connection) {
        if (err) {
            callback(true);
            return;
        }

        connection.query(check_sql, function (err, results) {
            connection.release();
            if (err) {
                callback(true);
                return;
            }

            return callback(false, results);
        });
    });
};

/**
 * function: 查看配送是否结束
 */
exports.checkDeliveryIsStarted = function (data, callback) {
    var check_sql = "select count(1) as num from jit_orderdelivery where jit_orderdelivery.OrderID = " + data.OrderID + " and jit_orderdelivery.DeliveryBeginTime is not null;";

    db_jinkebro.mysqlPool.getConnection(function (err, connection) {
        if (err) {
            callback(true);
            return;
        }

        connection.query(check_sql, function (err, results) {
            connection.release();
            if (err) {
                callback(true);
                return;
            }

            return callback(false, results);
        });
    });
};
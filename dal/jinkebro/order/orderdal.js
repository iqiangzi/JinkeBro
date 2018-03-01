/**
 * @Author: Cecurio
 * @Date: 2017/1/2 17:43
 * @Last Modified by: Cecurio
 * @Last Modified time: 2017/1/2 17:43
 * @Function:
 */
var db_jinkebro = appRequire('db/db_jinkebro'),
    order = appRequire('model/jinkebro/order/ordermodel'),
    logger = appRequire("util/loghelper").helper,
    dbHelper = appRequire("util/dbhelper"),
    async = require('async'),
    moment = require('moment');

/**
 * 创建订单（事务保证，损失性能）,优化版本
 * @param {object} data 订单对象
 * @param {function} callback 回调方法
 */
exports.createSimplifiedOrder = function(data, callback) {
    /**
     * 1.校验data传过来的必要的参数是否有，并且合法（这一步其实应该在service层做）
     * 2.校验当前订单对应的所有商品库存是否满足下单量
     * 3.创建订单
     * 4.创建订单与商品的关系数据
     * 5.扣减对应的商品数量，update的时候注意where条件（where 当前商品的库存>下单的数量），如果update之后返回影响的行数如果为0，说明
     * 商品库存不足，此时也应该回滚
     * 6.返回创建生成的订单号
     * 7.以上任何一步异常，回滚
     * 8.提交
     */
    var createResult = {};
    //创建订单sql
    var createOrderSql = generateOrderSql(data);
    //创建订单客户关系sql
    var createOrderCustomerSql = '';
    //创建订单商品关系sql
    var createOrderProductsSql = '';
    //存储商品库存扣减sql
    var productStockSqls = [];
    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            console.error('mysql 链接失败');
            callback(true);
            return;
        }
        connection.beginTransaction(function(err) {
            if (err) {
                connection.release();
                return callback(true, '订单创建异常!请检查DB连接');
            }
            //1.订单
            var orderFunc = function(callback1) {
                connection.query(createOrderSql, function(err, results) {
                    if (err) {
                        return callback1(true, "生成订单失败");
                    }

                    var newOrderID = results.insertId;

                    createOrderCustomerSql = generateOrderCustomerSql(newOrderID, data);

                    receiveProductCounts = data.ProductCounts;

                    createOrderProductsSql = generateOrderProductsSql(newOrderID, data.ProductIDs, data.ProductCounts);

                    createResult = results;
                    console.log(1);
                    callback1(null, newOrderID);
                });
            };

            //2.订单客户关系
            var customerOfOrderFunc = function(newOrderID, callback2) {
                connection.query(createOrderCustomerSql, function(err, results) {
                    if (err) {
                        return callback2(true, "生成订单客户关系失败");
                    }
                    console.log(2);
                    callback2(null, newOrderID);
                });
            };
            //3.订单商品关系
            var productOfOrderFunc = function(newOrderID, callback3) {
                connection.query(createOrderProductsSql, function(err, results) {
                    if (err) {
                        return callback2(true, "生成订单商品关系失败");
                    }
                    console.log(3);
                    callback3(null, newOrderID);
                });
            };
            //同步执行
            async.waterfall([orderFunc, customerOfOrderFunc, productOfOrderFunc], function(err, result) {
                    if (err) {
                        return callback(true, {});
                    }

                    data.ProductIDs.forEach(function(element) {
                        var index = 0;
                        var update_sql = generateUpdateProductStockSql(element, data.ProductCounts[index++]);
                        productStockSqls.push(update_sql);
                    });
                    console.log(4);

                    async.eachSeries(productStockSqls, function(sql, callback) {
                        console.log(sql)
                        connection.query(sql, function(err, results) {
                            if (err) {
                                console.log(5);
                                // 异常后调用callback并传入err
                                callback(err);
                            } else {
                                if (results.affectedRows == 0) {
                                    console.log(6);
                                    return callback(true, "商品库存不足!");
                                }
                                console.log(7);
                                console.log(sql + "执行成功");
                                // 执行完成后也要调用callback，不需要参数
                                callback();
                            }
                        });
                    }, function(err) {
                        if (err) {
                            console.log(8);
                            connection.rollback(function() {

                            });
                            connection.release();
                            return callback(true);
                        } else {
                            console.log(9);
                            console.log("SQL全部执行成功");
                            connection.commit(function(err) {
                                if (err) {
                                    connection.release();
                                    connection.rollback(function() {
                                        throw err;
                                    });
                                    return callback(true, "生成订单异常");
                                }

                                connection.release();
                                return callback(false, createResult);
                            });
                        }
                    });
                },
                function(err) {
                    console.log('订单创建异常,err:' + JSON.stringify(err));
                    return callback(true, {});
                });
        });
    });
}

/**
 * 生成插入订单的sql
 * @param {object} data 元数据
 */
function generateOrderSql(data) {
    var data = {
        OrderTime: data.OrderTime,
        PayMethod: data.PayMethod,
        IsValid: data.IsValid,
        IsActive: data.IsActive,
        OrderStatus: data.OrderStatus
    };

    var sql = dbHelper.generateInsertCommonSql('jit_order', data);

    return sql;
}

/**
 * 生成插入订单客户关系的sql
 * @param {int} orderid 新生成的订单号
 * @param {object} data 元数据
 */
function generateOrderCustomerSql(orderid, data) {
    var data = {
        CustomerID: data.CustomerID,
        OrderID: orderid,
        IsActive: data.IsActive,
        CreateTime: moment().format('YYYY-MM-DD HH:mm:ss')
    };

    var sql = dbHelper.generateInsertCommonSql('jit_ordercustomer', data);

    return sql;
}

/**
 * 生成订单商品关系sql
 * @param {int} orderid 新生成的订单号
 * @param {Array} products 商品数组
 * @param {Array} receiveProductCounts 商品数量数组
 */
function generateOrderProductsSql(orderid, products, receiveProductCounts) {
    var sql = 'insert into jit_orderproduct (OrderID,ProductID,ProductCount) values ';

    for (var i = 0, totalProducts = products.length; i < totalProducts; i++) {
        if (i == totalProducts - 1) {
            sql += "(" + orderid + "," + products[i] + "," + receiveProductCounts[i] + ");";
        } else {
            sql += "(" + orderid + "," + products[i] + "," + receiveProductCounts[i] + "),";
        }
    }

    return sql;
}

/**
 * 生成商品扣减sql
 * @param {int} reduceCount 扣减的数量
 * @param {int} productID 商品ID
 */
function generateUpdateProductStockSql(productID, reduceCount) {
    var sql = 'update jit_productstock set jit_productstock.TotalNum = jit_productstock.TotalNum - ' + reduceCount;
    sql += ' where jit_productstock.TotalNum >= ' + reduceCount + ' and ProductID = ' + productID + ';';

    return sql;
}

/**
 * 创建订单（事务保证，损失性能）
 * @param {object} data 订单对象
 * @param {function} callback 回调方法
 */
exports.createOrder = function(data, callback) {

    var insertOrderData = {
        OrderTime: data.OrderTime,
        PayMethod: data.PayMethod,
        IsValid: data.IsValid,
        IsActive: data.IsActive,
        OrderStatus: data.OrderStatus
    };

    var receiveProductIDs = data.ProductIDs,
        receiveProductCounts = data.ProductCounts;

    var failResponse = {
        msg: '出错啦！！'
    };

    // 从链接池得到connection
    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            console.error('mysql 链接失败');
            callback(true);
            return;
        }
        //开始事务
        connection.beginTransaction(function(err) {
            if (err) {
                connection.release();
                throw err;
            }
            var returnResult = {};
            var funcArr = [];

            // 添加记录到order表
            var func1 = function(callback1) {
                var insertSql1 = 'insert into jit_order set ';
                var sql = '';
                if (insertOrderData !== undefined) {
                    for (var key in insertOrderData) {
                        if (sql.length == 0) {
                            if (!isNaN(insertOrderData[key])) {
                                sql += " " + key + " = " + insertOrderData[key] + " ";
                            } else {
                                sql += " " + key + " = '" + insertOrderData[key] + "' ";
                            }
                        } else {
                            if (!isNaN(insertOrderData[key])) {
                                sql += ", " + key + " = " + insertOrderData[key] + " ";
                            } else {
                                sql += ", " + key + " = '" + insertOrderData[key] + "' ";
                            }
                        }
                    }
                }
                insertSql1 += sql + ' ;';

                logger.writeInfo("insert into order,sql: " + insertSql1);
                connection.query(insertSql1, function(err, info) {
                    if (err) {
                        connection.release();
                        connection.rollback(function() {
                            logger.writeError("[order]执行事务失败，" + "ERROR：" + err);
                            console.log("[order]执行事务失败，" + "ERROR：" + err);
                            throw err;
                        });
                        return;
                    }
                    console.log(info);
                    returnResult = info;
                    callback1(err, info);
                });
            };
            funcArr.push(func1);

            // 添加记录到ordercustomer表
            var func2 = function(callback2) {
                var InsertUserOrderData = {
                    CustomerID: data.CustomerID,
                    OrderID: returnResult.insertId,
                    IsActive: data.IsActive,
                    CreateTime: moment().format('YYYY-MM-DD HH:mm:ss')
                };

                var insertSql2 = ' insert into jit_ordercustomer set  ';
                var sql = '';
                if (InsertUserOrderData !== undefined) {
                    for (var key in InsertUserOrderData) {
                        if (sql.length == 0) {
                            if (!isNaN(InsertUserOrderData[key])) {
                                sql += " " + key + " = " + InsertUserOrderData[key] + " ";
                            } else {
                                sql += " " + key + " = '" + InsertUserOrderData[key] + "' ";
                            }
                        } else {
                            if (!isNaN(InsertUserOrderData[key])) {
                                sql += ", " + key + " = " + InsertUserOrderData[key] + " ";
                            } else {
                                sql += ", " + key + " = '" + InsertUserOrderData[key] + "' ";
                            }
                        }
                    }
                }
                insertSql2 += sql + ' ;';

                logger.writeInfo("insert into ordercustomer,sql: " + insertSql2)
                connection.query(insertSql2, function(err, info) {
                    if (err) {
                        connection.release();
                        connection.rollback(function() {
                            logger.writeError("[ordercustomer]执行事务失败，" + "ERROR：" + err);
                            console.log("[ordercustomer]执行事务失败，" + "ERROR：" + err);
                            throw err;
                        });
                        return;
                    }
                    console.log(info);
                    callback2(err, info);
                });
            };
            funcArr.push(func2);

            // 修改productstock表
            (function next(index) {
                if (index === receiveProductIDs.length) { // No items left
                    return;
                }
                var tempProID = receiveProductIDs[index];
                var tempProCount = receiveProductCounts[index];
                var tempfunc = function(callbacktemp) {
                    var updateStockSql = 'update jit_productstock set jit_productstock.TotalNum = jit_productstock.TotalNum - ' + tempProCount;
                    updateStockSql += ' where jit_productstock.TotalNum >= ' + tempProCount + ' and ProductID = ' + tempProID + ';';

                    logger.writeInfo("updateStockSql" + index + ": " + updateStockSql);

                    connection.query(updateStockSql, function(err, info) {
                        if (err) {
                            connection.release();
                            connection.rollback(function() {
                                logger.writeError("[orderProduct]执行事务失败，" + "ERROR：" + err);
                                console.log("[orderProduct]执行事务失败，" + "ERROR：" + err);
                                throw err;
                            });
                            return;
                        }
                        if (info.affectedRows == 0) {
                            connection.release();
                            connection.rollback(function() {
                                logger.writeError("[productstock]执行事务失败，" + "ProductID为" + tempProID + "的商品库存不足！");
                                console.log("[productstock]执行事务失败，" + "ProductID为" + tempProID + "的商品库存不足！");
                            });
                            callback(false, tempProID);
                            return;
                        }
                        console.log(info);
                        callbacktemp(err, info);
                    });
                }
                funcArr.push(tempfunc);
                next(index + 1);
            })(0);

            // 插入记录到orderProduct表
            var func3 = function(callback3) {
                var insertSql3 = 'insert into jit_orderproduct (OrderID,ProductID,ProductCount) values ';
                var receiveProductIDsLength = receiveProductIDs.length;
                for (var i = 0; i < receiveProductIDsLength; i++) {
                    if (i == receiveProductIDsLength - 1) {
                        insertSql3 += "(" + returnResult.insertId + "," + receiveProductIDs[i] + "," + receiveProductCounts[i] + ");";
                    } else {
                        insertSql3 += "(" + returnResult.insertId + "," + receiveProductIDs[i] + "," + receiveProductCounts[i] + "),";
                    }
                }

                connection.query(insertSql3, function(err, info) {
                    if (err) {
                        connection.release();
                        connection.rollback(function() {
                            logger.writeError("[order]执行事务失败，" + "ERROR：" + err);
                            console.log("[order]执行事务失败，" + "ERROR：" + err);
                            throw err;
                        });
                        return;
                    }
                    console.log(info);
                    if (info.affectedRows != receiveProductIDsLength) {
                        connection.release();
                        connection.rollback(function() {
                            logger.writeError("[productstock]执行事务失败，" + "ProductID为" + tempProID + "的商品库存不足！");
                            console.log("[productstock]执行事务失败，" + "ProductID为" + tempProID + "的商品库存不足！");
                        });
                        callback(false, '下单失败');
                        return;
                    }
                    callback3(err, info);
                });
            };
            funcArr.push(func3);

            async.series(funcArr, function(err, result) {
                if (err) {
                    connection.release();
                    connection.rollback(function(err) {
                        throw err;
                    });
                    return;
                }

                connection.commit(function(err) {
                    if (err) {
                        connection.release();
                        connection.rollback(function() {
                            throw err;
                        });
                        return;
                    }
                    console.log('insert order success');
                    connection.release();
                    return callback(false, returnResult);
                });
            });
        });

    });

};

/**
 * 使用事务增加订单
 * @param data
 * @param callback
 * return
 * success-responce:
 * {
    "fieldCount": 0,
    "affectedRows": 1,
    "insertId": 464, // 此为新增订单的OrderID
    "serverStatus": 3,
    "warningCount": 0,
    "message": "",
    "protocol41": true,
    "changedRows": 0
  }
 *error-responce:
 * 如果库存不足，就返回字符串 "ProductID为5（某个数字）的商品库存不足！"
 *
 */

exports.insertOrderFull = function(data, callback) {
    var insertSql1 = '',
        insertSql2 = '';

    // var receiveData = {
    //     "OrderTime": "2017-01-10 15:47:32",
    //     "PayMethod": 1,
    //     "IsValid": 1,
    //     "IsActive": 1,
    //     "ProductIDs": [
    //         1,
    //         2,
    //         3
    //     ],
    //     "ProductCounts": [
    //         2,
    //         1,
    //         3
    //     ],
    //     "CustomerID": 1,
    //     "OrderStatus": 1
    // };

    var insertOrderData = {
        OrderTime: data.OrderTime,
        PayMethod: data.PayMethod,
        IsValid: data.IsValid,
        IsActive: data.IsActive,
        OrderStatus: data.OrderStatus
    };

    var receiveProductIDs = data.ProductIDs,
        receiveProductCounts = data.ProductCounts;

    logger.writeInfo("[insertOrderFull func in orderdal]订单新增. ");

    // 从链接池得到connection
    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            console.error('mysql 链接失败');
            callback(true);
            return;
        }
        //开始事务
        connection.beginTransaction(function(err) {
            if (err) {
                throw err;
            }

            var returnResult = {};
            var funcArr = [];

            // 添加记录到order表
            var func1 = function(callback1) {
                insertSql1 = 'insert into jit_order set ';
                var sql = '';
                if (insertOrderData !== undefined) {
                    for (var key in insertOrderData) {
                        if (sql.length == 0) {
                            if (!isNaN(insertOrderData[key])) {
                                sql += " " + key + " = " + insertOrderData[key] + " ";
                            } else {
                                sql += " " + key + " = '" + insertOrderData[key] + "' ";
                            }
                        } else {
                            if (!isNaN(insertOrderData[key])) {
                                sql += ", " + key + " = " + insertOrderData[key] + " ";
                            } else {
                                sql += ", " + key + " = '" + insertOrderData[key] + "' ";
                            }
                        }
                    }
                }
                insertSql1 += sql + ' ;';
                console.log("insert into order,sql: " + insertSql1);
                logger.writeInfo("insert into order,sql: " + insertSql1);
                connection.query(insertSql1, function(err, info) {
                    if (err) {
                        connection.rollback(function() {
                            logger.writeError("[order]执行事务失败，" + "ERROR：" + err);
                            console.log("[order]执行事务失败，" + "ERROR：" + err);
                            throw err;
                        });
                        return;
                    }
                    console.log(info);
                    returnResult = info;
                    callback1(err, info);
                });
            };
            funcArr.push(func1);

            // 添加记录到ordercustomer表
            var func2 = function(callback2) {
                var InsertUserOrderData = {
                    CustomerID: data.CustomerID,
                    OrderID: returnResult.insertId,
                    IsActive: data.IsActive,
                    CreateTime: moment().format('YYYY-MM-DD HH:mm:ss')
                };

                insertSql2 = ' insert into jit_ordercustomer set  ';
                var sql = '';
                if (InsertUserOrderData !== undefined) {
                    for (var key in InsertUserOrderData) {
                        if (sql.length == 0) {
                            if (!isNaN(InsertUserOrderData[key])) {
                                sql += " " + key + " = " + InsertUserOrderData[key] + " ";
                            } else {
                                sql += " " + key + " = '" + InsertUserOrderData[key] + "' ";
                            }
                        } else {
                            if (!isNaN(InsertUserOrderData[key])) {
                                sql += ", " + key + " = " + InsertUserOrderData[key] + " ";
                            } else {
                                sql += ", " + key + " = '" + InsertUserOrderData[key] + "' ";
                            }
                        }
                    }
                }
                insertSql2 += sql + ' ;';
                console.log("insert into ordercustomer,sql: " + insertSql2);
                logger.writeInfo("insert into ordercustomer,sql: " + insertSql2)
                connection.query(insertSql2, function(err, info) {
                    if (err) {
                        connection.rollback(function() {
                            logger.writeError("[ordercustomer]执行事务失败，" + "ERROR：" + err);
                            console.log("[ordercustomer]执行事务失败，" + "ERROR：" + err);
                            throw err;
                        });
                        return;
                    }
                    console.log(info);
                    callback2(err, info);
                });
            };
            funcArr.push(func2);

            // 插入记录到orderProduct表
            (function next(index) {
                if (index === receiveProductIDs.length) { // No items left
                    return;
                }
                var tempProID = receiveProductIDs[index];
                var tempProCount = receiveProductCounts[index];
                var tempfunc = function(callbacktemp) {
                    var insertSqlTemp = ' insert into jit_orderproduct set OrderID = ' + returnResult.insertId + ' , ';
                    insertSqlTemp += ' ProductID = ' + tempProID + ' , ';
                    insertSqlTemp += ' ProductCount = ' + tempProCount + ' ;';
                    console.log("insertSqlTemp" + index + ": " + insertSqlTemp);
                    logger.writeInfo("insertSqlTemp" + index + ": " + insertSqlTemp);
                    connection.query(insertSqlTemp, function(err, info) {
                        if (err) {
                            connection.rollback(function() {
                                logger.writeError("[orderProduct]执行事务失败，" + "ERROR：" + err);
                                console.log("[orderProduct]执行事务失败，" + "ERROR：" + err);
                                throw err;
                            });
                            return;
                        }
                        console.log(info);
                        callbacktemp(err, info);
                    });
                }
                funcArr.push(tempfunc);
                next(index + 1);
            })(0);

            // 修改productstock表
            (function next(index) {
                if (index === receiveProductIDs.length) { // No items left
                    return;
                }
                var tempProID = receiveProductIDs[index];
                var tempProCount = receiveProductCounts[index];
                var tempfunc = function(callbacktemp) {
                    var updateStockSql = 'update jit_productstock set jit_productstock.TotalNum = jit_productstock.TotalNum - ' + tempProCount;
                    updateStockSql += ' where jit_productstock.TotalNum >= ' + tempProCount + ' and ProductID = ' + tempProID + ';';

                    console.log("updateStockSql" + index + ": " + updateStockSql);
                    logger.writeInfo("updateStockSql" + index + ": " + updateStockSql);

                    connection.query(updateStockSql, function(err, info) {
                        if (err) {
                            connection.rollback(function() {
                                logger.writeError("[orderProduct]执行事务失败，" + "ERROR：" + err);
                                console.log("[orderProduct]执行事务失败，" + "ERROR：" + err);
                                throw err;
                            });
                        }
                        if (info.affectedRows == 0) {
                            connection.rollback(function() {
                                logger.writeError("[productstock]执行事务失败，" + "ProductID为" + tempProID + "的商品库存不足！");
                                console.log("[productstock]执行事务失败，" + "ProductID为" + tempProID + "的商品库存不足！");
                            });
                            callback(false, tempProID);
                            return;
                        }
                        console.log(info);
                        callbacktemp(err, info);
                    });
                }
                funcArr.push(tempfunc);
                next(index + 1);
            })(0);

            async.series(funcArr, function(err, result) {
                if (err) {
                    connection.rollback(function(err) {
                        throw err;
                    });
                    connection.release();
                    return;
                }

                connection.commit(function(err) {
                    if (err) {
                        connection.rollback(function() {
                            throw err;
                        });
                        return;
                    }
                    console.log('insert success');
                    connection.release();
                    return callback(false, returnResult);
                });
            });
        });

    });
};

/**
 * 删除订单,物理删除
 * @param data
 * @param callback
 */
exports.deleteOrder = function(data, callback) {
    var delete_sql = 'delete from jit_order where 1 = 0 ;  ';

    console.log(delete_sql);

    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            callback(true);
            return;
        }

        connection.query(delete_sql, function(err, results) {
            if (err) {
                connection.release();
                callback(true);
                return;
            }
            connection.release();
            return callback(false, results);
        });
    });
};

/**
 * 修改订单,包括修改order表，orderproduct表
 * @param data
 * @param callback
 */
exports.updateOrder = function(data, callback) {
    //接收的data数据形式如下：
    // {
    //     order: {
    //         OrderID: '1',
    //             OrderTime: '',
    //             PayTime: '',
    //             DeliveryTime: '',
    //             PayMethod: '',
    //             IsValid: '',
    //             IsActive: 0,
    //             DeliveryUserID: '',
    //             IsCancel: '',
    //             CancelTime: '',
    //             DiscountMoney: '',
    //             DiscountType: '',
    //             BizID: '',
    //             Memo: '',
    //             IsCheck: '',
    //             PDate: '',
    //             OrderStatus: ''
    //     }
    // }
    var orderTableData = data.order;
    for (var key in orderTableData) {
        if (orderTableData[key] == 0) {
            orderTableData[key] = orderTableData[key].toString();
        }
    }

    var update_sql = 'update jit_order set ';
    var temp_sql = '';
    if (orderTableData !== undefined) {
        for (var key in orderTableData) {
            if (orderTableData[key] != '') {
                if (temp_sql.length == 0) {
                    if (!isNaN(orderTableData[key]) && orderTableData[key] != 0) {
                        temp_sql += " " + key + " = " + orderTableData[key] + " ";
                    } else {
                        temp_sql += " " + key + " = '" + orderTableData[key] + "' ";
                    }
                } else {
                    if (!isNaN(orderTableData[key]) && orderTableData[key] != 0) {
                        temp_sql += " , " + key + " = " + orderTableData[key] + " ";
                    } else {
                        temp_sql += " , " + key + " = '" + orderTableData[key] + "' ";
                    }
                }
            }
        }
    }

    update_sql += temp_sql;
    update_sql += ' where OrderID = ' + orderTableData.OrderID + ';';

    logger.writeInfo('修改order表中记录的sql:' + update_sql);

    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            console.error('mysql 链接失败');
            return callback(true);
        }

        connection.query(update_sql, function(err, results) {
            connection.release();

            if (err) {
                return callback(true);
            }

            return callback(false, results);
        });
    });
};

/**
 * 查询订单、产品信息
 * @param data
 * @param callback
 */
exports.queryOrderProduct = function(data, callback) {
    var arr = new Array();
    // data的格式如下
    // {
    //     pageManage: {
    //         page: 1,
    //             pageNum: 20,
    //             isPaging: 1
    //     },
    //     orderProduct: {
    //         'jit_orderproduct.ProductID': [
    //
    //         ],
    //             'jit_orderproduct.ProductCount': [
    //
    //         ]
    //     },
    //     order: {
    //         'jit_ordercustomer.OrderID': '1',
    //             'jit_customer.WechatUserCode': '',
    //             'jit_customer.CustomerID': '',
    //             'jit_order.OrderStatus': ''
    //     }
    // }
    arr.push(' select jit_customer.CustomerID,jit_ordercustomer.OrderID, ');
    arr.push(' jit_order.OrderTime,jit_orderproduct.ProductID,jit_product.ProductName,jit_orderproduct.ProductCount, ');
    arr.push(' jit_product.ProductPrice,jit_productype.ProductTypeName,jit_order.PayMethod,jit_order.OrderStatus,jit_order.IsValid,jit_order.IsActive ');
    arr.push(' from jit_ordercustomer ,jit_order,jit_orderproduct,jit_product,jit_customer,jit_productype ');
    arr.push(' where 1 = 1 and jit_order.OrderID = jit_ordercustomer.orderID ');
    arr.push(' and jit_order.OrderID = jit_orderproduct.OrderID ');
    arr.push(' and jit_product.ProductID = jit_orderproduct.ProductID ');
    arr.push(' and jit_ordercustomer.CustomerID = jit_customer.CustomerID ');
    arr.push(' and jit_product.ProductTypeID = jit_productype.ID ');

    var query_sql = arr.join(' ');

    // 接收service传来的数据
    var pageManageData = data.pageManage;
    var orderProductData = data.orderProduct;
    var orderData = data.order;

    // OrderID,WechatUserCode,CustomerID,OrderStatus,IsActive的拼接
    if (orderData !== undefined) {
        for (var key in orderData) {
            if (orderData[key] != '') {
                //判断data[key]是否是数值类型
                if (!isNaN(orderData[key])) {
                    query_sql += " and " + key + " = " + orderData[key] + " ";
                } else {
                    query_sql += " and " + key + " = '" + orderData[key] + "' ";
                }
            }
        }
    }

    var num = pageManageData.pageNum; //每页显示的个数
    var page = pageManageData.page || 1;

    if (pageManageData.isPaging == 0) {
        query_sql += " LIMIT " + (page - 1) * num + "," + num + " ;";
    }

    logger.writeInfo("[queryOrders func in productdal]订单产品查询:" + query_sql);

    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            return callback(true);
        }

        connection.query(query_sql, function(err, results) {
            connection.release();

            if (err) {
                return callback(true);
            }

            return callback(false, results);
        });
    });
};

/**
 * 查询指定条件订单产品的个数
 * @param data
 * @param callback
 * @constructor
 */
exports.CountOrderProduct = function(data, callback) {
    var arr = new Array();
    arr.push(' select count(1) as num ');
    arr.push(' from jit_ordercustomer ,jit_order,jit_orderproduct,jit_product,jit_customer ');
    arr.push(' where 1 = 1 and jit_order.OrderID = jit_ordercustomer.orderID ');
    arr.push(' and jit_order.OrderID = jit_orderproduct.OrderID ');
    arr.push(' and jit_product.ProductID = jit_orderproduct.ProductID ');
    arr.push(' and jit_ordercustomer.CustomerID = jit_customer.CustomerID ');
    var sql = arr.join(' ');

    // 接收service传来的数据
    var orderProductData = data.orderProduct;
    var orderData = data.order;

    // OrderID,WechatUserCode,CustomerID,OrderStatus的拼接
    if (orderData !== undefined) {
        for (var key in orderData) {
            if (orderData[key] != '') {
                //判断data[key]是否是数值类型
                if (!isNaN(orderData[key])) {
                    sql += " and " + key + " = " + orderData[key] + " ";
                } else {
                    sql += " and " + key + " = '" + orderData[key] + "' ";
                }
            }
        }
    }

    sql += ';'; //sql拼接结束

    logger.writeInfo("查询指定条件的订单商品个数,sql:" + sql);

    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            logger.writeError('数据库连接错误：' + err);
            return callback(true);
        }

        connection.query(sql, function(err, results) {
            connection.release();

            if (err) {
                logger.writeError('查询指定条件的订单个数：' + err);
                return callback(true);
            }

            return callback(false, results);
        });
    });
};

/**
 * 查询订单信息，只查询订单表
 * @param data
 * @param callback
 */
exports.queryOrders = function(data, callback) {
    var arr = new Array();

    arr.push(' select jit_order.OrderID,jit_order.OrderTime,jit_order.PayTime, ');
    arr.push(' jit_order.DeliveryTime,jit_order.PayMethod, ')
    arr.push(' jit_order.IsValid,jit_order.IsActive,jit_order.DeliveryUserID, ');
    arr.push(' jit_order.IsCancel,jit_order.CancelTime,jit_order.DiscountMoney,jit_order.DiscountType, ');
    arr.push(' jit_order.BizID,jit_order.Memo,jit_order.IsCheck,jit_order.PDate,jit_order.OrderStatus, ');
    arr.push(' jit_customer.NickName,jit_customer.Phone ');
    arr.push(' from jit_order,jit_customer,jit_ordercustomer ');
    arr.push(' where 1=1 and jit_customer.CustomerID = jit_ordercustomer.CustomerID ');
    arr.push(' and jit_order.OrderID = jit_ordercustomer.OrderID ');

    var query_sql = arr.join(' ');

    // 接收service传来的数据
    var pageManageData = data.pageManage;
    var orderData = data.order;

    // OrderID,OrderStatus,IsActive的拼接
    if (orderData !== undefined) {
        for (var key in orderData) {
            if (orderData[key] != '') {
                //判断data[key]是否是数值类型
                if (!isNaN(orderData[key])) {
                    query_sql += " and " + key + " = " + orderData[key] + " ";
                } else {
                    query_sql += " and " + key + " = '" + orderData[key] + "' ";
                }
            }
        }
    }

    query_sql += ' ORDER BY jit_order.OrderTime DESC ';

    var num = pageManageData.pageNum; //每页显示的个数
    var page = pageManageData.page || 1;
    if (pageManageData.isPaging == 0) {
        query_sql += " LIMIT " + (page - 1) * num + "," + num + " ;";
    }

    logger.writeInfo("[queryOrders func in productdal]订单查询:" + query_sql);

    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            return callback(true);
        }

        connection.query(query_sql, function(err, results) {
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
 * 查询指定条件订单的个数（只查询订单表）
 * @param data
 * @param callback
 * @constructor
 */
exports.CountOrders = function(data, callback) {
    var arr = new Array();
    arr.push(' select count(1) as num ');
    arr.push(' from jit_order,jit_customer,jit_ordercustomer ');
    arr.push(' where 1=1 and jit_customer.CustomerID = jit_ordercustomer.CustomerID ');
    arr.push(' and jit_order.OrderID = jit_ordercustomer.OrderID ');

    var sql = arr.join(' ');

    // 接收service传来的数据
    var orderData = data.order;

    // OrderID,IsActive,OrderStatus的拼接
    if (orderData !== undefined) {
        for (var key in orderData) {
            if (orderData[key] != '') {
                //判断data[key]是否是数值类型
                if (!isNaN(orderData[key])) {
                    sql += " and " + key + " = " + orderData[key] + " ";
                } else {
                    sql += " and " + key + " = '" + orderData[key] + "' ";
                }
            }
        }
    }

    sql += ';'; //sql拼接结束

    logger.writeInfo("查询指定条件的订单个数,sql:" + sql);

    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            logger.writeError('数据库连接错误：' + err);
            return callback(true);
        }

        connection.query(sql, function(err, results) {
            connection.release();

            if (err) {
                logger.writeError('查询指定条件的订单个数：' + err);
                callback(true);
                return;
            }

            return callback(false, results);
        });
    });
};

/**
 * @function: 查询是否有重复的菜单
 */

exports.checkHasRepeatOrder = function(data, callback) {
    var arr = new Array();

    arr.push("select A.OrderID , A.OrderTime , A.PayMethod , A.IsValid , A.IsActive , A.OrderStatus , B.CustomerID");
    arr.push(" , C.ProductID , C.ProductCount from jit_order A left join jit_ordercustomer B on B.OrderID = A.OrderID");
    arr.push(" left join jit_orderproduct C on A.OrderID = C.OrderID where 1=1 ");
    var query_sql = arr.join(' ');

    //订单中的order信息，包含OrderID WechatUserCode CustomerID OrderStatus IsActive
    var order = data['order']

    for (var key in order) {
        if (key == 'jit_customer.CustomerID') {
            query_sql += " and B.CustomerID = " + order[key];
        }

        if (key == 'jit_order.OrderStatus') {
            query_sql += " and A.OrderStatus = " + order[key];
        }
    }

    query_sql += ' and A.OrderTime>="' + moment().add(-1, 'minutes').format('YYYY-MM-DD HH:mm:ss') + '"';

    console.log("[查询该用户在1分钟内是否有重复未完成订单]订单查询:" + query_sql);

    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            callback(true);
            return;
        }

        connection.query(query_sql, function(err, results) {
            connection.release();
            if (err) {
                callback(true);
                return;
            }

            callback(false, results);
            return;
        });
    });

};

/**
 * 根据订单的订单号查询所订购的商品的信息
 * @param data
 * @param callback
 */
exports.queryOrderProductWechat = function(data, callback) {

    var arr = new Array();

    arr.push("select A.OrderID , A.OrderStatus , B.ProductID , B.ProductCount , C.ProductName , C.ProductPrice");
    arr.push("from jit_order A left join jit_orderproduct B on A.OrderID = B.OrderID ");
    arr.push("left join jit_product C on B.ProductID = C.ProductID where A.OrderStatus = 1 ");

    var query_sql = arr.join(' ');

    query_sql += ' and A.OrderID = ' + data.order['jit_ordercustomer.OrderID'];

    logger.writeInfo("[queryOrders func in productdal]订单查询:" + query_sql);

    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            callback(true);
            return;
        }

        connection.query(query_sql, function(err, results) {
            connection.release();
            if (err) {
                callback(true);
                return;
            }

            callback(false, results);
            return;
        });
    });

};


/**
 * function:　用户的ID来获取用户的订单信息
 * 缺陷：暂时只取其中的最新的3个
 */

exports.queryHistoryProductWechat = function(data, callback) {

    console.log(data);
    var arr = new Array();

    arr.push("select A.CustomerID , A.OrderID , B.OrderStatus , C.ProductID  , C.ProductCount , D.ProductName , D.ProductPrice");
    arr.push("from jit_ordercustomer A left join jit_order B on A.OrderID = B.OrderID ");
    arr.push("left join jit_orderproduct C on A.OrderID = C.OrderID left join jit_product D on C.ProductID = D.ProductID where B.OrderStatus = 3");
    arr.push("and A.IsActive = 1 ");

    var query_sql = arr.join(' ');

    query_sql += ' and A.CustomerID = ' + data['CustomerID'] + " order by B.OrderTime desc limit 3";

    logger.writeInfo("[queryOrders func in productdal]订单查询:" + query_sql);

    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            callback(true);
            return;
        }

        connection.query(query_sql, function(err, results) {
            connection.release();
            if (err) {
                callback(true);
                return;
            }

            callback(false, results);
            return;
        });
    });

};
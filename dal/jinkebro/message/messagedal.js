/**
 * @Author: Cecurio
 * @Date: 2017/5/18 20:06
 * @Last Modified by: Cecurio
 * @Last Modified time: 2017/5/18 20:06
 * @Function:
 */
var db_jinkebro = appRequire('db/db_jinkebro'),
    messageModel = appRequire('model/jinkebro/message/messagemodel'),
    logger = appRequire("util/loghelper").helper,
    moment = require('moment');

var getMessageByCommand = function (command,callback) {
    if (typeof command != 'string') {
        return callback(true,'传参错误!');
    }

    var querySql = "select IsActive,MessageDesc,MessageContent,MessageID,MessageCommand from jit_message" +
        " where 1=1 and jit_message.MessageCommand = '"+ command +"';";
    db_jinkebro.mysqlPool.getConnection(function(err, connection) {
        if (err) {
            logger.writeError("[staffdal]数据库连接错误：" + err);
            callback(true,'数据库连接失败！');
            return;
        }
        logger.writeInfo(querySql);
        connection.query(querySql, function(err, result) {
            connection.release();
            if (err) {
                throw err;
                callback(true,'失败！');
                return;
            }

            logger.writeInfo('成功！');
            return callback(false, result);
        });
    });
};
exports.getMessageByCommand = getMessageByCommand;

/**
 * @Author: Cecurio
 * @Date: 2017/2/18 10:25
 * @Last Modified by: Cecurio
 * @Last Modified time: 2017/2/18 10:25
 * @Function:
 */
var messageDal = appRequire('dal/jinkebro/message/messagedal'),
    messageModel = appRequire('model/jinkebro/message/messagemodel'),
    logger = appRequire("util/loghelper").helper,
    config = appRequire('config/config'),
    logModel = appRequire('model/backend/log/logmodel'),
    logService = appRequire('service/backend/log/logservice'),
    operationConfig = appRequire('config/operationconfig'),
    moment = require('moment'),
    validator = require('validator'),
    dataCheck = appRequire('util/dataverify');

delete logModel.ID;

var Message = function () {

};
/**
 *
 * @param command string
 * @param callback
 * @return {*}
 */
Message.prototype.getMessageByCommand = function (command,callback) {
    if (typeof command != 'string') {
        return callback(true,'传参错误!');
    }
    messageDal.getMessageByCommand(command, function (err, result) {
        if (err) {
            return callback(true,'查询微信信息失败！');
        }

        logger.writeInfo('in service,查询微信信息成功！');

        return callback(false, result);
    });
};

module.exports = new Message();

/**
 * @Author: Duncan
 * @Date: 2016/11/13 19:04
 * @Last Modified by: Cecurio
 * @Last Modified time: 2016/12/08 20:04
 * @Function: 角色的勾选，角色的修改
 */

var express = require('express'),
	url = require('url'),
	router = express.Router(),
	logger = appRequire('util/loghelper').helper;

//菜单业务、用户业务逻辑组件
var userRole = appRequire('service/backend/user/userroleservice'),
	menuService = appRequire('service/backend/menu/menuservice'),
	roleservice = appRequire('service/backend/role/roleservice'),
	functionConfig = appRequire('config/functionconfig'),
    userFuncService = appRequire('service/backend/user/userfuncservice'),
	userService = appRequire('service/backend/user/userservice');


/**
 * method: {post}
 * @param {int} AccountID
 * @param {Array} RoleID
 * {
 * 		Account: 1,
 * 		data: [
 *			{RoleID: 12},
 * 			{RoleID: 16}
 *    ]
 * }
 * function: 为用户插入多个角色
 */
 
router.post('/', function (req, res) {
	var functionCode = functionConfig.backendApp.userRoleManage.userRoleAdd.functionCode;
    var data = {
        userID: req.query.jitkey,
        functionCode: functionCode
    }

    userFuncService.checkUserFunc(data, function (err, results) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '查询失败，服务器出错'
            });
        }
        
        if (results == undefined && results.isSuccess) {
            res.status(400);
			return res.json({
				code: 400,
				isSuccess: false,
				msg: results.msg
            });
        }
        
        if (results !== undefined && results.isSuccess) {
           
            var userID = req.body.AccountID,
                roleData = req.body.data,
                data = ['AccountID', 'RoleID'],
                data1 = ['账户名称', '角色名称'],
                errSend = '未填: ';

            if (userID == undefined || userID.length == 0) {
                errSend += data1[0];
            }

            if (roleData == undefined || roleData.length == 0) {
                errSend += data[1];
            }

            if (errSend != '未填: ') {
                res.status(400);
                return res.json({
                    code: 400,
                    isSuccess: false,
                    msg: errSend
                });
            }

            var roleID = [],
                i = 0;

            for (i = 0; i < roleData.length; i++) {
                roleID.push(roleData[i].RoleID);
            }

            var querydata = {
                'RoleID': roleID
            }

            roleservice.queryRoleByID(querydata, function (err, results) {
                if (err) {
                    res.status(500);
                    return res.json({
                        code: 500,
                        isSuccess: false,
                        msg: '用户角色的增加失败'
                    });
                }

                var count = results[0]['count'];
                
                if (results === undefined && count != i) {
                    //数据非法，重新输入
                    res.status(400);
                    return res.json({
                        code: 400,
                        isSuccess: false,
                        msg: "角色数据有误，请重新编辑"
                    });
                }
                
                if (results !== undefined && count == i) {
                     var insertdata = {
                        'AccountID': userID,
                        'data': roleData
                    }

                    //先删除原来的角色
                    userRole.delete(insertdata, function (err, results) {
                        logger.writeInfo(results);
                        if (err) {
                            res.status(500);
                            return res.json({
                                code: 500,
                                isSuccess: false,
                                msg: '操作失败，服务器出错'
                            });
                        }

                        if (results !== undefined) {
                            //新增
                            userRole.addUserRole(insertdata, function (err, insertInfo) {
                                logger.writeInfo(insertInfo);
                                if (err) {
                                    res.status(500);
                                    return res.json({
                                        code: 500,
                                        isSuccess: false,
                                        msg: "操作失败，服务器出错"
                                    })
                                }

                                if (insertInfo !== undefined && insertInfo.insertId > 0) {
                                    var senddata = {
                                        code: 200,
                                        isSuccess: true,
                                        funcData: data.data,
                                        msg: "操作成功"
                                    };
                                    res.status(200);
                                    return res.json(senddata)
                                } else {
                                    res.status(400);
                                    return res.json({
                                        code: 400,
                                        isSuccess: false,
                                        msg: "操作失败"
                                    });
                                }
                            });
                        }
                    });
                } 
            });
        }
	});

});

router.put('/', function (req, res) {

	var functionCode = functionConfig.backendApp.userRoleManage.userRoleEdit.functionCode;
    var data = {
        userID: req.query.jitkey,
        functionCode: functionCode
    }

    userFuncService.checkUserFunc(data, function (err, results) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '查询失败，服务器出错'
            });
        }
        
        if (results == undefined && results.isSuccess) {
            res.status(400);
            return res.json({
                code: 400,
                isSuccess: false,
                msg: results.msg
            });
        }
        
        if (results !== undefined && results.isSuccess === true) {
            var data = ['ID', 'AccountID', 'RoleID'];
            var data1 =  ['角色的ID', '账户名称', '角色名称'];
            var errSend = '未填: ';
            
            for (var value in data) {
                if (!(data[value] in req.body)) {
                    
                    errSend += data1[value] + ' ';
                }
            }
           
            if (errSend != '未填: ') {
                res.status(400);
                res.json({
                    code: 400,
                    isSuccess: false,
                    msg: errSend
                });
                logger.writeError("[routes/backend/user/userroleroute]" + errSend);
                return;
            }

            var ID = req.body.ID,
                accountID = req.body.AccountID,
                roleID = req.body.RoleID;

            var updData = {
                "ID": ID,
                "AccountID": accountID,
                "RoleID": roleID
            }

            userRole.updateUserRole(updData, function (err, results) {
                if (err) {
                    res.status(500);
                    res.json(
                        {
                            code: 500,
                            isSuccess: false,
                            msg: '操作失败，服务器出错'
                        });
                    logger.writeError("[routes/backend/user/userroleroute]" + "修改信息失败，服务器出错");
                    return;
                }
                
                if (results !== undefined && results.affectedRows != 0) {
                    res.json({
                        code: 200,
                        isSuccess: true,
                        msg: "操作成功"
                    });
                    return;
                    
                } else {
                    res.status(400);
                    res.json({
                        code: 400,
                        isSuccess: false,
                        msg: "操作失败"
                    });
                    logger.writeError("[routes/backend/user/userroleroute]" + "修改信息失败");
                    return;
                }
            });
        }
	});

});



/**
 * method {get} /userrole/userID/1
 * @param {int} userID
 * function: 通过用户的ID来查询用户所在的角色
 */
router.get('/userID/:userID', function (req, res) {
	var functionCode = functionConfig.backendApp.userRoleManage.userRoleQuery.functionCode;
    var data = {
        userID: req.query.jitkey,
        functionCode: functionCode
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
        
        
        if (results == undefined && results.isSuccess) {
             res.status(400);
             return res.json({
                code: 400,
                isSuccess: false,
                msg: results.msg
            });
        }
        
        
        if (results !== undefined && results.isSuccess === true) {
            var userID = req.params.userID;
            if (userID === undefined || userID === '') {
                res.status(400);
                return res.json({
                    code: 404,
                    isSuccess: false,
                    msg: 'require userID'
                });
            }

            if (isNaN(userID)) {
                res.status(400);
                return res.json({
                    code: 400,
                    isSuccess: false,
                    msg: 'userID不是数字'
                });
            }

            var data = {
                'AccountID': userID
            };

            userRole.query(data, function (err, RoleInfo) {
                if (err) {
                    res.status(500);
                    res.json({
                        code: 500,
                        isSuccess: true,
                        msg: '查询失败'
                    });
                    console.log("查询失败");
                    logger.writeError("[routes/backend/userrole]" + "查询失败");
                    return;
                }

                if (RoleInfo != undefined && RoleInfo.length != 0) {
                    var results = {
                        code: 200,
                        isSuccess: true,
                        msg: '查询成功',
                        data: RoleInfo
                    };
                    res.status(200);
                    res.json(results);
                    return;
                    
                } else {
                    res.status(200);
                    res.json({
                        code: 200,
                        isSuccess: true,
                        msg: "未查到数据",
                        data:{}
                    });
                    logger.writeWarn("[routes/backend/user/userroleroute]" + "未查到数据");
                    return;
                }
            });
        } 
	});
});


module.exports = router;
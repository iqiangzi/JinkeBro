/**
 * @Author: snail
 * @Date:   2016-12-03
 * @Last Modified by:
 * @Last Modified time:
 * 微信相关的操作
 */

var express = require('express');
var router = express.Router();
var url = require("url");
var crypto = require("crypto");
var operateconfig = appRequire("config/operationconfig");
var logger = appRequire('util/loghelper').helper;
//用来插入到log中的
var logService = appRequire('service/backend/log/logservice');
var logModel = appRequire('model/jinkebro/log/logmodel');
var config = appRequire('config/config');
//微信接收消息通用组件（待改，这种形式不好）
var customerhtml = appRequire('views/jinkeBro/wechat/readfilecustomer');
//微信的地址栏
var wechat = appRequire("service/wechat/wechatservice");
//从微信端获取数据插入数据库
var wechatCustomer = appRequire("service/jinkebro/customer/customerservice");
var messageService = appRequire("service/jinkebro/message/messageservice");
//调用商品的模块的内容
var product = appRequire('service/jinkebro/product/productservice');
var orderService = appRequire('service/jinkebro/order/orderservice');
var productService = appRequire('service/jinkebro/product/productservice');
var async = require('async');

wechat.token = config.weChat.token;

//微信开发者认证
router.get('/accesscheck', function (req, res, next) {
    console.log("进入access_token");
    var query = url.parse(req.url, true).query;
    var signature = query.signature;
    var echostr = query.echostr;
    var timestamp = query['timestamp'];
    var nonce = query.nonce;
    var oriArray = new Array();

    oriArray[0] = nonce;
    oriArray[1] = timestamp;
    oriArray[2] = config.weChat.token;
    oriArray.sort();

    var original = oriArray.join('');
    var md5sum = crypto.createHash("sha1");
    md5sum.update(original);

    var scyptoString = md5sum.digest("hex");
    if (signature == scyptoString) {
        res.end(echostr);
    } else {
        res.end("false");
    }
});

// 监听文本消息
wechat.textMsg(function (msg) {
    console.log("进入消息");
    console.log(msg);
    switch (msg.msgType) {
        case "text":
            var contentInfo = '等待回复';
            var resMsg = {
                fromUserName: msg.toUserName,
                toUserName: msg.fromUserName,
                msgType: "text",
                content: contentInfo,
                funcFlag: 0
            };

            // 返回文本消息           
            if (/^(\d+#\d+)$/.test(msg.content) || /^((\d+#\d+\|)+(\d+#\d+))$/.test(msg.content)) {
                resMsg.content = "对不起,下单失败,请稍候重试";
                var p = new Promise(function (resolve, reject) {
                    orderService.insertOrderInfo(msg.content, msg.fromUserName, function (err, orderInfo) {
                        var result = orderInfo;
                        var sendMsg = '';

                        if (err) {
                            reject(orderInfo);
                            return;
                        }

                        if (result[0].OrderID === undefined) {
                            sendMsg = '对不起，' + result + '库存数量不足';
                        } else {
                            var totalPrice = 0;
                            sendMsg = '亲，您的订单号为：' + result[0].OrderID + '\n' + '您所订购的商品为:\n';
                            result.forEach(function (item) {
                                sendMsg += item.ProductName + ' 数量为 ' + item.ProductCount + ' \n';
                                totalPrice += item.ProductPrice * item.ProductCount;
                            });
                            sendMsg += '总共消费' + totalPrice.toFixed(2) + '元， 正在准备配送';
                        }
                        console.log(sendMsg);
                        resolve(sendMsg);
                    });
                });

                p.then(function (resultSend) {
                    console.log(1);
                    resMsg.content = resultSend;
                    wechat.sendMsg(resMsg);
                }, function (err) {
                    resMsg.content = err;
                    wechat.sendMsg(resMsg);
                });
            } else {
                var command = msg.content;
                messageService.getMessageByCommand(command,function (err,result) {
                    if (err) {
                        resMsg.content = '服务器出错了,请稍后重试!';
                        wechat.sendMsg(resMsg);
                    }

                    if (result != undefined && result instanceof Array && result.length && result.length > 0) {
                        resMsg.content = result[0].MessageContent;
                        wechat.sendMsg(resMsg);
                    } else {
                        resMsg.content = '不能识别的指令,请查看帮助,或者换个关键字试试!';
                        wechat.sendMsg(resMsg);
                    }
                });

            }

            break;

            //输入其他的文字返回的是图文的信息
            // var articles = [];
            // var picurl = "http://mmbiz.qpic.cn/mmbiz_jpg/2gG8lzb9PibsPiadjuibZ6mm";
            // picurl += "GVvqk7am7a8yqW87U3v";
            // picurl += "vm2Bo6H0PXAa8Bxm3wpIKuicpjic0ZKYVT929L85fib64lwKw/0";

            // articles[0] = {
            //     title: "零食",
            //     description: "测试描述",
            //     picUrl: picurl,
            //     url: "https://www.baidu.com/"
            // };

            // var resMsg1 = {
            //     fromUserName: msg.toUserName,
            //     toUserName: msg.fromUserName,
            //     msgType: "news",
            //     articles: articles,
            //     funcFlag: 0
            // }

            // wechat.sendNewsMsg(resMsg1);
            break;

        case "音乐":
            // 返回音乐消息
            var resMsg = {
                fromUserName: msg.toUserName,
                toUserName: msg.fromUserName,
                msgType: "music",
                title: "音乐标题",
                description: "音乐描述",
                musicUrl: "音乐url",
                HQMusicUrl: "高质量音乐url",
                funcFlag: 0
            };

            wechat.sendMsg(resMsg);
            break;

        case "图文":
            // 返回图文消息
            var articles = [];

            articles[0] = {
                title: "测试",
                description: "测试描述",
                picUrl: "http://www.baidu.com",
                url: "http://www.baidu.com"
            };

            // 返回图文消息
            var resMsg = {
                fromUserName: msg.toUserName,
                toUserName: msg.fromUserName,
                msgType: "news",
                articles: articles,
                funcFlag: 0
            };

            wechat.sendMsg(resMsg);
            break;
    }
});

// 监听图片消息
wechat.imageMsg(function (msg) {
    console.log("[routes/api/wechatroute]imageMsg received");
    console.log(JSON.stringify(msg));
    var resMsg = {};
    switch (msg.msgType) {
        case 'image':
            //返回的图片数据
            resMsg = {
                fromUserName: msg.toUserName,
                toUserName: msg.fromUserName,
                msgType: "image",
                MediaId: msg.MediaId,
                funcFlag: 1
            };
            break;
    }
    wechat.sendMsg(resMsg);
});

// 监听语音消息
wechat.voiceMsg(function (msg) {
    var resMsg = {
        fromUserName: msg.toUserName,
        toUserName: msg.fromUserName,
        msgType: "text",
        content: '该功能暂未开放!',
        funcFlag: 0
    };

    wechat.sendMsg(resMsg);
});

// 监听位置消息
wechat.locationMsg(function (msg) {
    var resMsg = {
        fromUserName: msg.toUserName,
        toUserName: msg.fromUserName,
        msgType: "text",
        content: '该功能暂未开放!',
        funcFlag: 0
    };

    wechat.sendMsg(resMsg);
});

// 监听链接消息
wechat.urlMsg(function (msg) {
    var resMsg = {
        fromUserName: msg.toUserName,
        toUserName: msg.fromUserName,
        msgType: "text",
        content: '该功能暂未开放!',
        funcFlag: 0
    };

    wechat.sendMsg(resMsg);
});

// 监听事件消息
wechat.eventMsg(function (msg) {
    console.log("eventMsg received");
    console.log(msg);

    var resMsg = {
        fromUserName: msg.ToUserName,
        toUserName: msg.FromUserName,
        msgType: "text",
        content: '',
        funcFlag: 0
    };

    //判断是否是订阅以及取消的判断条件
    switch (msg.Event) {
        //订阅的事件
        case 'subscribe':
            //当订阅时间出发的时候发送欢迎标语
            resMsg.content = "欢迎来到金科小哥\n回复[帮助],查看内容";
            wechat.sendMsg(resMsg);
            //获取token
            var identifier = operateconfig.weChat.infoManage.access_tokenGet.identifier;
            wechat.getLocalAccessToken(identifier, function (isSussess, token) {
                    //如果成功
                    if (isSussess) {
                        //用户订阅时的操作
                        wechatCustomer.addSubscibe(token, msg, function (err, errinfo) {
                            if (err) {
                                console.log(errinfo);
                                return;
                            }
                            console.log("微信添加用户成功");
                            return ;
                        });
                    }
                });

            break;

        //取消订阅
        case 'unsubscribe':
            var identifier = operateconfig.weChat.infoManage.access_tokenGet.identifier;

            wechat.getLocalAccessToken(identifier, function (isSussess, token) {
                if (isSussess) {
                    //当服务器出错的时候的补过
                    wechatCustomer.addAllList(token, function (err, errinfo) {
                        if (err) {
                            logger.writeError("[route/api/wechatroute]" + errinfo);
                            return;
                        }

                        logger.writeInfo("[route/api/wechatroute]服务器出错的时候导致漏加的用户补全");
                        return;
                    });
                }
            });

            //获取token
            wechat.getLocalAccessToken(identifier, function (isSussess, token) {
                if (isSussess) {
                    //取消时更改用户
                    wechatCustomer.unsubscribe(token, msg, function (err, errinfo) {
                        if (err) {
                            logger.writeInfo("[route/api/wechatroute]" + errinfo);
                            return;
                        }
                        logger.writeInfo("[route/api/wechatroute]取消关注成功");
                    });
                }
            });

            break;

        //发送地址
        case 'LOCATION':
            //添加地址坐标到数据库
            wechatCustomer.addLocation(msg, function (err, errinfo) {
                if (err) {
                    console.log(errinfo);
                    return;
                }
                console.log("获取地址成功");
                return;
            });

            break;

        //扫码的事件
        case 'SCAN':
            break;

        //菜单点击的事件
        case 'CLICK':
            switch (msg.EventKey) {
                case 'ProductDisplay':

                    //优化后 snail
                    var contentInfo = '商品查询失败，请稍后再试!';
                    resMsg.content = contentInfo;

                    var p = new Promise(function (resolve, reject) {
                        var queryData = {
                            page: 1,
                            pageNum: 10,
                            isPaging: 1,
                            OnSale : 1
                        };
                        product.queryProducts(queryData, function (err, returndata) {
                            if (err) {
                                reject(Error("没有数据"));
                            }

                            var filterresult = '当前没有可用商品信息，请稍候再试';

                            if (returndata !== undefined && returndata.length > 0) {

                                filterresult = '';
                                returndata.forEach(function (item) {
                                    filterresult += "编号:" + item.ProductID + " \n";
                                    filterresult += "名称:" + item.ProductName + "\n";
                                    filterresult += "价格:" + item.ProductPrice + "\n";
                                    filterresult += "规格:" + item.ProductTypeName + "\n";
                                    filterresult += "库存:" + item.TotalNum + "\n----------\n";
                                }, this);

                                filterresult += '下单输入的格式为：编号#数量|编号#数量';
                            }

                            resolve(filterresult);
                        });
                    });

                    p.then(function (result) {
                        resMsg.content = result;
                        wechat.sendMsg(resMsg);
                    }, function (err) {
                        wechat.sendMsg(resMsg);
                    });
                    break;
                case 'SubmitOrder':
                    console.log("提交订单");
                    resMsg.content = '提交订单，请输入格式为:商品id#购买数量';
                    wechat.sendMsg(resMsg);
                    break;
                case 'TrackPackage':
                    console.log("跟踪包裹");
                    resMsg.content = '正在开发中,请稍候再试';
                    wechat.sendMsg(resMsg);
                    break;
                case 'OrderHistory':
                    resMsg.content = '正在开发中,请稍候再试';
                    wechat.sendMsg(resMsg);
                    break;
            }
            break;

        //菜单的链接的事件
        case 'VIEW':

            switch (msg.EventKey) {

                case config.jinkebro.baseUrl + 'wechat/addressinfo':
                    wechat.sendClickAddressEvent(msg);
                    break;
                case config.jinkebro.baseUrl + 'wechatshowpersonalorder':
                    console.log("点击了订单展示的页面!");
                    console.log(msg.FromUserName);
                    msg.EventKey = msg.EventKey + "?openid=" + msg.FromUserName;
                    break;
                case 'http://www.baidu.com':
                    console.log("点击了百度的页面");
                    break;
            }
            break;
    }
});

//监听地址的事件
wechat.clickAddress(function (judgement, username) {

    if (judgement != undefined && judgement == 'true') {
        var tempRoute = '/' + username;
        console.log(tempRoute)
        router.get(tempRoute, function (req, res) {
            customerhtml(res);
        });
        return;
    }
});

/************************************************************************************/
//渲染地址栏的页面//待改
router.get('/addressinfo', function (req, res) {
    var addressurl = config.jinkebro.baseUrl + 'wechat/' + wechat.data.FromUserName;
    console.log(addressurl);
    //路由的重定义
    console.log(addressurl);
    res.redirect(301, addressurl);
});

/************************************************************************************/

var openid = '';
/**
 * 与微信接口的统一入口（消息转发）
 */
router.post('/accesscheck', function (req, res) {
    console.log("最先经过accesscheck,下面打印:")
    console.log("url: " + req.url);
    console.log("req.query: " + req.query.openid);
    console.log("method: " + req.method);
    openid = req.query.openid;
    console.log(openid);
    wechat.handleWechatMsg(req, res);
});

/** --------------微信端获取数据的接口 开始-------------**/

//微信页面调用的插入订单的接口
router.post('/addOrder', function (req, res) {
    console.log(req.url);
    var formdata = req.body.formdata;
    var orderProducts = formdata.orderProduct;
    //var fromUserName = formdata.wechatUserCode;
    var fromUserName = openid || formdata.wechatUserCode;
    var submitMsg = '';

    for (var i = 0; i < orderProducts.length; ++i) {
        if (i > 0) {
            submitMsg += '|' + orderProducts[i].ProductID + '#' + orderProducts[i].OrderCount;
        } else {
            submitMsg += orderProducts[i].ProductID + '#' + orderProducts[i].OrderCount;
        }

    }

    console.log(submitMsg);
    console.log(fromUserName);

    if (!/^(\d+#\d+)$/.test(submitMsg) && !/^((\d+#\d+\|)+(\d+#\d+))$/.test(submitMsg)) {
        res.status(400);
        return res.json({
            code: 400,
            isSuccess: false,
            msg: '数据格式有误,请检查!'
        });
    }

    orderService.insertOrderInfo(submitMsg, fromUserName, function (err, orderInfo) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: '服务器内部错误,请稍后重试!'
            });
        }
        console.log(orderInfo);
        if (orderInfo && orderInfo[0].OrderID) {
            res.status(200);
            return res.json({
                code: 200,
                isSuccess: true,
                msg: '下单成功,您的订单号为:' + orderInfo[0].OrderID,
                data: orderInfo
            });
        } else {
            res.status(404);
            return res.json({
                code: 404,
                isSuccess: false,
                msg: '下单失败,请稍后重试!'
            });
        }
    });
});

router.get('/order', function (req, res) {
    var f = JSON.parse(req.query.f);
    //接收前端数据
    var page = (req.query.pageindex || req.query.pageindex) ? (req.query.pageindex || req.query.pageindex) : 1,
        pageNum = (req.query.pagesize || req.query.pagesize) ? (req.query.pagesize || req.query.pagesize) : 20,
        OrderID = f.OrderID || '',
        WechatUserCode = openid || f.WechatUserCode || '',
        isPaging = (req.query.isPaging != undefined) ? (req.query.isPaging) : 1, //是否分页 0表示不分页,1表示分页
        CustomerID = f.CustomerID || '';

    page = page > 0 ? page : 1;

    if (pageNum == '') {
        pageNum = config.pageCount;
    }

    //用于查询结果总数的计数
    var countNum = 0;

    // 传到dal的数据
    var sendData = {
        page: page,
        pageNum: pageNum,
        isPaging: isPaging,
        OrderID: OrderID,
        WechatUserCode: WechatUserCode,
        CustomerID: CustomerID
    };

    orderService.CountOrders(sendData, function (err, results) {
        if (err) {
            res.status(500);
            return res.json({
                code: 500,
                isSuccess: false,
                msg: "查询失败，服务器内部错误"
            });
        }

        if (results == undefined || results.length == 0 || results[0]['num'] <= 0) {
            res.status(404);
            return res.json({
                code: 404,
                isSuccess: false,
                msg: "未查询到相应订单"
            });
        }

        countNum = results[0]['num'];

        //所有的订单数据 result
        orderService.queryOrders(sendData, function (err, result) {
            if (err) {
                res.status(500);
                return res.json({
                    code: 500,
                    isSuccess: false,
                    msg: "查询失败，服务器内部错误"
                });
            }

            if (result == undefined || result.length == 0) {
                res.status(404);
                return res.json({
                    code: 404,
                    isSuccess: false,
                    msg: "未查询到相应订单"
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
            //执行顺序1
            var queueAllResult = [];
            var flag = 0;
            // 去计算价格
            async.map(result, function (item, callback) {
                var tempOrderID = item.OrderID;
                orderService.queryOrderProduct({ "OrderID": tempOrderID }, function (err, tags) {
                    var tempSumOfMoney = 0;
                    var productArr = [];
                    for (var i = 0; i < tags.length; i++) {
                        tempSumOfMoney += tags[i].ProductPrice * tags[i].ProductCount;
                        productArr.push({
                            ProductName : tags[i].ProductName,
                            ProductPrice : tags[i].ProductPrice,
                            ProductCount : tags[i].ProductCount,
                            totalMoney : tags[i].ProductPrice * tags[i].ProductCount
                        });
                    }
                    item['productInfo'] = productArr;
                    item['totalMoney'] = tempSumOfMoney.toFixed(2);
                    callback(null, item);
                })
            }, function (err, results1) {
                // !!!!!! 在此res.status() 、 res.json()  !!!!!!
                //执行顺序2
                for (var i = 0; i < results1.length; i++) {
                    queueAllResult[i] = results1[i];
                    if (i == results1.length - 1) {
                        flag = 1;
                    }
                }

                if (flag == 1) {
                    res.status(200);
                    return res.json(resultBack);
                }
            });
        });
    });
});

/** --------------微信端获取数据的接口 结束-------------**/


module.exports = router;

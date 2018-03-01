/**
 * @Author: snail
 * @Date: 2016-12-13
 * @Function:
 * 这里作为OperationLog的动作配置
 * identifier设置的数值，按照每个应用递增1000开始，也就是说每次新增第n个应用，第一个identifier=n*1000+1
 * 原则上只在记录operationlog方法中作为其参数使用
 */

var operationConfig = {
    operationType: {
        error: 1, //异常
        operation: 2 //操作
    },
    backendApp: {
        applicationID: 1, //应用的唯一id
        applicationName: "基础模块", //应用的名称
        //模块
        userManage: {
            module: "用户模块",
            //改模块下对应的功能
            userAdd: {
                actionName: "用户新增",
                identifier: 1
            },
            userDel: {
                actionName: "用户删除",
                identifier: 2
            },
            userSingleQuery: {
                actionName: "用户单个查询",
                identifier: 3
            },
            userMultiQuery: {
                actionName: "用户批量查询",
                identifier: 4
            },
            userroleAdd: {
                actionName: "用户角色新增",
                identifier: 5
            },
            userroleQuery: {
                actionName: "用户角色的查询",
                identifier: 6
            },
            userroleUpd: {
                actionName: "用户角色的修改",
                identifier: 7
            },
            userroleDel :{
                actionName: "用户角色的删除",
                identifier: 8
            }

        },
        roleManage: {
            module: "角色模块",
            roleAdd: {
                actionName: "角色新增",
                identifier: 101
            },
            roleDel: {
                actionName: "角色删除",
                identifier: 102
            },
            roleSingleQuery: {
                actionName: "角色单个查询",
                identifier: 103
            },
            roleMultiQuery: {
                actionName: "角色批量查询",
                identifier: 104
            },
            roleUpdate: {
                actionName: "角色修改",
                identifier: 105
            },
            roleFuncAdd: {
                actionName: "角色功能点新增",
                identifier: 106
            },
            roleFuncDel: {
                actionName: "角色功能点删除",
                identifier: 107
            },
            roleFuncQuery: {
                actionName: "角色功能点查询",
                identifier: 108
            },
        },
        memuManage: {
            module: "菜单模块",
            menuAdd: {
                actionName: "菜单新增",
                identifier: 1201
            },
            menuDel: {
                actionName: "菜单删除",
                identifier: 1202
            },
            menuUpd: {
                actionName: "菜单修改",
                identifier: 1203
            },
            menuSingleQuery: {
                actionName: "菜单单个查询",
                identifier: 1204
            },
            menuMultiQuery: {
                actionName: "菜单批量查询",
                identifier: 1205
            },
            menuTreeQueryByjitkey: {
                actionName: "通过jitkey查询菜单",
                identifier: 1206
            },
            menuCount: {
                actionName: "查看满足指定条件的菜单个数！",
                identifier: 1207
            }
        },
        appManage: {
            module: "应用模块",
            appAdd: {
                actionName: "应用新增",
                identifier: 1301
            },
            appDel: {
                actionName: "应用删除",
                identifier: 1302
            },
            appUpd: {
                actionName: "应用修改",
                identifier: 1303
            },
            appSingleQuery: {
                actionName: "应用单个查询",
                identifier: 1304
            },
            appMultiQuery: {
                actionName: "应用批量查询",
                identifier: 1305
            }
        },
        operationManage: {
            module: "日志模块",
            opertaionAdd: {
                actionName: "日志新增",
                identifier: 1401
            },
            opertaionDel: {
                actionName: "日志删除",
                identifier: 1402
            },
            opertaionUpd: {
                actionName: "日志修改",
                identifier: 1403
            },
            opertaionQuery: {
                actionName: "日志查询",
                identifier: 1404
            }
        },
    },
    jinkeBroApp: {
        applicationID: 2,
        applicationName: "金科小哥",
        customerManage: {
            module: "客户模块",
            customerAdd: {
                actionName: "客户新增",
                identifier: 2001
            },
            customerUpd: {
                actionName: '客户修改',
                identifier: 2002
            },
            customerQuery: {
                actionName: '客户的查询',
                identifier: 2003
            }
        },
        orderManger: {
            module: "订单模块",
            orderAdd: {
                actionName: "订单的新增",
                identifier: 2101
            },
            orderUpd: {
                actionName: "订单的更新",
                identifier: 2102
            },
            orderDel: {
                actionName: "订单的删除",
                identifier: 2103
            },
            orderQuery: {
                actionName: "订单的查询",
                identifier: 2104
            },
            orderQueryCount: {
                actionName: "查询满足相应条件的订单的个数",
                identifier: 2105
            }
        },
        orderDelivery: {
            module: "订单配送情况的模块",
            orderdeliveryAdd: {
                actionName: "配送情况单的新增",
                identifier: 2201
            },
            orderdeliveryUpd: {
                actionName: "配送情况单的更新",
                identifier: 2202
            },
            orderdeliveryDel: {
                actionName: "配送情况单的删除",
                identifier: 2203
            },
            orderdeliveryQuery: {
                actionName: "配送员情况单的查询",
                identifier: 2204
            }
        },
        orderProduct: {
            module: "订单商品情况的模块",
            orderProductAdd: {
                actionName: "配送商品情况的新增",
                identifier: 2301
            },
            orderProductUpd: {
                actionName: "配送商品情况的更新",
                identifier: 2302
            },
            orderProductDel: {
                actionName: "配送商品情况的删除",
                identifier: 2303
            },
            orderProductQuery: {
                actionName: "配送员商品情况的查询",
                identifier: 2304
            }
        },
        product: {
            module: "商品模块",
            productAdd: {
                actionName: "商品新增",
                identifier: 2401
            },
            productUpd: {
                actionName: "商品更新",
                identifier: 2402
            },
            productDel: {
                actionName: "商品删除",
                identifier: 2403
            },
            productQuery: {
                actionName: "商品查询",
                identifier: 2304
            }
        },
        productStock: {
            module: "商品库存模块",
            productStockAdd: {
                actionName: "商品库存新增",
                identifier: 2501
            },
            productStockUpd: {
                actionName: "商品库存更新",
                identifier: 2502
            },
            productStockDel: {
                actionName: "商品库存删除",
                identifier: 2503
            },
            productStockQuery: {
                actionName: "商品库存查询",
                identifier: 2504
            }
        },
        productType: {
            module: "商品种类模块",
            productTypeAdd: {
                actionName: "商品种类新增",
                identifier: 2601
            },
            productTypeUpd: {
                actionName: "商品种类更新",
                identifier: 2602
            },
            productTypeDel: {
                actionName: "商品种类删除",
                identifier: 2603
            },
            productTypeQuery: {
                actionName: "商品种类查询",
                identifier: 2604
            },
        },
        staff : {
            module: "员工模块",
            staffAdd: {
                actionName: "员工新增",
                identifier: 2701
            },
            staffUpd: {
                actionName: "员工更新",
                identifier: 2702
            },
            staffDel: {
                actionName: "员工删除",
                identifier: 2703
            },
            staffQuery: {
                actionName: "员工查询",
                identifier: 2704
            },
            staffTypeQuery: {
                actionName: "员工类型查询",
                identifier: 2705
            }
        }
    },
    sfmsApp: {
        applicationID: 3,
        applicationName: "基础模块",
        projectManage: {
            module: "项目模块",
            projectAdd: {
                actionName: "项目新增",
                identifier: 3001
            },
            projectUpdete: {
                actionName: "项目编辑",
                identifier: 3002
            },
            projectQuery: {
                actionName: "项目查询",
                identifier: 3003
            },
            projectDelete: {
                actionName: "项目删除",
                identifier: 3004
            },
            projectUserAdd: {
                actionName: "项目人员新增",
                identifier: 3005
            },
            projectUserUpdate: {
                actionName: "项目人员编辑",
                identifier: 3006
            },
            projectUserQuery: {
                actionName: "项目人员查询",
                identifier: 3007
            },
            projectUserDelete: {
                actionName: "项目人员删除",
                identifier: 3008
            },
            projectRemarkAdd: {
                actionName: "项目备注新增",
                identifier: 3009
            },
            projectRemarkQuery: {
                actionName: "项目备注查询",
                identifier: 3010
            },
            projectRemarkUpdate: {
                actionName: "项目备注修改",
                identifier: 3011
            },
            projectRemarkDelete: {
                actionName: "项目备注删除",
                identifier: 3012
            },
        },
        financeManage: {
            module: "财务模块",
            financeAdd: {
                actionName: "财务新增",
                identifier: 3101
            },
            financeUpdete: {
                actionName: "财务编辑",
                identifier: 3102
            },
            financeSingleQuery: {
                actionName: "财务单个查询",
                identifier: 3103
            },
            financeMultiQuery: {
                actionName: "财务批量查询",
                identifier: 3104
            },
            financeDelete: {
                actionName: "财务删除",
                identifier: 3105
            },
            financeCheck: {
                actionName: "财务审核",
                identifier: 3106
            },
            financeCount: {
                actionName: "财务统计",
                identifier: 3107
            },
        },
        KPIManage: {
            module: "绩效模块",
            KPIAdd: {
                actionName: "绩效新增",
                identifier: 3201
            },
            KPIUpdete: {
                actionName: "绩效编辑",
                identifier: 3202
            },
            KPISingleQuery: {
                actionName: "绩效单个查询",
                identifier: 3203
            },
            KPIMultiQuery: {
                actionName: "绩效批量查询",
                identifier: 3204
            },
            KPIDelete: {
                actionName: "绩效删除",
                identifier: 3205
            },
            KPICheck: {
                actionName: "绩效审核",
                identifier: 3206
            },
            KPICount: {
                actionName: "绩效统计",
                identifier: 3207
            },
        },
        SignManage: {
            module: "签到模块",
            SignIn: {
                actionName: "签到",
                identifier: 3301
            },
            SignOut: {
                actionName: "签出",
                identifier: 3302
            },
            SignQuery: {
                actionName: "签到查询",
                identifier: 3303
            },
            SignCount: {
                actionName: "签到统计",
                identifier: 3304
            },
        },
        MessageManage: {
            module: "通知模块",
            MessageQuery: {
                actionName: "通知查看",
                identifier: 3401
            },
            MessageManage: {
                actionName: "通知管理",
                identifier: 3402
            },
            MessageAdd: {
                actionName: "通知新增",
                identifier: 3403
            },
            MessageEdit: {
                actionName: "通知编辑",
                identifier: 3404
            },
            MessageReuse: {
                actionName: "通知启用",
                identifier: 3405
            },
            MessageForbid: {
                actionName: "通知禁用",
                identifier: 3406
            },
        },
    },
    weChat: {
        applicationID: 4,
        applicationName: "微信端",
        infoManage: {
            module: "获取信息模块",
            access_tokenGet: {
                actionName: "获取token",
                identifier: 4001
            },
            customerInfo: {
                actionName: "消费者信息获取",
                identifier: 4002
            },
            customerList: {
                actionName: "消费者列表的获取",
                identifier: 4003
            },
            customerNextList: {
                actionName: "指定消费者列表的获取",
                identifier: 4004
            }
        }
    }
};


module.exports = operationConfig;
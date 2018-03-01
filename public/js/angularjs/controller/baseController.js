/**
 * Created by Administrator on 2016/12/14.
 */
myApp.controller('baseController', function($scope, $http,$q,baseService,$location) {
    //显示左侧菜单栏
    $scope.menus =baseService.InitMenu().then(function(response){
        $scope.menus = response.data.data.Menu;
    });

    //登录用户的个人信息
    $scope.loginUserInfo = baseService.getLoginUserInfo().then(function(response){
        $scope.loginUserInfo = response.data.data[0];
        console.log($scope.loginUserInfo)
    });
    
    //跳转到个人资料界面
     $scope.turn = function(){
        location.href = './index#/backend/peredit';
    };

    //返回首页
     $scope.back = function(){
        localStorage.clear();
        location.href ='.';   
    };

//------所有模块------
    //分页初始化数据
    $scope.paginationConf = {
        currentPage: 1,
        itemsPerPage: 10,
        action: ""
    };

    $scope.pageInit = function () {
        $scope.paginationConf.currentPage = 1;
        $scope.paginationConf.itemsPerPage = 10;
        $scope.f = {};
    };

    //首页 数据显示
    $scope.f={};
    function getInit(){
        if($scope.paginationConf&&$scope.paginationConf.action&&$scope.paginationConf.action!="") {
            $http({
                method: 'get',
                url: $scope.paginationConf.action + "?access_token=" + localStorage.getItem('jit_token') + "&jitkey=" + localStorage.getItem('jit_key'),
                params: {
                    pageindex: $scope.paginationConf.currentPage,
                    pagesize: $scope.paginationConf.itemsPerPage,
                    f: $scope.f
                }
            }).success(function (response) {
                $scope.datas = response.data;
                $scope.paginationConf.totalItems = response.dataNum;
                if(!response.isSuccess){
                    alert(response.msg);
                };
            }).error(function (response) {
                alert(response.msg);
            });
        }
    }
    $scope.paginationConf = {
        currentPage: 1,
        itemsPerPage: 10
    }
    $scope.$watch( 'paginationConf.currentPage+paginationConf.itemsPerPage',getInit);
    $scope.$watch( 'paginationConf.action',getInit);
    
    //首页 查询
    $scope.search=function(){
        $scope.paginationConf.currentPage = 1;
        getInit();
        $scope.formdata={};
    };
   
     //首页 启用
    $scope.restart = function (index,a,action) {
        var mymessage=confirm("是否确认启用  "+a);
        if(mymessage==true){
            var formdata=$scope.datas[index];
            formdata.IsActive = 1;
            $http({
                method:'put',
                url:action+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
                data: {
                    formdata:formdata
                }
            }).
            success(function(response) {
                alert(response.msg)
                if(response.isSuccess === true) {
                    $scope.datas[index].IsActive = 1;
                }
            }).
            error(function(response) {
                alert(response.msg)
            });
        }else{

        }

    };
    //首页 禁用
    $scope.d={};
    $scope.remove = function(index,a,action){
        var mymessage=confirm("是否确认禁用  "+a);
        if(mymessage==true){
            $scope.d={
                "AccountID":$scope.datas[index].AccountID,
                "MenuID":$scope.datas[index].MenuID,
                "ID":$scope.datas[index].ID,
                "RoleID" : $scope.datas[index].RoleID,
                "StaffID": $scope.datas[index].StaffID,
                "ProductID" : $scope.datas[index].ProductID
            };
            $http({
                method:'delete',
                url:action+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
                params:{
                    d:$scope.d
                }
            }).
            success(function(response) {
                alert(response.msg)
                if(response.isSuccess === true) {
                    $scope.datas[index].IsActive = 0;
                }
            }).
            error(function(response) {
                alert(response.msg)
            });
        }else{

        }
    };

    $scope.kpiMaterialID = 0;
    $scope.files = [];
    function initPicture() {
        $scope.files = [];
        $http({
            method: 'get',
            url: '/sfms/api/kpi/file' + "?access_token=" + localStorage.getItem('jit_token') + "&jitkey=" + localStorage.getItem('jit_key'),
            params: {
                ID: $scope.kpiMaterialID
            }
        }).success(function (response) {
            // console.log(response);
            if(response.isSuccess) {
                for( var i in response.data)
                {
                    $scope.files.push( {
                        'url': response.data[i].fileUrl,
                        'fileName': response.data[i].fileName,
                        'size': bytesToSize(response.data[i].size)
                    })
                }
            }
        }).error(function (response) {

        });
    }

    $scope.removeFile = function (item, file) {
        var mymessage = confirm("是否确认删除此项");
        if (mymessage) {
            $http({
                method: 'delete',
                url: '/sfms/api/kpi/file' + "?access_token=" + localStorage.getItem('jit_token') + "&jitkey=" + localStorage.getItem('jit_key'),
                params: {
                    fileName:file
                }
            }).success(function (response) {
                // $scope.files.splice(item.$index, 1);
                initPicture();
                alert(response.msg);

            }).error(function (response) {
                initPicture();
                alert(response.msg);
            });

        }
    };

    //更改文件大小变量
    function bytesToSize(bytes) {
        if (bytes === 0) return '0 B';
        var k = 1000, // or 1024
            sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
            i = Math.floor(Math.log(bytes) / Math.log(k));

        return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
    }

    $scope.getID = function (ID) {
        $scope.kpiMaterialID = ID;
        // console.log($scope.kpiMaterialID);
        initPicture();
    };

    $scope.fileUrl = '';
    $scope.fileName = '';
    $scope.showPic = function (name,url) {
        $scope.fileUrl = url;
        $scope.fileName = name;
    };


    //新增页面  添加
    $scope.formdata={};
    $scope.addnew = function(formdata,action) {
        // console.log($scope.formdata)
        $http({
            method:'post',
            url:action+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            data:{
                formdata:$scope.formdata
            }
        }).
        success(function(response) {
            alert(response.msg);
        }).
        error(function(response) {         
            alert(response.msg);
        });
    };

    //编辑页面   确认修改
    var formdata=$scope.paginationConf.formdata={};
    $scope.newedit = function(formdata,action) {
        $http({
            method:'put',
            url:action+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            data:{
                formdata:$scope.paginationConf.formdata
            }
        }).
        success(function(response) {
            alert(response.msg)  
        }).
        error(function(response) {
            alert(response.msg);
        });
    };


    //获取编辑信息
    $scope.show=function(index,action){
         console.log(index);
        console.log(action);
        $http({
            method:'get',
            url:action+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            params:{
                f:{
                    MenuID:index,
                    RoleID:index,
                    ID:index,
                    AccountID:index
                }
            }
        }).
        success(function(response) {
            if(!response.isSuccess){
                alert(response.msg);
            };
        }).
        error(function(response) {
            alert(response.msg);
        });
    };
    

//------基础模块------
    //用户管理--首页  更多
    $scope.moreuser = function(index,action){
        $scope.f={
            "userID":$scope.datas[index].AccountID,
        };
        $http({
            method:'get',
            url:action+$scope.f.userID+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
        }).
        success(function(response) {
            $scope.dataRole = response.data;
            if(!response.isSuccess){
                alert(response.msg);
            };
        }).
        error(function(response) {
             alert(response.msg);
        });
    }

    //角色管理--首页 更多
    $scope.morerole = function(index,action){
        $http({
            method:'get',
            url:action+$scope.datas[index].RoleID+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
        }).
        success(function(response) {
            $scope.data = response.data;
            if(!response.isSuccess){
                alert(response.msg);
            };
        }).
        error(function(response) {
             alert(response.msg);
        });
    }


//------实验室管理系统------
    //签到管理--首页  更多
    $scope.moresign = function(index,page,action){
        $scope.f={
            "userID":index,
        };
        $scope.jumpPageNum = page;
        $scope.currentPage = page;
        
        $http({
            method:'get',
            url:action+$scope.f.userID+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            params:{
                pageindex: $scope.jumpPageNum,
                pagesize: 10,
                f:{
                    MenuID:index,
                    RoleID:index,
                    ID:index,
                    AccountID:index,
                }
            }
        }).
        success(function(response) {
            $scope.data = response.data;
            $scope.numberOfPages = response.totalPage; 

            console.log('当前页数'+$scope.currentPage);                      
            console.log('总计页数'+$scope.numberOfPages);   
            console.log(response);  

            $scope.length = response.dataNum;
                  
            $scope.pageList = [];
            
            if($scope.numberOfPages <= 7){
                // 判断总页数如果小于等于7，若小于则直接显示
                for(i =1; i <= $scope.numberOfPages; i++){
                        $scope.pageList.push(i);
                    }
            }else{
                // 总页数大于7（此时分为三种情况：1.左边没有...2.右边没有...3.左右都有...）
                // 计算中心偏移量
                var a = $scope.currentPage + 2;
                console.log('最大页数'+a); 
                console.log('当前页数'+ $scope.currentPage);                        
                if(($scope.currentPage-2) <= 1){
                    // 左边没有...
                    for(i =1; i <= 5; i++){
                        $scope.pageList.push(i);
                        console.log($scope.pageList);
                    }
                    $scope.pageList.push('...');
                    $scope.pageList.push($scope.numberOfPages);
                }else if(($scope.currentPage + 2) >= $scope.numberOfPages){//右边没有
                    var a = $scope.currentPage + 2;                      
                    $scope.pageList.push(1);
                    $scope.pageList.push('...');
                    console.log($scope.pageList);
                    for(i = 3; i >= 1; i--){
                        $scope.pageList.push($scope.numberOfPages - i);
                        console.log($scope.pageList);
                    }
                    $scope.pageList.push($scope.numberOfPages);
                }else{
                    // 最后一种情况，两边都有...
                    $scope.pageList.push(1);
                    $scope.pageList.push('...');

                    for(i = 1 ; i >= 1; i--){
                        $scope.pageList.push($scope.currentPage - i);
                    }
                    $scope.pageList.push($scope.currentPage);
                    for(i = 1; i <= 1; i++){
                        $scope.pageList.push($scope.currentPage + i);
                    }

                    $scope.pageList.push('...');
                    $scope.pageList.push($scope.numberOfPages);
                }
            }

                       
        }).
        error(function(response) {
          
        });
        //页数点击按钮
        $scope.pageChanged = function(n) {
            page = n.item;
            $scope.moresign(index,page,'/sfms/api/sign/')   
        }
        //页数输入按钮
        $scope.jumpToPage = function(m){
            $scope.moresign(index,m.jumpPageNum,'/sfms/api/sign/')          
        };
        //下一页
        $scope.nextPage = function(){
            if(page<$scope.pageList.length){
                page = page+1;
                $scope.moresign(index,page,'/sfms/api/sign/')
            }                      
        };
        //上一页
        $scope.prevPage = function(m){
           if(page>1){
                page = page-1;
                $scope.moresign(index,page,'/sfms/api/sign/')
            }     
        };    
  
    };

    $scope.signCountPerson = function (action) {
        $http({
            method:'get',
            url:action+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            params:{
                f:$scope.f
            }
        }).
        success(function(response) {
            $scope.data = response.data;
            if(!response.isSuccess){
                alert(response.msg);
            };
        }).
        error(function(response) {
            alert(response.msg);
        });
    };

    //项目管理--首页 更多
    $scope.moreproject = function(index,action){
            $scope.f={
                "projectID":$scope.datas[index].ID,
            };
            $http({
                method:'get',
                url:action+$scope.f.projectID+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            }).
            success(function(response) {
                $scope.data = response.data;
                if(!response.isSuccess){
                  alert(response.msg);
                };
            }).
            error(function(response) {
                 alert(response.msg);
            });
        };

   

    //查询列表点击表头排序
    $scope.logSort = function (sortindex) {
        var allArrow = document.getElementsByClassName("arrow");
        for(var i = 0;i < allArrow.length;i++){
            allArrow[i].style.display = 'none';
        }      
        var thisArrow = document.getElementById(sortindex).getElementsByClassName("arrow"); 

        if ($scope.f.sortindex == sortindex) {
            $scope.f.sortDirection = $scope.f.sortDirection == 'asc' ? 'desc' : 'asc';
        } else {
            $scope.f.sortDirection = 'asc';
        } 

        if($scope.f.sortDirection == 'desc'){             
           thisArrow[1].style.display = 'block';
        }else{           
           thisArrow[0].style.display = 'block';
        }   
        $scope.f.sortindex = sortindex;
        getInit();
    };

    //绩效统计--首页 更多
    $scope.moreKPI = function(index,page,f,action){
        $scope.f={
            "UserID":$scope.datas[index].userID,
            "StartTime":f.startTime,
            "EndTime":f.endTime,
            'KPIStatus': '通过',
            'IsActive':1
        };
        $scope.jumpPageNum = page;
        $scope.currentPage = page;
        $http({
            method:'get',
            params:{
                pageindex: $scope.jumpPageNum,
                pagesize: 10,
                f:$scope.f
            },
            url:action+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
        }).
        success(function(response) {
            $scope.data = response.data;
            $scope.f = {};
            if(!response.isSuccess){
                alert(response.msg);
            };
        }).
        error(function(response) {
            alert(response.msg);
        });
    };

    //通知新增
    $scope.addMessage = function(){
        $scope.formdata= {
            "MessageTitle" : $scope.formdata.MessageTitle,
            "MessageContent" : $scope.formdata.MessageContent,
        }
        $http({
            method:'post',
            url: "/sfms/api/message"+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            data:{
                formdata : $scope.formdata
            }
        }).
        success(function(response) {
            alert(response.msg)
        }).
        error(function(response) {
            alert(response.msg);
        });
    };

    //通知新增
    $scope.updateMessage = function(){
        $scope.formdata= {
            "ID": $scope.formdata.ID,
            "MessageTitle" : $scope.formdata.MessageTitle,
            "MessageContent" : $scope.formdata.MessageContent
        }
        $http({
            method:'put',
            url: "/sfms/api/message"+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            data:{
                formdata : $scope.formdata
            }
        }).
        success(function(response) {
            alert(response.msg)
        }).
        error(function(response) {
            alert(response.msg);
        });
    };

    //通知新增
    $scope.getMessage = function(ID, action){
        $http({
            method: 'get',
            url: '/sfms/api/message' + "?access_token=" + localStorage.getItem('jit_token') + "&jitkey=" + localStorage.getItem('jit_key'),
            params: {
                f: {
                    ID: ID
                }
            }
        }).success(function (response) {
            $scope.formdata = response.data[0];
            if (!response.isSuccess) {
                alert(response.msg);
            }
        }).error(function (response) {
            alert(response.msg);
        });
    };

    $scope.initForm = function () {
        $scope.formdata = {};
        getInit();
    };

    $scope.excel = function(action) {
        var url = action+'?' ;

        var excelData = $scope.f;

        if(excelData.startTime) {
            var date = excelData.startTime;
            date = date.toJSON();
            url += "startTime="+ date + "&";
        }

        if(excelData.endTime) {
            var date = excelData.endTime;
            date = date.toJSON();
            url += "endTime=" + date + "&";
        }

        if(excelData.startTime && excelData.endTime) {
            if(excelData.startTime > excelData.endTime) {
                alert("结束时间不能比起始时间早！");
                return;
            }
        }

        if(excelData.isActive) url += "isActive=" + excelData.isActive + "&";

        if($scope.f.StockAreaID) url += "StockAreaID=" + $scope.f.StockAreaID + "&";

        url += "access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key');
        console.info(url);
        location.href = url;   //这里不能使用get方法跳转，否则下载不成功
    };

        
    // }
//------金科小哥------
    //订单管理--首页  模态框
     //修改
    $scope.jitOrderEdit = function (OrderID, OrderStatus, OrderStatusDesc) {
        $scope.order = {
            'OrderID': OrderID,
            'OrderStatus': OrderStatus,
            'OrderStatusDesc': OrderStatusDesc
        }
        $http({
            method: 'get',
            url: '/datadict/plain' + "?access_token=" + localStorage.getItem('jit_token') + "&jitkey=" + localStorage.getItem('jit_key'),
            params: {
                f: {
                    Category: "dc_orderstatus"
                }
            }
        }).success(function (response) {
            $scope.orderStatus = response.data;
            if (!response.isSuccess) {
                alert(response.msg);
            }
            ;
        }).error(function (response) {
            alert(response.msg);
        });
    }
    //确认修改
    $scope.saveOrderEdit = function () {
        $scope.formdata = {
            "OrderID": $scope.order.OrderID,
            "OrderStatus": parseInt($scope.order.OrderStatus),
        }
        $http({
            method: 'put',
            url: "jinkeBro/order" + "?access_token=" + localStorage.getItem('jit_token') + "&jitkey=" + localStorage.getItem('jit_key'),
            data: {
                formdata: $scope.formdata
            }
        }).success(function (response) {
            if (response.isSuccess) {
                alert(response.msg);
                location.reload();
            } else {
                alert(response.msg);
            }

        }).error(function (response) {
            alert(response.msg);
        });
    }
    // //订单状态修改
    // $scope.orderStatusChanged = function () {
    //     console.log($scope.formdata.CollegeID)
    //     $http({
    //         method: 'get',
    //         url: '/datadict/plain' + "?access_token=" + localStorage.getItem('jit_token') + "&jitkey=" + localStorage.getItem('jit_key'),
    //         params: {
    //             isPaging: 1,
    //             pageindex: 1,
    //             pagesize: 10,
    //             f: {
    //                 Category: "dc_cls",
    //             }
    //         }
    //     }).success(function (response) {
    //         $scope.cls = response.data;
    //         if (!response.isSuccess) {
    //             alert(response.msg);
    //         }
    //         ;
    //     }).error(function (response) {
    //         alert(response.msg);
    //     });
    // }


    //分配
    $scope.Allocate = function (OrderID) {
        $scope.orderDelivery = {
            'OrderID': OrderID
        };

        $http({
            method: 'get',
            url: '/jinkeBro/staff' + "?access_token=" + localStorage.getItem('jit_token') + "&jitkey=" + localStorage.getItem('jit_key'),
            params: {
                f: {
                    StaffType : 2
                }
            }
        }).success(function (response) {
            $scope.orderDeliverys = response.data;
            if (!response.isSuccess) {
                alert(response.msg);
            }

        }).error(function (response) {
            alert(response.msg);
        });

        $http({
            method: 'get',
            url: '/jinkeBro/orderDelivery' + "?access_token=" + localStorage.getItem('jit_token') + "&jitkey=" + localStorage.getItem('jit_key'),
            params: {
                f: {
                    OrderID : OrderID
                }
            }
        }).success(function (response) {
            if (response.data != undefined && (response.data instanceof Array) && response.data.length != 0) {
                $scope.orderDeliveryinfo = response.data[0];
            } else {
                $scope.orderDeliveryinfo = {
                    StaffName : '还未分配配送员！'
                };
            }

            if (!response.isSuccess) {
                alert("还未分配配送员！");
            }

        }).error(function (response) {
            alert(response.msg);
        });
    }

    //确认分配
    $scope.saveAllocate = function(){
         $scope.formdata= {
             "OrderID" : $scope.orderDelivery.OrderID,
             "DeliveryUserID" : $scope.orderDelivery.StaffID,
         }
         $http({
            method:'post',
            url: "/jinkeBro/orderDelivery"+"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            data:{
                formdata : $scope.formdata
            }
        }).
        success(function(response) {
           alert(response.msg)  
        }).
        error(function(response) {
           alert(response.msg);
        });  
    }

    //订单详情
    $scope.moreDetails = function(OrderID){
         $scope.orderDetailInfo = {
             'OrderID': OrderID ,
             'totalMoney' : 0
         };

         $http({
            method:'get',
            url: 'jinkeBro/order' +"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            params:{
                f: {
                    OrderID : OrderID
                }
            }
        }).
        success(function(response) {
            $scope.orderDetails=response.data;

            // 计算总金额
            var productInfoArr = response.data;
            var sumMoney = 0;

            for (var i=0; i<productInfoArr.length; i++) {
                sumMoney += productInfoArr[i].ProductCount * productInfoArr[i].ProductPrice;
            }

            $scope.orderDetailInfo.totalMoney = sumMoney.toFixed(2);

            if(!response.isSuccess){
                alert(response.msg);
            };
        }).
        error(function(response) {
             alert(response.msg);
        });    
    }
    //订单配送管理
    //配送信息编辑
    $scope.editDelivery = function (orderID, action) {
        $scope.editInfo = {};
        $scope.f = {
            'OrderID':  orderID
        };

        $http({
            method:'get',
            url: action +"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            params:{
                f:$scope.f
            }
        }).
        success(function(response) {
            $scope.editInfo = response.data[0];
            if(!response.isSuccess){
                alert(response.msg);
            };
            $scope.f = {};
        }).
        error(function(response) {
            alert(response.msg);
            $scope.f = {};
        });
    };

    //配送信息编辑完成
    $scope.ensureEditDelivery = function (action) {
        var data = $scope.editInfo;

        $http({
            method:'put',
            url: action +"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            data:{
                formdata : data
            }
        }).
        success(function(response) {
            alert(response.msg)
            getInit();
        }).
        error(function(response) {
            alert(response.msg);
        });
    };

    //开始配送
    $scope.startDelivery = function (OrderID) {
        $http({
            method: 'put',
            url: '/jinkeBro/orderDelivery/startDelivery' + "?access_token=" + localStorage.getItem('jit_token') + "&jitkey=" + localStorage.getItem('jit_key'),
            data: {
                formdata: {
                    OrderID:OrderID
                }
            }
        }).success(function (response) {
            if (response.isSuccess) {
                alert(response.msg);
            }
            getInit();
        }).error(function (response) {
            alert(response.msg);
        });
    };

    //配送完成
    $scope.endDelivery = function (OrderID) {
        $http({
            method: 'put',
            url: '/jinkeBro/orderDelivery/endDelivery' + "?access_token=" + localStorage.getItem('jit_token') + "&jitkey=" + localStorage.getItem('jit_key'),
            data: {
                formdata: {
                    OrderID:OrderID
                }
            }
        }).success(function (response) {
            alert(response.msg);
            getInit();
        }).error(function (response) {
            alert(response.msg);
        });
    };

    //商品类型添加
    $scope.addProductType = function (action) {
        var productType = $scope.form.ProductTypeName;
        $http({
            method:'post',
            url: action +"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            data:{
                formdata: {
                    ProductTypeName: productType
                }
            }
        }).
        success(function(response) {
            alert(response.msg);
            getInit();
            $scope.formdata = {};
        }).
        error(function(response) {
            alert(response.msg);
        });
    };

    //商品类型信息编辑
    $scope.moreProductType = function (ID, action) {
        $scope.f = {
            'ID':  ID
        }
        $http({
            method:'get',
            url: action +"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            params:{
                f:$scope.f
            }
        }).
        success(function(response) {
            $scope.formdata = response.data[0];
            if(!response.isSuccess){
                alert(response.msg);
            };
            $scope.f = {};
        }).
        error(function(response) {
            alert(response.msg);
            $scope.f = {};
        });
    };

    //商品类型编辑完成
    $scope.editProductType = function (action) {
        var data = $scope.formdata;

        $http({
            method:'put',
            url: action +"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            data:{
                formdata : data
            }
        }).
        success(function(response) {
            alert(response.msg);
            getInit();
        }).
        error(function(response) {
            alert(response.msg);
        });
    };

    //商品类型编辑完成
    $scope.generateStockReport = function () {
        $http({
            method:'get',
            url: '/datadict/plain' +"?access_token="+localStorage.getItem('jit_token')+"&jitkey="+localStorage.getItem('jit_key'),
            params:{
                isPaging:1,
                pageindex:1,
                pagesize:10,
                f:{
                    Category:"dc_stockArea"
                }
            }
        }).
        success(function(response) {
            $scope.StockAreas = response.data;
        }).
        error(function(response) {
        });
    };

    $scope.getProductSKU = function (SKU,ProductID) {
        $scope.SKU = SKU;
        $scope.ProductID = ProductID;
    };

    $scope.formdata = {};
});
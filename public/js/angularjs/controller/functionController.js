/**
 * Created by Administrator on 2017/1/4.
 */
myApp.controller('functionController', function($scope, $http,$q,baseService) {
    $scope.tree_data = [];//树形数据，获取 $scope.tree_data过程是异步的如果没有初始化会导致报错
    $scope.disable=true;//右边的编辑框是否可编辑
    $scope.btnSaveMessage='编辑';//编辑框中的提交按钮的作用
    $scope.parent=[];//新增时，当前节点的父节点
    $scope.Config={
        ModelTitle:'确定',
        ModelBody:'保存成功',
        BtnCancel:'取消',
        BtnSave:'确定',
        Cancel:function(){
            $("#functionModel").modal('hide');
        },
        Save:function(){
            $("#functionModel").modal('hide');
        }
    };
    //获取树形数据
    $http.get("/func?access_token=" + accesstokenstring)
        .success(function (response) {
            $scope.tree_data = response.data;
        });
    //第一列显示的数据
    $scope.expanding_property = {
        field: "FunctionName",
        displayName: "功能名字",
        sortable: true,
        filterable: true,
        cellTemplate: "<i>{{row.branch[expandingProperty.field]}}</i>"
    };
    //grid展示的列
    $scope.col_defs = [
        {
            field: "FunctionCode",
            filterable: true
        },
        {
            field: "ApplicationID",
            sortable: true,
            sortingType: "number",
            filterable: true
        },
        {
            field: "FunctionID",
            sortable: true,
            sortingType: "number"
        },
        {
            field: "ParentID"
        }
        // {
        //     field: "IsActive",
        //     displayName: "是否删除",
        //     cellTemplate: "<i>{{row.branch[col.field]=='0'?'是':'否'}}</i>"
        // }
    ];
    //点击第一列时候发生的事件
    $scope.clickHander = function(e){
        e.ApplicationID= e.ApplicationID+'';
        $scope.currentData=e;
        // $scope.currentData=Object.assign({},e);
        //for(key in $scope.currentData){
      //      $scope.currentData[key]=$scope.currentData[key]+'';
       // }
    }
    //点击后面的编辑时候触发的事件
    $scope.clickHanderedit = function(e){
        e.ApplicationID= e.ApplicationID+'';
        $scope.currentData=e;
        $scope.disable=false;
        $scope.btnSaveMessage='保存';
        // $scope.currentData=Object.assign({},e);
        //for(key in $scope.currentData){
        //      $scope.currentData[key]=$scope.currentData[key]+'';
        // }
    }
    //点击新增时候触发的事件
    $scope.clickHanderAdd = function(e){
        $scope.parent=e;
        e.children.push({"ApplicationID": e.ApplicationID+'',"FunctionID":"","ParentID": e.FunctionID,"FunctionName":"","Memo":"",IsActive:1,FunctionLevel:"0"});
        $scope.currentData= e.children[e.children.length-1];

        $scope.disable=false;
        $scope.btnSaveMessage='保存';
        // $scope.currentData=Object.assign({},e);
        //for(key in $scope.currentData){
        //      $scope.currentData[key]=$scope.currentData[key]+'';
        // }
    }
    //点击form中编辑触发的事件
    $scope.edit=function(){
        if($scope.disable) { //初始状态，将按钮改为保存
            $scope.disable = false;
            $scope.btnSaveMessage = '保存';
        }else{//按钮为保存激活状态，点击保存操作
            var  promise=doSave();
            promise.success(function(data){
                if($scope.currentData.FunctionID===""){
                    $scope.currentData.FunctionID="s"
                }
                $("#functionModel").modal('show');
            });
        }
    }
    $scope.delete=function(e,par){
        $scope.currentData=e;
        $scope.parent=par;
        var  promise=doDelete();
        promise.success(function(data){
            for(index=0;index<$scope.parent.children.length;index++)
            {
                if($scope.parent.children[index]===$scope.currentData)
                {
                    break;
                }
            }
            $scope.parent.children.splice(index,1);
            $("#functionModel").modal('show');
        });
    }
    function  doDelete(){
        return $http({
            method: 'delete',
            url: "func?access_token=" + accesstokenstring+'&d='+JSON.stringify($scope.currentData),
            data: {
                d:JSON.stringify($scope.currentData)
            }
        });
    }
    function doSave(){
       if($scope.currentData.FunctionID==="") {
           return $http({
               method: 'post',
               url: "func?access_token=" + accesstokenstring,
               data: {
                   formdata: $scope.currentData
               }
           });
       }else{
           return $http({
               method: 'put',
               url: "func?access_token=" + accesstokenstring,
               data: {
                   formdata: $scope.currentData
               }
           });
       }
    }
    // 点击取消按钮时候触发事件
    $scope.cancel=function(){
        if($scope.currentData.FunctionID===""){
            $scope.parent.children.splice($scope.parent.children.length-1,1);
            $scope.currentData= $scope.parent;
            $scope.currentData.ApplicationID=ApplicationID+'';
        }
        $scope.disable=true;
        $scope.btnSaveMessage='编辑';
    }
})
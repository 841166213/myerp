var STD = getIndexWindow().STD;
function getIndexWindow(){
	return window.top;
}
function getCurentTagWindow(){
	return $(getIndexWindow().document).find(".main:visible").find("#iframe")[0].contentWindow;
}

function doCancel(){
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}


function parentCancelReload() {
	parent.reloadGrid();
	doCancel();
}

function openTag(id, title, url){
	getIndexWindow().addTabByTitleAndUrl(title, url, id, null, true);
}

function getCurrentDate(){
	 var now = new Date();
     var year = now.getFullYear();       //年
     var month = (now.getMonth() + 1)>9?(now.getMonth() + 1):'0'+(now.getMonth() + 1);     //月
     var day = now.getDate();            //日
     return year+'-'+month+'-'+day;
}


//绑定 Enter 键盘键
function BindEnter(obj)
{
    if(obj.keyCode == 13)
        {
    		obj.click();
            obj.returnValue = false;
        }
}

/**
 * @param val
 * @returns 
 * 处理空字符
 */
function dealNullString(val){
	if(val==null||val==undefined||val=="null"){
		return "";
	}
	return val;
}

function showOrHideClass(obj)
{
	$("#menu1td1").toggle();
	$("#menu1td2").toggle();
	$("#menu2").toggle();
	if($("#menu1td1").is(":hidden"))
	{
		$(obj).attr("class","unfold");
	}
	else
	{
		$(obj).attr("class","packUp");
	}
}
// 显示错误信息，自动隐藏
function showErrorMsg(msg) {
	getIndexWindow().showErrorMsg(msg);
}

// 显示操作成功信息，自动隐藏
function showSuccessMsg(msg) {
	getIndexWindow().showSuccessMsg(msg);
}


function showDialog(url, title, pageHeight, pageWidth) {
	window.parent.showMainPage(url, title, pageHeight, pageWidth);
}
function showDialog_S(url, title, pageHeight, pageWidth) {
	showDialog(url, title, 300, 500);
}
function showDialog_M(url, title, pageHeight, pageWidth) {
	showDialog(url, title, 400, 700);
}
function showDialog_L(url, title, pageHeight, pageWidth) {
	showDialog(url, title, 500, 900);
}

function openDialog_S(url, title){
	openDialog(url, title, '40%', '40%');
}
function openDialog_M(url, title){
	openDialog(url, title, '60%', '60%');
}
function openDialog_L(url, title){
	openDialog(url, title, '80%', '80%');
}
function openDialog_F(url, title){
	openDialog(url, title, '98%', '98%');
	
}
function openDialog(url, title, pageHeight, pageWidth){
	layer.open({
	      type: 2,
	      title: title,
	      maxmin: true, //开启最大化最小化按钮
	      area: [pageWidth, pageHeight],
	      content: url
	 });
}
$.fn.setForm = function (jsonValue) {
    var obj = this;
    $.each(jsonValue, function (name, ival) {
        var $oinput = obj.find("input[name='" + name + "']");
        if($oinput.attr("type")== "radio" || $oinput.attr("type")== "checkbox") {
           $oinput.each(function(){
             if(Object.prototype.toString.apply(ival) == '[object Array]'){//是复选框，并且是数组
                for(var i=0;i<ival.length;i++){
                    if($(this).val()==ival[i])
                       $(this).attr("checked", "checked");
                }
             }else{
             	if($(this).val()==ival)
                	$(this).attr("checked", "checked");
                }
           });
        }else{
        	obj.find("[name="+name+"]").val(ival); 
        }
    });
}

function toSelectJson(list, valueName, textName){
	var json = {};
	for(var i=0; i<list.length; i++){
		json[list[i][valueName]] = list[i][textName];
	}
	return json;
}

function myAjax(config){
	var _config = {	
		dataType : "json",
		type : "post",
		async: true
	};
	
	config = $.extend(_config, config);
	
	var loadIndex;
	$.ajax({ url: config.url,
		type: config.type,
		dataType: config.dataType, 
		data: config.data,
		async: config.async,
		success: config.success,
		beforeSend: function(){
			loadIndex = layer.load();
	    },
	    complete: function(){
	    	layer.close(loadIndex);
	    },
	    error: function(a, b, c){
	    	layer.close(loadIndex);
	    	layer.msg('请求失败');
	    }
	});
}

function validSubmit(success, formId, dataType){
	formId = formId ? formId : "validForm";
	$("#"+formId).isValid(function(isValid){if(isValid){
		var loadIndex;
		$("#"+formId).ajaxSubmit({
			 dataType: dataType == undefined ? "json" : dataType, 
		     beforeSend: function(){
		    	 loadIndex = layer.load();
		     },
		     success: success,
		     complete: function(){
		    	 layer.close(loadIndex);
		     },
		     error: function(){
		    	 layer.close(loadIndex);
			     layer.msg('请求失败');
		     }
		});	
	}});
}
function doCommonSubmit(){
	validSubmit(function(d){
		 showSuccessMsg("保存成功");
		 parentCancelReload();
	})
};

Date.prototype.Format = function(fmt) 
{ //author: meizz 
  var o = { 
    "M+" : this.getMonth()+1,                 //月份 
    "d+" : this.getDate(),                    //日 
    "h+" : this.getHours(),                   //小时 
    "m+" : this.getMinutes(),                 //分 
    "s+" : this.getSeconds(),                 //秒 
    "q+" : Math.floor((this.getMonth()+3)/3), //季度 
    "S"  : this.getMilliseconds()             //毫秒 
  }; 
  if(/(y+)/.test(fmt)) 
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
  for(var k in o) 
    if(new RegExp("("+ k +")").test(fmt)) 
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
  return fmt; 
}

function formatTime(value, colObjet, colValue){
	if(value)
		 return  new Date(value.time).Format("yyyy-MM-dd hh:mm:ss"); 
}

function refreshOptions(dataObject, dom, Originalvalue) {
	dom.innerHTML = "";
	var oOption = document.createElement("OPTION");  
	oOption.text="";  
	oOption.value="";  
	dom.add(oOption);
	$.each(dataObject, function(value, text){
		var oOption = document.createElement("OPTION");  
		oOption.text=text;  
		oOption.value=value;
		if(value == Originalvalue){
			oOption.selected = true;
		}
		dom.add(oOption);
	});
}

function downloadMode(modeName){
	var name = encodeURI(encodeURI(modeName));
	location = "comm/downloadImportModel?fileName=" + name;
}
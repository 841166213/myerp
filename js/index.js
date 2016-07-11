var STD = {};
initStd();
function initStd(){
	$.getJSON("getStdJson", null, function(rs){
		$.extend(STD, rs.data);
	})
}

$(function() {
	$(".main").css("height", ($(window).height() - 97) + "px");
});

$(window).resize(function() {
	$(".main").css("height", ($(window).height() - 97) + "px");
});



// 打开二级菜单
function showMenuDiv(obj) {
	// 移除一级菜单的选中样式
	$(".icon").parent().removeClass("select");
	// 关闭全部的二级菜单
	$(".mGoodsSon").hide();
	// 获取一级菜单id
	var id = $(obj).attr("id");
	// 根据一级菜单id，获取二级菜单id，并打开二级菜单
	$("#" + id + "Div").show();
}
// 给一级菜单增加选中样式
function addMenuSelect(obj) {
	// 获取二级菜单id
	var id = $(obj).attr("id");
	// 获取一级菜单id
	id = id.substring(0, 5);
	// 给一级菜单增加选中样式
	$("#" + id).addClass("select");
}

var t;
// 解决div中存在ul时，频繁调用onmouseout方法的问题
// 解决setTimeout对象传递问题
// 延迟关闭二级菜单
function delayHideSecondMenu() {
	t = setTimeout(function() {
		hideSecondMenu();
	}, 10);
}

// 清除延迟事件
function clearTime() {
	clearTimeout(t);
}
// 关闭二级菜单
function hideSecondMenu() {
	$("#firstmenu li").removeClass("select");
	// 隐藏二级菜单
	$(".secondMenu").hide();
}
// 展示二级菜单
function showSecondMenu(obj) {
	$("#firstmenu li").removeClass("select");
	// 隐藏二级菜单
	$(".secondMenu").hide();

	var secondmenu = $(obj).attr("secondmenu");
	$(obj).addClass("select");
	var clientHeight = window.document.body.clientHeight;
	var menuHeight = $("#" + secondmenu).css("height");
	menuHeight = menuHeight.substring(0,menuHeight.indexOf("px"));
	var top = $("#" + secondmenu).css("top");
	top = top.substring(0,top.indexOf("px"));
	if(clientHeight-menuHeight<top){
		top = clientHeight-menuHeight-20;
	}
	$("#" + secondmenu).css("top",top+"px");
	$("#" + secondmenu).show();
}

// isRefresh 是否刷新
// baseTag 取得首页隐藏域值
// 客户端管理 WCRM
// 基础资料 WBI
// 单据业务 WBILL
function addTabByTitleAndUrl(title, url, tabid, baseTag, isRefresh) {
	// 隐藏二级菜单
	$(".secondMenu").hide();
	if(baseTag!=null&&baseTag!=""){
		url = $("#BasePath_" + baseTag).val() + url;
	}
	openTab(title, url, tabid, isRefresh);
}
// 通过菜单新增tab
function addTab(obj) {
	// tab id 以该页面url定义
	var url = $(obj).attr("basepath") + $(obj).attr("url");
	var tabid = $(obj).attr("menuId");

	// 获取tab的标题
	var title = $(obj).html() == "" ? $(obj).attr("title") : $(obj).html();

	// 隐藏二级菜单
	$(".secondMenu").hide();
	openTab(title, url, tabid, true);
}
// isRefresh 是否刷新
function openTab(title, url, tabid, isRefresh) {
	tabid = tabid.replace(/\./g,'-');
	// 如果点击了已打开的tab
	if ($("#" + tabid).length > 0) {
		$("#firstmenu li").each(function() {
			$(this).removeClass("select");
		});

		var index = -1;
		// 移除tab选中样式
		$("#tab li").each(function(i) {
			$(this).attr("class", "normal");
			if (this.id == tabid) {
				index = i;
			}
		});
		$("#" + tabid).attr("class", "select");

		if (index != -1) {
			$(".main").hide();
			$($(".main")[index]).show();
			if (isRefresh) {
				$("#" + tabid).attr("url", url);
				$($(".main")[index]).find("#iframe")[0].contentWindow.location.href = url;
			}
		}
	} else {
		// 获取tab的链接

		var html = "";
		if (url.indexOf("?") > -1) {
			html = url + '&tabid=' + tabid;
		} else {
			html = url + '?tabid=' + tabid;
		}

		// 移除tab选中样式
		$("#tab li").each(function() {
			$(this).attr("class", "normal");
		});
		var copyHome = $("#home").clone();
		copyHome.attr("id", tabid);
		copyHome.attr("tabid", tabid);
		copyHome.attr("class", "select");
		copyHome.attr("url", html);
		copyHome
				.html('<span  class="fl" title="'
						+ title
						+ '" url="'
						+ html
						+ '" href="javascript:;" tabid="'
						+ tabid
						+ '" onclick="selectTab(this)">'
						+ title
						+ '</span><a tabid="'
						+ tabid
						+ '" class="tabClose" href="javascript:;" onclick="deleteTab(this)"></a>');
		$("#tab").append(copyHome);

		var copyMainPage = $("#maincontent").clone();
		copyMainPage.addClass("page");
		$("#mainpage").append(copyMainPage);
		$(".main").hide();
		copyMainPage.find("#iframe").attr("src", html);
		copyMainPage.show();
		
		// 显示tab到
		try{
			
		}catch(e){}
	}
}

// 选中tab
function selectTab(obj,isrefresh) {
	$("#firstmenu li").each(function() {
		$(this).removeClass("select");
	});

	var title = $(obj).attr("title");
	var tabid = $(obj).attr("tabid");
	$("#" + title).addClass("select");

	// 移除tab选中样式
	var index = 0;
	$("#tab li").each(function(i) {
		$(this).attr("class", "normal");
		if (this.id == tabid) {
			index = i;
		}
	});
	if (tabid == undefined) {
		$("#home").attr("class", "select");
		url = $("#home").attr("url");
		$($(".main")[index]).find("#iframe")[0].contentWindow.location.reload();
	} else {
		$("#" + tabid).attr("class", "select");
	}

	$(".main").hide();
	$($(".main")[index]).show();
	if(isrefresh){
		$($(".main")[index]).find("#iframe")[0].contentWindow.location.reload();
	}
}
// 删除tab
function deleteTab(obj) {
	var tabid = $(obj).attr("tabid");
	deleteTabByTabId(tabid);
}
// isSelect 表示是否需要选中最后一个tab
function deleteTabByTabId(tabid, isSelect) {
	if (tabid == "" || tabid == null || tabid == undefined) {
		return;
	}
	if($("#tab li[id$='" + tabid + "']").attr("locktab")){
		selectTab($("#tab li[id='businessprocess-stepone']"));
		showErrorMsg("请先解除锁定后关闭");
		return;
	}
	var index = -1;
	$("#tab li").each(
			function(i) {
				if (isSelect == undefined || isSelect == null || isSelect) {
					$(this).attr("class", "normal");
				}
				var id = this.id;
				if (id.indexOf(tabid) > -1
						&& id.substring(id.indexOf(tabid)) == tabid) {
					index = i;
				}
			});
	$("#tab li[id$='" + tabid + "']").remove();
	if (index > -1) {
		$($(".main")[index]).remove();
	}

	if (isSelect == undefined || isSelect == null || isSelect) {
		selectTab($("#tab li:last-child"));
	}
}

// 给定URL并刷新
function refreshTab(url) {
	if (url != undefined && url != null) {
		$(".main:visible").find("#iframe")[0].contentWindow.location.href = url;
	} else {
		$(".main:visible").find("#iframe")[0].contentWindow.location.reload();
	}
}
// 刷新指定name的tab
function refreshByTabName(tabName) {
	var j = "";
	$("#tab li").each(function(i) {
		var title = $(this).find("span").attr("title");
		if ($.trim(title) == tabName) {
			j = i;
		}
	});
	if (j != "") {
		$(".main").find("#iframe")[j].contentWindow.location.reload();
	}
}


//刷新指定tabid的tab
function refreshByTabId(tabid) {
	var j = "";
	$("#tab li").each(function(i) {
		var curtabid = $(this).find("span").attr("tabid");
		if ($.trim(curtabid) == tabid) {
			j = i;
		}
	});
	if (j != "") {
		$(".main").find("#iframe")[j].contentWindow.location.href = $(".main").find("#iframe")[j].contentWindow.location.href;
	}
}

function refreshAllTab(){
	$("#tab li").each(function(i) {
		$(".main").find("#iframe")[i].contentWindow.location.reload();
	});
}

// 关闭全部tab
function closeAllTab() {
	var len = $(".main").length;
	$("#tab li").each(function(i) {
		var id = $(this).attr("id");
		//var isremove = true;
		if (id != "home" && !$(this).attr("locktab")) {
			$(this).remove();
		} 
		if (len != 0 && !$($(".main")[len]).attr("locktab")) {
			$($(".main")[len]).remove();
		}
		len = len - 1;
		$(this).attr("class", "normal");
	});

	$("#home").attr("class", "select");
	$($(".main")[0]).show();
	
	// 恢复tab行到首页，防止值有一个菜单是首页被隐藏
	$(".u .scrol").css({left : "0px"});
}
// 关闭其他
function closeOtherTab() {
	$("#tab li").each(function(i) {
		var id = $(this).attr("id");
		if (id != "home" && $(this).attr("class") != "select" && !$(this).attr("locktab")) {
			$(this).remove();
		}
	});
	$(".main").each(function(i) {
		if ($(this).hasClass('page') && $(this).css("display") == "none"&&!$(this).attr("locktab")) {
			$(this).remove();
		}
	});
	// 恢复tab行到首页，防止值有一个菜单是首页被隐藏
	$(".u .scrol").css({left : "0px"});
}

// 显示错误信息，自动隐藏
function showErrorMsg(msg) {
	try {
		$(".errorInfo").text(msg);
		$(".errorInfo").show().delay(3000).fadeOut(200);
	} catch (e) {
		alert(e);
	}
}

// 显示操作成功信息，自动隐藏
function showSuccessMsg(msg) {
	try {
		$(".succeedInfo").text(msg);
		$(".succeedInfo").show().delay(3000).fadeOut(200);
	} catch (e) {
		alert(e);
	}
}



//显示首页
function showIndex(){
	selectTab($("#tab li:first-child"));
}


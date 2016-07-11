<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	 <base href="<%=basePath%>">
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <title>金谷erp</title>
     <link href="./css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/layer/layer.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script src="js/Cookie.js"></script>
<script src="js/desktop.js" type="text/javascript"></script>

<!-- fix IE7 下JSON 对象报错bug -->
<script src="js/json2.js"></script>

<script src="js/index.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		
		$(".tab_title ul li").click(function() {
			index = $(".tab_title ul li").index(this);
			$(this).addClass("select").siblings().removeClass("select");
			$(".tab_content div").eq(index).show().siblings().hide();
		});

		$(".vright").click(function(e) {
			var topTabWidth = $(".vright").offset().left - $(".vleft").offset().left - 45;

			var scrolbWidth = 0;
			$(".u .scrol li").each(function() {
				// 10px 为margin值
				scrolbWidth = scrolbWidth + this.offsetWidth + 10;
			});
			
			var leftNew = $(".u .scrol").offset().left-300;

			if(scrolbWidth > topTabWidth){
				if(leftNew < topTabWidth-scrolbWidth){
					leftNew = topTabWidth-scrolbWidth;
				}

				$(".u .scrol").css({left : leftNew + "px"});
			}
		});
		
		
		$(".vleft").click(function() {
			var leftNew = $(".u .scrol").offset().left+150;
			if(leftNew>0){
				leftNew = 0;
			}
			
			$(".u .scrol").css({left : leftNew + "px"});
		});
		
		// 帮助
        $("#divHelpArea").mouseenter(function () {
            $("#divHelpList").fadeIn(250);
        });
        $("#divHelpArea").mouseleave(function () {
            $("#divHelpList").fadeOut(250);
        });
	});
	
	function resetPassword(){
		layer.open({
		      type: 2,
		      title: '修改密码',
		      area: ['450px', '300px'],
		      content: 'system/user/resetPs'
		 });
	}
	
	function safetyExit(){
		layer.confirm("是否确认退出？",function(index){
			$.ajax({
				url:"login/quit",
				dataType : "json",
				type : "post",
				success:function(){
					window.location = "<%=basePath%>login";
				},
				error: function(){
			    	layer.msg('请求失败');
			    }
			});
			layer.close(index);
		});
	}
	
</script>
</head>
<body class="bodyBg">
	<div id="logs"></div>
	<!-- 是否是管理员-->
	<input type="hidden" id="isAdminRole" value="true" spellcheck="false">
	<!-- 是否是管理员-->
	<input type="hidden" id="hidUserId" value="A5454690-14B2-4A7D-A2CD-92669304CB30" spellcheck="false">
	
	<div class="succeedInfo" style="display: none"></div>
	<div class="errorInfo" style="display: none"></div>
	<div class="top">
		<div class="logo">
			<a class="link" onclick="showIndex()"></a>
		</div>
		<div class="topActionArea">
			<div class="loginInfo">
				<a href="javascript:;" onclick="openContactInfo()"> 
					<span class="topAvatar" style="background-image:url(http://static.zhsmjxc.com/attached/image///2015-02-05/C10776C7-F3EE-4777-B995-FA6CD7B47D15.jpg)"></span> 
					<span class="trial" style="display:none"></span>
					<input type="hidden" id="ispay" value="true" spellcheck="false">
					<span class="topUsername fl">
						<h1>您好！ </h1>
						<h2>${erp_session_user.account }</h2>
					</span>
				</a>
			</div>
			<!-- logininfo -->
			<div class="flow">
				<a href="javascript:;" title="业务流程" onclick="addTabByTitleAndUrl(&#39;业务流程&#39;, &#39;businessprocess/stepone.htm&#39;, &#39;businessprocess-stepone&#39;, &#39;WMAIN&#39;, false)"><span class="icon"></span><span class="text">业务流程</span></a>
			</div>
			<!-- flow -->
			<div id="divHelpArea" class="helpCenter">
		      <a><span class="icon"></span><span class="text">操作</span><span class="arrowDown"></span></a>
		      <div id="divHelpList" class="InstalList" style="margin-top:20px;display: none;">
		      	<div class="Lists">
		          <ul>
		            <li class="borderT title"><a href="javascript:;" onclick="resetPassword();">修改密码</a></li>
			            <li class="borderT title"><a href="javascript:;" onclick="safetyExit();">安全退出</a></li>
		          </ul>
		       </div>
		     </div>
		    </div>
		</div>
	</div>
	<!-- top -->
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tbody><tr>
			<td width="85" valign="top">
				<div class="leftMenu">
					<ul id="firstmenu" class="menu">
						<c:forEach var="item" items="${erp_session_user.menu }">
						<li secondmenu="${item.CLASS }" class="${item.CLASS }" onmouseover="showSecondMenu(this)"><a href="javascript:;" class="icon"></a></li>
						</c:forEach>
					</ul>

					<c:forEach var="item" items="${erp_session_user.menu }" varStatus="status">
					<div id="${item.CLASS }" secondmenu="${item.CLASS }" onmouseout="delayHideSecondMenu(this)" onmouseover="clearTime()" class="secondMenu" style="top:${66+65*status.index}px;display: none; z-index: 101">
						<c:forEach var="item2" items="${item.children}">
						<ul class="list dashLineR"><p>${item2.menuName}</p>
							<c:forEach var="item3" items="${item2.children}">
							<li><a href="javascript:;" menuId="${item3.menuId}" basepath="<%=basePath%>" url="${item3.url}" onclick="addTab(this)" class="text">${item3.menuName}</a></li>
							</c:forEach>
						</ul>
						</c:forEach>
					</div>
					</c:forEach>
			</div></td><td>
			</td><td style="background: #e9eef2;" valign="top">
				<div id="tabDiv">
				  <div class="tab_title">
				       <div class="vleft"></div>
					   <div class="u topTab">
					      	<ul id="tab" class="scrol">
								<li tabid="home" id="home" url="" firstmenu="" secondmenu="" class="select"><a href="javascript:;" onclick="selectTab(this)">首页</a></li>
							</ul>
						</div>
						
						<div id="down" class="downArrow">
							<div class="tabActionArea"></div>
							<div id="downlist" class="downArrowContent">
								<span><a href="javascript:;" onclick="refreshTab()">刷新当前页</a></span>
								<span><a href="javascript:;" onclick="closeAllTab()">关闭全部</a></span>
								<span><a href="javascript:;" onclick="closeOtherTab()">关闭其他</a></span>
							</div>
						</div>
					    <div class="vright"></div>
					</div>
				</div>
			
				<div id="mainpage">
					<div class="main" name="maincontent" id="maincontent" style="padding: 0px; width: 100%; height: 676px; display: block;">
						<iframe id='iframe' name="iframe" width='100%' height='100%' frameborder='0' scrolling='auto' src='main'></iframe>
					</div>
				</div>
			</td>
		</tr>
	</tbody></table>
</body></html>
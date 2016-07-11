function loading(obj) {
	if($(obj).length>0){
		$(".button").addClass('noActionButton');
		$(".loadding").show();
		$(obj).addClass("processing");
	}
}

function complete(obj) {
	if($(obj).length>0){
		$(".button").removeClass('noActionButton');
		$(".loadding").hide();
		$(obj).removeClass("processing");
	}
}
// 显示错误信息，自动隐藏
function showErrorMsg(msg) {
	parent.showErrorMsg(msg);
}

// 显示操作成功信息，自动隐藏
function showSuccessMsg(msg) {
	parent.showSuccessMsg(msg);
}

// 显示弹出框信息
function showAlertMsg(msg) {
	parent.showAlertMsg(msg);
}
function FullBgShow(content) {
	parent.$("#black_overlay").show();
	parent.$("#load_content").show();
	parent.$("#load_contents").text(content);
}
function FullBgHide() {
	parent.$("#black_overlay").hide();
	parent.$("#load_content").hide();
}
/*--获取网页传递的参数--*/
function request(paras) {
	var url = location.href;
	var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
	var paraObj = {}
	for (i = 0; j = paraString[i]; i++) {
		paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j
				.indexOf("=") + 1, j.length);
	}
	var returnValue = paraObj[paras.toLowerCase()];
	if (typeof (returnValue) == "undefined") {
		return "";
	} else {
		return returnValue;
	}
}
// guid生成
function guidGenerator() {
	var S4 = function() {
		return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
	};
	return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4()
			+ S4() + S4());
}


// 获取form 对象值
$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

// 参数说明：num 要格式化的数字 n 保留小数位
function formatMoney(num) {
	if (!/^(-?\d+)(\.\d+)?$/.test(num)) {
		return num;
	}

	var n = 2;
	try {
		// 取得金额小数位，从首页隐藏域中取得
		var n = parent.document.getElementById("PriceDecimalDigits").value;
		
		if (!n) {
			n = document.getElementById("PriceDecimalDigits").value;
		}
		
		if (!n) {
			n = 2;
		}
	} catch (e) {
	}

	return formatNumber(num, n);
}

// 参数说明：num 要格式化的数字 n 保留小数位
// 不四舍五入，直接舍去
function formatNumber(num, n) {
	try {
		if (n > 4) {
			n = 4;
		}
		num = parseFloat(num);
		num = String(num.toFixed(n));

		var numSplits = num.split(".");

		var re = /(-?\d+)(\d{3})/;

		while (re.test(numSplits[0]))
			numSplits[0] = numSplits[0].replace(re, "$1,$2");

		if (n <= 0) {
			num = numSplits[0];
		} else {
			num = numSplits[0] + "." + numSplits[1];
		}
	} catch (e) {
	}

	return num;
}
// 参数说明：num 要格式化的数字 n 保留小数位
function formatMoneyN(num) {
	if (!/^(-?\d+)(\.\d+)?$/.test(num)) {
		return num;
	}

	var n = 2;
	try {
		// 取得金额小数位，从首页隐藏域中取得
		var n = parent.document.getElementById("PriceDecimalDigits").value;
		
		if (!n) {
			n = document.getElementById("PriceDecimalDigits").value;
		}
		
		if (!n) {
			n = 2;
		}
	} catch (e) {
	}

	try {
		num = formatNumberN(num, n);
	} catch (e) {
	}

	return num;
}

// 参数说明：num 要格式化的数字 n 保留小数位
function formatNumberN(num, n) {
	try {
		num = parseFloat(num).toFixed(n);
	} catch (e) {
	}
	return num;
}
/**
 * 金额保留小数
 */
Number.prototype.formatMoney = function() {
	var value = this + "";
	return formatMoneyN(parseFloat(value.replace(/,/g, "")));
}
/**
 * 金额保留小数 有千分位
 */
Number.prototype.formatMoney3 = function() {
	var value = this + "";
	return formatMoney(parseFloat(value.replace(/,/g, "")));
}
/**
 * 金额保留小数 不四舍五入
 */
Number.prototype.formatMoney2 = function() {
	var value = this + "";
	return formatMoneyNoRounded(parseFloat(value.replace(/,/g, "")));
}
/**
 * 数量保留小数
 */
Number.prototype.formatNum = function() {
	var value = this + "";
	return formatNumberN(parseFloat(value.replace(/,/g, "")), 2);
}

function removeHTMLTag(str) {
	str = str.replace(/\</g, '《'); // 去除HTML tag
	str = str.replace(/\>/g, '》'); // 去除HTML tag
	str = str.replace(/[ | ]*\n/g, '\n'); // 去除行尾空白
	str = str.replace(/&nbsp;/ig, '');// 去掉&nbsp;
	str = str.replace(/\'/g, "’");// 替换英文单引号为中文单引号
	return str;
}


/**
 * @param strDateStart (e.g 2014-10-31) 不带时分秒
 * @param strDateEnd  (e.g 2014-10-31) 不带时分秒
 * @param strSeparator //日期分隔符 
 * @returns 获取时间相差 天数
 */
function getDays(strDateStart,strDateEnd,strSeparator){ 
	var oDate1; 
	var oDate2; 
	var iDays; 
	oDate1= strDateStart.split(strSeparator); 
	oDate2= strDateEnd.split(strSeparator); 
	var strDateS = new Date(oDate1[0], oDate1[1]-1, oDate1[2]); 
	var strDateE = new Date(oDate2[0], oDate2[1]-1, oDate2[2]); 
	iDays = parseInt(Math.abs(strDateS - strDateE ) / 1000 / 60 / 60 /24);//把相差的毫秒数转换为天数 
	return iDays + 1; 
} 

function getDecimalNum(){
	var n = 2;
	try {
		// 取得金额小数位，从首页隐藏域中取得
		n = parent.document.getElementById("PriceDecimalDigits").value;
		
		if (!n) {
			n = document.getElementById("PriceDecimalDigits").value;
		}
		if (!n) {
			n = 2;
		}
	} catch (e) {
	}
	return n;
}

//参数说明：num 要格式化的数字 n 保留小数位
function formatMoneyNoRounded(num) {
	if (!/^(-?\d+)(\.\d+)?$/.test(num)) {
		return num;
	}
	var n = 2;
	try {
		// 取得金额小数位，从首页隐藏域中取得
		var n = parent.document.getElementById("PriceDecimalDigits").value;
		if (!n) {
			n = 2;
		}
	} catch (e) {
	}

	return formatNumberNoRounded(num, n);
}
//参数说明：num 要格式化的数字 n 保留小数位
//不四舍五入，直接舍去
function formatNumberNoRounded(num, n) {
	try {
		if (n > 4) {
			n = 4;
		}
		num = parseFloat(num);
		num = String(num.toFixed(10));

		var numSplits = num.split(".");

		var re = /(-?\d+)(\d{3})/;

		while (re.test(numSplits[0]))
			numSplits[0] = numSplits[0].replace(re, "$1,$2");

		if (n <= 0) {
			num = numSplits[0];
		} else {
			num = numSplits[0] + "." + numSplits[1].substr(0, n);
		}
	} catch (e) {
	}

	return num.replace(/,/g, "");
}

function openExtExploer(url) {
	try{
		var msg = {};
		msg.method = "openExtExploer";
		
		var param = {};
		param.url = url;
		
		msg.param = param;
		var msgJson = JSON.stringify(msg);
		parent.parent.postMessage(msgJson,"file:///");
		parent.parent.postMessage(msgJson,"qrc:///");
	}catch(Exception){
		
	}
}


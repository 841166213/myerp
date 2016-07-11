var XZZJ_BTBZ = {//补贴标准
	"1": 300, //一般干部职工300元
	"2": 350, //科级350元
	"3": 400, //处级400元
	"4": 500 //厅级500元
}

var XZZJ_MJBZ = {//面积标准
	"1": 75, //一般干部职工75平米
	"2": 85, //科级85平米
	"3": 100, //处级100平米
	"4": 130 //厅级130平米
}

function getBNDYFFBZ(xzzj, ylqns){//获取本年度月补贴标准，输入：行政职级，已领取年数
	try{
		var zjbz = XZZJ_BTBZ[xzzj];
		ylqns = parseInt(ylqns);
		var btbz = Math.pow(1.1, ylqns)*zjbz;
		return Math.round(btbz);
	}catch(e){
		return 0;
	}
}

function getCEHBBTZE(xzzj, fgmj){//获取差额货币补贴总额，输入：行政职级，房改面积
	try{
		fgmj = parseInt(fgmj);
		var zjbz = XZZJ_BTBZ[xzzj];
		var mjbz = XZZJ_MJBZ[xzzj];
		var ze = (mjbz-fgmj)*zjbz*12*15/mjbz;
		return Math.round(ze);
	}catch(e){
		return 0;
	}
}

function getCEHBBTYE(xzzj, fgmj, ylqns){//获取差额货币补贴余额，输入：差额货币补贴总额，房改面积，已领取年数
	try{
		var ye = getCEHBBTZE(xzzj, fgmj);
		ylqns = parseInt(ylqns);
		for(var i=0; i<ylqns; i++){
			ye = ye - getBNDYFFBZ(xzzj, i)*12;
		}
		return ye;
	}catch(e){
		return 0;
	}
}

function getFFEHJ(sblx, xzzj, ylqns, lqfs, fgmj){//获取发放额合计， 输入： 申报类型，行政职级，已领取年数，领取方式， 房改面积
	try{
		var ffehj = 0;
		var bndyffbz = getBNDYFFBZ(xzzj, ylqns);
		
		if(sblx == '1'){//全额
			if(lqfs == "1"){//逐年逐月领取
				ffehj =  bndyffbz*12;
			}
			if(lqfs == "2"){//一次性领取
				ffehj =  bndyffbz*12*(15-parseInt(ylqns));
			}
		}
		
		if(sblx == '2'){//差额
			var cehbbtye = getCEHBBTYE(xzzj, fgmj, ylqns);
			if(lqfs == "1"){//逐年逐月领取
				ffehj = bndyffbz*12;
				ffehj = cehbbtye > ffehj ? ffehj : cehbbtye;
			}
			if(lqfs == "2"){//一次性领取
				ffehj = cehbbtye;
			}
		}
	
		return ffehj;
	}catch(e){
		return 0;
	}
}

function viewRySbDetail(id, sblx){
	if(sblx == 1){
		viewQesbDetail(id);
	}else{
		viewCesbDetail(id);
	}
}

function dwqeSbView(id, opt){
	openDialog_F("sb/dwqesbView?id="+id+"&opt="+opt, '单位全额申报情况查看');		
}

function dwceSbView(id, opt){
	openDialog_F("sb/dwcesbView?id="+id+"&opt="+opt, '单位差额申报情况查看');
}

function dwsbqkbView(id){
	openDialog_F("sb/dwsbqkbView?id="+id, '单位申报情况查看');
}

function viewQesbDetail(id){
	openDialog_L("sb/rysbxxDetail?id="+id+"&sblx=1", '全额申报详情');
}

function viewCesbDetail(id){
	openDialog_L("sb/rysbxxDetail?id="+id+"&sblx=2", '差额申报详情');
}

function viewDwsbHistory(dwid){
	var title = "单位申报历史查看";
	var url = "sb/dwsbHistory?dwid="+dwid;
	var id = "sb.dwsbHistory";
	openTag(id, title, url);
}

function viewRysbHistory(xm, sfzhm){
	var title = "人员申报历史查看";
	var url = "sb/rysbHistory?xm="+xm+"&sfzhm="+sfzhm;
	var id = "sb.rysbHistory";
	openTag(id, title, url);
}
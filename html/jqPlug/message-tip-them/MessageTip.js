var Common = new function () { };
Common.loadImage = function (url, callback) {
	var img = new Image();
	img.src = url;
	if (img.complete) {
		if (callback) callback(img);
		return;
	}
	img.onload = function () {
		if (callback) callback(img);
	};
	img.onerror = function () {
		if (callback) callback(img);
	};
};
$(function () {
	Common.loadImage("./images/loading.gif?v=111", null);
});
if (typeof (MsgTip) == "undefined") {
	var MsgTip = {}; var MsgTipNum = 0; var MsgTipStartNum = 0; var MsgTipData = new Array(); (function () {
		MsgTip.show = function (params) {
			if (params == null) { alert("必须输入最少是提示语句"); return; }; if (typeof (params) == "string") { var msg = params; params = {}; params.msg = msg; }; if (params.msg == null) { alert("必须输入提示语句"); return; }; if (params.top == null) { params.top = "center"; }; if (params.left == null) { params.left = "center"; }; if (params.during == null) { params.during = 2000; }; if (params.ico == null) { params.ico = ""; }; var html = "";
			html += "<div style=\"font-family:Arial;height:40px;width:" + ($GetStrLength(params.msg) * 14 + 40) + "px;line-height:40px;border:solid 1px #cccccc;padding:5px 5px 5px 5px;filter: progid:DXImageTransform.Microsoft.Shadow(Direction=145,OffX=2,OffY=2,enabled=true,color=#888888);-moz-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);-webkit-box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);background-color: White;\">"; if (params.ico != "") { html += "<div style='float:left;' class='tip-" + params.ico + "'>&nbsp;</div>"; }; html += params.msg; html += "</div>"; var id = params.during != 0 ? "MsgTipContainer" + MsgTipNum : "MsgTipContainerNoDuring" + MsgTipData.length; var msg = $("<div id='" + id + "' style='display:none;' class='tip-div' >" + html + "</div>").appendTo("body"); var pagewidth = ""; var pageheight = ""; if ($.browser.msie) pagewidth = document.compatMode == "CSS1Compat" ? document.documentElement.clientWidth : document.body.clientWidth; else pagewidth = self.innerWidth; pageheight = document.documentElement.clientHeight; msg.css("left", (params.left == "center" ? (pagewidth - parseInt(msg.width())) / 2 : params.left)).css("top", (params.top == "center" ? ((pageheight - parseInt(msg.height())) / 2 + +MsgTip.ScrollTopHeight()) : params.top)); msg.slideDown("fast", function () { if (params.callback) { setTimeout(function () { params.callback(); }, params.during); } }); if (params.during != 0) { MsgTipNum++; eval(" var MsgTip" + MsgTipNum + "=setInterval(function(){for(var i=MsgTipStartNum;i<MsgTipNum;i++){if(eval('MsgTip'+(i+1))){clearInterval(eval('MsgTip'+(i+1)));$('#MsgTipContainer'+i).remove();MsgTipStartNum=i+1;eval('MsgTip'+(i+1)+'=null;');break;}}}," + params.during + ");"); } else { { MsgTipData[MsgTipData.length] = "MsgTipContainerNoDuring" + MsgTipData.length; } }
		}; MsgTip.hide = function () { for (var i = 0; i < MsgTipData.length; i++) { if ($("#" + MsgTipData[i]).length != 0) { $("#" + MsgTipData[i]).remove(); } } }; MsgTip.getTipNum = function () { return MsgTipNum + MsgTipData.length; }
	})();
}; MsgTip.ScrollTopHeight = function () { if (document.documentElement && document.documentElement.scrollTop) { return document.documentElement.scrollTop; } else if (document.body && document.body.scrollTop) { return document.body.scrollTop; } else if (window.pageYOffset) { return window.pageYOffset; } return 0; }
function $GetStrLength(str) {
	var len = str.length;
	var relen = 0;
	for (var i = 0; i < len; i++) {
		if (str.charCodeAt(i) < 27 || str.charCodeAt(i) > 126) {
			relen += 2;
		} else {
			relen++;
		}
	}
	return relen / 2;
}
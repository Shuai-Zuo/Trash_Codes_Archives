// ******************************************************************
// 文件名: Light.EXP.WebUI.SystemFrame.calendar.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-23
// 主要内容：  日历控件
// ******************************************************************

namespace Light.EXP.WebUI.SystemFrame
{
    using System;
    using System.ComponentModel;
    using System.Collections;
    using System.Diagnostics;
    using System.Data;
    using System.Data.SqlClient;
    using System.Drawing;
    using System.Web;
    using System.Web.SessionState;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;
    using System.Configuration;
    using System.Web.Hosting;
    using System.Security.Cryptography;
    using System.Web.Security;
    using System.Security.Policy;
    using System.IO;
    using System.Text;

	public class calendar
	{
		/// <summary>
		///设置TextBox显示日历
		/// </summary>
		/// <param name="Message">按钮点击时的alert提示信息</param>
		/// <returns>返回是否成功</returns>
		public bool SetCalendar(System.Web.UI.WebControls.TextBox MyTextBox)
		{
			MyTextBox.Attributes["OnDblClick"]="setday(this)";
			return true;
		}

		/// <summary>
		///使当前页面创建日历js脚本,默认接口为:setday(this)
		/// </summary>
		/// <returns>返回是否成功</returns>
		public bool CreateCalendar()
		{
			string TempMsg="";
			TempMsg=TempMsg+"<SCRIPT LANGUAGE=\"JavaScript\">\n";
			TempMsg=TempMsg+"		<!--\n";
			TempMsg=TempMsg+"//############################################\n";
			TempMsg=TempMsg+"//控 件 名 称：Asp.Net日期输入TextBox\n";
			TempMsg=TempMsg+"//版       本：2.0\n";
			TempMsg=TempMsg+"//发 布 日 期：  2003/6/17\n";
			TempMsg=TempMsg+"//############################################\n";
			TempMsg=TempMsg+"var bMoveable=true;\n";
			TempMsg=TempMsg+"var strFrame;\n";
			TempMsg=TempMsg+"document.writeln('<iframe id=meizzDateLayer Author=wayx frameborder=0 style=\"position: absolute; width: 144; height: 211; z-index: 9998; display: none\"></iframe>');\n";
			TempMsg=TempMsg+"strFrame='<style>';\n";
			TempMsg=TempMsg+"strFrame+='INPUT.button{BORDER-RIGHT: #9ACD32 1px solid;BORDER-TOP: #9ACD32 1px solid;BORDER-LEFT: #9ACD32 1px solid;';\n";
			TempMsg=TempMsg+"strFrame+='BORDER-BOTTOM: #9ACD32 1px solid;BACKGROUND-COLOR: #fff8ec;font-family:宋体;}';\n";
			TempMsg=TempMsg+"strFrame+='TD{FONT-SIZE: 9pt;font-family:宋体;}';\n";
			TempMsg=TempMsg+"strFrame+='</style>';\n";
			TempMsg=TempMsg+"strFrame+='<scr' + 'ipt>';\n";
			TempMsg=TempMsg+"strFrame+='var datelayerx,datelayery;';\n";
			TempMsg=TempMsg+"strFrame+='var bDrag;';\n";
			TempMsg=TempMsg+"strFrame+='function document.onmousemove()';\n";
			TempMsg=TempMsg+"strFrame+='{if(bDrag && window.event.button==1)';\n";
			TempMsg=TempMsg+"strFrame+='	{var DateLayer=parent.document.all.meizzDateLayer.style;';\n";
			TempMsg=TempMsg+"strFrame+='		DateLayer.posLeft += window.event.clientX-datelayerx;';\n";
			TempMsg=TempMsg+"strFrame+='		DateLayer.posTop += window.event.clientY-datelayery;}}';\n";
			TempMsg=TempMsg+"strFrame+='function DragStart()';\n";
			TempMsg=TempMsg+"strFrame+='{var DateLayer=parent.document.all.meizzDateLayer.style;';\n";
			TempMsg=TempMsg+"strFrame+='	datelayerx=window.event.clientX;';\n";
			TempMsg=TempMsg+"strFrame+='	datelayery=window.event.clientY;';\n";
			TempMsg=TempMsg+"strFrame+='	bDrag=true;}';\n";
			TempMsg=TempMsg+"strFrame+='function DragEnd(){';\n";
			TempMsg=TempMsg+"strFrame+='	bDrag=false;}';\n";
			TempMsg=TempMsg+"strFrame+='</scr' + 'ipt>';\n";
			TempMsg=TempMsg+"strFrame+='<div style=\"z-index:9999;position: absolute; left:0; top:0;\" onselectstart=\"return false\"><span id=tmpSelectYearLayer Author=wayx style=\"z-index: 9999;position: absolute;top: 3; left: 19;display: none\"></span>';\n";
			TempMsg=TempMsg+"strFrame+='<span id=tmpSelectMonthLayer Author=wayx style=\"z-index: 9999;position: absolute;top: 3; left: 78;display: none\"></span>';\n";
			TempMsg=TempMsg+"strFrame+='<table border=1 cellspacing=0 cellpadding=0 width=142 height=160 bordercolor=#9ACD32 bgcolor=#9ACD32 Author=\"wayx\">';\n";
			TempMsg=TempMsg+"strFrame+='  <tr Author=\"wayx\"><td width=142 height=23 Author=\"wayx\" bgcolor=#FFFFFF><table border=0 cellspacing=1 cellpadding=0 width=140 Author=\"wayx\" height=23>';\n";
			TempMsg=TempMsg+"strFrame+='      <tr align=center Author=\"wayx\"><td width=16 align=center bgcolor=#9ACD32 style=\"font-size:12px;cursor: hand;color: #FFFFFF\" ';\n";
			TempMsg=TempMsg+"strFrame+='        onclick=\"parent.meizzPrevM()\" title=\"向前翻 1 月\" Author=meizz><b Author=meizz>&lt;</b>';\n";
			TempMsg=TempMsg+"strFrame+='        </td><td width=60 align=center style=\"font-size:12px;cursor:default;BACKGROUND-COLOR:#9ACD32\" Author=meizz ';\n";
			TempMsg=TempMsg+"strFrame+='onmouseover=\"style.backgroundColor=\\'#6B8E23\\'\" onmouseout=\"style.backgroundColor=\\'#9ACD32\\'\" ';\n";
			TempMsg=TempMsg+"strFrame+='onclick=\"parent.tmpSelectYearInnerHTML(this.innerText.substring(0,4))\" title=\"点击这里选择年份\"><span Author=meizz id=meizzYearHead></span></td>';\n";
			TempMsg=TempMsg+"strFrame+='<td width=48 align=center style=\"font-size:12px;cursor:default;BACKGROUND-COLOR:#9ACD32\" Author=meizz onmouseover=\"style.backgroundColor=\\'#6B8E23\\';\" ';\n";
			TempMsg=TempMsg+"strFrame+=' onmouseout=\"style.backgroundColor=\\'#9ACD32\\'\" onclick=\"parent.tmpSelectMonthInnerHTML(this.innerText.length==3?this.innerText.substring(0,1):this.innerText.substring(0,2))\"';\n";
			TempMsg=TempMsg+"strFrame+='        title=\"点击这里选择月份\"><span id=meizzMonthHead Author=meizz></span></td>';\n";
			TempMsg=TempMsg+"strFrame+='        <td width=16 bgcolor=#9ACD32 align=center style=\"font-size:12px;cursor: hand;color:#FFFFFF\" ';\n";
			TempMsg=TempMsg+"strFrame+='         onclick=\"parent.meizzNextM()\" title=\"向后翻 1 月\" Author=meizz><b Author=meizz>&gt;</b></td></tr>';\n";
			TempMsg=TempMsg+"strFrame+='    </table></td></tr>';\n";
			TempMsg=TempMsg+"strFrame+='  <tr Author=\"wayx\"><td width=142 height=18 Author=\"wayx\">';\n";
			TempMsg=TempMsg+"strFrame+='<table border=1 cellspacing=0 cellpadding=0 bgcolor=#9ACD32 ' + (bMoveable? 'onmousedown=\"DragStart()\" onmouseup=\"DragEnd()\"':'');\n";
			TempMsg=TempMsg+"strFrame+=' BORDERCOLORLIGHT=#9ACD32 BORDERCOLORDARK=#FFFFFF width=140 height=20 Author=\"wayx\" style=\"cursor:' + (bMoveable ? 'move':'default') + '\">';\n";
			TempMsg=TempMsg+"strFrame+='<tr Author=\"wayx\" align=center valign=bottom><td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>日</td>';\n";
			TempMsg=TempMsg+"strFrame+='<td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>一</td><td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>二</td>';\n";
			TempMsg=TempMsg+"strFrame+='<td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>三</td><td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>四</td>';\n";
			TempMsg=TempMsg+"strFrame+='<td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>五</td><td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>六</td></tr>';\n";
			TempMsg=TempMsg+"strFrame+='</table></td></tr>';\n";
			TempMsg=TempMsg+"strFrame+='  <tr Author=\"wayx\"><td width=142 height=120 Author=\"wayx\">';\n";
			TempMsg=TempMsg+"strFrame+='    <table border=1 cellspacing=2 cellpadding=0 BORDERCOLORLIGHT=#9ACD32 BORDERCOLORDARK=#FFFFFF bgcolor=#fff8ec width=140 height=120 Author=\"wayx\">';\n";
			TempMsg=TempMsg+"var n=0; for (j=0;j<5;j++){ strFrame+= ' <tr align=center Author=\"wayx\">'; for (i=0;i<7;i++){\n";
			TempMsg=TempMsg+"strFrame+='<td width=20 height=20 id=meizzDay'+n+' style=\"font-size:12px\" Author=meizz onclick=parent.meizzDayClick(this.innerText,0)></td>';n++;}\n";
			TempMsg=TempMsg+"strFrame+='</tr>';}\n";
			TempMsg=TempMsg+"strFrame+='      <tr align=center Author=\"wayx\">';\n";
			TempMsg=TempMsg+"for (i=35;i<39;i++)strFrame+='<td width=20 height=20 id=meizzDay'+i+' style=\"font-size:12px\" Author=wayx onclick=\"parent.meizzDayClick(this.innerText,0)\"></td>';\n";
			TempMsg=TempMsg+"strFrame+='        <td colspan=3 align=right Author=meizz><span onclick=parent.closeLayer() style=\"font-size:12px;cursor: hand\"';\n";
			TempMsg=TempMsg+"strFrame+='         Author=meizz><u>关闭</u></span>&nbsp;</td></tr>';\n";
			TempMsg=TempMsg+"strFrame+='    </table></td></tr><tr Author=\"wayx\"><td Author=\"wayx\">';\n";
			TempMsg=TempMsg+"strFrame+='        <table border=0 cellspacing=1 cellpadding=0 width=100% Author=\"wayx\" bgcolor=#FFFFFF>';\n";
			TempMsg=TempMsg+"strFrame+='          <tr Author=\"wayx\"><td Author=meizz align=left><input Author=meizz type=button class=button value=\"<<\" title=\"向前翻 1 年\" onclick=\"parent.meizzPrevY()\" ';\n";
			TempMsg=TempMsg+"strFrame+='             onfocus=\"this.blur()\" style=\"font-size: 12px; height: 20px\"><input Author=meizz class=button title=\"向前翻 1 月\" type=button ';\n";
			TempMsg=TempMsg+"strFrame+='             value=\"< \" onclick=\"parent.meizzPrevM()\" onfocus=\"this.blur()\" style=\"font-size: 12px; height: 20px\"></td><td ';\n";
			TempMsg=TempMsg+"strFrame+='             Author=meizz align=center><input Author=meizz type=button class=button value=Today onclick=\"parent.meizzToday()\" ';\n";
			TempMsg=TempMsg+"strFrame+='             onfocus=\"this.blur()\" title=\"当前日期\" style=\"font-size: 12px; height: 20px; cursor:hand\"></td><td ';\n";
			TempMsg=TempMsg+"strFrame+='             Author=meizz align=right><input Author=meizz type=button class=button value=\" >\" onclick=\"parent.meizzNextM()\" ';\n";
			TempMsg=TempMsg+"strFrame+='             onfocus=\"this.blur()\" title=\"向后翻 1 月\" class=button style=\"font-size: 12px; height: 20px\"><input ';\n";
			TempMsg=TempMsg+"strFrame+='             Author=meizz type=button class=button value=\">>\" title=\"向后翻 1 年\" onclick=\"parent.meizzNextY()\"';\n";
			TempMsg=TempMsg+"strFrame+='             onfocus=\"this.blur()\" style=\"font-size: 12px; height: 20px\"></td>';\n";
			TempMsg=TempMsg+"strFrame+='</tr></table></td></tr></table></div>';\n";
			TempMsg=TempMsg+"window.frames.meizzDateLayer.document.writeln(strFrame);\n";
			TempMsg=TempMsg+"window.frames.meizzDateLayer.document.close();\n";
			TempMsg=TempMsg+"var outObject;\n";
			TempMsg=TempMsg+"var outButton;\n";
			TempMsg=TempMsg+"var outDate=\"\";\n";
			TempMsg=TempMsg+"var odatelayer=window.frames.meizzDateLayer.document.all;\n";
			TempMsg=TempMsg+"function setday(tt,obj)\n";
			TempMsg=TempMsg+"{\n";
			TempMsg=TempMsg+"	if (arguments.length >  2){alert(\"对不起！传入本控件的参数太多！\");return;}\n";
			TempMsg=TempMsg+"	if (arguments.length == 0){alert(\"对不起！您没有传回本控件任何参数！\");return;}\n";
			TempMsg=TempMsg+"	var dads  = document.all.meizzDateLayer.style;\n";
			TempMsg=TempMsg+"	var th = tt;\n";
			TempMsg=TempMsg+"	var ttop  = tt.offsetTop;   \n";
			TempMsg=TempMsg+"	var thei  = tt.clientHeight; \n";
			TempMsg=TempMsg+"	var tleft = tt.offsetLeft;   \n";
			TempMsg=TempMsg+"	var ttyp  = tt.type;       \n";
			TempMsg=TempMsg+"	while (tt = tt.offsetParent){ttop+=tt.offsetTop; tleft+=tt.offsetLeft;}\n";
			TempMsg=TempMsg+"	dads.top  = (ttyp==\"image\")? ttop+thei : ttop+thei+6;\n";
			TempMsg=TempMsg+"	dads.left = tleft;\n";
			TempMsg=TempMsg+"	outObject = (arguments.length == 1) ? th : obj;\n";
			TempMsg=TempMsg+"	outButton = (arguments.length == 1) ? null : th;\n";
			TempMsg=TempMsg+"	var reg = /^(\\d+)\\-(\\d{1,2})\\-(\\d{1,2})$/; \n";
			TempMsg=TempMsg+"	var r = outObject.value.match(reg); \n";
			TempMsg=TempMsg+"	if(r!=null){\n";
			TempMsg=TempMsg+"		r[2]=r[2]-1; \n";
			TempMsg=TempMsg+"		var d= new Date(r[1], r[2],r[3]); \n";
			TempMsg=TempMsg+"		if(d.getFullYear()==r[1] && d.getMonth()==r[2] && d.getDate()==r[3]){\n";
			TempMsg=TempMsg+"			outDate=d;	\n";
			TempMsg=TempMsg+"		}\n";
			TempMsg=TempMsg+"		else outDate=\"\";\n";
			TempMsg=TempMsg+"			meizzSetDay(r[1],r[2]+1);\n";
			TempMsg=TempMsg+"	}\n";
			TempMsg=TempMsg+"	else{\n";
			TempMsg=TempMsg+"		outDate=\"\";\n";
			TempMsg=TempMsg+"		meizzSetDay(new Date().getFullYear(), new Date().getMonth() + 1);\n";
			TempMsg=TempMsg+"	}\n";
			TempMsg=TempMsg+"	dads.display = '';\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"	event.returnValue=false;\n";
			TempMsg=TempMsg+"}\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"var MonHead = new Array(12);    		 \n";
			TempMsg=TempMsg+"    MonHead[0] = 31; MonHead[1] = 28; MonHead[2] = 31; MonHead[3] = 30; MonHead[4]  = 31; MonHead[5]  = 30;\n";
			TempMsg=TempMsg+"    MonHead[6] = 31; MonHead[7] = 31; MonHead[8] = 30; MonHead[9] = 31; MonHead[10] = 30; MonHead[11] = 31;\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"var meizzTheYear=new Date().getFullYear(); \n";
			TempMsg=TempMsg+"var meizzTheMonth=new Date().getMonth()+1;\n";
			TempMsg=TempMsg+"var meizzWDay=new Array(39);              \n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"function document.onclick()\n";
			TempMsg=TempMsg+"{ \n";
			TempMsg=TempMsg+"  with(window.event)\n";
			TempMsg=TempMsg+"  { if (srcElement.getAttribute(\"Author\")==null && srcElement != outObject && srcElement != outButton)\n";
			TempMsg=TempMsg+"    closeLayer();\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"}\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"function document.onkeyup()\n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    if (window.event.keyCode==27){\n";
			TempMsg=TempMsg+"		if(outObject)outObject.blur();\n";
			TempMsg=TempMsg+"		closeLayer();\n";
			TempMsg=TempMsg+"	}\n";
			TempMsg=TempMsg+"	else if(document.activeElement)\n";
			TempMsg=TempMsg+"		if(document.activeElement.getAttribute(\"Author\")==null && document.activeElement != outObject && document.activeElement != outButton)\n";
			TempMsg=TempMsg+"		{\n";
			TempMsg=TempMsg+"			closeLayer();\n";
			TempMsg=TempMsg+"		}\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"function meizzWriteHead(yy,mm)\n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"	odatelayer.meizzYearHead.innerText  = yy + \" 年\";\n";
			TempMsg=TempMsg+"    odatelayer.meizzMonthHead.innerText = mm + \" 月\";\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"function tmpSelectYearInnerHTML(strYear) \n";
			TempMsg=TempMsg+"{\n";
			TempMsg=TempMsg+"  if (strYear.match(/\\D/)!=null){alert(\"年份输入参数不是数字！\");return;}\n";
			TempMsg=TempMsg+"  var m = (strYear) ? strYear : new Date().getFullYear();\n";
			TempMsg=TempMsg+"  if (m < 1000 || m > 9999) {alert(\"年份值不在 1000 到 9999 之间！\");return;}\n";
			TempMsg=TempMsg+"  var n = m - 10;\n";
			TempMsg=TempMsg+"  if (n < 1000) n = 1000;\n";
			TempMsg=TempMsg+"  if (n + 51 > 9999) n = 9949;\n";
			TempMsg=TempMsg+"  var s = \"<select Author=meizz name=tmpSelectYear style='font-size: 12px' \"\n";
			TempMsg=TempMsg+"     s += \"onblur='document.all.tmpSelectYearLayer.style.display=\\\"none\\\"' \"\n";
			TempMsg=TempMsg+"     s += \"onchange='document.all.tmpSelectYearLayer.style.display=\\\"none\\\";\"\n";
			TempMsg=TempMsg+"     s += \"parent.meizzTheYear = this.value; parent.meizzSetDay(parent.meizzTheYear,parent.meizzTheMonth)'>\\r\\n\";\n";
			TempMsg=TempMsg+"  var selectInnerHTML = s;\n";
			TempMsg=TempMsg+"  for (var i = n; i < n + 51; i++)\n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    if (i == m)\n";
			TempMsg=TempMsg+"       {selectInnerHTML += \"<option Author=wayx value='\" + i + \"' selected>\" + i + \"年\" + \"</option>\\r\\n\";}\n";
			TempMsg=TempMsg+"    else {selectInnerHTML += \"<option Author=wayx value='\" + i + \"'>\" + i + \"年\" + \"</option>\\r\\n\";}\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"  selectInnerHTML += \"</select>\";\n";
			TempMsg=TempMsg+"  odatelayer.tmpSelectYearLayer.style.display=\"\";\n";
			TempMsg=TempMsg+"  odatelayer.tmpSelectYearLayer.innerHTML = selectInnerHTML;\n";
			TempMsg=TempMsg+"  odatelayer.tmpSelectYear.focus();\n";
			TempMsg=TempMsg+"}\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"function tmpSelectMonthInnerHTML(strMonth)\n";
			TempMsg=TempMsg+"{\n";
			TempMsg=TempMsg+"  if (strMonth.match(/\\D/)!=null){alert(\"月份输入参数不是数字！\");return;}\n";
			TempMsg=TempMsg+"  var m = (strMonth) ? strMonth : new Date().getMonth() + 1;\n";
			TempMsg=TempMsg+"  var s = \"<select Author=meizz name=tmpSelectMonth style='font-size: 12px' \"\n";
			TempMsg=TempMsg+"     s += \"onblur='document.all.tmpSelectMonthLayer.style.display=\\\"none\\\"' \"\n";
			TempMsg=TempMsg+"     s += \"onchange='document.all.tmpSelectMonthLayer.style.display=\\\"none\\\";\"\n";
			TempMsg=TempMsg+"     s += \"parent.meizzTheMonth = this.value; parent.meizzSetDay(parent.meizzTheYear,parent.meizzTheMonth)'>\\r\\n\";\n";
			TempMsg=TempMsg+"  var selectInnerHTML = s;\n";
			TempMsg=TempMsg+"  for (var i = 1; i < 13; i++)\n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    if (i == m)\n";
			TempMsg=TempMsg+"       {selectInnerHTML += \"<option Author=wayx value='\"+i+\"' selected>\"+i+\"月\"+\"</option>\\r\\n\";}\n";
			TempMsg=TempMsg+"    else {selectInnerHTML += \"<option Author=wayx value='\"+i+\"'>\"+i+\"月\"+\"</option>\\r\\n\";}\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"  selectInnerHTML += \"</select>\";\n";
			TempMsg=TempMsg+"  odatelayer.tmpSelectMonthLayer.style.display=\"\";\n";
			TempMsg=TempMsg+"  odatelayer.tmpSelectMonthLayer.innerHTML = selectInnerHTML;\n";
			TempMsg=TempMsg+"  odatelayer.tmpSelectMonth.focus();\n";
			TempMsg=TempMsg+"}\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"function closeLayer()\n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    document.all.meizzDateLayer.style.display=\"none\";\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"function IsPinYear(year) \n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    if (0==year%4&&((year%100!=0)||(year%400==0))) return true;else return false;\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"function GetMonthCount(year,month) \n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    var c=MonHead[month-1];if((month==2)&&IsPinYear(year)) c++;return c;\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"function GetDOW(day,month,year)\n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    var dt=new Date(year,month-1,day).getDay()/7; return dt;\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"function meizzPrevY()\n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    if(meizzTheYear > 999 && meizzTheYear <10000){meizzTheYear--;}\n";
			TempMsg=TempMsg+"    else{alert(\"年份超出范围（1000-9999）！\");}\n";
			TempMsg=TempMsg+"    meizzSetDay(meizzTheYear,meizzTheMonth);\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"function meizzNextY() \n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    if(meizzTheYear > 999 && meizzTheYear <10000){meizzTheYear++;}\n";
			TempMsg=TempMsg+"    else{alert(\"年份超出范围（1000-9999）！\");}\n";
			TempMsg=TempMsg+"    meizzSetDay(meizzTheYear,meizzTheMonth);\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"function meizzToday() \n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"	var today;\n";
			TempMsg=TempMsg+"    meizzTheYear = new Date().getFullYear();\n";
			TempMsg=TempMsg+"    meizzTheMonth = new Date().getMonth()+1;\n";
			TempMsg=TempMsg+"    today=new Date().getDate();\n";
			TempMsg=TempMsg+"    //meizzSetDay(meizzTheYear,meizzTheMonth);\n";
			TempMsg=TempMsg+"    if(outObject){\n";
			TempMsg=TempMsg+"		outObject.value=meizzTheYear + \"-\" + meizzTheMonth + \"-\" + today;\n";
			TempMsg=TempMsg+"    }\n";
			TempMsg=TempMsg+"    closeLayer();\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"function meizzPrevM()\n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    if(meizzTheMonth>1){meizzTheMonth--}else{meizzTheYear--;meizzTheMonth=12;}\n";
			TempMsg=TempMsg+"    meizzSetDay(meizzTheYear,meizzTheMonth);\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"function meizzNextM()\n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    if(meizzTheMonth==12){meizzTheYear++;meizzTheMonth=1}else{meizzTheMonth++}\n";
			TempMsg=TempMsg+"    meizzSetDay(meizzTheYear,meizzTheMonth);\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"function meizzSetDay(yy,mm)\n";
			TempMsg=TempMsg+"{\n";
			TempMsg=TempMsg+"  meizzWriteHead(yy,mm);\n";
			TempMsg=TempMsg+"  meizzTheYear=yy;\n";
			TempMsg=TempMsg+"  meizzTheMonth=mm;\n";
			TempMsg=TempMsg+"  for (var i = 0; i < 39; i++){meizzWDay[i]=\"\"};\n";
			TempMsg=TempMsg+"  var day1 = 1,day2=1,firstday = new Date(yy,mm-1,1).getDay(); \n";
			TempMsg=TempMsg+"  for (i=0;i<firstday;i++)meizzWDay[i]=GetMonthCount(mm==1?yy-1:yy,mm==1?12:mm-1)-firstday+i+1\n";
			TempMsg=TempMsg+"  for (i = firstday; day1 < GetMonthCount(yy,mm)+1; i++){meizzWDay[i]=day1;day1++;}\n";
			TempMsg=TempMsg+"  for (i=firstday+GetMonthCount(yy,mm);i<39;i++){meizzWDay[i]=day2;day2++}\n";
			TempMsg=TempMsg+"  for (i = 0; i < 39; i++)\n";
			TempMsg=TempMsg+"  { var da = eval(\"odatelayer.meizzDay\"+i)\n";
			TempMsg=TempMsg+"    if (meizzWDay[i]!=\"\")\n";
			TempMsg=TempMsg+"      { \n";
			TempMsg=TempMsg+"		da.borderColorLight=\"#9ACD32\";\n";
			TempMsg=TempMsg+"		da.borderColorDark=\"#FFFFFF\";\n";
			TempMsg=TempMsg+"		if(i<firstday)\n";
			TempMsg=TempMsg+"		{\n";
			TempMsg=TempMsg+"			da.innerHTML=\"<b><font color=gray>\" + meizzWDay[i] + \"</font></b>\";\n";
			TempMsg=TempMsg+"			da.title=(mm==1?12:mm-1) +\"月\" + meizzWDay[i] + \"日\";\n";
			TempMsg=TempMsg+"			da.onclick=Function(\"meizzDayClick(this.innerText,-1)\");\n";
			TempMsg=TempMsg+"			if(!outDate)\n";
			TempMsg=TempMsg+"				da.style.backgroundColor = ((mm==1?yy-1:yy) == new Date().getFullYear() && \n";
			TempMsg=TempMsg+"					(mm==1?12:mm-1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ?\n";
			TempMsg=TempMsg+"					 \"#FFD700\":\"#e0e0e0\";\n";
			TempMsg=TempMsg+"			else\n";
			TempMsg=TempMsg+"			{\n";
			TempMsg=TempMsg+"				da.style.backgroundColor =((mm==1?yy-1:yy)==outDate.getFullYear() && (mm==1?12:mm-1)== outDate.getMonth() + 1 && \n";
			TempMsg=TempMsg+"				meizzWDay[i]==outDate.getDate())? \"#00ffff\" :\n";
			TempMsg=TempMsg+"				(((mm==1?yy-1:yy) == new Date().getFullYear() && (mm==1?12:mm-1) == new Date().getMonth()+1 && \n";
			TempMsg=TempMsg+"				meizzWDay[i] == new Date().getDate()) ? \"#FFD700\":\"#e0e0e0\");\n";
			TempMsg=TempMsg+"				if((mm==1?yy-1:yy)==outDate.getFullYear() && (mm==1?12:mm-1)== outDate.getMonth() + 1 && \n";
			TempMsg=TempMsg+"				meizzWDay[i]==outDate.getDate())\n";
			TempMsg=TempMsg+"				{\n";
			TempMsg=TempMsg+"					da.borderColorLight=\"#FFFFFF\";\n";
			TempMsg=TempMsg+"					da.borderColorDark=\"#9ACD32\";\n";
			TempMsg=TempMsg+"				}\n";
			TempMsg=TempMsg+"			}\n";
			TempMsg=TempMsg+"		}\n";
			TempMsg=TempMsg+"		else if (i>=firstday+GetMonthCount(yy,mm))\n";
			TempMsg=TempMsg+"		{\n";
			TempMsg=TempMsg+"			da.innerHTML=\"<b><font color=gray>\" + meizzWDay[i] + \"</font></b>\";\n";
			TempMsg=TempMsg+"			da.title=(mm==12?1:mm+1) +\"月\" + meizzWDay[i] + \"日\";\n";
			TempMsg=TempMsg+"			da.onclick=Function(\"meizzDayClick(this.innerText,1)\");\n";
			TempMsg=TempMsg+"			if(!outDate)\n";
			TempMsg=TempMsg+"				da.style.backgroundColor = ((mm==12?yy+1:yy) == new Date().getFullYear() && \n";
			TempMsg=TempMsg+"					(mm==12?1:mm+1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ?\n";
			TempMsg=TempMsg+"					 \"#FFD700\":\"#e0e0e0\";\n";
			TempMsg=TempMsg+"			else\n";
			TempMsg=TempMsg+"			{\n";
			TempMsg=TempMsg+"				da.style.backgroundColor =((mm==12?yy+1:yy)==outDate.getFullYear() && (mm==12?1:mm+1)== outDate.getMonth() + 1 && \n";
			TempMsg=TempMsg+"				meizzWDay[i]==outDate.getDate())? \"#00ffff\" :\n";
			TempMsg=TempMsg+"				(((mm==12?yy+1:yy) == new Date().getFullYear() && (mm==12?1:mm+1) == new Date().getMonth()+1 && \n";
			TempMsg=TempMsg+"				meizzWDay[i] == new Date().getDate()) ? \"#FFD700\":\"#e0e0e0\");\n";
			TempMsg=TempMsg+"				if((mm==12?yy+1:yy)==outDate.getFullYear() && (mm==12?1:mm+1)== outDate.getMonth() + 1 && \n";
			TempMsg=TempMsg+"				meizzWDay[i]==outDate.getDate())\n";
			TempMsg=TempMsg+"				{\n";
			TempMsg=TempMsg+"					da.borderColorLight=\"#FFFFFF\";\n";
			TempMsg=TempMsg+"					da.borderColorDark=\"#9ACD32\";\n";
			TempMsg=TempMsg+"				}\n";
			TempMsg=TempMsg+"			}\n";
			TempMsg=TempMsg+"		}\n";
			TempMsg=TempMsg+"		else\n";
			TempMsg=TempMsg+"		{\n";
			TempMsg=TempMsg+"			da.innerHTML=\"<b>\" + meizzWDay[i] + \"</b>\";\n";
			TempMsg=TempMsg+"			da.title=mm +\"月\" + meizzWDay[i] + \"日\";\n";
			TempMsg=TempMsg+"			da.onclick=Function(\"meizzDayClick(this.innerText,0)\");\n";
			TempMsg=TempMsg+"			if(!outDate)\n";
			TempMsg=TempMsg+"				da.style.backgroundColor = (yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate())?\n";
			TempMsg=TempMsg+"					\"#FFD700\":\"#e0e0e0\";\n";
			TempMsg=TempMsg+"			else\n";
			TempMsg=TempMsg+"			{\n";
			TempMsg=TempMsg+"				da.style.backgroundColor =(yy==outDate.getFullYear() && mm== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())?\n";
			TempMsg=TempMsg+"					\"#00ffff\":((yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate())?\n";
			TempMsg=TempMsg+"					\"#FFD700\":\"#e0e0e0\");\n";
			TempMsg=TempMsg+"				if(yy==outDate.getFullYear() && mm== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())\n";
			TempMsg=TempMsg+"				{\n";
			TempMsg=TempMsg+"					da.borderColorLight=\"#FFFFFF\";\n";
			TempMsg=TempMsg+"					da.borderColorDark=\"#9ACD32\";\n";
			TempMsg=TempMsg+"				}\n";
			TempMsg=TempMsg+"			}\n";
			TempMsg=TempMsg+"		}\n";
			TempMsg=TempMsg+"        da.style.cursor=\"hand\"\n";
			TempMsg=TempMsg+"      }\n";
			TempMsg=TempMsg+"    else{da.innerHTML=\"\";da.style.backgroundColor=\"\";da.style.cursor=\"default\"}\n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"}\n";
			TempMsg=TempMsg+"\n";
			TempMsg=TempMsg+"function meizzDayClick(n,ex)\n";
			TempMsg=TempMsg+"{\n";
			TempMsg=TempMsg+"  var yy=meizzTheYear;\n";
			TempMsg=TempMsg+"  var mm = parseInt(meizzTheMonth)+ex;\n";
			TempMsg=TempMsg+"	if(mm<1){\n";
			TempMsg=TempMsg+"		yy--;\n";
			TempMsg=TempMsg+"		mm=12+mm;\n";
			TempMsg=TempMsg+"	}\n";
			TempMsg=TempMsg+"	else if(mm>12){\n";
			TempMsg=TempMsg+"		yy++;\n";
			TempMsg=TempMsg+"		mm=mm-12;\n";
			TempMsg=TempMsg+"	}\n";
			TempMsg=TempMsg+"	\n";
			TempMsg=TempMsg+"  if (mm < 10){mm = \"0\" + mm;}\n";
			TempMsg=TempMsg+"  if (outObject)\n";
			TempMsg=TempMsg+"  {\n";
			TempMsg=TempMsg+"    if (!n) {//outObject.value=\"\"; \n";
			TempMsg=TempMsg+"      return;}\n";
			TempMsg=TempMsg+"    if ( n < 10){n = \"0\" + n;}\n";
			TempMsg=TempMsg+"    outObject.value= yy + \"-\" + mm + \"-\" + n ;\n";
			TempMsg=TempMsg+"    closeLayer(); \n";
			TempMsg=TempMsg+"  }\n";
			TempMsg=TempMsg+"  else {closeLayer(); alert(\"您所要输出的控件对象并不存在！\");}\n";
			TempMsg=TempMsg+"}\n";
			TempMsg=TempMsg+"	//-->\n";
			TempMsg=TempMsg+"		</SCRIPT>\n";
			TempMsg=TempMsg+"\n";

			System.Web.HttpContext.Current.Response.Write(TempMsg);

			return true;
		}
	}
}

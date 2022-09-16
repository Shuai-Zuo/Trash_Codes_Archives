<%@ Page language="c#" MasterPageFile="~/MasterPage.master" Inherits="Light.EXP.WebUI.SystemFrame.ErrorPage" CodeFile="ErrorPage.aspx.cs" CodeFileBaseClass="Light.EXP.WebUI.SystemFrame.PageBase" Theme="Default" %>
<asp:Content ID="cntnErrorPage" ContentPlaceHolderID="cphPage" Runat="Server">
    <table width="600" border="0" align="center" cellpadding="5" cellspacing="0" height="470">
        <tr>
	        <td bgcolor='#f5f9ff' valign="top">
		        <table width="100%" border="1" cellpadding="5" cellspacing="0" bordercolorlight='#4f7fc9'
			        bordercolordark='#d3d8e0'>
			        <tr bgcolor="#e4e4e4">
				        <td height="22" bgcolor='#e3efff'>
				            <strong>
				                <font color="red">发生问题：</font>
				            </strong>
				        </td>
			        </tr>
			        <tr>
				        <td height="22">
					        <table cellSpacing="0" cellPadding="0" width="100%" border="0">
						        <tr>
							        <td height="22">
								        <asp:Label id="lblMsg" runat="server" Width="100%"></asp:Label>
							        </td>
						        </tr>
					        </table>
				        </td>
			        </tr>
			        <tr>
				        <td height="22">
					        <div align="center">
					            <input type="button" value="返 回" style="WIDTH: 120px" onclick="javascript:history.back();">
					        </div>
				        </td>
			        </tr>
		        </table>
	        </td>
        </tr>
    </table>
</asp:Content>


<%@ Page language="c#" Inherits="Light.EXP.WebUI.SystemFrame.Login" CodeFile="Login.aspx.cs" Theme="Default" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head runat="server">
    <title>登录－启明快递运输管理系统</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
</head>
<body>
    <form id="frmLogin" method="post" runat="server">
        <table width="430" height="120" align="center">
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
        <table background="../images/login.gif" class="text" cellSpacing="0" cellPadding="10" width="430" height="322" border="0" align="center">
            <tr>
                <td height="150">&nbsp;</td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Login ID="lgnUserLogin" runat="server" DisplayRememberMe="False" DestinationPageUrl = "../Index.aspx" OnLoggedIn="lgnUserLogin_LoggedIn">
                    </asp:Login>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

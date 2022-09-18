<%@ Page language="c#" MasterPageFile="~/MasterPage.master" Inherits="Light.EXP.WebUI.User.UserView" CodeFile="UserView.aspx.cs" CodeFileBaseClass="Light.EXP.WebUI.SystemFrame.PageBase" Theme="Default"%>
<asp:Content ID="cntnUserView" ContentPlaceHolderID="cphPage" Runat="Server">
    <table class="text" cellSpacing="0" cellPadding="0" width="609" height="420" align="center" border="0">
	    <tr>
		    <td align="center" background="../Images/wla_top005.gif">
			    <table class="text" cellSpacing="0" cellPadding="0" width="609" border="0">
				    <tr>
					    <td align="right" width="342">
					        <strong>用户查看</strong>
					    </td>
					    <td align="right" width="267">
					        <a href="../Index.aspx" target="_self">
					            <img height="24" src="../Images/wla_top019.gif" width="21" border="0">
					        </a>
					    </td>
				    </tr>
			    </table>
		    </td>
	    </tr>
	    <tr>
		    <td vAlign="top" align="center" background="../Images/wla_top006.gif" height="100%">
			    <table cellSpacing="0" cellPadding="0" width="572" border="0">
				    <tr>
					    <td>
                            <asp:FormView ID="frmvUserView" runat="server" DataSourceID="objdUserView">
                                <ItemTemplate>
                                    <table class="text" cellSpacing="0" cellPadding="3" width="570" border="0">
                                        <tr bgColor="#ffffff">
                                            <td align="right" width="100">登录ID： </td>
                                            <td width="195"  align="left">
                                                <%# Eval("LoginID") %>
                                            </td>
                                            <td width="100">用户名称：</td>
                                            <td width="195"  align="left">
                                                <%# Eval("UserName") %>
                                            </td>
                                        </tr>
                                        <tr bgColor="#f4f9ff">
                                            <td align="right">性别： </td>
                                            <td  align="left">
                                                <%# Eval("Sex").ToString() == "1" ? "男" : "女" %>
                                            </td>
                                            <td>出生日期：</td>
                                            <td  align="left">
                                                <%# Eval("Birthday", "{0:D}") %>
                                            </td>
                                        </tr>
                                        <tr bgColor="#ffffff">
                                            <td align="right" colSpan="4">
                                                <asp:ImageButton ID="imgbCancel" Runat="server" ImageUrl="../Images/anniu004.gif" OnClick="imgbCancel_Click"></asp:ImageButton>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:ObjectDataSource ID="objdUserView" runat="server">
                            </asp:ObjectDataSource>
                        </td>
				    </tr>
			    </table>
			    <table cellSpacing="0" cellPadding="1" width="570" bgColor="#7e7e7e" border="0">
				    <tr>
					    <td>
					    </td>
				    </tr>
			    </table>
		    </td>
	    </tr>
	    <tr>
		    <td>
		        <img height="21" src="../Images/wla_top007.gif" width="609">
		    </td>
	    </tr>
    </table>
</asp:Content>
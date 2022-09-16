<%@ Page language="c#" MasterPageFile="~/MasterPage.master" Inherits="Light.EXP.WebUI.User.UserList" CodeFile="UserList.aspx.cs" CodeFileBaseClass="Light.EXP.WebUI.SystemFrame.PageBase" Theme="Default" %>
<%@ Register Src="../Controls/DataPager.ascx" TagName="DataPager" TagPrefix="uc1" %>
<asp:Content ID="cntnUserList" ContentPlaceHolderID="cphPage" Runat="Server">
	<table height="400" cellSpacing="0" cellPadding="0" width="609" align="center" border="0">
		<tr>
			<td align="center" background="../Images/wla_top005.gif" height="24">
				<table cellSpacing="0" cellPadding="0" width="609" border="0">
					<tr>
						<td align="right" width="342">
						    <strong>用户管理</strong>
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
			<td vAlign="top" align="center" background="../Images/wla_top006.gif">
				<table cellSpacing="0" cellPadding="0" width="572" border="0">
					<tr>
						<td height="5"></td>
					</tr>
					<tr>
						<td align="right" style="height: 19px">
						    <a href="UserCreate.aspx">
						        <img height="15" src="../Images/image002.gif" width="20" align="absMiddle" border="0">增加用户
						    </a>
							<asp:linkbutton id="lnkbBatchDelete" Runat="server" OnClick="lnkbBatchDelete_Click">
							    <img height="15" src="../Images/image003.gif" width="20" align="absMiddle" border="0">批量删除
							</asp:linkbutton>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td vAlign="top" align="center" background="../Images/wla_top006.gif" height="100%">
				<table cellSpacing="0" cellPadding="0" width="572" border="0">
					<tr>
						<td vAlign="bottom" height="24"><img height="12" src="../Images/wla_top013.gif" width="572"></td>
					</tr>
					<tr>
						<td align="center" background="../Images/wla_top014.gif">
							<table cellSpacing="0" cellPadding="0" width="530" align="center" border="0">
								<tr>
									<td>用户名称：&nbsp;&nbsp;&nbsp;
										<asp:textbox id="txtbUserName" runat="server"></asp:textbox>&nbsp;&nbsp;&nbsp;&nbsp; 
										性别：
										<asp:dropdownlist id="drdlSex" runat="server" Width="100px">
											<asp:ListItem Value="0">全部</asp:ListItem>
											<asp:ListItem Value="1">男</asp:ListItem>
											<asp:ListItem Value="2">女</asp:ListItem>
										</asp:dropdownlist>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
										<asp:imagebutton id="imgbSearch" Runat="server" ImageUrl="../Images/wla_top016.gif" OnClick="imgbSearch_Click"></asp:imagebutton>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td><img height="4" src="../Images/wla_top015.gif" width="572"></td>
					</tr>
				</table>
				<table cellSpacing="0" cellPadding="0" width="572" border="0">
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				<table borderColor="#ffffff" cellSpacing="1" cellPadding="3" width="572" bgColor="#7d7d7d" border="0">
					<tr>
						<td align="left" bgColor="#ffffff" colSpan="6">
						    <asp:imagebutton id="imgbAllSelect" Runat="server" ImageUrl="../Images/an011.gif" OnClick="imgbAllSelect_Click"></asp:imagebutton>
							<asp:imagebutton id="imgbCancelSelect" Runat="server" ImageUrl="../Images/an015.gif" OnClick="imgbCancelSelect_Click"></asp:imagebutton>&nbsp; 
							每页显示数量：
							<asp:ImageButton ID="imgbFive" ImageUrl="../Images/5-1.gif" Runat="server" AlternateText="每页显示5条记录" OnClick="imgbFive_Click"></asp:ImageButton>&nbsp;
							<asp:ImageButton ID="imgbTen" ImageUrl="../Images/10-1.gif" Runat="server" AlternateText="每页显示10条记录" OnClick="imgbTen_Click"></asp:ImageButton>&nbsp;
							<asp:ImageButton ID="imgbFifteen" ImageUrl="../Images/15-1.gif" Runat="server" AlternateText="每页显示15条记录" OnClick="imgbFifteen_Click"></asp:ImageButton>&nbsp; 
							排序方式：
							<asp:ImageButton ID="imgbUp" ImageUrl="../Images/up-1.gif" Runat="server" AlternateText="升序排序" OnClick="imgbUp_Click"></asp:ImageButton>&nbsp;
							<asp:ImageButton ID="imgbDown" ImageUrl="../Images/down-1.gif" Runat="server" AlternateText="降序排序" OnClick="imgbDown_Click"></asp:ImageButton>&nbsp; 
							<asp:dropdownlist id="drdlSortField" Runat="server" Font-Size="9pt">
								<asp:ListItem Value="LoginId">登录ID</asp:ListItem>
								<asp:ListItem Value="Username">用户名称</asp:ListItem>
								<asp:ListItem Value="Sex">性别</asp:ListItem>
								<asp:ListItem Value="Birthday">出生日期</asp:ListItem>
							</asp:dropdownlist>
                        </td>
					</tr>
					<tr align="center" bgColor="#a4ceeb">
						<td width="20"></td>
						<td width="100">登录ID</td>
						<td width="150">用户名称</td>
						<td width="80">性别</td>
						<td width="100">出生日期</td>
						<td width="120">操作</td>
					</tr>
				</table>
				<asp:DataList ID="dtlUser" runat="server" Width="572px">
					<ItemTemplate>
						<tr bgcolor="ffffff" onMouseOver="this.style.backgroundColor='ffffff'" onMouseOut="this.style.backgroundColor='ffffff'">
							<td width="20"><input id="chkbUserID" type="checkbox" runat="server" value='<%# DataBinder.Eval(Container.DataItem,"LoginId")%>' NAME="chkbUserID"></td>
							<td width="100"><%# DataBinder.Eval(Container.DataItem,"LoginID")%></td>
							<td width="150"><%# DataBinder.Eval(Container.DataItem,"Username")%></td>
							<td width="80"><%# DataBinder.Eval(Container.DataItem,"Sex")%></td>
							<td width="100"><%# DataBinder.Eval(Container.DataItem,"Birthday")%></td>
							<td width="120">
								<a href = 'UserView.aspx?LoginID=<%# System.Web.HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"LoginID").ToString()) %>' title='查看用户信息'>
									<img src="../Images/tu007.gif" align="absMiddle" border="0">查看 </a><a href = 'UserUpdate.aspx?LoginID=<%# System.Web.HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"LoginID").ToString()) %>' title='编辑用户信息'>
									<img src="../Images/tu009.gif" align="absMiddle" border="0">编辑 </a>
							</td>
						</tr>
					</ItemTemplate>
				</asp:DataList>
				<table cellSpacing="0" cellPadding="0" width="572" border="0">
					<tr>
						<td align="center" height="8">
						    <uc1:DataPager ID="dtpUser" runat="server" ControlNameToPager="dtlUser" />
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
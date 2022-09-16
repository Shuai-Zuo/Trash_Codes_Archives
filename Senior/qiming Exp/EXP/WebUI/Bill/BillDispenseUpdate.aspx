<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master"CodeFile="BillDispenseUpdate.aspx.cs" Inherits="Light.EXP.WebUI.Bill.BillDispenseUpdate" Theme="Default" %>
<%@ Register Src="../Controls/DataPager.ascx" TagName="DataPager" TagPrefix="uc1" %>
<asp:Content ID="cntBillDispenseUpdate" ContentPlaceHolderID="cphPage" Runat="Server">
    <table cellSpacing="0" cellPadding="0" width="609" height="470" align="center" border="0">
        <tr>
			<td align="center" background="../Images/wla_top005.gif">
				<table cellSpacing="0" cellPadding="0" width="609" border="0">
					<tr>
						<td align="right" width="342">
						    <strong>单据分发编辑</strong>
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
			<td vAlign="top" align="center" background="../Images/wla_top006.gif" style="height: 97%">
				<table cellSpacing="0" cellPadding="0" width="572" border="0">
					<tr>
						<td style="height: 19px">&nbsp;</td>
					</tr>
				</table>
				<table cellSpacing="0" cellPadding="1" width="570" bgColor="#7e7e7e" border="0">
					<tr>
						<td>
                            <table cellSpacing="0" cellPadding="3" width="570" border="0">
						        <tr bgColor="#ffffff">
									<td align="left" width="15%">单据类型：</td>
									<td align="left" colspan="3">
                                        <asp:DropDownList ID="drdlBillType" runat="server" Enabled="False">
                                            <asp:ListItem Value="0">货运单</asp:ListItem>
                                            <asp:ListItem Value="1">回执单</asp:ListItem>
                                        </asp:DropDownList>
									</td>
								</tr>
						    </table>
							<table cellSpacing="0" cellPadding="3" width="570" border="0">
								<tr bgColor="#f4f9ff">
                                    <td align="left" width="15%">
                                         单据开始号：
                                    </td>
                                    <td align="left" width="35%">
                                        <asp:TextBox ID="txtbBillStartCode" runat="server" Enabled="False"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rqfvBillStartCode" runat="server" ControlToValidate="txtbBillStartCode"
                                        ErrorMessage="*" ToolTip="单据开始号不能为空！"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left" width="15%">
                                         单据结束号：
                                    </td>
                                    <td align="left" width="35%">
                                        <asp:TextBox ID="txtbBillEndCode" runat="server" Enabled="False"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rqfvBillEndCode" runat="server" ControlToValidate="txtbBillEndCode"
                                        ErrorMessage="*" ToolTip="单据结束号不能为空！"></asp:RequiredFieldValidator>&nbsp;
                                    </td>
                                </tr>
                                <tr bgColor="#ffffff">
                                    <td align="left">
                                         领票人：
                                    </td>
                                    <td align="left">
                                    <asp:DropDownList ID="drdlReceiveBillPerson" runat="server"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rqfvReceiveBillPerson" runat="server" ControlToValidate="drdlReceiveBillPerson"
                                            ErrorMessage="*" ToolTip="领票人不能为空！"></asp:RequiredFieldValidator></td>
                                    <td align="left">
                                         接货点：
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtbAcceptStation" runat="server" MaxLength="20"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rqfvAcceptStation" runat="server" ControlToValidate="txtbAcceptStation"
                                        ErrorMessage="*" ToolTip="接货点不能为空！"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr bgColor="#f4f9ff">
                                    <td align="left">
                                         领票时间：
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtbReceiveBillTime" runat="server" Enabled="False"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rqfvReceiveBillTime" runat="server" ControlToValidate="txtbReceiveBillTime"
                                        ErrorMessage="*" ToolTip="领票时间不能为空！"></asp:RequiredFieldValidator>
                                        <asp:RangeValidator ID="rngvReceiveBillTime" runat="server" ControlToValidate="txtbReceiveBillTime"
                                        ErrorMessage="*" MaximumValue="2010-12-31" MinimumValue="1900-01-01" Type="Date" ToolTip="领票时间必须是合法日期时间,格式为 : yyyy-mm-dd,且位于1900-01-01 和2010-12-31 之间！"></asp:RangeValidator>
                                    </td>
                                    <td align="left">
                                         分发人：
                                    </td>
                                    <td align="left">
                                    <asp:DropDownList ID="drdlReleasePerson" runat="server"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rqfvReleasePerson" runat="server" ControlToValidate="drdlReleasePerson"
                                            ErrorMessage="*" ToolTip="分发人不能为空！"></asp:RequiredFieldValidator></td>
                                </tr>
								<tr bgColor="#ffffff">
									<td align="right" colSpan="4">
									    <asp:ImageButton ID="imgbModify" Runat="server" ImageUrl="../Images/anniu009.gif" OnClick="imgbModify_Click"></asp:ImageButton>
                                        <asp:ImageButton ID="imgbDelete" Runat="server" ImageUrl="../Images/anniu006.gif" OnClick="imgbDelete_Click" CausesValidation="False"></asp:ImageButton>
										<asp:ImageButton ID="imgbBack" Runat="server" ImageUrl="../Images/anniu005.gif" OnClick="imgbCancel_Click" CausesValidation="False"></asp:ImageButton>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
   </table>
</asp:Content> 
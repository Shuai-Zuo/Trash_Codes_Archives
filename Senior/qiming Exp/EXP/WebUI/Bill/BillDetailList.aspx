<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BillDetailList.aspx.cs" Inherits="Light.EXP.WebUI.Bill.BillDetailList" Theme="Default" %>
<%@ Register Src="../Controls/DataPager.ascx" TagName="DataPager" TagPrefix="uc1" %>
<asp:Content ID="cntBillDetailList" ContentPlaceHolderID="cphPage" Runat="Server">
    <table height="420" cellSpacing="0" cellPadding="0" width="609" align="center" border="0">
        <tr>
            <td align="center" background="../Images/wla_top005.gif" height="24">
                <table cellSpacing="0" cellPadding="0" width="609" border="0">
                    <tr>
                    <td align="right" width="342">
                        <strong>票据销核</strong>
                    </td>
                        <td align="right" width="267">
                            <a href="../index.aspx" target="_self">
                                <IMG height="24" src="../Images/wla_top019.gif" width="21" border="0">
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
                            <table cellSpacing="0" cellPadding="0" width="572" border="0">
                                <tr>
                                    <td vAlign="bottom"><IMG height="12" src="../Images/wla_top013.gif" width="572"></td>
                                </tr>
                                <tr>
                                    <td align="center" background="../Images/wla_top014.gif">
                                        <table cellSpacing="1" cellPadding="2" width="90%" border="0" align="center">
                                            <tr>
                                                <td style="text-align: left">
                                                    单据编号：
                                                    <asp:TextBox ID="txtbBillCode" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left">
                                                    单据状态：
                                                    <asp:DropDownList ID="drdlBillStatus" runat="server" Font-Bold="False">
                                                        <asp:ListItem Selected="True" Value="0">[全部]</asp:ListItem>
                                                        <asp:ListItem Value="1">已填</asp:ListItem>
                                                        <asp:ListItem Value="2">作废</asp:ListItem>
                                                    </asp:DropDownList>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    单据类型：

                                                    <asp:DropDownList ID="drdlBillType" runat="server">
                                                        <asp:ListItem Selected="True" Value="0">[全部]</asp:ListItem>
                                                        <asp:ListItem Value="1">货运单</asp:ListItem>
                                                        <asp:ListItem Value="2">回执单</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left">
                                                    时间范围：

                                                    <asp:TextBox ID="txtbBeginWriteDate" runat="server" Width="100px" OnTextChanged="txtbBeginWriteDate_TextChanged">2007-12-1</asp:TextBox>&nbsp;到&nbsp;
                                                    <asp:TextBox ID="txtbEndWriteDate" runat="server" Width="101px">2007-12-12</asp:TextBox>&nbsp;
                                                    <asp:ImageButton ID="imgbQuery" runat="server" ImageUrl="~/Images/wla_top016.gif" align="top" OnClick="imgbQuery_Click" />
                                                </td>
                                          </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td><IMG height="4" src="../Images/wla_top015.gif" width="572"></td>
                                </tr>
                            </table>							  
                        </td>
                    </tr>
                </table>
                <table width="572" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <table cellSpacing="0" cellPadding="0" width="572" border="0">
                    <tr>
                        <td align="center">
                            <asp:GridView ID="grdvBillDetail" runat="server" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="BillType" HeaderText="单据类型"></asp:BoundField>
                                    <asp:BoundField DataField="BillCode" HeaderText="单据编号"></asp:BoundField>
                                    <asp:BoundField DataField="BillState" HeaderText="单据状态"></asp:BoundField>
                                    <asp:BoundField DataField="WriteDate" HeaderText="填写日期"></asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                <table cellSpacing="0" cellPadding="0" width="572" border="0">
                    <tr>
                        <td align="center" height="8">
                            <uc1:DataPager ID="dtpBillDetails" runat="server" ControlNameToPager="grdvBillDetail" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <IMG height="21" src="../Images/wla_top007.gif" width="609">
            </td>
        </tr>
    </table>
</asp:Content>
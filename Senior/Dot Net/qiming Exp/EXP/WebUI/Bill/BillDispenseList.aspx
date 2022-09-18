<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BillDispenseList.aspx.cs" Inherits="Light.EXP.WebUI.Bill.BillDispenseList" Theme="default" %>
<%@ Register Src="../Controls/DataPager.ascx" TagName="DataPager" TagPrefix="uc1" %>
<asp:Content ID="cntnBillDispenseList" ContentPlaceHolderID="cphPage" Runat="Server">
   <table height="420" cellSpacing="0" cellPadding="0" width="609" align="center" border="0">
    <tr>
        <td align="center" background="../Images/wla_top005.gif" height="24">
            <table cellSpacing="0" cellPadding="0" width="609" border="0">
                <tr>
                <td align="right" width="342">
                    <strong>单据分发查询</strong>
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
            <table width="572" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="22" align="right" valign="bottom">
                        <a href="BillDispenseCreate.aspx">
                            <img height="15" src="../Images/image002.gif" width="20" align="absMiddle" border="0">增加单据分发
                        </a>
                    </td>
                </tr>
            </table>
            <table cellSpacing="0" cellPadding="0" width="572" border="0">
                <tr>
                    <td>
                        <table cellSpacing="0" cellPadding="0" width="572" border="0">
                            <tr>
                                <td vAlign="bottom"><IMG height="12" src="../Images/wla_top013.gif" width="572"></td>
                            </tr>
                            <tr>
                                <td align="center" background="../Images/wla_top014.gif">
                                   单据类型：                                <asp:DropDownList ID="drdlBillStatus" runat="server" Font-Bold="False">
                                    <asp:ListItem Selected="True" Value="0">[全部]</asp:ListItem>
                                    <asp:ListItem Value="1">货运单</asp:ListItem>
                                    <asp:ListItem Value="2">回执单</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp; &nbsp; &nbsp;&nbsp;
                                领票人：
                                <asp:TextBox ID="txtbReceiveBillPerson" runat="server"></asp:TextBox>
                                &nbsp;&nbsp;
                                <asp:ImageButton ID="imgbQuery" runat="server" ImageUrl="~/Images/wla_top016.gif" align="top" OnClick="imgbQuery_Click" />
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
                        <asp:GridView ID="grdvBillDispenses" runat="server" AutoGenerateColumns="False">
                               <Columns>
                                   <asp:BoundField DataField="PKID" HeaderText="票据ID" Visible="False" />
                                   <asp:BoundField DataField="BillType" HeaderText="单据类型"></asp:BoundField>
                                   <asp:HyperLinkField DataNavigateUrlFields="PKID" DataNavigateUrlFormatString="BillDispenseUpdate.aspx?pkId = {0}"
                                       DataTextField="BillStartCode" HeaderText="单据开始号" />
                                   <asp:BoundField DataField="BillEndCode" HeaderText="单据结束号" />
                                   <asp:BoundField DataField="ReceiveBillPerson" HeaderText="领票人" />
                                   <asp:BoundField DataField="AcceptStation" HeaderText="接货点　" />
                                   <asp:BoundField DataField="ReceiveBillTime" HeaderText="领票时间　" />
                                   <asp:BoundField DataField="ReleasePerson" HeaderText="分发人" />
                               </Columns>
                           </asp:GridView>
                    </td>
                </tr>
            </table>
            <table cellSpacing="0" cellPadding="0" width="572" border="0">
                <tr>
                    <td align="center" height="8">
                        <uc1:DataPager ID="dtpBillDepense" runat="server" ControlNameToPager="grdvBillDispenses" />
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
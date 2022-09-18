<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DataPager.ascx.cs" Inherits="Light.EXP.WebUI.SystemFrame.DataPager" %>
<table cellpadding=0 cellspacing=0 width="570" align="center">
    <tr>
        <td align=center>
            <table cellpadding=0 cellspacing=0 width="100%" align="center">
                <tr>
                    <td width="200" align="center"><asp:Label ID="lbCurrentPageText" runat="server" Text=""></asp:Label></td>
                    <td width="200" align="center">
                        <asp:LinkButton ID="lnkbHome" runat="server" onclick="lnkbHome_Click">首页</asp:LinkButton>&nbsp;
                        <asp:LinkButton ID="lnkbPriv" runat="server" onclick="lnkbPriv_Click">上一页</asp:LinkButton>&nbsp;
                        <asp:LinkButton ID="lnkbNext" runat="server" onclick="lnkbNext_Click">下一页</asp:LinkButton>&nbsp;
                        <asp:LinkButton ID="lnkbLast" runat="server" onclick="lnkbLast_Click">最后一页</asp:LinkButton>&nbsp;
                    </td>
                    <td width="80" align="center">
                        <asp:TextBox ID="txtbNum" runat="server" Width="30px" Height="15px"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Panel ID="pnlValid" runat="server">
                            <asp:LinkButton ID="lnkbGo" runat="server" onclick="lnkbGo_Click">GO</asp:LinkButton>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

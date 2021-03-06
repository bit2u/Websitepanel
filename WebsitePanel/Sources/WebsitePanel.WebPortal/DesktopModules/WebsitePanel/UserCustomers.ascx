<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserCustomers.ascx.cs" Inherits="WebsitePanel.Portal.UserCustomers" %>
<%@ Import Namespace="WebsitePanel.Portal" %>
<%@ Register Src="UserControls/Comments.ascx" TagName="Comments" TagPrefix="uc4" %>
<%@ Register Src="UserControls/SearchBox.ascx" TagName="SearchBox" TagPrefix="uc1" %>
<%@ Register Src="UserControls/UserDetails.ascx" TagName="UserDetails" TagPrefix="uc2" %>
<%@ Register Src="UserControls/CollapsiblePanel.ascx" TagName="CollapsiblePanel" TagPrefix="wsp" %>

<asp:UpdatePanel runat="server" ID="updatePanelUsers">
    <ContentTemplate> 

<div class="FormButtonsBar">
    <div class="Left">
        <asp:Button ID="btnAddUser" runat="server"
            meta:resourcekey="btnAddUser" Text="Create User" CssClass="Button3"
                OnClick="btnAddUser_Click" />
    </div>
    <div class="Right">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td>
				    &nbsp;&nbsp;&nbsp;
					<asp:DropDownList ID="ddlStatus" runat="server" CssClass="NormalTextBox" resourcekey="ddlStatus"
							AutoPostBack="true">
						<asp:ListItem Value="0">ByStatus</asp:ListItem>
						<asp:ListItem Value="1">Active</asp:ListItem>
						<asp:ListItem Value="2">Suspended</asp:ListItem>
						<asp:ListItem Value="3">Cancelled</asp:ListItem>
						<asp:ListItem Value="4">Pending</asp:ListItem>
					</asp:DropDownList>
			        &nbsp;&nbsp;&nbsp;
			        
					<asp:DropDownList ID="ddlRole" runat="server" CssClass="NormalTextBox" resourcekey="ddlRole"
							AutoPostBack="true">
						<asp:ListItem Value="0">ByRole</asp:ListItem>
						<asp:ListItem Value="3">Users</asp:ListItem>
						<asp:ListItem Value="2">Resellers</asp:ListItem>
					</asp:DropDownList>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
				<td>
					<uc1:SearchBox ID="searchBox" runat="server" />
				</td>
			</tr>
		</table>
    </div>
</div>

<asp:GridView id="gvUsers" runat="server" AutoGenerateColumns="False"
	AllowPaging="True" AllowSorting="True"
	CssSelectorClass="NormalGridView"
	DataSourceID="odsUsersPaged" EnableViewState="False"
	EmptyDataText="gvUsers">
	<Columns>
		<asp:TemplateField>
			<ItemTemplate>							        
				<asp:Image ID="img2" runat="server" Width="16px" Height="16px" ImageUrl='<%# GetStateImage(Eval("LoginStatusId")) %>' ImageAlign="AbsMiddle" />
			</ItemTemplate>
		</asp:TemplateField>
		<asp:TemplateField SortExpression="Username" HeaderText="gvUsersUsername" HeaderStyle-Wrap="false">
			<ItemTemplate>
				<asp:hyperlink id=lnkEdit runat="server" NavigateUrl='<%# GetUserHomePageUrl((int)Eval("UserID")) %>'>
					<%# Eval("Username") %>
				</asp:hyperlink>
			</ItemTemplate>
		</asp:TemplateField>
		<asp:BoundField DataField="FullName" HtmlEncode="true" SortExpression="FullName" HeaderText="gvUsersName">
		    <HeaderStyle Wrap="false" />
            <ItemStyle Wrap="False" />
        </asp:BoundField>
		<asp:BoundField DataField="Email" SortExpression="Email" HeaderText="gvUsersEmail"></asp:BoundField>
		<asp:BoundField DataField="CompanyName" SortExpression="CompanyName" HeaderText="gvUsersCompanyName">
		    <HeaderStyle Wrap="false" />
        </asp:BoundField>
		<asp:TemplateField SortExpression="RoleID" HeaderText="gvUsersRole">
			<ItemStyle Wrap="False"></ItemStyle>
			<ItemTemplate>
				<%# PanelFormatter.GetUserRoleName((int)Eval("RoleID"))%>
			</ItemTemplate>
		</asp:TemplateField>
		<asp:BoundField DataField="PackagesNumber" SortExpression="PackagesNumber" HeaderText="gvUsersSpaces"></asp:BoundField>
		<asp:TemplateField SortExpression="StatusID" HeaderText="gvUsersStatus">
			<ItemStyle Wrap="False"></ItemStyle>
			<ItemTemplate>
				<%# PanelFormatter.GetAccountStatusName((int)Eval("StatusID"))%>
			</ItemTemplate>
		</asp:TemplateField>
		<asp:TemplateField ItemStyle-Width="20px" ItemStyle-Wrap="false">
			<ItemTemplate><uc4:Comments id="Comments1" runat="server"
				    Comments='<%# Eval("Comments") %>'>
                </uc4:Comments></ItemTemplate>
		</asp:TemplateField>
	</Columns>
</asp:GridView>
<asp:ObjectDataSource ID="odsUsersPaged" runat="server" EnablePaging="True" SelectCountMethod="GetUsersPagedCount"
    SelectMethod="GetUsersPaged" SortParameterName="sortColumn" TypeName="WebsitePanel.Portal.UsersHelper" OnSelected="odsUsersPaged_Selected">
    <SelectParameters>
        <asp:QueryStringParameter Name="userId" QueryStringField="UserID" Type="Int32" />
        <asp:ControlParameter Name="filterColumn" ControlID="searchBox"  PropertyName="FilterColumn" />
        <asp:ControlParameter Name="filterValue" ControlID="searchBox" PropertyName="FilterValue" />
        <asp:ControlParameter Name="statusId" ControlID="ddlStatus" PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter Name="roleId" ControlID="ddlRole" PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
    </ContentTemplate>
</asp:UpdatePanel>

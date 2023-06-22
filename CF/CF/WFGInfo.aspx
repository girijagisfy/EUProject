<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="WFGInfo.aspx.cs" Inherits="CF.WFGInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>WFG's Info</title>
    <script>
        var loading;
        function ShowLoader() {
            debugger;
            loading = $("#loading");
            loading.show();
        };

        function HideLoader() {
            loading = $("#loading");
            loading.show();
        };

        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "WFGInfo.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
        }

        function ConfirmAlert(btnConfirm, text) {
            debugger;
            if (btnConfirm.dataset.confirmed) {
                // The action was already confirmed by the user, proceed with server event
                btnConfirm.dataset.confirmed = false;
                return true;
            } else {
                // Ask the user to confirm/cancel the action
                var option = '';
                if (text != '') {
                    option = text;
                }
                else {
                    option = btnConfirm.value;
                }
                event.preventDefault();
                swal({
                    title: "Are you sure to " + option + " ?",
                    //text: "Once submitted, you will not be able to edit this form!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then((willConfirm) => {
                    if (willConfirm) {
                        // Set data-confirmed attribute to indicate that the action was confirmed
                        btnConfirm.dataset.confirmed = true;
                        // Trigger button click programmatically
                        btnConfirm.click();
                    }
                    else {
                        //swal("Your imaginary file is safe!");
                    }
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h1 class="box-title">Women Farmer Groups Information.</h1>
                    <div class="pull-right box-tools">
                        <a runat="server" id="btnFilter" class="btn btn-primary" href="WfgFilter.aspx"><i class="fa fa-filter">&nbsp;Filter</i></a>
                        <asp:LinkButton ID="btnReport" Font-Size="X-Large" runat="server" OnClick="btnReport_Click">
                            <img src="Images/Excel.png" style="width: 30px;" />
                        </asp:LinkButton>
                        <a id="btnAddNew" runat="server" class="btn btn-success" href="AddWFG.aspx"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                    </div>
                    <div class="pull-right box-tools" style="margin-right: 5px;">
                        <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                            <asp:ListItem Value="Active" Text="Active"></asp:ListItem>
                            <asp:ListItem Value="Inactive" Text="Inactive"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="pull-right box-tools">
                        <label style="vertical-align: -webkit-baseline-middle;">Status&nbsp;</label>
                    </div>
                </div>
                <div class="box-body">
                    <div style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                        <asp:GridView runat="server" CssClass="table table-striped table-bordered table-condensed table-hover infoarea" AlternatingRowStyle-CssClass="infoarea" ID="gvWFG" DataKeyNames="WfgNo, Status" AutoGenerateColumns="false" OnRowCommand="gvWFG_RowCommand" PageSize="30" AllowSorting="true" OnSorting="gvWFG_Sorting" AllowPaging="true" OnPageIndexChanging="gvWFG_PageIndexChanging" OnRowDataBound="gvWFG_RowDataBound" OnRowCreated="Gridview1_RowCreated">
                            <Columns>
                                <asp:BoundField DataField="WFGName" HeaderText="WFG Name" SortExpression="WFGName" />
                                <asp:BoundField DataField="Village" HeaderText="Village Name" SortExpression="Village" />
                                <asp:BoundField DataField="CSOName" HeaderText="CSO Name " SortExpression="CSOName" />
                                <asp:BoundField DataField="SocialCategory" HeaderText="WFG Type" SortExpression="SocialCategory" />
                                <asp:ButtonField ButtonType="Link" ControlStyle-Font-Size="x-large" HeaderText="Edit" CommandName="btnEdit" ControlStyle-CssClass="nav-icon fa fa-edit" HeaderStyle-CssClass="text-blue" />
                                <asp:TemplateField HeaderStyle-CssClass="text-blue">
                                    <HeaderTemplate>
                                        Active/Inactive
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Button ID="btnStatus" runat="server" CommandName="" Text="" OnClientClick="ConfirmAlert(this,'')" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-CssClass="text-blue">
                                    <HeaderTemplate>
                                        Delete
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelete" ForeColor="Red" Font-Size="X-Large" runat="server" Text="<i class='nav-icon fa fa-trash-o'></i>" OnClick="btnDelete_Click" OnClientClick="ConfirmAlert(this,'Delete')"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <div id="loading" class="dvloader" style="display: none">
                <div class="loader">
                    <img src="Images/waiting.gif" />
                </div>
            </div>
        </div>
    </form>
</asp:Content>

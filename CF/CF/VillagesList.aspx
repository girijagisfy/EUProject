<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="VillagesList.aspx.cs" Inherits="CF.VillagesList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Villages List</title>
    <style>
        td {
            vertical-align: middle !important;
        }
    </style>
    <script>
        function ConfirmAlert(btnConfirm) {
            if (btnConfirm.dataset.confirmed) {
                // The action was already confirmed by the user, proceed with server event
                btnConfirm.dataset.confirmed = false;
                return true;
            } else {
                // Ask the user to confirm/cancel the action
                event.preventDefault();
                swal({
                    title: "Are you sure to delete ?",
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

        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "VillagesList.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <section class="content">
            <div class="box box-success">
                <div class="box-header with-border">
                    <h1 class="box-title">Villages List</h1>
                    <div class="pull-right box-tools">
                        <a id="btnAddNew" runat="server" class="btn btn-success" href="AddVillageList.aspx"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                    </div>

                    <div class="pull-right box-tools" style="width: 20%; margin-right: 1%; margin-bottom: 1%;">
                        <asp:DropDownList runat="server" ID="ddlBlock" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlBlock_SelectedIndexChanged">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="pull-right box-tools" style="margin-right: 1%;">
                        <h4>Block</h4>
                    </div>
                    <div class="pull-right box-tools" style="width: 20%; margin-right: 1%; margin-bottom: 1%;">
                        <asp:DropDownList runat="server" ID="ddlDistrict" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="pull-right box-tools" style="margin-right: 1%;">
                        <h4>District :</h4>
                    </div>
                    <div class="pull-right box-tools" style="width: 20%; margin-right: 1%; margin-bottom: 1%;">
                        <asp:DropDownList runat="server" ID="ddlState" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="pull-right box-tools" style="margin-right: 1%;">
                        <h4>State :</h4>
                    </div>
                </div>
                <div class="box-body">
                    <div style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                        <asp:GridView ID="gvVillages" runat="server" DataKeyNames="VillageID" CssClass="table table-striped table-bordered table-condensed table-hover" AutoGenerateColumns="false" AllowSorting="True" EmptyDataRowStyle-CssClass="infoarea" AlternatingRowStyle-CssClass="infoarea" OnRowCommand="gvVillages_RowCommand" AllowPaging="true" PageSize="10" OnSorting="gvVillages_Sorting" OnPageIndexChanging="gvVillages_PageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="StateName" HeaderText="State" SortExpression="StateName" />
                                <asp:BoundField DataField="District" HeaderText="District" SortExpression="District" />
                                <asp:BoundField DataField="Block" HeaderText="Block" SortExpression="Block" />
                                <asp:BoundField DataField="Village" HeaderText="Village" SortExpression="Village" />
                                <asp:ButtonField ButtonType="Link" ControlStyle-Font-Size="x-large" CommandName="btnEdit" HeaderText="Edit" ControlStyle-CssClass="nav-icon fa fa-edit" HeaderStyle-CssClass="text-blue" />
                                <asp:TemplateField HeaderStyle-CssClass="text-blue">
                                    <HeaderTemplate>
                                        Delete
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelete" ForeColor="Red" Font-Size="X-Large" runat="server" Text="<i class='nav-icon fa fa-trash-o'></i>" OnClientClick="ConfirmAlert(this)" OnClick="btnDelete_Click"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </section>
    </form>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="CsoInfo.aspx.cs" Inherits="CF.CsoInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>CSOs Info</title>
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
                    title: "Are you sure to " + btnConfirm.value + " ?",
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
                    window.location = "CsoInfo.aspx";
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
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h1 class="box-title">Civil Society Organizations Information</h1>
                    <div class="pull-right box-tools">
                        <a runat="server" class="btn btn-primary" href="CsoFilter.aspx"><i class="fa fa-filter">&nbsp;Filter</i></a>
                        <a id="btnAddNew" runat="server" class="btn btn-success" href="AddCso.aspx"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                    </div>
                </div>
                <div class="box-body">
                    <div style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                        <asp:GridView ID="Gridview1" runat="server" DataKeyNames="CsoId, Status" CssClass="table table-striped table-bordered table-condensed table-hover" AutoGenerateColumns="false" AllowSorting="True" EmptyDataRowStyle-CssClass="infoarea" AlternatingRowStyle-CssClass="infoarea" PageSize="30" OnRowCommand="Gridview1_RowCommand" AllowPaging="true" OnSorting="Gridview1_Sorting" OnPageIndexChanging="Gridview1_PageIndexChanging" OnRowDataBound="Gridview1_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Csoname" HeaderText="CSO Name" SortExpression="Csoname" />
                                <asp:BoundField DataField="District" HeaderText="District" SortExpression="District" />
                                <asp:BoundField DataField="Block" HeaderText="Block" SortExpression="Block" />
                                <asp:BoundField DataField="RegisteredAddress" HeaderText="Registered Address" SortExpression="RegisteredAddress" />
                                <asp:BoundField DataField="NameofContactPerson" HeaderText="Name  of Contact Person" SortExpression="NameofContactPerson" />
                                <asp:BoundField DataField="addressofcontactPerson" HeaderText="Address of Contact Person" SortExpression="addressofcontactPerson" />
                                <asp:ButtonField ButtonType="Link" ControlStyle-Font-Size="x-large" CommandName="btnEdit" ControlStyle-CssClass="nav-icon fa fa-edit" HeaderText="Edit" HeaderStyle-CssClass="text-blue" />
                                <asp:TemplateField HeaderStyle-CssClass="text-blue">
                                    <HeaderTemplate>
                                        Active/Inactive
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Button ID="btnStatus" runat="server" CommandName="" Text="" OnClientClick="ConfirmAlert(this)" />
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

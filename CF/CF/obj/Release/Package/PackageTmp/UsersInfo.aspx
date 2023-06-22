<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="UsersInfo.aspx.cs" Inherits="CF.UsersInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Master Users</title>
    <script>
        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "UsersInfo.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
        }

        function ConfirmAlert(btnConfirm) {
            if (btnConfirm.dataset.confirmed) {
                // The action was already confirmed by the user, proceed with server event
                btnConfirm.dataset.confirmed = false;
                return true;
            } else {
                // Ask the user to confirm/cancel the action
                event.preventDefault();
                swal({
                    title: "Are you sure to " + btnConfirm.value + " User Credentials ?",
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
                    <h1 class="box-title">User's Info</h1>
                    <div class="pull-right box-tools">
                        <a id="btnAddNew" runat="server" class="btn btn-success" href="AddUser.aspx"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                    </div>
                </div>
                <div class="box-body">
                    <div style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                        <asp:GridView runat="server" CssClass="table table-striped table-bordered table-condensed table-hover infoarea" AlternatingRowStyle-CssClass="infoarea" ID="gvUsers" DataKeyNames="Cid, Status" AutoGenerateColumns="false" OnRowCommand="gvUsers_RowCommand" AllowSorting="true" OnSorting="gvUsers_Sorting" OnRowDataBound="gvUsers_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                <asp:BoundField DataField="UserID" HeaderText="User ID" SortExpression="UserID" />
                                <asp:BoundField DataField="UserType" HeaderText="Type" SortExpression="UserType" />
                                <asp:ButtonField Text="Reset Password" ControlStyle-CssClass="btn btn-primary" HeaderStyle-Width="10%" CommandName="btnEdit" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnStatus" runat="server" CommandName="" Text="" OnClientClick="ConfirmAlert(this)" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>

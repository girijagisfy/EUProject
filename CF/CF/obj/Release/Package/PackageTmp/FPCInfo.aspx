<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="FPCInfo.aspx.cs" Inherits="CF.FPCInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>FPC Info</title>
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
                    window.location = "FPCInfo.aspx";
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h1 class="box-title">Farmers Producer Company Information</h1>
                    <div class="pull-right box-tools">
                        <a id="btnAddNew" runat="server" class="btn btn-success" href="FPCRegistration.aspx"><i class="fa fa-plus-circle" >&nbsp;Add New</i></a>
                    </div>
                    <div class="pull-right box-tools" style="margin-right: 10px;">
                        <asp:LinkButton ID="btnCropReport" Font-Size="X-Large" OnClick="btnCropReport_Click" runat="server">
                                <img src="Images/Excel.png" style="width: 30px;" />
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="box-body">
                    <div style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                        <asp:GridView runat="server" CssClass="table table-striped table-bordered table-condensed table-hover infoarea" AlternatingRowStyle-CssClass="infoarea" ID="gvFPC" DataKeyNames="FPCId, Status" AutoGenerateColumns="false" AllowSorting="true" AllowPaging="true" OnSorting="gvFPC_Sorting" OnRowCommand="gvFPC_RowCommand" OnPageIndexChanging="gvFPC_PageIndexChanging" OnRowDataBound="gvFPC_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="CSOName" HeaderText="CSO Name" SortExpression="CSOName" />
                                <asp:BoundField DataField="FPCName" HeaderText="FPC Name" SortExpression="FPCName" />
                                <asp:BoundField DataField="FPCContactNumber" HeaderText="FPC Contact Number" SortExpression="FPCContactNumber" />
                                <asp:BoundField DataField="FPCAddress" HeaderText="FPC Address" SortExpression="FPCAddress" />
                                <asp:ButtonField ButtonType="Link" ControlStyle-Font-Size="x-large" HeaderText="Edit" CommandName="btnEdit" ControlStyle-CssClass="nav-icon fa fa-edit" HeaderStyle-CssClass="text-blue" />
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
        </div>
    </form>
</asp:Content>

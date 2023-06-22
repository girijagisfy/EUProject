<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="VillagesInfo.aspx.cs" Inherits="CF.VillagesInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Villages Info</title>
    <style>
        td {
            vertical-align: middle !important;
        }
    </style>
    <script>
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

        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "VillagesInfo.aspx";
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
                    <h1 class="box-title">Villages Information</h1>
                    <div class="pull-right box-tools">
                        <a id="btnFilter" runat="server" class="btn btn-primary" href="VillageFilter.aspx"><i class="fa fa-filter">&nbsp;Filter</i></a>
                        <asp:LinkButton ID="btnReport" Font-Size="X-Large" runat="server" OnClick="btnReport_Click">
                            <img src="Images/Excel.png" style="width: 30px;" />
                        </asp:LinkButton>
                        <a id="btnAddNew" runat="server" class="btn btn-success" aria-readonly="true" href="AddVillage.aspx"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                    </div>
                </div>
                <div class="box-body">
                    <div style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                        <asp:GridView ID="Gridview1" runat="server" DataKeyNames="Vid, Status" CssClass="table table-striped table-bordered table-condensed table-hover" AutoGenerateColumns="false" AllowSorting="True" EmptyDataRowStyle-CssClass="infoarea" AlternatingRowStyle-CssClass="infoarea" PageSize="30" OnRowCommand="Gridview1_RowCommand" AllowPaging="true" OnSorting="Gridview1_Sorting" OnPageIndexChanging="Gridview1_PageIndexChanging" OnRowDataBound="Gridview1_RowDataBound" OnRowCreated="Gridview1_RowCreated">
                            <Columns>
                                <asp:BoundField DataField="CSOName" HeaderText="Name of CSO" SortExpression="CSOName" />
                                <asp:BoundField DataField="Village" HeaderText="Village Name" SortExpression="Village" />
                                <asp:BoundField DataField="HamletCount" HeaderText="Hamlet Count" SortExpression="HamletCount" />
                                <asp:ButtonField ButtonType="Link"  ControlStyle-Font-Size="x-large" CommandName="btnEdit" HeaderText="Edit Village" ControlStyle-CssClass="nav-icon fa fa-edit" HeaderStyle-CssClass="text-blue"  />
                                <asp:ButtonField ButtonType="Link"  ControlStyle-Font-Size="x-large" CommandName="Hamlet" HeaderText="Edit Hamlet"  ControlStyle-CssClass="nav-icon fa fa-edit" HeaderStyle-CssClass="text-blue" />
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
                                        <asp:LinkButton ID="btnDelete" ForeColor="Red" Font-Size="X-Large" runat="server" Text="<i class='nav-icon fa fa-trash-o'></i>" OnClick="btnDelete_Click" OnClientClick="ConfirmAlert(this,'Delete')" Enabled = "false"></asp:LinkButton>
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

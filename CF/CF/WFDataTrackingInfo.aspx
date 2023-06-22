<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="WFDataTrackingInfo.aspx.cs" Inherits="CF.WFDataTrackingInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Woman Farmer Data Info</title>
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
                    window.location = "WFDataTrackingInfo.aspx";
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
                    <h1 class="box-title">Woman Farmer Indicator Info</h1>

                    <div class="pull-right box-tools">
                        <a id="btnAddNew" runat="server" class="btn btn-success" href="AddWFDataTracking.aspx"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                    </div>
                    <div class="pull-right box-tools" style="margin-right: 5px;">
                        <a href="WFDataReport.aspx" class="btn btn-primary"><i class="fa fa-file">&nbsp;Report</i></a>
                    </div>
                    <div class="pull-right box-tools" style="margin-right: 10px; padding-left: 5px;">
                        <asp:LinkButton ID="btnexcelExport" Font-Size="X-Large" OnClick="btnexcelExport_Click" runat="server">
                                <img src="Images/Excel.png" style="width: 30px;" /></asp:LinkButton>
                    </div>
                    <div class="box-body">
                        <div style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                            <asp:GridView ID="Gridview1" runat="server" DataKeyNames="WFDataID" CssClass="table table-striped table-bordered table-condensed table-hover" AutoGenerateColumns="false" AllowSorting="True" EmptyDataRowStyle-CssClass="infoarea" AlternatingRowStyle-CssClass="infoarea" AllowPaging="true" OnSorting="Gridview1_Sorting" PageSize="50" OnPageIndexChanging="Gridview1_PageIndexChanging" OnRowCommand="Gridview1_RowCommand" OnRowCreated="Gridview1_RowCreated">
                                <Columns>
                                    <asp:BoundField DataField="WomenName" HeaderText="Women Name" SortExpression="WomenName" />
                                    <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
                                    <asp:BoundField DataField="Village" HeaderText="Village Name" SortExpression="Village" />
                                    <asp:BoundField DataField="CSOName" HeaderText="CSO Name " SortExpression="CSOName" />
                                    <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" SortExpression="ContactNumber" />
                                    <asp:ButtonField ButtonType="Link" ControlStyle-Font-Size="x-large" HeaderText="Edit" CommandName="btnEdit" ControlStyle-CssClass="nav-icon fa fa-edit" HeaderStyle-CssClass="text-blue" />
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
        </section>
    </form>
</asp:Content>

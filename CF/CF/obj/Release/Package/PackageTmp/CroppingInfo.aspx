<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="CroppingInfo.aspx.cs" Inherits="CF.CroppingInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Cropping Pattern Info</title>
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
                    window.location = "CroppingInfo.aspx";
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
                    <h1 class="box-title">Cropping Pattern Info</h1>
                    <div class="pull-right box-tools">
                        <a runat="server" class="btn btn-primary" href="HamletDataInfo.aspx"><i class="fa fa-arrow-left">&nbsp;Back</i></a>
                        <a id="btnAddNew" runat="server" class="btn btn-success" href="AddCroppingPattern.aspx"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                    </div>
                    <div class="pull-right box-tools" style="margin-right: 10px;">
                        <asp:LinkButton ID="btnReport" Font-Size="X-Large" runat="server" OnClick="btnReport_Click">
                            <img src="Images/Excel.png" style="width: 30px;" />
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="box-body">
                    <div style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                        <asp:GridView ID="gvCropping" runat="server" DataKeyNames="NCid" CssClass="table table-striped table-bordered table-condensed table-hover" AutoGenerateColumns="false" AllowSorting="True" EmptyDataRowStyle-CssClass="infoarea" AlternatingRowStyle-CssClass="infoarea" OnRowCommand="gvCropping_RowCommand" AllowPaging="true" PageSize="10" OnSorting="gvCropping_Sorting" OnPageIndexChanging="gvCropping_PageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="NameofHamlet" HeaderText="Hamlet Name" SortExpression="NameofHamlet" />
                                <asp:BoundField DataField="PatternName" HeaderText="Pattern Name" SortExpression="PatternName" />
                                <asp:BoundField DataField="TotalAreainacre" HeaderText="Total Area in acre" SortExpression="TotalAreainacre" />
                                <asp:BoundField DataField="AverageProduction" HeaderText="Average Production" SortExpression="AverageProduction" />
                                <asp:BoundField DataField="AverageIncome" HeaderText="Average Income" SortExpression="AverageIncome" />
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
    <script>
        $(document).ready(function () {
            $("#liVillages").addClass("active");
        });
    </script>
</asp:Content>

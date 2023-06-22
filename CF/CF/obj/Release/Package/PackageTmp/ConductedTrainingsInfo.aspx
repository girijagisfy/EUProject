<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="ConductedTrainingsInfo.aspx.cs" Inherits="CF.ConductedTrainingsInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Project Management</title>
    <script>
        function ConfirmAlert(btnConfirm) {
            debugger;
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
                    window.location = "ConductedTrainingsInfo.aspx";
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
        <div class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h1 class="box-title">Training Info</h1>
                    <div class="pull-right box-tools">
                        <a id="btnAddNew" runat="server" class="btn btn-success" href="AddTrainings.aspx"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                    </div>
                </div>
                <div class="box-body">
                    <div style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                        <asp:GridView runat="server" CssClass="table table-striped table-bordered table-condensed table-hover infoarea" AlternatingRowStyle-CssClass="infoarea" ID="gvProject" DataKeyNames="trno" AutoGenerateColumns="false" OnRowCommand="gvProject_RowCommand" AllowSorting="true" OnSorting="gvProject_Sorting">
                            <Columns>
                                <asp:BoundField DataField="TrainingTask" HeaderText="Training Task" SortExpression="TrainingTask" />
                                <asp:BoundField DataField="StartDate" HeaderText="Start Date" SortExpression="StartDate" />
                                <asp:BoundField DataField="EndDate" HeaderText="End Date" SortExpression="EndDate" />
                                <asp:BoundField DataField="Budget" HeaderText="Budget" SortExpression="Budget" />
                                <asp:BoundField DataField="NoofWomenFarmer" HeaderText="No. of Women Farmer" SortExpression="NoofWomenFarmer" />
                                <asp:BoundField DataField="NoofTrainings" HeaderText="No. of Trainings" SortExpression="NoofTrainings" />
                                <asp:ButtonField ButtonType="Link" ControlStyle-Font-Size="x-large" CommandName="btnEdit" ControlStyle-CssClass="nav-icon fa fa-edit" />
                                <asp:TemplateField HeaderStyle-CssClass="text-blue">
                                    <HeaderTemplate>
                                        Delete
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelete" ForeColor="Red" Font-Size="X-Large" runat="server" Text="<i class='nav-icon fa fa-trash-o'></i>" CommandName="btnDelete" OnClientClick="ConfirmAlert(this)"></asp:LinkButton>
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

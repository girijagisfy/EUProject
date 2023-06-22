<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="EditTrainings.aspx.cs" Inherits="CF.EditTrainings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>New Training</title>
    <script>
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
        };
        function SplCharCheck(input) {
            debugger;
            let value = input.value;
            let numbers = value.replace(/[^a-zA-Z0-9-.,/_&( )]/g, "").trimStart();
            input.value = numbers;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm1"></asp:ScriptManager>
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Edit Training</h3>
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Training Name:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtName" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ErrorMessage="Please Enter Name" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Training Task:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtTask" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTask" ErrorMessage="Please Enter Task" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Starting Date:"></asp:Label>
                                <asp:TextBox runat="server" TextMode="Date" ID="txtSDate" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSDate" ErrorMessage="Please Enter Starting Date" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Ending Date:"></asp:Label>
                                <asp:TextBox runat="server" TextMode="Date" ID="txtEDate" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEDate" ErrorMessage="Please Enter Ending Date" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Budget:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtBudget" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBudget" ErrorMessage="Please Enter Budget" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="No. of Women Farmer:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtWFarmer" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtWFarmer" ErrorMessage="Please Enter No. of Women Farmers" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="No. of Trainings Conducted:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtNoofTrainings" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNoofTrainings" ErrorMessage="Please Enter No. of Trainings" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="No. of Women Attended Training:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtNoofAttended" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNoofAttended" ErrorMessage="Please Enter No. of Women attended " SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="No. of Women not attended Training:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtNoofNotAttended" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNoofNotAttended" ErrorMessage="Please Enter No. of Women not attended " SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer clearfix">
                        <a href="ConductedTrainingsInfo.aspx" class="btn btn-danger">Cancel</a>
                        <asp:Button runat="server" ID="btnAdd" Text="Update" CssClass="btn btn-warning text-left" OnClick="btnAdd_Click" />
                    </div>
                </div>
            </div>

        </section>
    </form>
    <script>
        function NumberCheck(input) {
            debugger;
            let value = input.value;
            let numbers = value.replace(/[^0-9]/g, "");
            input.value = numbers;
        }
        $(document).ready(function () {
            $("#Project").addClass("active");
        });

    </script>
</asp:Content>

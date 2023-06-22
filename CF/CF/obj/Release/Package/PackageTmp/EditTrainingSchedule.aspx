<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="EditTrainingSchedule.aspx.cs" Inherits="CF.EditTrainingSchedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>New Training</title>
    <script>
        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "ProjectManagement.aspx";
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
                    <h3 class="box-title">Add Training Schedule</h3>
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
                                <asp:DropDownList runat="server" ID="ddlTrainingName" CssClass="form-control">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" InitialValue="Select" ControlToValidate="ddlTrainingName" ErrorMessage="Please Select Training Name" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                <asp:Label runat="server" Text="No. of Trainings:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtTrainings" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTrainings" ErrorMessage="Please Enter No. of Trainings" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Area:"></asp:Label>
                                <asp:TextBox runat="server" ID="txtArea" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtArea" ErrorMessage="Please Enter Area" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="CSO Name::"></asp:Label>
                                <asp:DropDownList runat="server" ID="ddlCSO" CssClass="form-control" OnSelectedIndexChanged="ddlCSO_SelectedIndexChanged">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" InitialValue="Select" ControlToValidate="ddlCSO" ErrorMessage="Please Select CSO" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="WFG Name:"></asp:Label>
                                <asp:DropDownList runat="server" ID="ddlWFG" CssClass="form-control">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" InitialValue="Select" ControlToValidate="ddlWFG" ErrorMessage="Please Select WFG" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer clearfix">
                        <a href="TrainingScheduleInfo.aspx" class="btn btn-danger">Cancel</a>
                        <asp:Button runat="server" ID="btnAdd" Text="Add" CssClass="btn btn-primary text-left" OnClick="btnAdd_Click" />
                    </div>
                </div>
            </div>
        </section>
    </form>
    <script>
        $(document).ready(function () {
            //$("#Project").addClass("active");
        });
        function NumberCheck(input) {
            debugger;
            let value = input.value;
            let numbers = value.replace(/[^0-9]/g, "");
            input.value = numbers;
        }
    </script>
</asp:Content>

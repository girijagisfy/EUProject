<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="CF.AddUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add User</title>

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

        function ShowExist(msg, type) {
            debugger;

            swal("", msg, type).then(function () {
                window.location = "UsersInfo.aspx";
            });
        }

        function SplCharCheck(input) {
            debugger;
            let value = input.value;
            let numbers = value.replace(/[^a-zA-Z0-9-.,/_&( )$@]/g, "").trimStart();
            input.value = numbers;
        }

        function SplCharCheck2(input) {
            debugger;
            let value = input.value;
            let numbers = value.replace(/[^a-zA-Z0-9_]/g, "").trimStart();
            input.value = numbers;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm1" runat="server"></asp:ScriptManager>
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Add User</h3>
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblType" runat="server" Text="Select Type"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlType" CssClass="form-control" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlType" InitialValue="Select" ErrorMessage="Please Select an Option" CssClass="text-danger" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlName" CssClass="form-control">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlName" InitialValue="Select" ErrorMessage="Please Select Name" CssClass="text-danger" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblUserID" runat="server" Text="User ID"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtUserID" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" OnTextChanged="txtUserID_TextChanged" MaxLength="30" AutoPostBack="true" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUserID" CssClass="text-danger" ErrorMessage="Please Enter User ID" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblUserStatus" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label runat="server" Text="Password"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtPassword" runat="server" oninput="SplCharCheck(this)" TextMode="Password" CssClass="form-control" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" CssClass="text-danger" ErrorMessage="Please Enter Password" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:Label runat="server" ID="lblPassword"></asp:Label>
                                        <ajaxToolkit:PasswordStrength ID="txtPassword_PasswordStrength" runat="server" BehaviorID="txtPassword_PasswordStrength" TargetControlID="txtPassword" MinimumLowerCaseCharacters="2" MinimumNumericCharacters="2" MinimumUpperCaseCharacters="2" PreferredPasswordLength="10" TextStrengthDescriptions="Week;Ok;Good;Strong;Excellent" StrengthIndicatorType="Text" TextStrengthDescriptionStyles="text-danger;text-warning;text-info;text-blue;text-success" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblCnfpwd" runat="server" Text="Confirm Password"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtConformPassword" runat="server" TextMode="Password" oninput="SplCharCheck(this)" CssClass="form-control" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConformPassword" CssClass="text-danger" ErrorMessage="Please Confirm Password" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConformPassword" CssClass="text-danger" ErrorMessage="Password is mismatched" Display="Dynamic" SetFocusOnError="true"></asp:CompareValidator>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="box-footer clearfix">
                    <a id="btnCancel" runat="server" class="btn btn-danger" href="UsersInfo.aspx">Cancel</a>
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Add" OnClick="btnSubmit_Click" />
                </div>
            </div>
        </section>
    </form>
    <script>
        $(document).ready(function () {
            $("#liUsers").addClass("active");
        });
    </script>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="AddState.aspx.cs" Inherits="CF.AddState" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add State</title>
    <style>
        label {
            padding-left: 10px;
        }
    </style>
    <script>

        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "StatesInfo.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
        }

        function SplCharCheck(input) {
            debugger;
            let value = input.value;
            let numbers = value.replace(/[^a-zA-Z ]/g, "").trimStart();
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
                    <h3 class="box-title">Add State</h3>
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>

                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <label>State Name</label>
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtState" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtState" ErrorMessage="Pease enter State Name" SetFocusOnError="true" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="box-footer clearfix">
                        <a id="btnCancel" runat="server" class="btn btn-danger" href="StatesInfo.aspx">Cancel</a>
                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Add" OnClick="btnSubmit_Click" />
                    </div>
                </div>
            </div>
        </section>
    </form>
    <script>
        $(document).ready(function () {
            $("#liStates").addClass("active");
        });
    </script>
</asp:Content>

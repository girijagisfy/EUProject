<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="EditDistrict.aspx.cs" Inherits="CF.EditDistrict" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Edit District</title>
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
                    window.location = "DistrictsInfo.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
        }

        function SplCharCheck(input) {
            debugger;
            let value = input.value;
            let numbers = value.replace(/[^a-zA-Z]/g, "").trimStart();
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
                    <h3 class="box-title">Edit District</h3>
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>

                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>State Name</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:DropDownList runat="server" ID="ddlState" CssClass="form-control">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlState" InitialValue="Select" ErrorMessage="Pease Select State Name" SetFocusOnError="true" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>District Name</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:TextBox runat="server" ID="txtDistrict" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDistrict" ErrorMessage="Pease Enter District Name" SetFocusOnError="true" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer clearfix">
                        <a id="btnCancel" runat="server" class="btn btn-danger" href="DistrictsInfo.aspx">Cancel</a>
                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-warning" Text="Update" OnClick="btnSubmit_Click" />
                    </div>
                </div>
            </div>
        </section>
    </form>
    <script>
        $(document).ready(function () {
            //debugger;
            $("#liDistricts").addClass("active");
        });
    </script>
</asp:Content>

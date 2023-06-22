<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="EditFinanceLiteracy.aspx.cs" Inherits="CF.EditFinanceLiteracy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Edit Financial literacy</title>
    <style>
        .LableSpace, label {
            font-weight: 500 !important;
            margin-right: 40px !important;
            margin-left: 5px !important;
        }
    </style>
    <script>

        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "FinancialLiteracyInfo.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
        }

        function NumberCheck(input) {
            debugger;
            let value = input.value;
            let numbers = value.replace(/[^0-9]/g, "");
            input.value = numbers;
        }

        function DecimalCheck(input) {
            debugger;
            let value = input.value;
            let numbers = value.replace(/[^0-9.]/g, "");
            input.value = numbers;
        }

        function SplCharCheck(input) {
            debugger;
            let value = input.value;
            let numbers = value.replace(/[^a-zA-Z0-9-.,/_&( )]/g, "").trimStart();
            input.value = numbers;
        }

        function SplCharCheck2(input) {
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
                    <h3 class="box-title">Add Financial literacy</h3>
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
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label8" runat="server" Text="Name Of State" ReadOnly="true"></asp:Label>
                                <asp:TextBox ID="txtState" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label173" runat="server" Text="Name Of CSO" ReadOnly="true"></asp:Label>
                                <asp:TextBox ID="txtCSO" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label2" runat="server" Text="Name Of District"></asp:Label>
                                <asp:TextBox ID="txtDistrict" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label1" runat="server" Text="Name Of Block"></asp:Label>
                                <asp:TextBox ID="txtBlock" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <%--<div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label4" runat="server" Text="Gram Panchayat Name"></asp:Label>
                                <asp:TextBox ID="txtGramPanchayat" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                        </div>--%>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label3" runat="server" Text="Village Name"></asp:Label>
                                <asp:TextBox ID="txtvillagename" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Hamlet</label>
                                <asp:TextBox runat="server" ID="txthamlet" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <asp:Panel runat="server" GroupingText="Finance literacy details">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label223" runat="server" Text="Name of bank in the village "></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtBank" runat="server" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Enter Name of bank in the village " ControlToValidate="txtBank" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label269" runat="server" Text="Bank distance from village (in KM)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtBankdistance" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Enter Bank distance from village (in KM) " ControlToValidate="txtBankdistance" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label224" runat="server" Text="Name of Co-operative society"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtCooperative" runat="server" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Enter Name of Co-operative society" ControlToValidate="txtCooperative" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label270" runat="server" Text="Distance of Co-operative society (in KM)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtCooperativeDistance" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Enter Distance of Co-operative society (in KM)" ControlToValidate="txtCooperativeDistance" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label225" runat="server" Text="Number of HHs with bank accounts"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtHHBanks" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Enter Number of HHs with bank accounts" ControlToValidate="txtHHBanks" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label233" runat="server" Text="Benefiting From Revolving Fund  UPSRLM/Nabard"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtRevolving" runat="server" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Enter benefiting from revolving fund  UPSRLM/Nabard" ControlToValidate="txtRevolving" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label226" runat="server" Text="Number of households having KCC "></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtKCC" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Enter Number of households having KCC " ControlToValidate="txtKCC" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label227" runat="server" Text="Number of households having Mudra loan"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtMudra" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Enter Number of households having Mudra loan" ControlToValidate="txtMudra" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <div class="box-footer clearfix">
                        <a id="btnCancel" runat="server" class="btn btn-danger" href="FinancialLiteracyInfo.aspx">Cancel</a>
                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-warning" Text="Update" OnClick="btnSubmit_Click" />
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

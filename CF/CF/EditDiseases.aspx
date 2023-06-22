<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="EditDiseases.aspx.cs" Inherits="CF.EditDiseases" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Edit Diseases</title>
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
                    window.location = "PrevalentDiseasesInfo .aspx";
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
            let numbers = value.replace(/[^0-9. ]/g, "");
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
                    <h3 class="box-title">Edit Diseases in village</h3>
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
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblyear" runat="server" Text="Year"></asp:Label>
                                <asp:TextBox ID="txtYear" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                        </div>
                    </div>
                    <asp:Panel ID="Panel11" runat="server" GroupingText="Major prevalent Diseases in village">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label206" runat="server" Text="Disease Name "></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="TxtDiseasesName" runat="server" CssClass="form-control" oninput="SplCharCheck2(this)" onblur="GetDataAddress();" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Disease Name" ControlToValidate="TxtDiseasesName" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label207" runat="server" Text="Description"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="Txtdescription" runat="server" CssClass="form-control" oninput="SplCharCheck2(this)" onblur="GetDiseases();" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Description" ControlToValidate="Txtdescription" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">
                                <a id="A1" runat="server" class="btn btn-danger" href="PrevalentDiseasesInfo.aspx">Cancel</a>
                                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" />
                            </div>
                        </div>
                    </asp:Panel>
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

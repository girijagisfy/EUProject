<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="FPCRegistrationEdit.aspx.cs" Inherits="CF.FPCRegistrationEdit" ValidateRequest="false" %>

<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Edit FPC Registration</title>

    <style>
        .Preview {
            /*font-family: arial, sans-serif;*/
            border-collapse: collapse;
            width: 100%;
            border-color: #dddddd;
            overflow-wrap: anywhere !important;
        }

        p.Mainheading {
            margin-bottom: 0px;
            font-size: 20px;
        }

        p.Subheading {
            margin-bottom: 0px;
            font-size: 18px;
        }

        .mt-3 {
            margin-top: 20px;
        }

        td, th {
            /*border: 1px solid #dddddd;*/
            text-align: left;
        }

        table {
            width: 100%;
        }

        th {
            width: auto;
        }

        .modal-header .close {
            margin-top: -20px !important;
        }

        .footer,
        #non-printable {
            display: none !important;
        }

        #printable {
            display: block;
        }

        .LableSpace, label {
            font-weight: 500 !important;
            margin-right: 40px !important;
            /*margin-left: 5px !important;*/
        }

        #cbdeclare, label {
            margin-left: 5px !important;
        }

        img {
            cursor: zoom-in;
        }

        div#ContentPlaceHolder1_pnlContact legend {
            font-size: 18px;
        }

        div#ContentPlaceHolder1_pnlMemberDetails legend {
            font-size: 18px;
        }

        div#ContentPlaceHolder1_pnlOtherDetails legend {
            font-size: 18px;
        }

        div#ContentPlaceHolder1_pnlLicenseDetails legend {
            font-size: 18px;
        }

        div#ContentPlaceHolder1_pnlAccountDetails legend {
            font-size: 18px;
        }


        label {
            margin-bottom: 0px;
        }

        .removeDiv {
            float: right;
        }

        a {
            cursor: pointer;
        }
    </style>
    <script>
    function ShowAlert(msg, type) {
        //debugger;
        if (type == 'success') {
            swal("", msg, type).then(function () {
                window.location = "FPCInfo.aspx";
            });
        }
        else {
            swal("", msg, type);
        }
    }

    function validateEmail(emailField, lable, field) {
        //debugger;
        var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
        if ($('#ContentPlaceHolder1_' + field).val() != '') {
            if (reg.test(emailField.value) == false) {
                //alert('Invalid Email Address');
                $('#' + lable).text('Please Enter Valid Email');
                $('#ContentPlaceHolder1_' + field).focus();
                return false;
            }
            $('#' + lable).text('');
            return true;
        }
        $('#' + lable).text('');
        return true;
    }

    function NumberCheck(input) {
        //debugger;
        let value = input.value;
        let numbers = value.replace(/[^0-9]/g, "");
        input.value = numbers;
    }

    function DecimalCheck(input) {
        ////debugger;
        let value = input.value;
        let numbers = value.replace(/[^0-9.]/g, "");
        input.value = numbers;
    }

    function SplCharCheck(input) {
        //debugger;
        let value = input.value;
        let numbers = value.replace(/[^a-zA-Z0-9-.,/_&( )]/g, "").trimStart();
        input.value = numbers;
    }

    function SplCharCheckPassword(input) {
        //debugger;
        let value = input.value;
        let numbers = value.replace(/[^a-zA-Z0-9-.,/_&@#$( )]/g, "").trimStart();
        input.value = numbers;
    }

    function printDiv(divName) {
        var printContents = document.getElementById(divName).innerHTML;
        // var originalContents = document.body.innerHTML;
        var printWindow = window.open('', '', 'height=800,width=800');
        printWindow.document.write('<html><head><title>Print DIV Content</title>');
        printWindow.document.write('<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css" />');
        printWindow.document.write("<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'>");
        printWindow.document.write('<link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css" />');
        printWindow.document.write('<link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css" />');
        printWindow.document.write('<link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css" />');
        printWindow.document.write('<link rel="stylesheet" href="dist/css/AdminLTE.min.css" />');
        printWindow.document.write('<link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">');
        printWindow.document.write('<link rel="stylesheet" href="bower_components/morris.js/morris.css">');
        printWindow.document.write('<link rel="stylesheet" href="bower_components/jvectormap/jquery-jvectormap.css">');
        printWindow.document.write(' <link rel="stylesheet" href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css" />');
        printWindow.document.write(' <link rel="stylesheet" href="bower_components/bootstrap-daterangepicker/daterangepicker.css" />');
        printWindow.document.write('<link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />');
        printWindow.document.write('<style>.Preview {border-collapse: collapse;width: 100%;border-color: #dddddd;overflow-wrap: anywhere !important;} p.heading {margin-bottom: 0px;font-size: 20px;}.mt-3 {margin-top: 20px;} td, th {border: 1px solid #dddddd;text-align: left;padding:5px;}table {width: 100% !important;;}th {width: 20% !important;} .modal-header .close {margin-top: -20px !important;}</style>');
        printWindow.document.write('</head><body>');
        printWindow.document.write(printContents);
        printWindow.document.write('</body></html>');
        printWindow.document.close();
        printWindow.print();
        //document.body.innerHTML = printContents;

        //window.print();

        //document.body.innerHTML = originalContents;
    }
    </script>

    <link href="plugins/select2/css/select2.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm1" runat="server"></asp:ScriptManager>
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Edit FPC Registration</h3>
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <div class="box-body">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-3">
                                    <asp:Label ID="Label5" runat="server" Text="State"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList runat="server" ID="ddlState" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select State" ControlToValidate="ddlState" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label2" runat="server" Text="District"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList runat="server" ID="ddlDistrict" CssClass="form-control" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select District" ControlToValidate="ddlDistrict" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label7" runat="server" Text="Block"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList runat="server" ID="ddlBlocks" CssClass="form-control" OnSelectedIndexChanged="ddlBlock_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select Block" ControlToValidate="ddlBlocks" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label6" runat="server" Text="CSO"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList runat="server" ID="ddlCSO" CssClass="form-control">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Select CSO Name" ControlToValidate="ddlCSO" SetFocusOnError="true" InitialValue="Select" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Panel ID="pnlFPC" runat="server" GroupingText="FPC Details">
                        <asp:Panel ID="pnlContact" runat="server" GroupingText="Contact Details">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <asp:Label ID="lblcompany" runat="server" Text="FPC Name"></asp:Label><b style="color: red"> *</b>
                                                <asp:TextBox runat="server" ID="txtFPCName" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter FPC Name" ControlToValidate="txtFPCName" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <asp:Label ID="lblorganisation" runat="server" Text="FPC Contact Number"></asp:Label><b style="color: red"> *</b>
                                                <asp:TextBox runat="server" ID="txtFPCConcact" CssClass="form-control" oninput="NumberCheck(this)" MaxLength="10"></asp:TextBox>
                                                <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter contact number" ControlToValidate="txtFPCConcact" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <asp:Label ID="lblAddress" runat="server" Text="FPC Email"></asp:Label><b style="color: red"> *</b>
                                                <asp:TextBox runat="server" ID="txtFPCEmail" onblur="validateEmail(this,'lblFPCEmail','txtFPCEmail')" CssClass="form-control"></asp:TextBox>
                                                <label id="lblFPCEmail" class="text-danger"></label>
                                                <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter valid email" ControlToValidate="txtFPCEmail" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <asp:Label ID="lblbusiness" runat="server" Text="FPC Website (if any)"></asp:Label>
                                                <asp:TextBox runat="server" ID="txtFPCWebsite" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:Label ID="lblapplicant" runat="server" Text="FPC Address"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtFPCAddress" TextMode="MultiLine" Rows="4" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Address" ControlToValidate="txtFPCAddress" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" ID="pnlMemberDetails" GroupingText="Member Details">
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label ID="lblturnover" runat="server" Text="Male Members"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtmaleMembers" oninput="NumberCheck(this)" CssClass="form-control" onblur="calTotalMem();"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Male Members" ControlToValidate="txtmaleMembers" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label ID="lblAadhar" runat="server" Text="Female Members"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtfemaleMembers" oninput="NumberCheck(this)" CssClass="form-control" onblur="calTotalMem();"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Female Members" ControlToValidate="txtfemaleMembers" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label ID="Label42" runat="server" Text="Transgender Members"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtTransgenderMembers" oninput="NumberCheck(this)" CssClass="form-control" onblur="calTotalMem();"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Transgender Members" ControlToValidate="txtTransgenderMembers" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label ID="lblemployed" runat="server" Text="Total Members"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtTotalMembers" oninput="NumberCheck(this)" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Total Members" ControlToValidate="txtTotalMembers" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label ID="Label3" runat="server" Text="SF/MF Members"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtSFMFmembers" oninput="NumberCheck(this)" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter SF/MF Members" ControlToValidate="txtSFMFmembers" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator runat="server" CssClass="text-danger" ErrorMessage="SF/MF members should be less than or equal to total members" ControlToCompare="txtTotalMembers" Type="Integer" ControlToValidate="txtSFMFmembers" Operator="LessThanEqual" Display="Dynamic" ValidationGroup="validatePreview" SetFocusOnError="true"></asp:CompareValidator>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label ID="Label4" runat="server" Text="ST Members"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtSTmembers" oninput="NumberCheck(this)" CssClass="form-control" onblur="calTotalMem();"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter ST Members" ControlToValidate="txtSTmembers" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label ID="Label8" runat="server" Text="SC Members"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtSCMembers" oninput="NumberCheck(this)" CssClass="form-control" onblur="calTotalMem();"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter SC Members" ControlToValidate="txtSCMembers" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label ID="Label9" runat="server" Text="OBC Members"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtOBCMembers" oninput="NumberCheck(this)" CssClass="form-control" onblur="calTotalMem();"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter OBC Members" ControlToValidate="txtOBCMembers" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label ID="Label43" runat="server" Text="General Members"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtGeneral" oninput="NumberCheck(this)" CssClass="form-control" onblur="calTotalMem();"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter General Members" ControlToValidate="txtGeneral" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Label ID="Label29" runat="server" Text="Social Category Total"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtSocialCategoryTotal" oninput="NumberCheck(this)" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        <asp:CompareValidator runat="server" ID="cmpSocial" CssClass="text-danger" ErrorMessage="Social category members should be less than or equal to total members" ControlToCompare="txtTotalMembers" Type="Integer" ControlToValidate="txtSocialCategoryTotal" Operator="LessThanEqual" Display="Dynamic" ValidationGroup="validatePreview" SetFocusOnError="true"></asp:CompareValidator>
                                    </div>
                                </div>
                            </div>
                            <asp:Label runat="server" CssClass="text-danger" ID="lblSocialMem"></asp:Label>
                        </asp:Panel>
                        <asp:Panel ID="pnlOtherDetails" runat="server" GroupingText="Other Details">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="lblPancard" runat="server" Text="No. of Villages Covered"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtVillgesCovered" oninput="NumberCheck(this)" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Villages Covered" ControlToValidate="txtVillgesCovered" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="lblAccount" runat="server" Text="No. of Blocks Covered"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtBlocksCovered" oninput="NumberCheck(this)" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Blocks Covered" ControlToValidate="txtBlocksCovered" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label1" runat="server" Text="No. of Districts Covered"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtDistrictsCovered" oninput="NumberCheck(this)" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Districts Covered" ControlToValidate="txtDistrictsCovered" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label66" runat="server" Text="No.of Shares Mobilized "></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtNoofSharesMobilized" oninput="DecimalCheck(this)" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter No.of Shares Mobilized" ControlToValidate="txtNoofSharesMobilized" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <%-- till this --%>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="lblCommence" runat="server" Text="Shared Money Mobilized (in Rs.)"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtSharedMoneyMobilized" oninput="DecimalCheck(this)" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Shares Mobilized" ControlToValidate="txtSharedMoneyMobilized" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="lblAdditional" runat="server" Text="SFAC Equity Support Availed"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList runat="server" ID="ddlSFACEquity" CssClass="form-control">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" SetFocusOnError="true" ControlToValidate="ddlSFACEquity" InitialValue="Select" ErrorMessage="Select SFAC Equity Support Availed" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3" id="dvEquityGrant">
                                    <div class="form-group">
                                        <asp:Label ID="lblInvestment" runat="server" Text="Equity Grant Fund Mobilized (in Rs.)"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtEquityGrant" oninput="DecimalCheck(this)" CssClass="form-control"></asp:TextBox>
                                        <asp:CustomValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ValidateEmptyText="true" ErrorMessage="Please Enter Equity Grant Fund" SetFocusOnError="true" Display="Static" ClientValidationFunction="validateEquityGrant"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label10" runat="server" Text="FPC Registration Date"></asp:Label><b style="color: red"> *</b>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtFPCRegistrationDate" runat="server" CssClass="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                        </div>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Registration Date" ControlToValidate="txtFPCRegistrationDate" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label35" runat="server" Text="Legal Act under Which FPC is Registered"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList runat="server" ID="ddlLegalActFPC" CssClass="form-control">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                            <asp:ListItem Value="Company" Text="Company"></asp:ListItem>
                                            <asp:ListItem Value="Cooperative Society" Text="Cooperative Society"></asp:ListItem>
                                            <asp:ListItem Value="Society" Text="Society"></asp:ListItem>
                                            <asp:ListItem Value="Trust" Text="Trust"></asp:ListItem>
                                            <asp:ListItem Value="Others" Text="Others"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select Legal Act" ControlToValidate="ddlLegalActFPC" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="dvOtherLegalAct">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label30" runat="server" Text="Legal Act under Which FPC is Registered (if others)"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="txtOtherLeagal" oninput="SplCharCheck(this);"></asp:TextBox>
                                        <%--<asp:CustomValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ValidateEmptyText="true"  ErrorMessage="Enter Legal Act under Which FPC is Registered (if others)" SetFocusOnError="true" Display="Static" ClientValidationFunction="validateOtherLegalAct"></asp:CustomValidator>--%>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" GroupingText="Support Taken Details" ID="pnlSupporttDetails">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="lblContact" runat="server" Text="CIN Number"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtCINNumber" oninput="SplCharCheck(this)" MaxLength="21" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter CIN Number" ControlToValidate="txtCINNumber" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="lblSupportTakenFrom" runat="server" Text="Support Taken from other Agency"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList runat="server" ID="ddlSupportTaken" CssClass="form-control">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" SetFocusOnError="true" ControlToValidate="ddlSupportTaken" InitialValue="Select" ErrorMessage="Select Support Taken from other Agency" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div id="dvSupportTaken">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="lblNameofAgency" runat="server" Text="Name of Agency"></asp:Label><b style="color: red"> *</b>
                                            <asp:TextBox runat="server" ID="txtNameofAgency0" oninput="SplCharCheck(this)" onblur="GetSupportTakenData();" CssClass="form-control"></asp:TextBox>
                                            <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="txtNameofAgency0" runat="server" CssClass="text-danger" ValidateEmptyText="true" ErrorMessage="Please Enter Name of Agency" ClientValidationFunction="validateNameofAgency" SetFocusOnError="true" Display="Static"></asp:CustomValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="lblNameofScheme" runat="server" Text="Name of Scheme"></asp:Label><b style="color: red"> *</b>
                                            <asp:TextBox runat="server" ID="txtNameofScheme0" oninput="SplCharCheck(this)" onblur="GetSupportTakenData();" CssClass="form-control"></asp:TextBox>
                                            <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="txtNameofScheme0" runat="server" CssClass="text-danger" ValidateEmptyText="true" ErrorMessage="Please Enter Name of Scheme" ClientValidationFunction="validateNameofScheme" SetFocusOnError="true" Display="Static"></asp:CustomValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="lblConfirmpw" runat="server" Text="Support (in Rs.)"></asp:Label><b style="color: red"> *</b>
                                            <asp:TextBox runat="server" ID="txtSupport0" oninput="DecimalCheck(this)" onblur="GetSupportTakenData();" CssClass="form-control"></asp:TextBox>
                                            <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="txtSupport0" runat="server" CssClass="text-danger" ValidateEmptyText="true" ErrorMessage="Please Enter Support" ClientValidationFunction="validateSchemeSupport" SetFocusOnError="true" Display="Static"></asp:CustomValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="Label41" runat="server" Text="Date"></asp:Label><b style="color: red"> *</b>
                                            <div class="input-group date">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <asp:TextBox ID="txtSupportTakenDate0" runat="server" onchange="GetSupportTakenData()" CssClass="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                            </div>
                                            <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="txtSupportTakenDate0" runat="server" CssClass="text-danger" ValidateEmptyText="true" ErrorMessage="Please Enter Date" ClientValidationFunction="validateSchemeDate" SetFocusOnError="true" Display="Static"></asp:CustomValidator>
                                        </div>
                                    </div>
                                </div>
                                <div id="dynamicControls">
                                </div>
                                <div class="row">
                                    <div class="col-md-2">
                                        <div class="form-group">
                                            <a id="AddSupportTaken" onclick="addSupportTaken();"><i class="fa fa-plus-circle">Add New</i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" GroupingText="Bank Details" ID="pnlBankDetails">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label13" runat="server" Text="Bank Name"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtBankName0" oninput="SplCharCheck(this)" onblur="GetBankDetailsData();" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Bank Name" ControlToValidate="txtBankName0" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label11" runat="server" Text="FPC Bank Account Number"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtFPCBankNumber0" oninput="NumberCheck(this)" onblur="GetBankDetailsData();" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Bank Account Number" ControlToValidate="txtFPCBankNumber0" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label12" runat="server" Text="Account Type"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtFPCAccountType0" oninput="SplCharCheck(this)" onblur="GetBankDetailsData();" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Account Type" ControlToValidate="txtFPCAccountType0" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label14" runat="server" Text="Bank Branch"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtBankBranch0" oninput="SplCharCheck(this)" onblur="GetBankDetailsData();" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Bank Branch" ControlToValidate="txtBankBranch0" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label15" runat="server" Text="IFSC Code"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtICSCCode0" oninput="SplCharCheck(this)" onblur="GetBankDetailsData();" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter IFSC Code" ControlToValidate="txtICSCCode0" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div id="dynamicBankDetails">
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <a id="AddBankDetails" onclick="addBankDetails();"><i class="fa fa-plus-circle">Add New</i></a>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" GroupingText="ID Proof Details" ID="pnlIdProofs">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <asp:Label ID="Label16" runat="server" Text="FPC Business Address"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" TextMode="MultiLine" ID="txtFPCBusinessAddress" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Business Address" ControlToValidate="txtFPCBusinessAddress" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:Label ID="Label47" runat="server" Text="PAN"></asp:Label>
                                </div>
                                <div class="col-md-4">
                                    <asp:RadioButtonList ID="rblPAN" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal" BorderStyle="None" BorderWidth="0">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblPAN" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="validatePreview"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row" id="dvPANno">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label48" runat="server" Text="PAN No"></asp:Label><b style="color: red">*</b>
                                        <asp:TextBox ID="txtPanNo" runat="server" placeholder="PAN No" CssClass="form-control" oninput="SplCharCheck(this)" />
                                        <asp:CustomValidator runat="server" ControlToValidate="txtPanNo" ErrorMessage="Please Enter PAN Number" Display="Dynamic" ClientValidationFunction="ValidatePANNo" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="validatePreview"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label49" runat="server" Text="Date"></asp:Label><b style="color: red">*</b>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtPanDate" runat="server" CssClass="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                        </div>
                                        <asp:CustomValidator runat="server" ControlToValidate="txtPanDate" ErrorMessage="Please Enter PAN Date" Display="Dynamic" ClientValidationFunction="ValidatePANDate" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="validatePreview"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label50" runat="server" Text="Expiry Date"></asp:Label>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtPanExpiry" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:Label ID="Label51" runat="server" Text="TAN"></asp:Label>
                                </div>
                                <div class="col-md-4">
                                    <asp:RadioButtonList ID="rblTAN" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal" BorderStyle="None">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblTAN" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="validatePreview"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row" id="dvTANno">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label52" runat="server" Text="TAN No"></asp:Label><b style="color: red">*</b>
                                        <asp:TextBox ID="txtTanNo" runat="server" placeholder="TAN No" MaxLength="10" CssClass="form-control" oninput="SplCharCheck(this)" />
                                        <%--<asp:CustomValidator runat="server" ControlToValidate="txtTanNo" ErrorMessage="Please Enter TAN Number" Display="Dynamic" ClientValidationFunction="ValidateTANNo" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="validatePreview"></asp:CustomValidator>--%>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label53" runat="server" Text="Date"></asp:Label><b style="color: red">*</b>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtTanDate" runat="server" CssClass="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy" />
                                        </div>
                                        <%--<asp:CustomValidator runat="server" ControlToValidate="txtTanDate" ErrorMessage="Please Enter TAN Date" Display="Dynamic" ClientValidationFunction="ValidateTANDate" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="validatePreview"></asp:CustomValidator>--%>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label54" runat="server" Text="Expiry Date"></asp:Label>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtTanExpiry" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:Label ID="Label17" runat="server" Text="GST"></asp:Label>
                                </div>
                                <div class="col-md-4">
                                    <asp:RadioButtonList ID="rblGST" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal" BorderStyle="None">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblGST" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="validatePreview"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row" id="dvGSTno">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label18" runat="server" Text="GST No"></asp:Label><b style="color: red">*</b>
                                        <asp:TextBox ID="txtGSTNo" runat="server" oninput="SplCharCheck(this)" MaxLength="15" placeholder="GST No" CssClass="form-control" />
                                        <asp:CustomValidator runat="server" ControlToValidate="txtGSTNo" ErrorMessage="Please Enter GST No" Display="Dynamic" ClientValidationFunction="ValidateGSTNo" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="validatePreview"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label22" runat="server" Text="Date"></asp:Label><b style="color: red">*</b>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtGSTDate" runat="server" CssClass="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy" />
                                        </div>
                                        <asp:CustomValidator runat="server" ControlToValidate="txtGSTDate" ErrorMessage="Please Enter GST Date" Display="Dynamic" ClientValidationFunction="ValidateGSTDate" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="validatePreview"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label24" runat="server" Text="Expiry Date"></asp:Label>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtGSTExpiry" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:Label ID="Label55" runat="server" Text="Service Tax Number"></asp:Label>
                                </div>
                                <div class="col-md-4">
                                    <asp:RadioButtonList ID="rblServiceTax" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal" BorderStyle="None">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblServiceTax" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="validatePreview"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row" id="dvServiceTax">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label19" runat="server" Text="Service TAX Number"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtServiceTAXNumber" oninput="SplCharCheck(this)" MaxLength="15" CssClass="form-control"></asp:TextBox>
                                        <asp:CustomValidator runat="server" ControlToValidate="txtServiceTAXNumber" ErrorMessage="Please Enter  Service Tax Number" Display="Dynamic" ClientValidationFunction="ValidateServiceTaxNumber" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="validatePreview"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label57" runat="server" Text="Date"></asp:Label><b style="color: red">*</b>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtServiceTaxDate" runat="server" CssClass="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy" />
                                        </div>
                                        <asp:CustomValidator runat="server" ControlToValidate="txtServiceTaxDate" ErrorMessage="Please Enter Service Tax Date" Display="Dynamic" ClientValidationFunction="ValidateServiceTaxDate" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="validatePreview"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label58" runat="server" Text="Expiry Date"></asp:Label>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtServiceTaxExpiry" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" GroupingText="License Details" ID="pnlLicenseDetails">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label20" runat="server" Text="Business license Taken"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList runat="server" ID="ddlBusinessTaken" CssClass="form-control">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Business license Taken" ControlToValidate="ddlBusinessTaken" SetFocusOnError="true" Display="Dynamic" InitialValue="Select"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div id="dvBusiness">
                                <div class="row" runat="server">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label runat="server" Text="License Name"></asp:Label><b style="color: red"> *</b>
                                            <asp:TextBox runat="server" ID="txtLicenceName0" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                            <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="txtLicenceName0" ValidateEmptyText="true" runat="server" CssClass="text-danger" ClientValidationFunction="BusinessLicenceNameValidate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Enter License Number"></asp:CustomValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="Label21" runat="server" Text="License Number"></asp:Label><b style="color: red"> *</b>
                                            <asp:TextBox runat="server" ID="txtLicenseNumber0" oninput="SplCharCheck(this)" onblur="GetBusinessLicenseData();" CssClass="form-control"></asp:TextBox>
                                            <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="txtLicenseNumber0" ValidateEmptyText="true" runat="server" CssClass="text-danger" ClientValidationFunction="BusinessLicenceNumberValidate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Enter License Number"></asp:CustomValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label runat="server" Text="Name of licensing authority"></asp:Label><b style="color: red"> *</b>
                                            <asp:TextBox runat="server" ID="txtLicenceNameauthority0" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                            <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="txtLicenceNameauthority0" ValidateEmptyText="true" runat="server" CssClass="text-danger" ClientValidationFunction="BusinessLicenceNameauthorityValidate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Enter License Number Authority"></asp:CustomValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="Label44" runat="server" Text="License Registration Date"></asp:Label><b style="color: red"> *</b>
                                            <div class="input-group date">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <asp:TextBox ID="txtLicenceRegistrationDate0" runat="server" CssClass="form-control pull-right CurrectDatePicker" onchange="GetBusinessLicenseData();" placeholder="dd-MM-yyyy"></asp:TextBox>
                                            </div>
                                            <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="txtLicenceRegistrationDate0" ValidateEmptyText="true" runat="server" CssClass="text-danger" ClientValidationFunction="BusinessLicenceDateValidate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Enter License Registration Date"></asp:CustomValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="Label45" runat="server" Text="License Expiry Date"></asp:Label>
                                            <div class="input-group date">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <asp:TextBox ID="txtLicenceExpiryDate0" runat="server" CssClass="form-control pull-right datePicker" onchange="GetBusinessLicenseData();" placeholder="dd-MM-yyyy"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="dynamicBusiness">
                                </div>
                                <div class="row">
                                    <div class="col-md-2">
                                        <div class="form-group">
                                            <a id="AddBusiness" onclick="addBusinessLicense();"><i class="fa fa-plus-circle">Add New</i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="aboutus" runat="server" GroupingText="About Us Details">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label36" runat="server" Text="Overview"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox runat="server" ID="txtOverview" oninput="SplCharCheck(this)" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter OverView" ControlToValidate="txtOverview" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label37" runat="server" Text="Mission Statement"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox runat="server" ID="txtMission" oninput="SplCharCheck(this)" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Mission" ControlToValidate="txtMission" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblVision" runat="server" Text="Vision Statement"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox runat="server" ID="txtVission" oninput="SplCharCheck(this)" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Vision" ControlToValidate="txtVission" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblValues" runat="server" Text="Our Core values"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox runat="server" ID="txtCorevalues" oninput="SplCharCheck(this)" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Our Core values" ControlToValidate="txtCorevalues" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label38" runat="server" Text="Chairperson Note "></asp:Label>
                                    <asp:TextBox runat="server" ID="txtChairperson" oninput="SplCharCheck(this)" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label39" runat="server" Text="Business Model"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox runat="server" ID="txtBusinessModel" oninput="SplCharCheck(this)" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Business Model " ControlToValidate="txtBusinessModel" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label40" runat="server" Text="Social and Environment "></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox runat="server" ID="txtSocialandenvironment" oninput="SplCharCheck(this)" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please enter Social and environment " ControlToValidate="txtSocialandenvironment" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" GroupingText="OurTeam">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label23" runat="server" Text="Team Members"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList runat="server" ID="ddlTeamMembers" CssClass="form-control">
                                        <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Select Team Members" ControlToValidate="ddlTeamMembers" SetFocusOnError="true" InitialValue="Select" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div id="dvTeamMembers">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label25" runat="server" Text="Employee Name"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtEmployeeName0" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                        <asp:CustomValidator ValidationGroup="validatePreview" runat="server" ID="cvEmpName" ValidateEmptyText="true" ClientValidationFunction="EmpNameValidate" CssClass="text-danger" ErrorMessage="Please Enter Employee Name" SetFocusOnError="true" Display="Dynamic"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label26" runat="server" Text="Gender"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList runat="server" ID="ddlEmpGender0" CssClass="form-control teamGender">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                            <asp:ListItem Value="Male" Text="Male"></asp:ListItem>
                                            <asp:ListItem Value="Female" Text="Female"></asp:ListItem>
                                            <asp:ListItem Value="Transgender" Text="Transgender"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:CustomValidator ValidationGroup="validatePreview" runat="server" ID="cvGender" ClientValidationFunction="GenderValidate" CssClass="text-danger" ErrorMessage="Please Select Gender" SetFocusOnError="true" Display="Dynamic"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label27" runat="server" Text="Contact Number"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtContactNumber0" MaxLength="10" oninput="NumberCheck(this)" CssClass="form-control"></asp:TextBox>
                                        <asp:CustomValidator ValidationGroup="validatePreview" runat="server" ID="cvContact" ValidateEmptyText="true" ClientValidationFunction="ContactValidate" CssClass="text-danger" ErrorMessage="Please Enter Contact Number" SetFocusOnError="true" Display="Dynamic"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label28" runat="server" Text="Designation"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList runat="server" ID="ddlDesignation0" CssClass="form-control teamDesignation">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                            <asp:ListItem Value="President" Text="President"></asp:ListItem>
                                            <asp:ListItem Value="Vice-President" Text="Vice-President"></asp:ListItem>
                                            <asp:ListItem Value="Secretary" Text="Secretary"></asp:ListItem>
                                            <asp:ListItem Value="Joint-Secretary" Text="Joint-Secretary"></asp:ListItem>
                                            <asp:ListItem Value="Treasurer" Text="Treasurer"></asp:ListItem>
                                            <asp:ListItem Value="Others" Text="Others"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="ddlDesignation0" runat="server" ID="CustomValidator1" ClientValidationFunction="DesignationValidate" CssClass="text-danger" ErrorMessage="Please Select Designation" SetFocusOnError="true" Display="Dynamic"></asp:CustomValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label62" runat="server" Text="Date of Joining"></asp:Label><b style="color: red"> *</b>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtDOJ0" runat="server" CssClass="form-control pull-right CurrectDatePicker" onchange="GetTeamMemberData();" placeholder="dd-MM-yyyy"></asp:TextBox>
                                        </div>
                                        <%--<asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="txtDOJ0" ValidateEmptyText="true" runat="server" CssClass="text-danger" ClientValidationFunction="DOJoinValidate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Enter Date of Joining"></asp:CustomValidator>--%>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label63" runat="server" Text="Date of Relieving"></asp:Label>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtDOR0" runat="server" CssClass="form-control pull-right datePicker" onchange="GetTeamMemberData();" placeholder="dd-MM-yyyy"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="dynamicTeamMembers">
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <a id="addTeamMember" onclick="addTeamMembers();"><i class="fa fa-plus-circle">Add New</i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label56" runat="server" Text="DirectorsAppointed"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList runat="server" ID="ddlDirectors" CssClass="form-control">
                                        <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Select Directors Appointed" ControlToValidate="ddlDirectors" SetFocusOnError="true" InitialValue="Select" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div id="dvDirectors">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label31" runat="server" Text="Directors Name"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtDirectorsName0" oninput="SplCharCheck(this)" CssClass="form-control" onblur="GetDirectorsAppointedData();"></asp:TextBox>
                                        <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="txtDirectorsName0" ValidateEmptyText="true" runat="server" ID="CustomValidator2" ClientValidationFunction="DirectorNameValidate" CssClass="text-danger" ErrorMessage="Please Enter Name" SetFocusOnError="true" Display="Dynamic"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label60" runat="server" Text="Gender"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList runat="server" ID="ddlDirectorGender0" CssClass="form-control teamGender" onchange="GetDirectorsAppointedData()">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                            <asp:ListItem Value="Male" Text="Male"></asp:ListItem>
                                            <asp:ListItem Value="Female" Text="Female"></asp:ListItem>
                                            <asp:ListItem Value="Transgender" Text="Transgender"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="ddlDirectorGender0" runat="server" ID="CustomValidator3" ClientValidationFunction="DirectorGenderValidate" CssClass="text-danger" ErrorMessage="Please Select Gender" SetFocusOnError="true" Display="Dynamic"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label61" runat="server" Text="Contact Number"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox runat="server" ID="txtDirectorContact0" MaxLength="10" oninput="NumberCheck(this)" CssClass="form-control" onblur="GetDirectorsAppointedData()"></asp:TextBox>
                                        <asp:CustomValidator ValidationGroup="validatePreview" ValidateEmptyText="true" ControlToValidate="txtDirectorContact0" runat="server" ID="CustomValidator4" ClientValidationFunction="DirectorContactValidate" CssClass="text-danger" ErrorMessage="Please Enter Contract number" SetFocusOnError="true" Display="Dynamic"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label46" runat="server" Text="Type of Appointment"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList runat="server" ID="ddlDirectorType0" CssClass="form-control teamGender" onchange="GetDirectorsAppointedData()">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                            <asp:ListItem Value="Selected" Text="Selected"></asp:ListItem>
                                            <asp:ListItem Value="Elected" Text="Elected"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="ddlDirectorType0" runat="server" ID="CustomValidator5" ClientValidationFunction="DirectorTypeValidate" CssClass="text-danger" ErrorMessage="Please Select Type of Appointment" SetFocusOnError="true" Display="Dynamic"></asp:CustomValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label64" runat="server" Text="Date of Joining"></asp:Label><b style="color: red"> *</b>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtDirectorDOJ0" runat="server" CssClass="form-control pull-right CurrectDatePicker" onchange="GetDirectorsAppointedData();" placeholder="dd-MM-yyyy"></asp:TextBox>
                                        </div>
                                        <asp:CustomValidator ValidationGroup="validatePreview" ControlToValidate="txtDirectorDOJ0" ValidateEmptyText="true" runat="server" CssClass="text-danger" ClientValidationFunction="DirectorDOJoinValidate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Enter Date of Joining"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label65" runat="server" Text="Date of Relieving"></asp:Label>
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <asp:TextBox ID="txtDirectorDOR0" runat="server" CssClass="form-control pull-right datePicker" onchange="GetDirectorsAppointedData();" placeholder="dd-MM-yyyy"></asp:TextBox>
                                            <asp:HiddenField ID="hfDirID0" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="dynamicDirectors">
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <br />
                                        <a id="addDirector" onclick="addDirectors();"><i class="fa fa-plus-circle">Add New</i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" GroupingText="Credentials">
                        <div class="row">
                            <div class="col-md-9">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <asp:Label ID="Label32" runat="server" Text="User ID"></asp:Label><b style="color: red"> *</b>
                                                    <asp:TextBox runat="server" ID="txtUserName" OnTextChanged="txtuser_TextChanged" CssClass="form-control" AutoPostBack="true"></asp:TextBox>
                                                    <asp:Label runat="server" ID="lblCheck"></asp:Label>
                                                    <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter User Name" ControlToValidate="txtUserName" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <asp:Label ID="Label33" runat="server" Text="Password"></asp:Label><b style="color: red"> *</b>
                                                    <asp:TextBox runat="server" ID="txtPassword" oninput="SplCharCheckPassword(this)" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Password" ControlToValidate="txtPassword" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <%--<asp:PasswordStrength ID="pwdStrength" StrengthIndicatorType="Text" PrefixText="Strength:" runat="server" TargetControlID="txtPassword"/>--%>
                                                    <ajaxToolkit:PasswordStrength ID="txtPassword_PasswordStrength" runat="server" BehaviorID="txtPassword_PasswordStrength" DisplayPosition="BelowRight" TargetControlID="txtPassword" MinimumLowerCaseCharacters="2" MinimumNumericCharacters="2" MinimumUpperCaseCharacters="2" PreferredPasswordLength="10" TextStrengthDescriptions="Week;Ok;Good;Strong;Excellent" StrengthIndicatorType="Text" TextStrengthDescriptionStyles="text-danger;text-warning;text-info;text-blue;text-success" />
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <asp:Label ID="Label34" runat="server" Text="Confirm Password"></asp:Label><b style="color: red"> *</b>
                                            <asp:TextBox runat="server" ID="txtConfirmPassword" TextMode="Password" oninput="SplCharCheckPassword(this)" CssClass="form-control"></asp:TextBox>
                                            <asp:CompareValidator runat="server" ControlToCompare="txtPassword" CssClass="text-danger" ControlToValidate="txtConfirmPassword" ErrorMessage="Password mismatched" Display="Dynamic" SetFocusOnError="true"></asp:CompareValidator>
                                            <asp:RequiredFieldValidator ValidationGroup="validatePreview" runat="server" ControlToValidate="txtConfirmPassword" CssClass="text-danger" ErrorMessage="Password mismatched" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <asp:Label Text="FPC Logo" runat="server"></asp:Label><small style="color: red">&nbsp;(.jpg, .jpeg, .png, max-size=100kb)</small>
                                            <div class="custom-file form-group" style="overflow: hidden;">
                                                <asp:FileUpload runat="server" class="custom-file-input" ID="fuFpcLogo" onchange="previewImage(this);" accept="image/png,image/jpg,image/jpeg" />
                                                <label class="custom-file-label" for="customFile">Choose file</label>
                                            </div>
                                            <asp:RegularExpressionValidator ValidationGroup="validatePreview" ID="RegExValFileUploadFileType" runat="server" ControlToValidate="fuFpcLogo" ErrorMessage="Only .jpg,.png,.jpeg Files are allowed" CssClass="text-danger" Display="Dynamic" ValidationExpression="(.*?)\.(jpg|jpeg|png|JPG|JPEG|PNG)$"></asp:RegularExpressionValidator>
                                            <%--<asp:CustomValidator  ValidationGroup="validatePreview" runat="server" CssClass="text-danger" ErrorMessage="Image size should be less than 100kb and ratio 100 x 100" ClientValidationFunction="checkFileSizeandRatio" Display="Static" SetFocusOnError="true"></asp:CustomValidator>--%>
                                            <label id="lblFileDetails" class="text-danger"></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <img id="ImgPreview" runat="server" height="150" width="150" src="" style="border-width: 0px;" />
                                </div>
                            </div>
                        <div class="col-md-3 form-group" style="margin-top: -42px;margin-left:5px">
                            <asp:Label Text="File Upload" runat="server"></asp:Label><b style="color: red"> *</b>
                            <div class="custom-file form-group" style="margin-left: -6px;overflow: hidden;">
                                <asp:FileUpload ID="fileuploadnew" runat="server" accept=".pdf" class="custom-file-input" />                      
                                <label class="custom-file-label" for="customFile">Choose file</label>
                            </div>
                            <asp:Label Text="File size should not be greater than 1Mb." runat="server" Style="color: red;"></asp:Label>
                            <asp:CustomValidator ID="FileUpload12" runat="server" ControlToValidate="fileuploadnew" ValidateEmptyText="true" ClientValidationFunction="ValidateFileSize" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic" ErrorMessage="File size should not be greater than 1Mb."></asp:CustomValidator>
                        </div>
                        </div>
                    </asp:Panel>

                    <div class="box-footer clearfix">
                        <a id="btnCancel" runat="server" class="btn btn-danger" href="FPCInfo.aspx">Cancel</a>
                        <input type="button" id="btnPreview" class="btn btn-primary" name="Preview" value="Preview" />
                    </div>

                    <asp:HiddenField ID="hiddenDivRowId" runat="server" Value="1" />
                    <asp:HiddenField ID="hiddenDataArrayId" runat="server" />

                    <asp:HiddenField ID="hiddenBusinessId" runat="server" Value="1" />
                    <asp:HiddenField ID="hiddenBusinessDataArray" runat="server" />

                    <asp:HiddenField ID="hiddenTeamMembersId" runat="server" Value="1" />
                    <asp:HiddenField ID="hiddenTeamMembersDataArray" runat="server" />

                    <asp:HiddenField ID="hiddenDirectorsId" runat="server" Value="1" />
                    <asp:HiddenField ID="hiddenDirectorsDataArray" runat="server" />

                    <asp:HiddenField ID="hiddenBankDetailsId" runat="server" Value="1" />
                    <asp:HiddenField ID="hiddenBankDetailsArray" runat="server" />

                    <asp:HiddenField ID="hfdeletedDirec" runat="server" />
                </div>
            </div>

            <div class="modal fade bd-example-modal-lg" id="PreviewPopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                    <div class="modal-content" id="printableArea">
                        <div class="modal-header">
                            <h4 class="modal-title" id="exampleModalLongTitle">Preview Application</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div style="text-align: center">
                                <p class="Mainheading">FPC Registration Details</p>
                            </div>
                            <div class="mt-3">
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th><strong>State</strong></th>
                                        <td id="tdState"></td>
                                        <th><strong>District</strong></th>
                                        <td id="tdDistrict"></td>
                                    </tr>
                                    <tr>
                                        <th><strong>Block</strong></th>
                                        <td id="tdBlock"></td>
                                        <th><strong>CSO Name</strong></th>
                                        <td id="tdCSO"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="Mainheading">FPC Details</p>
                                <hr />
                                <p class="Subheading">Contact Details</p>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th>FPC Name</th>
                                        <td id="tdFpcName"></td>
                                        <th>FPC Contact Number</th>
                                        <td id="tdFpcContactNumber"></td>
                                    </tr>
                                    <tr>
                                        <th>FPC Email</th>
                                        <td id="tdFpcEmail"></td>
                                        <th>FPC Website (if any)</th>
                                        <td id="tdFpcWebSite"></td>
                                    </tr>
                                    <tr>
                                        <th>Address</th>
                                        <td colspan="3" id="tdAddress"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3">
                                <p class="Subheading">Member Details</p>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th>Male Members</th>
                                        <td id="tdMaleMembers"></td>
                                        <th>Female Members</th>
                                        <td id="tdFemaleMembers"></td>
                                    </tr>
                                    <tr>
                                        <th>Transgender Members</th>
                                        <td id="tdTransgenderMembers"></td>
                                        <th>SF/MF Members</th>
                                        <td id="tdSFMFMembers"></td>
                                    </tr>
                                    <tr>
                                        <th>ST Members</th>
                                        <td id="tdStMembers"></td>
                                        <th>SC Members</th>
                                        <td id="tdScMembers"></td>
                                    </tr>
                                    <tr>
                                        <th>OBC Members</th>
                                        <td id="tdObcMembers"></td>
                                        <th>General Members</th>
                                        <td id="tdGeneralMembers"></td>
                                    </tr>
                                    <tr>
                                        <th>Total Members</th>
                                        <td colspan="3" id="tdTotalMembers"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3">
                                <p class="Subheading">Other Details</p>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th>No. of Villages Covered</th>
                                        <td id="tdNoofVillagesCovered"></td>
                                        <th>No. of Blocks Covered</th>
                                        <td id="tdNoofBlocksCovered"></td>
                                    </tr>
                                    <tr>
                                        <th>No. of Districts Covered</th>
                                        <td id="tdNoofDistrictsCovered"></td>
                                        <th>No. of Shares Mobilized  </th>
                                        <td id="tdNoofSharesMobilized"></td>
                                    </tr>
                                    <tr>
                                        <th>Shared Money Mobilized (in Rs.)</th>
                                        <td id="tdSharedMoneyMobilized"></td>
                                        <th>SFAC Equity Support Availed</th>
                                        <td id="tdSFACEquitySupport"></td>
                                    </tr>
                                    <tr>
                                        <th>Equity Grant Fund Mobilized (in Rs.)</th>
                                        <td id="tdEquityGrantFund"></td>
                                        <th>FPC Registration Date</th>
                                        <td id="tdFpcRegistrationDate"></td>
                                    </tr>
                                    <tr>
                                        <th>Legal Act under Which FPC is Registered</th>
                                        <td id="tdLegalAct"></td>

                                    </tr>
                                </table>
                            </div>
                            <%--Account Details--%>
                            <div class="mt-3">
                                <p class="Subheading">Account Details</p>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th>CIN Number</th>
                                        <td colspan="3" id="tdCINNumber"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="padding: 0px !important;">
                                            <table rules="all">
                                                <tbody id="dynamictdSupportTaken">
                                                    <tr>
                                                        <th>Support Taken from other Agency</th>
                                                        <th>Name of Agency</th>
                                                        <th>Name of Scheme </th>
                                                        <th>Support (in Rs.)</th>
                                                        <th>Date</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="padding: 0px !important;">
                                            <table rules="all">
                                                <tbody id="dynamicPreBankDetails">
                                                    <tr>
                                                        <th>Bank Name</th>
                                                        <th>FPC Bank Account Number</th>
                                                        <th>Account Type</th>
                                                        <th>Bank Branch</th>
                                                        <th>IFSC Code</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <p class="Subheading">ID Proof Details</p>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th>PAN</th>
                                        <th>PAN Number</th>
                                        <th>PAN Date</th>
                                        <th>PAN Expiry</th>
                                    </tr>
                                    <tr>
                                        <td id="tdPANStatus"></td>
                                        <td id="tdPANNumber"></td>
                                        <td id="tdPANDate"></td>
                                        <td id="tdPANExpiry"></td>
                                    </tr>
                                    <tr>
                                        <th>TAN</th>
                                        <th>TAN Number</th>
                                        <th>TAN Date</th>
                                        <th>TAN Expiry</th>
                                    </tr>
                                    <tr>
                                        <td id="tdTANStatus"></td>
                                        <td id="tdTANNumber"></td>
                                        <td id="tdTANDate"></td>
                                        <td id="tdTANExpiry"></td>
                                    </tr>
                                    <tr>
                                        <th>GST</th>
                                        <th>GST Number</th>
                                        <th>GST Date</th>
                                        <th>GST Expiry</th>
                                    </tr>
                                    <tr>
                                        <td id="tdGSTStatus"></td>
                                        <td id="tdGSTNumber"></td>
                                        <td id="tdGSTDate"></td>
                                        <td id="tdGSTExpiry"></td>
                                    </tr>
                                    <tr>
                                        <th>Service Tax</th>
                                        <th>Service Tax Number</th>
                                        <th>Service Tax Date</th>
                                        <th>Service Tax Expiry</th>
                                    </tr>
                                    <tr>
                                        <td id="tdTaxStatus"></td>
                                        <td id="tdTaxNumber"></td>
                                        <td id="tdTaxDate"></td>
                                        <td id="tdTaxExpiry"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3">
                                <p class="Subheading">License Details</p>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <td colspan="4" style="padding: 0px !important;">
                                            <table rules="all">
                                                <tbody id="dynamictdLicenseDetails">
                                                    <tr>
                                                        <th>Business license Taken</th>
                                                        <th>License Name</th>
                                                        <th>License Number</th>
                                                        <th>Licensing Authority Name</th>
                                                        <th>License Registration Date</th>
                                                        <th>License Expiry Date</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3">
                                <p class="Mainheading">About Us Details</p>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th>Overview</th>
                                    </tr>
                                    <tr>
                                        <td id="tdOverview"></td>
                                    </tr>
                                    <tr>
                                        <th>Mission Statement</th>
                                    </tr>
                                    <tr>
                                        <td id="tdMissionValues"></td>
                                    </tr>
                                    <tr>
                                        <th>Vision Statement</th>
                                    </tr>
                                    <tr>
                                        <td id="tdVissionValues"></td>
                                    </tr>
                                    <tr>
                                        <th>ChairpersonNote</th>
                                    </tr>
                                    <tr>
                                        <td id="tdChairpersonNote"></td>
                                    </tr>
                                    <tr>
                                        <th>Business Model</th>
                                    </tr>
                                    <tr>
                                        <td id="tdBusinessModel"></td>
                                    </tr>
                                    <tr>
                                        <th>Social and Environment</th>
                                    </tr>
                                    <tr>
                                        <td id="tdSocialandEnvironment"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3">
                                <p class="Mainheading">Our Team</p>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <td colspan="4" style="padding: 0px !important;">
                                            <table rules="all">
                                                <tbody id="dynamictdTeamMembers">
                                                    <tr>
                                                        <th>Team Members</th>
                                                        <th>Employee Name</th>
                                                        <th>Gender</th>
                                                        <th>Contact Number</th>
                                                        <th>Designation</th>
                                                        <th>Date of Joining</th>
                                                        <th>Date of Relieving</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="padding: 0px !important;">
                                            <table rules="all">
                                                <tbody id="dynamictdDirectorsAppointed">
                                                    <tr>
                                                        <th>Directors Appointed</th>
                                                        <th>Directors Name</th>
                                                        <th>Directors Gender</th>
                                                        <th>Directors Contact</th>
                                                        <th>Directors Type of Appointment</th>
                                                        <th>Date of Joining</th>
                                                        <th>Date of Relieving</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3">
                                <p class="Mainheading">Credentials</p>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th>User ID</th>
                                        <td id="tdUserId"></td>
                                        <td width="120px" rowspan="2">
                                            <img id="tdImgPreview" alt="FPC Logo" width="100" height="100" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Password</th>
                                        <td id="tdPassword"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="row mt-3">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <asp:CheckBox runat="server" ID="cbConfirm" TextAlign="Right" Text="I hereby declare that the above information is correct." />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer clearfix">
                            <a onclick="printDiv('printableArea')" class="btn btn-info">Print</a>
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" ValidationGroup="CheckAgree" Text="Submit" OnClick="btnSubmit_Click" />
                            <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">Close</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </form>
    <script type="text/javascript">

    $(document).ready(function () {
        $("#<%=btnSubmit.ClientID%>").prop('disabled', true);
    });

    $('#<%=cbConfirm.ClientID%>').click(function () {
        var thisCheck = $(this);
        if (this.checked) {
            $("#<%=btnSubmit.ClientID%>").prop('disabled', false);
        }
        else {
            $("#<%=btnSubmit.ClientID%>").prop('disabled', true);
        }
    });
    function calTotalMem() {
        var male = 0;
        var fmale = 0;
        var trans = 0;
        var sc = 0;
        var st = 0;
        var obc = 0;
        var gen = 0;
        var sfmf = $('#<%=txtSFMFmembers.ClientID%>').val();

        if ($('#<%=txtmaleMembers.ClientID%>').val() != "") {
            male = parseInt($('#<%=txtmaleMembers.ClientID%>').val());
        }
        if ($('#<%=txtfemaleMembers.ClientID%>').val() != "") {
            fmale = parseInt($('#<%=txtfemaleMembers.ClientID%>').val());
        }
        if ($('#<%=txtTransgenderMembers.ClientID%>').val() != "") {
            trans = parseInt($('#<%=txtTransgenderMembers.ClientID%>').val());
        }
        if ($('#<%=txtSCMembers.ClientID%>').val() != "") {
            sc = parseInt($('#<%=txtSCMembers.ClientID%>').val());
        }
        if ($('#<%=txtSTmembers.ClientID%>').val() != "") {
            st = parseInt($('#<%=txtSTmembers.ClientID%>').val());
        }
        if ($('#<%=txtOBCMembers.ClientID%>').val() != "") {
            obc = parseInt($('#<%=txtOBCMembers.ClientID%>').val());
        }
        if ($('#<%=txtGeneral.ClientID%>').val() != "") {
            gen = parseInt($('#<%=txtGeneral.ClientID%>').val());
        }

        var totalmem = male + fmale + trans;
        var socialMem = sc + st + obc + gen;
        $('#<%=txtTotalMembers.ClientID%>').val(totalmem);
        $('#<%=txtSocialCategoryTotal.ClientID%>').val(socialMem);

        if (socialMem > totalmem) {
            $('#<%=lblSocialMem.ClientID%>').html("Social category members should be less than or equal to total members");
        }
        else {
            $('#<%=lblSocialMem.ClientID%>').html("");
        }
    }

    $(document).ready(function () {
        $('#dvEquityGrant').hide();
        $('#dvSupportTaken').hide();
        $('#dvBusiness').hide();
        $('#dvTeamMembers').hide();
        $('#dvOtherLegalAct').hide();
        $('#dvPANno').hide();
        $('#dvTANno').hide();
        $('#dvGSTno').hide();
        $('#dvServiceTax').hide();
        $('#dvDirectors').hide();

        var LegalActFPC = $("#<%= ddlLegalActFPC.ClientID %> option:selected").text();
        if (LegalActFPC == 'Others') {
            $('#dvOtherLegalAct').show();
        }

        var ddlSupportTaken = $("#<%= ddlSupportTaken.ClientID %> option:selected").text();
        if (ddlSupportTaken == 'Yes') {
            FillSupportTakenFields();
            $('#dvSupportTaken').show();
        }

        var ddlBusinessLicenseTaken = $("#<%= ddlBusinessTaken.ClientID %> option:selected").val();
        if (ddlBusinessLicenseTaken == 'Yes') {
            FIllBusinessLicenseTakenFields();
            $('#dvBusiness').show();
        }

        var SfacEquity = $("#<%=ddlSFACEquity.ClientID %> option:selected").val();
        if (SfacEquity == 'Yes') {
            $('#dvEquityGrant').show();
        }

        var ddlTeamMembers = $("#<%= ddlTeamMembers.ClientID %> option:selected").val();
        if (ddlTeamMembers == 'Yes') {
            FillTeamMembersFields();
            $('#dvTeamMembers').show();
        }

        var ddlDirectors = $("#<%= ddlDirectors.ClientID %> option:selected").val();
        if (ddlDirectors == "Yes") {
            $('#dvDirectors').show();
            FillDirectorsFields();
        }

        var rblPAN = $("#<%=rblPAN.ClientID %> input:checked").val();
        if (rblPAN == "Yes") {
            $('#dvPANno').show();
        }

        var rblTAN = $("#<%= rblTAN.ClientID %> input:checked").val();
        if (rblTAN == "Yes") {
            $('#dvTANno').show();
        }

        var rblGST = $("#<%= rblGST.ClientID %> input:checked").val();
        if (rblGST == "Yes") {
            $('#dvGSTno').show();
        }

        var rblServiceTax = $("#<%= rblServiceTax.ClientID %> input:checked").val();
        if (rblServiceTax == "Yes") {
            $('#dvServiceTax').show();
        }
        FillBankDetails();
    })

    function FillSupportTakenFields() {
        debugger;
        var data = $("#<%=hiddenDataArrayId.ClientID %>").val();
        if (data != null) {
            var datasplit = data.split('$');
            var id = 1;
            if (datasplit.length > 0) {
                for (var i = 0; i < datasplit.length; i++) {
                    var secsplit = datasplit[i].split(':');
                    if (i == 0) {
                        $("#<%=txtNameofAgency0.ClientID%>").val(secsplit[0]);
                        $("#<%=txtNameofScheme0.ClientID%>").val(secsplit[1]);
                        $("#<%=txtSupport0.ClientID%>").val(secsplit[2]);
                        $("#<%=txtSupportTakenDate0.ClientID%>").val(secsplit[3]);
                    }
                    else {
                        $("#dynamicControls").append('<div class="row" id="SupportTaken' + id + '"><div class="col-md-3 form-group"><span>Name of Agency</span><b style="color: red"> *</b><input type="text" onblur="GetSupportTakenData();" id="txtNameofAgency' + id + '"  value="' + secsplit[0] + '" required oninvalid="this.setCustomValidity(&apos;Please Enter Agency Name&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" class="form-control" /></div><div class="col-md-3 form-group"><span>Name of Scheme</span><b style="color: red"> *</b><input type="text" value="' + secsplit[1] + '" required oninvalid="this.setCustomValidity(&apos;Please Enter Name of Scheme&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" class="form-control" onblur="GetSupportTakenData();" id="txtNameofScheme' + id + '" /></div><div class="col-md-3 form-group"><span>Support (in Rs.)</span><b style="color: red"> *</b><input type="text" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Support&apos;)" oninput="setCustomValidity(&apos;&apos;);DecimalCheck(this);" value="' + secsplit[2] + '" onblur="GetSupportTakenData();" id="txtSupport' + id + '" /></div><div class="col-md-3 form-group"><span>Date</span><b style="color: red"> *</b><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetSupportTakenData();" id="txtSupportTakenDate' + id + '" value="' + secsplit[3] + '" class="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy" required oninvalid="this.setCustomValidity(&apos;Please Enter Date&apos;)" oninput="setCustomValidity(&apos;&apos;);"></div><a class="removeDiv" onclick = "RemoveCurrentDiv(&apos;#SupportTaken' + id + '&apos;);" style="color:red"><i class="fa fa-remove"></i></a></div></div></div>');
                        id++;
                    }
                }
            }
            $("#<%=hiddenDivRowId.ClientID %>").val(id);
        }
    }

    function FIllBusinessLicenseTakenFields() {
        debugger;
        var data1 = $("#<%=hiddenBusinessDataArray.ClientID %>").val();
        if (data1 != null) {
            var datasplit1 = data1.split('$');
            var idd = 1;
            if (datasplit1.length > 0) {
                for (var i = 0; i < datasplit1.length; i++) {
                    var secsplit1 = datasplit1[i].split(':');
                    if (i == 0) {
                        $("#<%=txtLicenceName0.ClientID%>").val(secsplit1[0]);
                        $("#<%=txtLicenseNumber0.ClientID%>").val(secsplit1[1]);
                        $("#<%=txtLicenceNameauthority0.ClientID%>").val(secsplit1[2]);
                        $("#<%=txtLicenceRegistrationDate0.ClientID%>").val(secsplit1[3]);
                        $("#<%=txtLicenceExpiryDate0.ClientID%>").val(secsplit1[4]);
                    }
                    else {
                        $("#dynamicBusiness").append('<div class="row" id = "BusinessLicence' + idd + '" ><div class="col-md-3 form-group"><span>License Name</span><b style="color: red"> *</b><input type="text" id="txtLicenceName' + idd + '" value="' + secsplit1[0] + '" class="form-control" required  oninvalid="this.setCustomValidity(&apos;Please Enter License Name&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" /></div><div class="col-md-3 form-group"><span>License Number </span><b style="color: red"> *</b><input class="form-control" id="txtLicenseNumber' + idd + '" value="' + secsplit1[1] + '" required oninvalid="this.setCustomValidity(&apos;Please Enter License Numbwer&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" onblur="GetBusinessLicenseData();"></div><div class="col-md-3 form-group"><span>Name of licensing authority</span><b style="color: red"> *</b><input type="text" id="txtLicenceNameauthority' + idd + '" value="' + secsplit1[2] + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter License Authority&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" /></div><div class="col-md-3 form-group"><span>License Registration Date</span><b style="color: red"> *</b><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetBusinessLicenseData();" id="txtLicenceRegistrationDate' + idd + '" value="' + secsplit1[3] + '" class="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy" required oninvalid="this.setCustomValidity(&apos;Please Enter Registration Date&apos;)" oninput="setCustomValidity(&apos;&apos;);"></div></div><div class="col-md-3 form-group"><span>License Expiry Date</span><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetBusinessLicenseData();" id="txtLicenceExpiryDate' + idd + '" value="' + secsplit1[4] + '"  class="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></div><a class="removeDiv" onclick="RemoveCurrentBusinessDiv(&apos;#BusinessLicence' + idd + '&apos;)" style="color: red"><i class="fa fa-remove"></i></a></div></div>');
                        idd++;
                    }
                }
            }
            $("#<%=hiddenBusinessId.ClientID %>").val(idd);
        }
    }

    function FillTeamMembersFields() {
        debugger;
        var data2 = $("#<%=hiddenTeamMembersDataArray.ClientID %>").val();
        if (data2 != null) {
            var datasplit2 = data2.split('$');
            var id1 = 1;
            if (datasplit2.length > 0) {
                for (var i = 0; i < datasplit2.length; i++) {
                    var secsplit2 = datasplit2[i].split(':');
                    if (i == 0) {
                        $("#<%=txtEmployeeName0.ClientID%>").val(secsplit2[0]);
                        $("#<%=ddlEmpGender0.ClientID%>").val(secsplit2[1]);
                        $("#<%=txtContactNumber0.ClientID%>").val(secsplit2[2]);
                        $("#<%=ddlDesignation0.ClientID%>").val(secsplit2[3]);
                        $("#<%=txtDOJ0.ClientID%>").val(secsplit2[4]);
                        $("#<%=txtDOR0.ClientID%>").val(secsplit2[5]);
                    }
                    else {
                        $("#dynamicTeamMembers").append('<div class="row" id="TeamMembers' + id1 + '"><div class="col-md-3"><div class="form-group"><span id="Label25">Employee Name</span><b style="color: red"> *</b><input type="text" onblur="GetTeamMemberData();" id="txtEmployeeName' + id1 + '" value="' + secsplit2[0] + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Name&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" /></div></div><div class="col-md-3"><div class="form-group"><span id="Label26">Gender</span><b style="color: red"> *</b><select id="ddlEmpGender' + id1 + '" class="form-control teamGender" onchange="GetTeamMemberData()" required oninvalid="this.setCustomValidity(&apos;Please Select Gender&apos;)" oninput="setCustomValidity(&apos;&apos;);"><option Value="Select">Select</option><option Value="Male">Male</option><option Value="Female">Female</option><option Value="Transgender">Transgender</option></select></div></div><div class="col-md-3"><div class="form-group"><span id="Label27">Contact Number</span><b style="color: red"> *</b><input type="text" onblur="GetTeamMemberData();" value="' + secsplit2[2] + '" id="txtContactNumber' + id1 + '" pattern=".{10,10}" title="10 Numbers Required"  required oninvalid="this.setCustomValidity(&apos;Please Enter Name&apos;)" oninput="setCustomValidity(&apos;&apos;);NumberCheck(this);" class="form-control" /></div></div><div class="col-md-3"><div class="form-group"><span id="Label28">Designation</span><b style="color: red"> *</b><select id="ddlDesignation' + id1 + '" class="form-control teamDesignation" onchange="GetTeamMemberData()" required oninvalid="this.setCustomValidity(&apos;Please Select Designation&apos;)" oninput="setCustomValidity(&apos;&apos;);"><option Value="Select">Select</option><option Value="President">President</option><option Value="Vice-President">Vice-President</option><option Value="Secretary">Secretary</option><option Value="Joint-Secretary">Joint-Secretary</option><option Value="Treasurer">Treasurer</option><option Value="Others">Others</option></select></div></div><div class="col-md-3 form-group"><span>Date of Joining</span><b style="color: red"> *</b><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetTeamMemberData();" value="' + secsplit2[4] + '" id="txtDOJ' + id1 + '" class="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy" required oninvalid="this.setCustomValidity(&apos;Please Enter Date of Join&apos;)" oninput="setCustomValidity(&apos;&apos;);"></div></div><div class="col-md-3 form-group"><span>Date of Relieving</span><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetTeamMemberData();" id="txtDOR' + id1 + '" value="' + secsplit2[5] + '" class="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></div><a class="removeDiv" onclick="RemoveCurrentTeamMembersDiv(&apos;#TeamMembers' + id1 + '&apos;)" style="color: red"><i class="fa fa-remove"></i></a></div></div>');
                        $("#ddlEmpGender" + id1).val(secsplit2[1]);
                        $("#ddlDesignation" + id1).val(secsplit2[3]);
                        id1++;
                    }
                }
            }
            $("#<%=hiddenTeamMembersId.ClientID %>").val(id1);
        }
    }

    function FillDirectorsFields() {
        debugger;
        var data4 = $("#<%=hiddenDirectorsDataArray.ClientID %>").val();
        var datasplit3 = data4.split('$');
        var id2 = 1;
        debugger;
        if (datasplit3.length > 0) {
            for (var i = 0; i < datasplit3.length; i++) {
                var datasplit4 = datasplit3[i].split(':');
                if (i == 0) {
                    $("#<%=txtDirectorsName0.ClientID%>").val(datasplit4[0]);
                    $("#<%=ddlDirectorGender0.ClientID%>").val(datasplit4[1]);
                    $("#<%=txtDirectorContact0.ClientID%>").val(datasplit4[2]);
                    $("#<%=ddlDirectorType0.ClientID%>").val(datasplit4[3]);
                    $("#<%=txtDirectorDOJ0.ClientID%>").val(datasplit4[4]);
                    $("#<%=txtDirectorDOR0.ClientID%>").val(datasplit4[5]);
                    $("#<%=hfDirID0.ClientID%>").val(datasplit4[6]);
                }
                else {
                    $("#dynamicDirectors").append('<div class="row" id="Directors' + id2 + '"><div class="col-md-3"><div class="form-group"><span>Directors Name</span><b style="color: red"> *</b><input type="text" onblur="GetDirectorsAppointedData();" id="txtDirectorsName' + id2 + '" value="' + datasplit4[0] + '" required oninvalid="this.setCustomValidity(&apos;Please Enter Name&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" onblur="GetDirectorsAppointedData()" class="form-control" /></div></div><div class="col-md-3"><div class="form-group"><span>Gender</span><b style="color: red"> *</b><select id="ddlDirectorGender' + id2 + '" class="form-control" onchange="GetDirectorsAppointedData()" required oninvalid="this.setCustomValidity(&apos;Please Select Gender&apos;)" oninput="setCustomValidity(&apos;&apos;);"><option Value="Select">Select</option><option Value="Male">Male</option><option Value="Female">Female</option><option Value="Transgender">Transgender</option></select></div></div><div class="col-md-3"><div class="form-group"><span>Contact Number</span><b style="color: red"> *</b><input type="text" onblur="GetDirectorsAppointedData();" id="txtDirectorContact' + id2 + '" value="' + datasplit4[2] + '" pattern=".{10,10}" title="10 Numbers Required" required  oninvalid="this.setCustomValidity(&apos;Please Enter Contact Number&apos;)" oninput="setCustomValidity(&apos;&apos;);NumberCheck(this);"  class="form-control" /></div></div><div class="col-md-3"><div class="form-group"><span>Type of Appointment</span><b style="color: red"> *</b><select  id="ddlDirectorType' + id2 + '" class="form-control" onchange="GetDirectorsAppointedData()"><option Value="Select">Select</option><option Value="Selected">Selected</option><option Value="Elected">Elected</option></select></div></div><div class="col-md-3 form-group"><span>Date of Joining</span><b style="color: red"> *</b><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetDirectorsAppointedData();" value="' + datasplit4[4] + '" id="txtDirectorDOJ' + id2 + '" class="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy" required  oninvalid="this.setCustomValidity(&apos;Please Enter Registration Date&apos;)" oninput="setCustomValidity(&apos;&apos;);"></div></div><div class="col-md-3 form-group"><span>Date of Relieving</span><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetDirectorsAppointedData();" id="txtDirectorDOR' + id2 + '" value="' + datasplit4[5] + '" class="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></div><a class="removeDiv" onclick = "RemoveCurrentDivDirectors(&apos;#Directors' + id2 + '&apos;);" style="color:red"><i class="fa fa-remove"></i></a></div><input type="hidden" id="hfDirID' + id2 + '" value="' + datasplit4[6] + '" /></div>');
                    $("#ddlDirectorGender" + id2).val(datasplit4[1]);
                    $("#ddlDirectorType" + id2).val(datasplit4[3]);

                    id2++;
                }
            }
        }
        $("#<%=hiddenDirectorsId.ClientID %>").val(id2);
    }

    function FillBankDetails() {
        debugger;
        var data4 = $("#<%=hiddenBankDetailsArray.ClientID %>").val();
        var datasplit4 = data4.split('$');
        var data1 = datasplit4[0].split(':');
        var data2 = datasplit4[1].split(':');
        var data3 = datasplit4[2].split(':');
        var data4 = datasplit4[3].split(':');
        var data5 = datasplit4[4].split(':');
        var id2 = 1;
        //debugger;
        if (datasplit4.length > 0) {
            for (var i = 0; i < data1.length; i++) {
                if (i == 0) {
                    $("#<%=txtBankName0.ClientID%>").val(data1[i]);
                    $("#<%=txtFPCBankNumber0.ClientID%>").val(data2[i]);
                    $("#<%=txtFPCAccountType0.ClientID%>").val(data3[i]);
                    $("#<%=txtBankBranch0.ClientID%>").val(data4[i]);
                    $("#<%=txtICSCCode0.ClientID%>").val(data5[i]);
                }
                else {
                    $("#dynamicBankDetails").append('<div class="row" id="BankDetails' + id + '"><div class="col-md-4 form-group"><span>Bank Name</span><b style="color: red"> *</b><input type="text" onblur="GetBankDetailsData();" id="txtBankName' + id + '" value="' + data1[i] + '"  required  oninvalid="this.setCustomValidity(&apos;Please Enter Bank Name&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" class="form-control" /></div><div class="col-md-4 form-group"><span>FPC Bank Account Number</span><b style="color: red"> *</b><input type="text" class="form-control" onblur="GetBankDetailsData();" id="txtFPCBankNumber' + id + '" value="' + data2[i] + '" required  oninvalid="this.setCustomValidity(&apos;Please Enter Account Number&apos;)" oninput="setCustomValidity(&apos;&apos;);NumberCheck(this);" /></div><div class="col-md-4 form-group"><span>Account Type</span><b style="color: red"> *</b><input type="text" class="form-control" onblur="GetBankDetailsData();" value="' + data3[i] + '" id="txtFPCAccountType' + id + '"  required oninvalid="this.setCustomValidity(&apos;Please Enter Account Type&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" /></div><div class="col-md-4 form-group"><span>Bank Branch</span><b style="color: red"> *</b><input type="text" class="form-control" required  onblur="GetBankDetailsData();" id="txtBankBranch' + id + '"  value="' + data4[i] + '"  oninvalid="this.setCustomValidity(&apos;Please Enter Bank Branch&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" /></div><div class="col-md-4 form-group"><span>IFSC Code</span><b style="color: red"> *</b><input type="text" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter IFSC Code&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" onblur="GetBankDetailsData();" value="' + data5[i] + '" id="txtICSCCode' + id + '" /><a class="removeDiv" onclick = "RemoveBankDiv(&apos;#BankDetails' + id + '&apos;);" style="color:red"><i class="fa fa-remove"></i></a></div></div></div></div>');
                    id2++;
                }
            }
        }
        $("#<%=hiddenBankDetailsId.ClientID %>").val(id2);
    }

    function ShowPreview() {

        var elements = document.getElementsByClassName('previewDyanamicRow');
        while (elements.length > 0) {
            elements[0].parentNode.removeChild(elements[0]);
        }

        //debugger;
        $("#tdCSO").html($("#<%=ddlCSO.ClientID%> option:selected").text());
        $("#tdState").html($("#<%=ddlState.ClientID%> option:selected").text());
        $("#tdDistrict").html($("#<%=ddlDistrict.ClientID%> option:selected").text());
        $("#tdBlock").html($("#<%=ddlBlocks.ClientID%> option:selected").text());

        //FPC Details
        //Contact Details
        $("#tdFpcName").html($("#<%=txtFPCName.ClientID%>").val());
        $("#tdFpcContactNumber").html($("#<%=txtFPCConcact.ClientID%>").val());
        $("#tdFpcEmail").html($("#<%=txtFPCEmail.ClientID%>").val());
        $("#tdFpcWebSite").html($("#<%=txtFPCWebsite.ClientID%>").val());
        $("#tdAddress").html($("#<%=txtFPCAddress.ClientID%>").val());

        //Member Details
        $("#tdMaleMembers").html($("#<%=txtmaleMembers.ClientID%>").val());
        $("#tdFemaleMembers").html($("#<%=txtfemaleMembers.ClientID%>").val());
        $("#tdTransgenderMembers").html($("#<%=txtTransgenderMembers.ClientID%>").val());
        $("#tdSFMFMembers").html($("#<%=txtSFMFmembers.ClientID%>").val());
        $("#tdStMembers").html($("#<%=txtSTmembers.ClientID%>").val());
        $("#tdScMembers").html($("#<%=txtSCMembers.ClientID%>").val());
        $("#tdObcMembers").html($("#<%=txtOBCMembers.ClientID%>").val());
        $("#tdGeneralMembers").html($("#<%=txtGeneral.ClientID%>").val());
        $("#tdTotalMembers").html($("#<%=txtTotalMembers.ClientID%>").val());

        //Other Details
        $("#tdNoofVillagesCovered").html($("#<%=txtVillgesCovered.ClientID%>").val());
        $("#tdNoofBlocksCovered").html($("#<%=txtBlocksCovered.ClientID%>").val());
        $("#tdNoofDistrictsCovered").html($("#<%=txtDistrictsCovered.ClientID%>").val());
        $("#tdNoofSharesMobilized").html($("#<%=txtNoofSharesMobilized.ClientID%>").val());
        $("#tdSharedMoneyMobilized").html($("#<%=txtSharedMoneyMobilized.ClientID%>").val());
        $("#tdSFACEquitySupport").html($("#<%=ddlSFACEquity.ClientID%> option:selected").text());
        if ($("#<%=ddlSFACEquity.ClientID%> option:selected").text() == "Yes") {
            $("#tdEquityGrantFund").html($("#<%=txtEquityGrant.ClientID%>").val());
        }
        $("#tdFpcRegistrationDate").html($("#<%=txtFPCRegistrationDate.ClientID%>").val());
        if ($("#<%=ddlLegalActFPC.ClientID%> option:selected").text() != "Others") {
            $("#tdLegalAct").html($("#<%=ddlLegalActFPC.ClientID%> option:selected").text());
        }
        else {
            $("#tdLegalAct").html($("#<%=txtOtherLeagal.ClientID%>").val());
        }
        //Account Details
        $("#tdCINNumber").html($("#<%=txtCINNumber.ClientID%>").val());
        if ($("#<%=ddlSupportTaken.ClientID%> option:selected").val() == "Yes") {
            var supportTaken = $('#<%=hiddenDataArrayId.ClientID%>').val();
            var supportTakenArray = [];
            var supportData = [];
            if (supportTaken != "") {
                supportTakenArray = supportTaken.split('$');
                for (var i = 0; i < supportTakenArray.length; i++) {
                    supportData = supportTakenArray[i].split(':');
                    if (i == 0) {
                        $('#dynamictdSupportTaken').append('<tr class="previewDyanamicRow"><td rowspan="' + supportTakenArray.length + '">' + $("#<%=ddlSupportTaken.ClientID%> option:selected").val() + '</td><td>' + supportData[0] + '</td><td>' + supportData[1] + '</td><td>' + supportData[2] + '</td><td>' + supportData[3] + '</td></tr>');
                    }
                    else {
                        $('#dynamictdSupportTaken').append('<tr class="previewDyanamicRow"><td>' + supportData[0] + '</td><td>' + supportData[1] + '</td><td>' + supportData[2] + '</td><td>' + supportData[3] + '</td></tr>');
                    }
                }
            }
        }
        else {
            $('#dynamictdSupportTaken').append('<tr class="previewDyanamicRow"><td>' + $("#<%=ddlSupportTaken.ClientID%> option:selected").val() + '</td><td></td><td></td><td></td><td></td></tr>');
        }

        var Bank = $("#<%=hiddenBankDetailsArray.ClientID %>").val();
        var BankData = Bank.split('$');
        var txtBankName = BankData[0].split(':');
        var txtFPCBankNumber = BankData[1].split(':');
        var txtFPCAccountType = BankData[2].split(':');
        var txtBankBranch = BankData[3].split(':');
        var txtICSCCode = BankData[4].split(':');
        for (var k = 0; k < txtBankName.length; k++) {
            $("#dynamicPreBankDetails").append('<tr class="previewDyanamicRow"><td>' + txtBankName[k] + '</td><td>' + txtFPCBankNumber[k] + '</td><td>' + txtFPCAccountType[k] + '</td><td>' + txtBankBranch[k] + '</td><td>' + txtICSCCode[k] + '</td></tr>')
        }
        $("#tdFpcBusinessAddress").html($("#<%=txtFPCBusinessAddress.ClientID%>").val());
        //debugger;
        $("#tdTANStatus").html($("#<%=rblTAN.ClientID%> input:checked").val());
        if ($("#<%=rblTAN.ClientID%> input:checked").val() == "Yes") {
            $("#tdTANNumber").html($("#<%=txtTanNo.ClientID%>").val());
            $("#tdTANDate").html($("#<%=txtTanDate.ClientID%>").val());
            $("#tdTANExpiry").html($("#<%=txtTanExpiry.ClientID%>").val());
        }
        else {
            $("#tdTANNumber").html('');
            $("#tdTANDate").html('');
            $("#tdTANExpiry").html('');
        }

        $("#tdPANStatus").html($("#<%=rblPAN.ClientID%> input:checked").val());
        if ($("#<%=rblPAN.ClientID%> input:checked").val() == "Yes") {
            $("#tdPANNumber").html($("#<%=txtPanNo.ClientID%>").val());
            $("#tdPANDate").html($("#<%=txtPanDate.ClientID%>").val());
            $("#tdPANExpiry").html($("#<%=txtPanExpiry.ClientID%>").val());
        }
        else {
            $("#tdPANNumber").html('');
            $("#tdPANDate").html('');
            $("#tdPANExpiry").html('');
        }
        $("#tdGSTStatus").html($("#<%=rblGST.ClientID%> input:checked").val());
        if ($("#<%=rblGST.ClientID%> input:checked").val() == "Yes") {
            $("#tdGSTNumber").html($("#<%=txtGSTNo.ClientID%>").val());
            $("#tdGSTDate").html($("#<%=txtGSTDate.ClientID%>").val());
            $("#tdGSTExpiry").html($("#<%=txtGSTExpiry.ClientID%>").val());
        }
        else {
            $("#tdGSTNumber").html('');
            $("#tdGSTDate").html('');
            $("#tdGSTExpiry").html('');
        }
        $("#tdTaxStatus").html($("#<%=rblServiceTax.ClientID%> input:checked").val());
        if ($("#<%=rblServiceTax.ClientID%> input:checked").val() == "Yes") {
            $("#tdTaxNumber").html($("#<%=txtServiceTAXNumber.ClientID%>").val());
            $("#tdTaxDate").html($("#<%=txtServiceTaxDate.ClientID%>").val());
            $("#tdTaxExpiry").html($("#<%=txtServiceTaxExpiry.ClientID%>").val());
        }
        else {
            $("#tdTaxNumber").html('');
            $("#tdTaxDate").html('');
            $("#tdTaxExpiry").html('');
        }
            <%--$("#tdEffectiveDate").html($("#<%=txtEffectiveDate.ClientID%>").val());
            $("#tdDateofExpiry").html($("#<%=txtexpiryDate.ClientID%>").val());--%>


        // Licence Details
        if ($("#<%=ddlBusinessTaken.ClientID%> option:selected").val() == "Yes") {
            var LicenceTaken = $('#<%=hiddenBusinessDataArray.ClientID%>').val();
            var LicenceTakenArray = [];
            var licenceData = [];
            if (LicenceTaken != "") {
                LicenceTakenArray = LicenceTaken.split('$');
                for (var i = 0; i < LicenceTakenArray.length; i++) {
                    licenceData = LicenceTakenArray[i].split(':');
                    if (i == 0) {
                        $('#dynamictdLicenseDetails').append('<tr class="previewDyanamicRow"><td rowspan="' + LicenceTakenArray.length + '">' + $("#<%=ddlBusinessTaken.ClientID%> option:selected").val() + '</td><td>' + licenceData[0] + '</td><td>' + licenceData[1] + '</td><td>' + licenceData[2] + '</td><td>' + licenceData[3] + '</td><td>' + licenceData[4] + '</td></tr>');
                    }
                    else {
                        $('#dynamictdLicenseDetails').append('<tr class="previewDyanamicRow"><td>' + licenceData[0] + '</td><td>' + licenceData[1] + '</td><td>' + licenceData[2] + '</td><td>' + licenceData[3] + '</td><td>' + licenceData[4] + '</td></tr>');
                    }
                }
            }
        }
        else {
            $('#dynamictdLicenseDetails').append('<tr class="previewDyanamicRow"><td>' + $("#<%=ddlBusinessTaken.ClientID%> option:selected").val() + '</td><td></td><td></td><td></td><td></td><td></td></tr>');
        }

        //About us details
        $("#tdOverview").html($("#<%=txtOverview.ClientID%>").val());
        $("#tdMissionValues").html($("#<%=txtMission.ClientID%>").val());
        $("#tdVissionValues").html($("#<%=txtVission.ClientID%>").val());
        $("#tdChairpersonNote").html($("#<%=txtChairperson.ClientID%>").val());
        $("#tdBusinessModel").html($("#<%=txtBusinessModel.ClientID%>").val());
        $("#tdSocialandEnvironment").html($("#<%=txtSocialandenvironment.ClientID%>").val());

            //Documentaion
            <%--$("#tdOrganizationPolicy").html($("#<%=fuOrganizationPolacy.ClientID%>").get(0).files[0].name);--%>


        //Our Team
        if ($("#<%=ddlTeamMembers.ClientID%> option:selected").val() == "Yes") {

            var teamMembers = $('#<%=hiddenTeamMembersDataArray.ClientID%>').val();
            var teamMembersArray = [];
            var teamMembersData = [];
            if (teamMembers != "") {
                teamMembersArray = teamMembers.split('$');
                for (var i = 0; i < teamMembersArray.length; i++) {
                    teamMembersData = teamMembersArray[i].split(':');
                    if (i == 0) {
                        $('#dynamictdTeamMembers').append('<tr class="previewDyanamicRow"><td rowspan="' + teamMembersArray.length + '">' + $("#<%=ddlTeamMembers.ClientID%> option:selected").val() + '</td><td>' + teamMembersData[0] + '</td><td>' + teamMembersData[1] + '</td><td>' + teamMembersData[2] + '</td><td>' + teamMembersData[3] + '</td><td>' + teamMembersData[4] + '</td><td>' + teamMembersData[5] + '</td></tr>');
                    }
                    else {
                        $('#dynamictdTeamMembers').append('<tr class="previewDyanamicRow"><td>' + teamMembersData[0] + '</td><td>' + teamMembersData[1] + '</td><td>' + teamMembersData[2] + '</td><td>' + teamMembersData[3] + '</td><td>' + teamMembersData[4] + '</td><td>' + teamMembersData[5] + '</td></tr>');
                    }
                }
            }
        }
        else {
            $('#dynamictdTeamMembers').append('<tr class="previewDyanamicRow"><td>' + $("#<%=ddlTeamMembers.ClientID%> option:selected").val() + '</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>');
        }

        if ($("#<%=ddlDirectors.ClientID%>").val() == "Yes") {
            var directors = $('#<%=hiddenDirectorsDataArray.ClientID%>').val();
            var directorsArray = [];
            if (directors != "") {
                directorsArray = directors.split('$');
                for (var i = 0; i < directorsArray.length; i++) {
                    var DirectorData = directorsArray[i].split(':');
                    if (i == 0) {
                        $('#dynamictdDirectorsAppointed').append('<tr class="previewDyanamicRow"><td rowspan="' + directorsArray.length + '">' + $("#<%=ddlDirectors.ClientID%> option:selected").val() + '</td><td>' + DirectorData[0] + '</td><td>' + DirectorData[1] + '</td><td>' + DirectorData[2] + '</td><td>' + DirectorData[3] + '</td><td>' + DirectorData[4] + '</td><td>' + DirectorData[5] + '</td></tr>');
                    }
                    else {
                        $('#dynamictdDirectorsAppointed').append('<tr class="previewDyanamicRow"><td>' + DirectorData[0] + '</td><td>' + DirectorData[1] + '</td><td>' + DirectorData[2] + '</td><td>' + DirectorData[3] + '</td><td>' + DirectorData[4] + '</td><td>' + DirectorData[5] + '</td></tr>');
                    }
                }
            }
        }
        else {
            $('#dynamictdDirectorsAppointed').append('<tr class="previewDyanamicRow"><td>' + $("#<%=ddlDirectors.ClientID%>").val() + '</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>');
        }

        //Credentials
        $("#tdUserId").html($("#<%=txtUserName.ClientID%>").val());
        $("#tdPassword").html($("#<%=txtPassword.ClientID%>").val());
        //debugger;
        $('#tdImgPreview').attr('src', $('#<%=ImgPreview.ClientID%>').prop('src'));

        $('#PreviewPopup').modal('show');
    }


    $("#btnPreview").click(function () {
        if (typeof (Page_ClientValidate) == 'function') {

            Page_ClientValidate();
            if (Page_IsValid) {
                if ($('#<%=form1.ClientID%>')[0].checkValidity()) {
                    ShowPreview();
                }
                else {
                    $('#<%=form1.ClientID%>')[0].reportValidity();
                }
            }
            else {
                return Page_IsValid;
            }
        } else {
            if ($(this).valid()) {
                alert('the form is valid');
            }
        }
    });


    $('#<%=ddlDirectors.ClientID %>').change(function () {
        //debugger;
        var ddl = $("#<%= ddlDirectors.ClientID %> ").val();
        if (ddl == 'Yes') {
            $('#dvDirectors').show();
        } else {
            $('#dvDirectors').hide();
        }
        GetDirectorsAppointedData();
    });

    $('#<%=rblPAN.ClientID %>').change(function () {
        //debugger;
        var ddl = $("#<%= rblPAN.ClientID %> input:checked").val();
        if (ddl == 'Yes') {
            $('#dvPANno').show();
        } else {
            $('#dvPANno').hide();
        }
    });

    $('#<%=rblTAN.ClientID %>').change(function () {
        //debugger;
        var ddl = $("#<%= rblTAN.ClientID %> input:checked").val();
        if (ddl == 'Yes') {

            $('#dvTANno').show();
        } else {

            $('#dvTANno').hide();
        }
    });
    $('#<%=rblServiceTax.ClientID %>').change(function () {
        //debugger;
        var ddl = $("#<%= rblServiceTax.ClientID %> input:checked").val();
        if (ddl == 'Yes') {
            $('#dvServiceTax').show();
        } else {
            $('#dvServiceTax').hide();
        }
    });
    $('#<%=rblGST.ClientID %>').change(function () {
        //debugger;
        var ddl = $("#<%= rblGST.ClientID %> input:checked").val();
        if (ddl == 'Yes') {
            $('#dvGSTno').show();
        } else {
            $('#dvGSTno').hide();
        }
    });

    function ValidatePANNo(source, arguments) {
        //debugger;
        var txt = document.getElementById('<%=txtPanNo.ClientID%>');
        var ddl = $("#<%=rblPAN.ClientID %> input:checked").val();

        if (ddl == 'Yes') {
            arguments.IsValid = txt.value.length > 0;
        } else {
            arguments.IsValid = true;
        }
    }

    function ValidatePANDate(source, arguments) {
        //debugger;
        var txt = document.getElementById('<%=txtPanDate.ClientID%>');
        var ddl = $("#<%=rblPAN.ClientID %> input:checked").val();

        if (ddl == 'Yes') {
            arguments.IsValid = txt.value.length > 0;
        } else {
            arguments.IsValid = true;
        }
    }

    function ValidateTANNo(source, arguments) {
        //debugger;
        var txt = document.getElementById('<%=txtTanNo.ClientID%>');
        var ddl = $("#<%=rblTAN.ClientID %> input:checked").val();

        if (ddl == 'Yes') {
            arguments.IsValid = txt.value.length > 0;
        } else {
            arguments.IsValid = true;
        }
    }

    function ValidateTANDate(source, arguments) {
        //debugger;
        var txt = document.getElementById('<%=txtTanDate.ClientID%>');
        var ddl = $("#<%=rblTAN.ClientID %> input:checked").val();

        if (ddl == 'Yes') {
            arguments.IsValid = txt.value.length > 0;
        } else {
            arguments.IsValid = true;
        }
    }

    function ValidateGSTNo(source, arguments) {
        //debugger;
        var txt = document.getElementById('<%=txtGSTNo.ClientID%>');
        var ddl = $("#<%=rblGST.ClientID %> input:checked").val();

        if (ddl == 'Yes') {
            arguments.IsValid = txt.value.length > 0;
        } else {
            arguments.IsValid = true;
        }
    }

    function ValidateGSTDate(source, arguments) {
        //debugger;
        var txt = document.getElementById('<%=txtGSTDate.ClientID%>');
        var ddl = $("#<%=rblGST.ClientID %> input:checked").val();

        if (ddl == 'Yes') {
            arguments.IsValid = txt.value.length > 0;
        } else {
            arguments.IsValid = true;
        }
    }

    function ValidateServiceTaxNumber(source, arguments) {
        //debugger;
        var txt = document.getElementById('<%=txtServiceTAXNumber.ClientID%>');
        var ddl = $("#<%=rblServiceTax.ClientID %> input:checked").val();

        if (ddl == 'Yes') {
            arguments.IsValid = txt.value.length > 0;
        } else {
            arguments.IsValid = true;
        }
    }

    function ValidateServiceTaxDate(source, arguments) {
        //debugger;
        var txt = document.getElementById('<%=txtServiceTaxDate.ClientID%>');
        var ddl = $("#<%=rblServiceTax.ClientID %> input:checked").val();

        if (ddl == 'Yes') {
            arguments.IsValid = txt.value.length > 0;
        } else {
            arguments.IsValid = true;
        }
    }

    $(".custom-file-input").on("change", function () {
        //debugger;
        var fileName = $(this).val().split("\\").pop();
        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
    });

    function addSupportTaken() {
        var id = $("#<%=hiddenDivRowId.ClientID %>").val();
        //e.preventDefault();
        $("#dynamicControls").append('<div class="row" id="SupportTaken' + id + '"><div class="col-md-3 form-group"><span>Name of Agency</span><b style="color: red"> *</b><input type="text" onblur="GetSupportTakenData();" id="txtNameofAgency' + id + '" required oninvalid="this.setCustomValidity(&apos;Please Enter Agency Name&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" class="form-control" /></div><div class="col-md-3 form-group"><span>Name of Scheme</span><b style="color: red"> *</b><input type="text" required oninvalid="this.setCustomValidity(&apos;Please Enter Name of Scheme&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" class="form-control" onblur="GetSupportTakenData();" id="txtNameofScheme' + id + '" /></div><div class="col-md-3 form-group"><span>Support (in Rs.)</span><b style="color: red"> *</b><input type="text" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Support&apos;)" oninput="setCustomValidity(&apos;&apos;);DecimalCheck(this);" onblur="GetSupportTakenData();" id="txtSupport' + id + '" /></div><div class="col-md-3 form-group"><span>Date</span><b style="color: red"> *</b><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetSupportTakenData();" id="txtSupportTakenDate' + id + '" class="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy" required oninvalid="this.setCustomValidity(&apos;Please Enter Date&apos;)" oninput="setCustomValidity(&apos;&apos;);"></div><a class="removeDiv" onclick = "RemoveCurrentDiv(&apos;#SupportTaken' + id + '&apos;);" style="color:red"><i class="fa fa-remove"></i></a></div></div></div>');
        id++;
        $("#<%=hiddenDivRowId.ClientID %>").val(id);
        console.log(id);
        GetSupportTakenData();
        return false;
    };

    function GetSupportTakenData() {
        //debugger;
        var Data = "";
        if ($("#<%=ddlSupportTaken.ClientID %>").val() == "Yes") {
            var DataCount = $("#<%=hiddenDivRowId.ClientID %>").val();
            var Data = $("#<%=txtNameofAgency0.ClientID%>").val() + ':' + $("#<%=txtNameofScheme0.ClientID%>").val() + ':' + $("#<%=txtSupport0.ClientID%>").val() + ':' + $("#<%=txtSupportTakenDate0.ClientID%>").val();

            for (var i = 1; i < DataCount; i++) {
                var txtAgencyName = "txtNameofAgency" + i;
                var txtSchemeName = "txtNameofScheme" + i;
                var txtSupport = "txtSupport" + i;
                var txtSupportDate = "txtSupportTakenDate" + i;

                if ($('#' + txtAgencyName).val() != undefined && $('#' + txtSchemeName).val() != undefined && $('#' + txtSupport).val() != undefined && $('#' + txtSupportDate).val() != undefined) {
                    if ($('#' + txtAgencyName).val() != '' && $('#' + txtSchemeName).val() != '' && $('#' + txtSupport).val() != '' && $('#' + txtSupportDate).val() != '') {
                        if (Data != "") {
                            Data += '$' + $('#' + txtAgencyName).val() + ':' + $('#' + txtSchemeName).val() + ':' + $('#' + txtSupport).val() + ':' + $('#' + txtSupportDate).val();
                        }
                        else {
                            Data += $('#' + txtAgencyName).val() + ':' + $('#' + txtSchemeName).val() + ':' + $('#' + txtSupport).val() + ':' + $('#' + txtSupportDate).val();
                        }
                    }
                }
            }
        }

        console.log(Data);
        $("#<%=hiddenDataArrayId.ClientID %>").val(Data);
        console.log('Selected Values');
        console.log($("#<%=hiddenDataArrayId.ClientID %>").val());
    }

    function RemoveCurrentDiv(id) {
        ////debugger;
        $(id).remove();
        GetSupportTakenData();
        return false;
    };

    function addBankDetails() {
        var id = $("#<%=hiddenBankDetailsId.ClientID %>").val();
        //e.preventDefault();
        $("#dynamicBankDetails").append('<div class="row" id="BankDetails' + id + '"><div class="col-md-4 form-group"><span>Bank Name</span><b style="color: red"> *</b><input type="text" onblur="GetBankDetailsData();" id="txtBankName' + id + '"  required  oninvalid="this.setCustomValidity(&apos;Please Enter Bank Name&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" class="form-control" /></div><div class="col-md-4 form-group"><span>FPC Bank Account Number</span><b style="color: red"> *</b><input type="text" class="form-control" onblur="GetBankDetailsData();" id="txtFPCBankNumber' + id + '" required  oninvalid="this.setCustomValidity(&apos;Please Enter Account Number&apos;)" oninput="setCustomValidity(&apos;&apos;);NumberCheck(this);" /></div><div class="col-md-4 form-group"><span>Account Type</span><b style="color: red"> *</b><input type="text" class="form-control" onblur="GetBankDetailsData();" id="txtFPCAccountType' + id + '"  required oninvalid="this.setCustomValidity(&apos;Please Enter Account Type&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" /></div><div class="col-md-4 form-group"><span>Bank Branch</span><b style="color: red"> *</b><input type="text" class="form-control" required  onblur="GetBankDetailsData();" id="txtBankBranch' + id + '" oninvalid="this.setCustomValidity(&apos;Please Enter Bank Branch&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" /></div><div class="col-md-4 form-group"><span>IFSC Code</span><b style="color: red"> *</b><input type="text" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter IFSC Code&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" onblur="GetBankDetailsData();" id="txtICSCCode' + id + '" /><a class="removeDiv" onclick = "RemoveBankDiv(&apos;#BankDetails' + id + '&apos;);" style="color:red"><i class="fa fa-remove"></i></a></div></div></div></div>');
        id++;
        $("#<%=hiddenBankDetailsId.ClientID %>").val(id);
        console.log(id);
        GetBankDetailsData();
        return false;
    }

    function GetBankDetailsData() {
        //debugger;
        var DataCount = $("#<%=hiddenBankDetailsId.ClientID %>").val();
        var data1 = $("#<%=txtBankName0.ClientID %>").val();
        var data2 = $("#<%=txtFPCBankNumber0.ClientID%>").val();
        var data3 = $("#<%=txtFPCAccountType0.ClientID%>").val();
        var data4 = $("#<%=txtBankBranch0.ClientID%>").val();
        var data5 = $("#<%=txtICSCCode0.ClientID%>").val();

        for (var i = 1; i < DataCount; i++) {
            var txtBankName = "txtBankName" + i;
            var txtFPCBankNumber = "txtFPCBankNumber" + i;
            var txtFPCAccountType = "txtFPCAccountType" + i;
            var txtBankBranch = "txtBankBranch" + i;
            var txtICSCCode = "txtICSCCode" + i;

            if ($('#' + txtBankName).val() != undefined && $('#' + txtFPCBankNumber).val() != undefined && $('#' + txtFPCAccountType).val() != undefined && $('#' + txtBankBranch).val() != undefined && $('#' + txtICSCCode).val() != undefined) {
                if ($('#' + txtBankName).val() != '' && $('#' + txtFPCBankNumber).val() != '' && $('#' + txtFPCAccountType).val() != '' && $('#' + txtBankBranch).val() != '' && $('#' + txtICSCCode).val() != '') {
                    if (Data != "") {
                        data1 += ':' + $('#' + txtBankName).val();
                        data2 += ':' + $('#' + txtFPCBankNumber).val();
                        data3 += ':' + $('#' + txtFPCAccountType).val();
                        data4 += ':' + $('#' + txtBankBranch).val();
                        data5 += ':' + $('#' + txtICSCCode).val();
                    }
                    else {
                        data1 += $('#' + txtBankName).val();
                        data2 += $('#' + txtFPCBankNumber).val();
                        data3 += $('#' + txtFPCAccountType).val();
                        data4 += $('#' + txtBankBranch).val();
                        data5 += $('#' + txtICSCCode).val();
                    }
                }
            }
        }
        var Data = data1 + '$' + data2 + '$' + data3 + '$' + data4 + '$' + data5;
        console.log(Data);
        $("#<%=hiddenBankDetailsArray.ClientID %>").val(Data);
        console.log('Selected Values');
        console.log($("#<%=hiddenBankDetailsArray.ClientID %>").val());
    }

    function RemoveBankDiv(id) {
        ////debugger;
        $(id).remove();
        GetBankDetailsData();
        return false;
    };

    function addBusinessLicense() {
        var idd = $("#<%=hiddenBusinessId.ClientID %>").val();

        $("#dynamicBusiness").append('<div class="row" id = "BusinessLicence' + idd + '" ><div class="col-md-3 form-group"><span>License Name</span><b style="color: red"> *</b><input type="text" id="txtLicenceName' + idd + '" class="form-control" required  oninvalid="this.setCustomValidity(&apos;Please Enter License Name&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" /></div><div class="col-md-3 form-group"><span>License Number </span><b style="color: red"> *</b><input class="form-control" id="txtLicenseNumber' + idd + '" required oninvalid="this.setCustomValidity(&apos;Please Enter License Numbwer&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" onblur="GetBusinessLicenseData();"></div><div class="col-md-3 form-group"><span>Name of licensing authority</span><b style="color: red"> *</b><input type="text" id="txtLicenceNameauthority' + idd + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter License Authority&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" /></div><div class="col-md-3 form-group"><span>License Registration Date</span><b style="color: red"> *</b><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetBusinessLicenseData();" id="txtLicenceRegistrationDate' + idd + '" class="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy" required oninvalid="this.setCustomValidity(&apos;Please Enter Registration Date&apos;)" oninput="setCustomValidity(&apos;&apos;);"></div></div><div class="col-md-3 form-group"><span>License Expiry Date</span><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetBusinessLicenseData();" id="txtLicenceExpiryDate' + idd + '" class="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></div><a class="removeDiv" onclick="RemoveCurrentBusinessDiv(&apos;#BusinessLicence' + idd + '&apos;)" style="color: red"><i class="fa fa-remove"></i></a></div></div>');
        //<select class="form-control licenceType" id="txtLicenceName' + idd + '"><option value="General">General</option><option value="Industrial">Industrial</option><option value="Construction">Construction</option><option value="Commercial">Commercial</option><option value="Operational">Operational</option></select>
        idd++;
        $("#<%=hiddenBusinessId.ClientID %>").val(idd);
        console.log(idd);
        GetBusinessLicenseData();
        return false;
    }

    $('body').on('change', '.licenceType', function () {
        //debugger;
        GetBusinessLicenseData();
    });

    function GetBusinessLicenseData() {
        //debugger;
        var DataCount = $("#<%=hiddenBusinessId.ClientID %>").val();
        var Data = $("#<%=txtLicenceName0.ClientID %>").val() + ':' + $("#<%=txtLicenseNumber0.ClientID%>").val() + ':' + $("#<%=txtLicenceNameauthority0.ClientID%>").val() + ':' + $("#<%=txtLicenceRegistrationDate0.ClientID%>").val() + ':' + $("#<%=txtLicenceExpiryDate0.ClientID%>").val();

        for (var i = 1; i < DataCount; i++) {
            var txtLicenceName = "txtLicenceName" + i;
            var txtlicenceNumber = "txtLicenseNumber" + i;
            var txtLicenceNameauthority = "txtLicenceNameauthority" + i;
            var txtRegDate = "txtLicenceRegistrationDate" + i;
            var txtExpiryDate = "txtLicenceExpiryDate" + i;

            if ($('#' + txtLicenceName).val() != undefined && $('#' + txtlicenceNumber).val() != undefined && $('#' + txtLicenceNameauthority).val() != undefined && $('#' + txtRegDate).val() != undefined && $('#' + txtExpiryDate).val() != undefined) {
                if ($('#' + txtLicenceName).val() != '' && $('#' + txtlicenceNumber).val() != '' && $('#' + txtLicenceNameauthority).val() != '' && $('#' + txtRegDate).val() != '') {
                    if (Data != "") {
                        Data += '$' + $('#' + txtLicenceName).val() + ':' + $('#' + txtlicenceNumber).val() + ':' + $('#' + txtLicenceNameauthority).val() + ':' + $('#' + txtRegDate).val() + ':' + $('#' + txtExpiryDate).val();
                    }
                    else {
                        Data += $('#' + txtLicenceName).val() + ':' + $('#' + txtlicenceNumber).val() + ':' + $('#' + txtLicenceNameauthority).val() + ':' + $('#' + txtRegDate).val() + ':' + $('#' + txtExpiryDate).val();
                    }
                }
            }
        }

        console.log(Data);
        $("#<%=hiddenBusinessDataArray.ClientID %>").val(Data);
        console.log('Selected Values');
        console.log($("#<%=hiddenBusinessDataArray.ClientID %>").val());
    }

    function RemoveCurrentBusinessDiv(id) {
        ////debugger;
        $(id).remove();
        GetBusinessLicenseData();
        return false;
    };

    function addTeamMembers() {
        //debugger;
        var id1 = $("#<%=hiddenTeamMembersId.ClientID %>").val();

        $("#dynamicTeamMembers").append('<div class="row" id="TeamMembers' + id1 + '"><div class="col-md-3"><div class="form-group"><span id="Label25">Employee Name</span><b style="color: red"> *</b><input type="text" onblur="GetTeamMemberData();" id="txtEmployeeName' + id1 + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Name&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" /></div></div><div class="col-md-3"><div class="form-group"><span id="Label26">Gender</span><b style="color: red"> *</b><select id="ddlEmpGender' + id1 + '" class="form-control teamGender" onchange="GetTeamMemberData()" required oninvalid="this.setCustomValidity(&apos;Please Select Gender&apos;)" oninput="setCustomValidity(&apos;&apos;);"><option Value="Select">Select</option><option Value="Male">Male</option><option Value="Female">Female</option><option Value="Transgender">Transgender</option></select></div></div><div class="col-md-3"><div class="form-group"><span id="Label27">Contact Number</span><b style="color: red"> *</b><input type="text" onblur="GetTeamMemberData();" id="txtContactNumber' + id1 + '" pattern=".{10,10}" title="10 Numbers Required"  required oninvalid="this.setCustomValidity(&apos;Please Enter Name&apos;)" oninput="setCustomValidity(&apos;&apos;);NumberCheck(this);" class="form-control" /></div></div><div class="col-md-3"><div class="form-group"><span id="Label28">Designation</span><b style="color: red"> *</b><select id="ddlDesignation' + id1 + '" class="form-control teamDesignation" onchange="GetTeamMemberData()" required oninvalid="this.setCustomValidity(&apos;Please Select Designation&apos;)" oninput="setCustomValidity(&apos;&apos;);"><option Value="Select">Select</option><option Value="President">President</option><option Value="Vice-President">Vice-President</option><option Value="Secretary">Secretary</option><option Value="Joint-Secretary">Joint-Secretary</option><option Value="Treasurer">Treasurer</option><option Value="Others">Others</option></select></div></div><div class="col-md-3 form-group"><span>Date of Joining</span><b style="color: red"> *</b><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetTeamMemberData();" id="txtDOJ' + id1 + '" class="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy" required oninvalid="this.setCustomValidity(&apos;Please Enter Date of Join&apos;)" oninput="setCustomValidity(&apos;&apos;);"></div></div><div class="col-md-3 form-group"><span>Date of Relieving</span><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetTeamMemberData();" id="txtDOR' + id1 + '" class="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></div><a class="removeDiv" onclick="RemoveCurrentTeamMembersDiv(&apos;#TeamMembers' + id1 + '&apos;)" style="color: red"><i class="fa fa-remove"></i></a></div></div>');
        id1++;
        $("#<%=hiddenTeamMembersId.ClientID %>").val(id1);
        console.log(id1);
        GetTeamMemberData();
        return false;
    }

    function RemoveCurrentTeamMembersDiv(id) {
        $(id).remove();
        GetTeamMemberData();
        return false;
    };

    function GetTeamMemberData() {
        //debugger;
        var TeamData = "";
        if ($("#<%=ddlTeamMembers.ClientID%>").val() == "Yes") {
            var TeamDataCount = $("#<%=hiddenTeamMembersId.ClientID %>").val();
            TeamData = $("#<%=txtEmployeeName0.ClientID%>").val() + ':' + $("#<%=ddlEmpGender0.ClientID %> option:selected").val() + ':' + $("#<%=txtContactNumber0.ClientID%>").val() + ':' + $("#<%=ddlDesignation0.ClientID%> option:selected").val() + ':' + $("#<%=txtDOJ0.ClientID%>").val() + ':' + $("#<%=txtDOR0.ClientID%>").val();

            for (var i = 1; i < TeamDataCount; i++) {
                var txtempname = "txtEmployeeName" + i;
                var ddlgender = "ddlEmpGender" + i;
                var txtcontactnumber = "txtContactNumber" + i;
                var ddldesignation = "ddlDesignation" + i;
                var txtDOJ = "txtDOJ" + i;
                var txtDOR = "txtDOR" + i;
                if ($('#' + txtempname).val() != undefined && $('#' + ddlgender + " option:selected").val() != undefined && $('#' + txtcontactnumber).val() != undefined && $('#' + ddldesignation + " option:selected").val() != undefined && $('#' + txtDOJ).val() != undefined && $('#' + txtDOR).val() != undefined) {
                    if ($('#' + txtempname).val() != '' && $('#' + ddlgender + " option:selected").val() != '' && $('#' + txtcontactnumber).val() != '' && $('#' + ddldesignation + " option:selected").val() != '' && $('#' + txtDOJ).val() != '') {
                        if (TeamData != "") {
                            TeamData += '$' + $('#' + txtempname).val() + ':' + $('#' + ddlgender + " option:selected").val() + ':' + $('#' + txtcontactnumber).val() + ':' + $('#' + ddldesignation + " option:selected").val() + ':' + $('#' + txtDOJ).val() + ':' + $('#' + txtDOR).val();
                        }
                        else {
                            TeamData += $('#' + txtempname).val() + ':' + $('#' + ddlgender + " option:selected").val() + ':' + $('#' + txtcontactnumber).val() + ':' + $('#' + ddldesignation + " option:selected").val() + ':' + $('#' + txtDOJ).val() + ':' + $('#' + txtDOR).val();
                        }
                    }
                }
            }
        }

        console.log(TeamData);
        $("#<%=hiddenTeamMembersDataArray.ClientID %>").val(TeamData);
        console.log('Selected Values');
        console.log($("#<%=hiddenTeamMembersDataArray.ClientID %>").val());
    }

    $('body').on('change', '.teamGender', function () {
        //debugger;
        GetTeamMemberData();
    });

    $('body').on('change', '.teamDesignation', function () {
        //debugger;
        GetTeamMemberData();
    });


    function addDirectors() {

        var id2 = $("#<%=hiddenDirectorsId.ClientID %>").val();
        //e.preventDefault();
        $("#dynamicDirectors").append('<div class="row" id="Directors' + id2 + '"><div class="col-md-3"><div class="form-group"><span>Directors Name</span><b style="color: red"> *</b><input type="text" onblur="GetDirectorsAppointedData();" id="txtDirectorsName' + id2 + '" required oninvalid="this.setCustomValidity(&apos;Please Enter Name&apos;)" oninput="setCustomValidity(&apos;&apos;);SplCharCheck(this);" onblur="GetDirectorsAppointedData()" class="form-control" /></div></div><div class="col-md-3"><div class="form-group"><span>Gender</span><b style="color: red"> *</b><select id="ddlDirectorGender' + id2 + '" class="form-control" onchange="GetDirectorsAppointedData()" required oninvalid="this.setCustomValidity(&apos;Please Select Gender&apos;)" oninput="setCustomValidity(&apos;&apos;);"><option Value="Select">Select</option><option Value="Male">Male</option><option Value="Female">Female</option><option Value="Transgender">Transgender</option></select></div></div><div class="col-md-3"><div class="form-group"><span>Contact Number</span><b style="color: red"> *</b><input type="text" onblur="GetDirectorsAppointedData();" id="txtDirectorContact' + id2 + '" pattern=".{10,10}" title="10 Numbers Required" required  oninvalid="this.setCustomValidity(&apos;Please Enter Contact Number&apos;)" oninput="setCustomValidity(&apos;&apos;);NumberCheck(this);"  class="form-control" /></div></div><div class="col-md-3"><div class="form-group"><span>Type of Appointment</span><b style="color: red"> *</b><select  id="ddlDirectorType' + id2 + '" class="form-control" onchange="GetDirectorsAppointedData()"><option Value="Select">Select</option><option Value="Selected">Selected</option><option Value="Elected">Elected</option></select></div></div><div class="col-md-3 form-group"><span>Date of Joining</span><b style="color: red"> *</b><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetDirectorsAppointedData();" id="txtDirectorDOJ' + id2 + '" class="form-control pull-right CurrectDatePicker" placeholder="dd-MM-yyyy" required  oninvalid="this.setCustomValidity(&apos;Please Enter Registration Date&apos;)" oninput="setCustomValidity(&apos;&apos;);"></div></div><div class="col-md-3 form-group"><span>Date of Relieving</span><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input onchange="GetDirectorsAppointedData();" id="txtDirectorDOR' + id2 + '" class="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></div><a class="removeDiv" onclick = "RemoveCurrentDivDirectors(&apos;#Directors' + id2 + '&apos;);" style="color:red"><i class="fa fa-remove"></i></a></div><input type="hidden" id="hfDirID' + id2 + '" value="0" /></div>');
        id2++;
        $("#<%=hiddenDirectorsId.ClientID %>").val(id2);
        console.log(id2);
        GetDirectorsAppointedData();
        return false;
    };

    function GetDirectorsAppointedData() {
        debugger;
        var DataD = "";
        if ($("#<%=ddlDirectors.ClientID%>").val() == "Yes") {
            var DataCountD = $("#<%=hiddenDirectorsId.ClientID %>").val();
            DataD = $("#<%=txtDirectorsName0.ClientID%>").val() + ':' + $("#<%=ddlDirectorGender0.ClientID%> option:selected").val() + ':' + $("#<%=txtDirectorContact0.ClientID%>").val() + ':' + $("#<%=ddlDirectorType0.ClientID%>").val() + ':' + $("#<%=txtDirectorDOJ0.ClientID%>").val() + ':' + $("#<%=txtDirectorDOR0.ClientID%>").val() + ':' + $("#<%=hfDirID0.ClientID%>").val();

            for (var i = 1; i < DataCountD; i++) {
                var txtDirectorName = "txtDirectorsName" + i;
                var ddlDirectorGender = "ddlDirectorGender" + i;
                var txtDirectorContact = "txtDirectorContact" + i;
                var ddlDirectorType = "ddlDirectorType" + i;
                var txtDirectorDOJ = "txtDirectorDOJ" + i;
                var txtDirectorDOR = "txtDirectorDOR" + i;
                var hfDirID = "hfDirID" + i;
                if ($('#' + txtDirectorName).val() != undefined && $('#' + ddlDirectorGender + " option:selected").val() != undefined && $('#' + txtDirectorDOJ).val() != undefined && $('#' + txtDirectorDOR).val() != undefined) {
                    if ($('#' + txtDirectorName).val() != '' && $('#' + ddlDirectorGender + " option:selected").val() != '' && $('#' + txtDirectorContact).val() != '' && $('#' + ddlDirectorType + " option:selected").val() != '' && $('#' + txtDirectorDOJ).val() != '') {
                        if (DataD != "") {
                            DataD += '$' + $('#' + txtDirectorName).val() + ':' + $('#' + ddlDirectorGender + " option:selected").val() + ':' + $('#' + txtDirectorContact).val() + ':' + $('#' + ddlDirectorType + " option:selected").val() + ':' + $('#' + txtDirectorDOJ).val() + ':' + $('#' + txtDirectorDOR).val() + ':' + $("#" + hfDirID).val();
                        }
                        else {
                            DataD += $('#' + txtDirectorName).val() + ':' + $('#' + ddlDirectorGender + " option:selected").val() + ':' + $('#' + txtDirectorContact).val() + ':' + $('#' + ddlDirectorType + " option:selected").val() + ':' + $('#' + txtDirectorDOJ).val() + ':' + $('#' + txtDirectorDOR).val() + ':' + $("#" + hfDirID).val();
                        }
                    }
                }
            }
        }
        console.log(DataD);
        $("#<%=hiddenDirectorsDataArray.ClientID %>").val(DataD);
        console.log('Selected Values');
        console.log($("#<%=hiddenDirectorsDataArray.ClientID %>").val());

    }

    function RemoveCurrentDivDirectors(id) {
        ////debugger;
        var data = $("#<%=hfdeletedDirec.ClientID%>").val();
        var hfDirID = "hfDirID" + i; $("#" + hfDirID).val();
        if ($("#" + hfDirID).val() != undefined && $("#" + hfDirID).val() != '') {
            if (data == "") {
                data = $("#" + hfDirID).val();
            }
            else {
                data = data + ',' + $("#" + hfDirID).val();
            }
        }
        $("#<%=hfdeletedDirec.ClientID%>").val(data);
        $(id).remove();
        GetDirectorsAppointedData();
        return false;
    };


    $('body').on('change', '#ContentPlaceHolder1_ddlSFACEquity', function () {
        //debugger;
        var selectedValue = $("#<%= ddlSFACEquity.ClientID %> option:selected").val();

        if (selectedValue != "Select") {
            if (selectedValue == "Yes") {
                $('#dvEquityGrant').show();
            }
            else {
                $('#dvEquityGrant').hide();
            }
        }
        else {
            $('#dvEquityGrant').hide();
        }
    });

    $('body').on('change', '#ContentPlaceHolder1_ddlSupportTaken', function () {

        var selectedValue = $("#<%= ddlSupportTaken.ClientID %> option:selected").val();

        if (selectedValue != "Select") {
            if (selectedValue == "Yes") {
                $('#dvSupportTaken').show();
                $('#AddSupportTaken').show();
            }
            else {
                $('#dvSupportTaken').hide();
                $('#AddSupportTaken').hide();
            }
        }
        else {
            $('#dvSupportTaken').hide();
            $('#AddSupportTaken').hide();
        }
    });

    $('body').on('change', '#ContentPlaceHolder1_ddlBusinessTaken', function () {

        var selectedValue = $("#<%= ddlBusinessTaken.ClientID %> option:selected").val();

        if (selectedValue != "Select") {
            if (selectedValue == "Yes") {
                $('#dvBusiness').show();
            }
            else {
                $('#dvBusiness').hide();
            }
        }
        else {
            $('#dvBusiness').hide();
        }
    });

    function pageLoad(sender, args) {
        $('.datePicker').datepicker({
            autoclose: true
        });
        var FromEndDate = new Date();
        $('.CurrectDatePicker').datepicker({
            autoclose: true,
            endDate: FromEndDate,
        });
    };

    $('body').on('focus', ".datePicker", function () {
        //debugger;
        $(this).datepicker({
            autoclose: true
        });
    });

    $('body').on('focus', ".CurrectDatePicker", function () {
        ////debugger;
        var FromEndDate = new Date();
        $(this).datepicker({
            autoclose: true,
            endDate: FromEndDate,
        });
    });

    $(document).ready(function () {
        ////debugger;
        $("#liFPC").addClass("active");

    });

    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#ImgPreview').css('visibility', 'visible');
                $('#<%=ImgPreview.ClientID%>').attr('src', e.target.result);
                $('#tdImgPreview').attr('src', e.target.result);
                var img = document.getElementById('<%=ImgPreview.ClientID%>');
                img.src = e.target.result;
                img.onload = function () {
                    var height = this.naturalHeight;
                    var width = this.naturalWidth;
                    var size = parseFloat((input.files[0].size) / 1024).toFixed(2);
                    //console.log(img); //console.log(input.files[0]); //console.log(size); //console.log(height); //console.log(width);
                    if (size <= 100) {
                        $('#lblFileDetails').html('');
                    }
                    else {
                        $('#lblFileDetails').html('Image size should be less than 100kb. Uploaded file size : ' + size + 'kb');
                        $("#<%=fuFpcLogo.ClientID%>").val('');
                        $(".custom-file-label").html('Choose file');
                    }
                };
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $('img').addClass('img-enlargable').click(function () {
        var src = $(this).attr('src');
        $('<div>').css({
            background: 'RGBA(0,0,0,.5) url(' + src + ') no-repeat center',
            backgroundSize: 'contain',
            width: '100%', height: '100%',
            position: 'fixed',
            zIndex: '10000',
            top: '0', left: '0',
            cursor: 'zoom-out'
        }).click(function () {
            $(this).remove();
        }).appendTo('body');
    });

    $('#<%=ddlTeamMembers.ClientID %>').change(function () {
        //debugger;
        var ddl = $("#<%= ddlTeamMembers.ClientID %> option:selected").val();
        if (ddl == 'Yes') {
            $('#dvTeamMembers').show();
            $('#addTeamMember').show();
        } else {
            $('#dvTeamMembers').hide();
            $('#addTeamMember').hide();
        }
        GetTeamMemberData();
    });

    function validateEquityGrant(source, arguments) {
        //debugger;
        var name = document.getElementById('<%= txtEquityGrant.ClientID%>');

        var ddl = $("#<%= ddlSFACEquity.ClientID %> option:selected").val();

        if (ddl == 'Yes') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }

        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function validateNameofAgency(source, arguments) {
        //debugger;
        var name = document.getElementById('<%= txtNameofAgency0.ClientID%>');

        var ddl = $("#<%= ddlSupportTaken.ClientID %> option:selected").text();


        if (ddl == 'Yes') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }

        if (arguments.IsValid == "false") {
            name.focus();
        }
    }


    $('body').on('change', '#<%=ddlLegalActFPC.ClientID%>', function () {
        //debugger;
        var ddl = $("#<%= ddlLegalActFPC.ClientID %> option:selected").text();
        if (ddl == "Others") {
            $('#dvOtherLegalAct').show();
        }
        else { $('#dvOtherLegalAct').hide(); }
    });

    function validateOtherLegalAct(source, arguments) {
        //debugger;
        var name = document.getElementById('<%= txtOtherLeagal.ClientID%>');

        var ddl = $("#<%= ddlLegalActFPC.ClientID %> option:selected").text();

        if (ddl == 'Others') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }

        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function validateNameofScheme(source, arguments) {
        //debugger;
        var name = document.getElementById('<%= txtNameofScheme0.ClientID%>');

        var ddl = $("#<%= ddlSupportTaken.ClientID %> option:selected").text();

        if (ddl == 'Yes') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }

        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function validateSchemeSupport(source, arguments) {
        //debugger;
        var name = document.getElementById('<%= txtSupport0.ClientID%>');

        var ddl = $("#<%= ddlSupportTaken.ClientID %> option:selected").text();

        if (ddl == 'Yes') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }

        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function validateSchemeDate(source, arguments) {
        //debugger;
        var name = document.getElementById('<%= txtSupportTakenDate0.ClientID%>');

        var ddl = $("#<%= ddlSupportTaken.ClientID %> option:selected").text();

        if (ddl == 'Yes') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }

        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function EmpNameValidate(source, arguments) {
        //debugger;

        var name = document.getElementById('<%= txtEmployeeName0.ClientID %>');
        var ddl = $("#<%= ddlTeamMembers.ClientID %> option:selected").val();
        if (ddl != "Select") {
            if (ddl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        else {
            arguments.IsValid = false;
        }
        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function GenderValidate(source, arguments) {
        //debugger;

        var name = $('#<%= ddlEmpGender0.ClientID %> option:selected').val();
        var ddl = $("#<%= ddlTeamMembers.ClientID %> option:selected").val();
        if (ddl != "Select") {
            if (ddl == 'Yes') {
                if (name != "Select") {
                    arguments.IsValid = true;
                }
                else {
                    arguments.IsValid = false;
                }
                //arguments.IsValid = (name != "Select");
            } else {
                arguments.IsValid = true;
            }
        }
        else {
            arguments.IsValid = false;
        }
        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function ContactValidate(source, arguments) {
        //debugger;

        var name = document.getElementById('<%= txtContactNumber0.ClientID %>');
        var ddl = $("#<%= ddlTeamMembers.ClientID %> option:selected").val();
        if (ddl != "Select") {
            if (ddl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        else {
            arguments.IsValid = false;
        }
        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function DesignationValidate(source, arguments) {
        //debugger;

        var name = $('#<%= ddlDesignation0.ClientID %> option:selected').val();
        var ddl = $("#<%= ddlTeamMembers.ClientID %> option:selected").val();
        if (ddl != "Select") {
            if (ddl == 'Yes') {
                if (name != "Select") {
                    arguments.IsValid = true;
                }
                else {
                    arguments.IsValid = false;
                }
                //arguments.IsValid = (name != "Select");
            } else {
                arguments.IsValid = true;
            }
        }
        else {
            arguments.IsValid = false;
        }

        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function BusinessLicenceNameValidate(source, arguments) {
        //debugger;

        var name = document.getElementById('<%= txtLicenceName0.ClientID %>');
        var ddl = $("#<%= ddlBusinessTaken.ClientID %> option:selected").val();

        if (ddl == 'Yes') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }

        if (arguments.IsValid == "false") {
            name.focus();
        }
    }
    function BusinessLicenceNameauthorityValidate(source, arguments) {
        //debugger;

        var name = document.getElementById('<%= txtLicenceNameauthority0.ClientID %>');
        var ddl = $("#<%= ddlBusinessTaken.ClientID %> option:selected").val();

        if (ddl == 'Yes') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }

        if (arguments.IsValid == "false") {
            name.focus();
        }
    }
    function DOJoinValidate(source, arguments) {
        //debugger;

        var name = document.getElementById('<%= txtDOJ0.ClientID %>');
        var ddl = $("#<%= ddlTeamMembers.ClientID %> option:selected").val();
        if (ddl != "Select") {
            if (ddl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        else {
            arguments.IsValid = false;
        }
        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function DirectorDOJoinValidate(source, arguments) {
        //debugger;

        var name = document.getElementById('<%= txtDirectorDOJ0.ClientID %>');
        var ddl = $("#<%= ddlDirectors.ClientID %> option:selected").val();
        if (ddl != "Select") {
            if (ddl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        else {
            arguments.IsValid = false;
        }
        if (arguments.IsValid == "false") {
            name.focus();
        }
    }
    function BusinessLicenceNumberValidate(source, arguments) {
        //debugger;

        var name = document.getElementById('<%= txtLicenseNumber0.ClientID %>');
        var ddl = $("#<%= ddlBusinessTaken.ClientID %> option:selected").val();

        if (ddl == 'Yes') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }

        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function BusinessLicenceDateValidate(source, arguments) {
        //debugger;

        var name = document.getElementById('<%= txtLicenceRegistrationDate0.ClientID %>');
        var ddl = $("#<%= ddlBusinessTaken.ClientID %> option:selected").val();

        if (ddl == 'Yes') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }

        if (arguments.IsValid == "false") {
            name.focus();
        }
    }

    function DirectorNameValidate(source, arguments) {
        //debugger;
        var name = document.getElementById('<%= txtDirectorsName0.ClientID %>');
        var ddl = $("#<%= ddlDirectors.ClientID %> option:selected").val();

        if (ddl == 'Yes') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }
    }

    function DirectorGenderValidate(sender, arguments) {
        //debugger;
        var name = $('#<%= ddlDirectorGender0.ClientID %>  option:selected').val();
        var ddl = $("#<%= ddlDirectors.ClientID %> option:selected").val();

        if (ddl == 'Yes') {
            arguments.IsValid = name != "Select";
        } else {
            arguments.IsValid = true;
        }
    }

    function DirectorContactValidate(sender, arguments) {
        //debugger;
        var name = document.getElementById('<%= txtDirectorContact0.ClientID %>');
        var ddl = $("#<%= ddlDirectors.ClientID %> option:selected").val();

        if (ddl == 'Yes') {
            arguments.IsValid = name.value.length > 0;
        } else {
            arguments.IsValid = true;
        }
    }

    function DirectorTypeValidate(sender, arguments) {
        //debugger;
        var name = $('#<%= ddlDirectorType0.ClientID %>  option:selected').val();
        var ddl = $("#<%= ddlDirectors.ClientID %> option:selected").val();

        if (ddl == 'Yes') {
            arguments.IsValid = name != "Select";
        } else {
            arguments.IsValid = true;
        }
    }
    function ValidateFileSize(sender, args) {
        debugger;
        var maxFileSize = 1 * 1024 // 1MB -> 1 * 1024 – to check in KB – Kilo Bytes
        var fileUpload = document.getElementById("<%=fileuploadnew.ClientID%>");
        if (typeof (fileUpload.files) != "undefined") {
            var size = parseFloat(fileUpload.files[0].size / 1024).toFixed(2);

            if (size < maxFileSize) {

                args.IsValid = true;
            } else {

                args.IsValid = false;
            }

        } else {
            alert("File size should be less than 1 MB.");

        }
    }
    </script>
</asp:Content>

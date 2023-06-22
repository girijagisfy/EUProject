<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="EditWF.aspx.cs" Inherits="CF.EditWF" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Edit Woman Farmer</title>


    <style>
        .LableSpace, label {
            font-weight: 500 !important;
            margin-right: 40px !important;
            margin-left: 5px !important;
        }

        .fa-calendar:before {
            content: "\f073" !important;
        }

        .datepicker-dropdown {
            width: 300px;
        }

        .modal-lg, .modal-xl {
            max-width: 70%;
        }

        .Preview {
            /*font-family: arial, sans-serif;*/
            border-collapse: collapse;
            width: 100%;
            border-color: #dddddd;
            overflow-wrap: anywhere !important;
        }

        p.heading {
            margin-bottom: 0px;
            font-size: 20px;
        }

        .mt-3 {
            margin-top: 20px;
        }

        .footer,
        #non-printable {
            display: none !important;
        }

        #printable {
            display: block;
        }
    </style>

    <script>
        function funNumber(a) {
            ////debugger;

            let value = a.value;
            let numbers = value.replace(/[^0-9]/g, "");
            a.value = numbers;
            if (numbers > 365) {
                a.value = numbers.substring(0, 2);
                return true;
            }

        }
        function ShowAlert(msg, type) {
            ////debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "WFInfo.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
        }

        function validateEmail(emailField) {
            //////debugger;
            var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            if ($('#ContentPlaceHolder1_txtEmailId').val() != '') {
                if (reg.test(emailField.value) == false) {
                    //alert('Invalid Email Address');
                    $('#lblEmail').text('Please enter valid email');
                    $('#ContentPlaceHolder1_txtEmailId').focus();
                    return false;
                }
                $('#lblEmail').text('');
                return true;
            }
            $('#lblEmail').text('');
            return true;
        }

        function NumberCheck(input) {
            ////debugger;
            let value = input.value;
            let numbers = value.replace(/[^0-9]/g, "");
            input.value = numbers;
        }

        function DecimalCheck(input) {
            ////debugger;
            let value = input.value;
            let numbers = value.replace(/[^0-9.]/g, "");

            let count = 0;

            // looping through the items
            for (let i = 0; i < numbers.length; i++) {

                // check if the character is at that position
                if (numbers.charAt(i) == '.') {
                    count += 1;
                }
            }
            if (count > 1) {
                numbers = numbers.substring(0, numbers.length - 1);
            }
            input.value = numbers;
        }

        function SplCharCheck(input) {
            ////debugger;
            let value = input.value;
            let numbers = value.replace(/[^a-zA-Z0-9-.,/_&( )]/g, "").trimStart();
            input.value = numbers;
        }
        function SplCharCheck2(input) {
            ////debugger;
            let value = input.value;
            let numbers = value.replace(/[^a-zA-Z0-9-./_&( )]/g, "").trimStart();
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
                    <h3 class="box-title">Edit Woman Farmer</h3>
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <%--                <asp:UpdatePanel runat="server">
                    <ContentTemplate>--%>

                <div class="box-body">
                    <asp:UpdatePanel runat="server">
                             <ContentTemplate>
                         <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblFPC" runat="server" Text="Is already FPC member?"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList ID="rblIsFPCMember" RepeatDirection="Horizontal" CssClass="LableSpace" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblIsFPCMember" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>              
                            <div class="row" runat="server" id="dvCSO">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="lblCSO" runat="server" Text="Select CSO"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlCSO" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlCSO_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select CSO" ControlToValidate="ddlCSO" SetFocusOnError="true" InitialValue="Select" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label27" runat="server" Text="State:"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlstate" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label30" runat="server" Text="District:"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label31" runat="server" Text="Block:"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlBlock" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row" runat="server">
                                <asp:Panel ID="pnlVillage" runat="server">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="lblVillage" runat="server" Text="Select Village"></asp:Label><b style="color: red"> *</b>
                                            <asp:DropDownList ID="ddlVillage" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlVillage_SelectedIndexChanged" AutoPostBack="true">
                                                <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select Village" ControlToValidate="ddlVillage" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="Label28" runat="server" Text="Grama Panchayat:"></asp:Label>
                                            <asp:TextBox runat="server" ID="txtGrampanchayat" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="pnlWFG" runat="server">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="lblWFG" runat="server" Text="Select WFG"></asp:Label><b style="color: red"> *</b>
                                            <asp:DropDownList ID="ddlWFG" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlWFG_SelectedIndexChanged" AutoPostBack="true">
                                                <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select WFG" ControlToValidate="ddlWFG" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="Label29" runat="server" Text="Hamlet(if Any):"></asp:Label>
                                            <asp:TextBox runat="server" ID="txtHamlet" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Panel ID="Panel1" runat="server" GroupingText="Woman details">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtNameofWomen" runat="server" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Name" ControlToValidate="txtNameofWomen" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblFatherName" runat="server" Text="Name Of Husband/Father"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtFatherName" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Name Of Husband/Father" ControlToValidate="txtFatherName" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label1" runat="server" Text="Marital Status"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList ID="ddlMaritalStatus" CssClass="form-control" runat="server">
                                        <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="Married" Text="Married"></asp:ListItem>
                                        <asp:ListItem Value="UnMarried" Text="UnMarried"></asp:ListItem>
                                        <asp:ListItem Value="Widow" Text="Widow"></asp:ListItem>
                                        <asp:ListItem Value="Separated" Text="Separated"></asp:ListItem>
                                        <asp:ListItem Value="Divorce" Text="Divorce"></asp:ListItem>

                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select Marital Status" ControlToValidate="ddlMaritalStatus" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblReligion" runat="server" Text="Religion"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList ID="ddlReligion" CssClass="form-control" runat="server">
                                        <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="Hindu" Text="Hindu"></asp:ListItem>
                                        <asp:ListItem Value="Muslim" Text="Muslim"></asp:ListItem>
                                        <asp:ListItem Value="Christian" Text="Christian"></asp:ListItem>
                                        <asp:ListItem Value="Jain" Text="Jain"></asp:ListItem>
                                        <asp:ListItem Value="Shikh" Text="Shikh"></asp:ListItem>
                                        <asp:ListItem Value="Others" Text="Others"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select Religion" ControlToValidate="ddlReligion" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvReligionSpecify">
                                <div class="form-group">
                                    <asp:Label ID="lblOtherReligion" runat="server" Text="Specify"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox runat="server" ID="txtOtherReligion" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVOtherReligion" ValidateEmptyText="true" ControlToValidate="txtOtherReligion" SetFocusOnError="true" ClientValidationFunction="ReligionValidate" Display="Dynamic" ErrorMessage="Please Enter Other Religion" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblSocialCategory" runat="server" Text="Social Category"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList ID="ddlSocialCategory" CssClass="form-control" runat="server">
                                        <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select Social Category" ControlToValidate="ddlSocialCategory" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblAadharNo" runat="server" Text="Aadhaar No"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtAadharNo" runat="server" oninput="NumberCheck(this)" MaxLength="12" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Aadhar Number" ControlToValidate="txtAadharNo" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="lblDOB" runat="server" Text="DOB"></asp:Label><b style="color: red"> *</b>
                                            <div class="input-group date">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy" OnTextChanged="txtDOB_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            </div>
                                            <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Date Of Birth" ControlToValidate="txtDOB" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="lblAge" runat="server" Text="Age"></asp:Label>
                                            <asp:TextBox ID="txtAge" runat="server" oninput="NumberCheck(this)" ReadOnly="true" MaxLength="2" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>

                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblEducationQualification" runat="server" Text="Education Qualification"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList runat="server" ID="ddlEducationQualification" CssClass="form-control">
                                        <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="Can not read at all" Text="Can't read at all"></asp:ListItem>
                                        <asp:ListItem Value="Can read Name/signature" Text="Can read Name/signature"></asp:ListItem>
                                        <asp:ListItem Value="Upto 5th" Text="Upto 5th"></asp:ListItem>
                                        <asp:ListItem Value="Upto 8th" Text="Upto 8th"></asp:ListItem>
                                        <asp:ListItem Value="Upto 10th" Text="Upto 10th"></asp:ListItem>
                                        <asp:ListItem Value="11-12th" Text="11-12th"></asp:ListItem>
                                        <asp:ListItem Value="BA" Text="BA"></asp:ListItem>
                                        <asp:ListItem Value="MA" Text="MA"></asp:ListItem>
                                        <asp:ListItem Value="Other" Text="Any Other"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator InitialValue="Select" ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Education Qualification" ControlToValidate="ddlEducationQualification" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblFamilyMembers" runat="server" Text="Total No.of Family Members"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtFamilyMembers" runat="server" oninput="NumberCheck(this)" MaxLength="2" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Number of Family Members" ControlToValidate="txtFamilyMembers" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblRationCardHolder" runat="server" Text="Ration Card holder (Yes/No)"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList ID="rblRationCard" RepeatDirection="Horizontal" CssClass="LableSpace" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblRationCard" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvRation">
                                <div class="form-group">
                                    <asp:Label ID="lblRation" runat="server" Text="Select Ration Card Type"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList ID="ddlRationCardType" runat="server" CssClass="form-control">
                                        <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator1" ValidateEmptyText="true" ControlToValidate="ddlRationCardType" SetFocusOnError="true" ClientValidationFunction="RCValidate" Display="Dynamic" ErrorMessage="Please Select Ration Card Type" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label2" runat="server" Text="Personal / Individual Bank Account"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblBank" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblBank" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3" id="dvOtherEducation">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Other Qualification"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox runat="server" ID="txtOtherQualification" CssClass="form-control"></asp:TextBox>
                                    <asp:CustomValidator runat="server" ControlToValidate="txtOtherQualification" ValidateEmptyText="true" ErrorMessage="Please Enter Other Qualification" Display="Dynamic" ValidationGroup="PreviewCheck" ClientValidationFunction="ValidateOtherQualification" CssClass="text-danger" SetFocusOnError="true"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                        <div id="dvBankName">
                            <h4>Bank Details</h4>
                            <hr style="margin-top: unset;" />
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label6" runat="server" Text="Bank Name"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                        <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVBankName" ValidateEmptyText="true" ControlToValidate="txtBankName" SetFocusOnError="true" ClientValidationFunction="BankValidate" Display="Dynamic" ErrorMessage="Please Enter Bank Name" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label32" runat="server" Text="Branch Name"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox ID="txtBranchName" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                        <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVBranch" ValidateEmptyText="true" ControlToValidate="txtBranchName" SetFocusOnError="true" ClientValidationFunction="BranchValidate" Display="Dynamic" ErrorMessage="Please Enter Branch Name" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label33" runat="server" Text="Account Holder Name"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox ID="txtAccountHolderName" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                        <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVAccountHolderName" ValidateEmptyText="true" ControlToValidate="txtAccountHolderName" SetFocusOnError="true" ClientValidationFunction="AccountHolderValidate" Display="Dynamic" ErrorMessage="Please Enter Account Holder Name" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label34" runat="server" Text="Account Number"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox ID="txtAccountNo" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                        <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVAccountNo" ValidateEmptyText="true" ControlToValidate="txtAccountNo" SetFocusOnError="true" ClientValidationFunction="AccountNoValidate" Display="Dynamic" ErrorMessage="Please Enter Account Number" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label35" runat="server" Text="IFSC Code"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox ID="txtIFSC" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                        <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVIFSC" ValidateEmptyText="true" ControlToValidate="txtIFSC" SetFocusOnError="true" ClientValidationFunction="IFSCValidate" Display="Dynamic" ErrorMessage="Please Enter IFSC Code" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </asp:Panel>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblMemberofAnyCBO" runat="server" Text="Member of Any CBO"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblCBO" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblCBO" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvCBOName">
                            <div class="form-group">
                                <asp:Label ID="lblMemberofAnyCBOName" runat="server" Text="Name of CBO"></asp:Label><b style="color: red"> *</b>
                                <div class="form-group">
                                    <asp:TextBox ID="txtMemberofAnyCBOName" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVCBOName" ValidateEmptyText="true" ControlToValidate="txtMemberofAnyCBOName" SetFocusOnError="true" ClientValidationFunction="CBOValidate" Display="Dynamic" ErrorMessage="Please Enter CBO Name" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvCBOtype">
                            <div class="form-group">
                                <asp:Label ID="lblCBOtype" runat="server" Text="Nature of the CBO"></asp:Label><b style="color: red"> *</b>
                                <asp:DropDownList ID="ddlCBOtype" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                </asp:DropDownList>
                                <%--<asp:TextBox ID="txtCBOtype" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>--%>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVCBOtype" ControlToValidate="ddlCBOtype" SetFocusOnError="true" ClientValidationFunction="CBONatureValidate" Display="Dynamic" ErrorMessage="Please Select CBO Type" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label3" runat="server" Text="Ujjwala Gas Connection"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblGas" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblGas" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label4" runat="server" Text="Toilet present in home"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblToilet" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblToilet" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvToiletFunction">
                            <div class="form-group">
                                <asp:Label ID="Label5" runat="server" Text="Toilet Function or not"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblToiletState" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Functional" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="Not Functional" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVToiletState" ValidateEmptyText="true" ControlToValidate="rblToiletState" SetFocusOnError="true" ClientValidationFunction="ToiletValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblDisability" runat="server" Text="Have Disability?"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblDisability" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblDisability" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvDisabilityType">
                            <div class="form-group">
                                <asp:Label ID="Label49" runat="server" Text="Type of Disability"></asp:Label><b style="color: red"> *</b>
                                <asp:DropDownList ID="ddlDisabilityType" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                    <asp:ListItem Value="Visual" Text="Visual"></asp:ListItem>
                                    <asp:ListItem Value="Hearing" Text="Hearing"></asp:ListItem>
                                    <asp:ListItem Value="Physical Movement" Text="Physical Movement"></asp:ListItem>
                                    <asp:ListItem Value="Speech and Hearing" Text="Speech and Hearing"></asp:ListItem>
                                    <asp:ListItem Value="Mental Illness" Text="Mental Illness"></asp:ListItem>
                                    <asp:ListItem Value="Multiple Disability" Text="Multiple Disability"></asp:ListItem>
                                    <asp:ListItem Value="Intellectual" Text="Intellectual"></asp:ListItem>
                                    <asp:ListItem Value="Other" Text="Any Other"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVDisability" ValidateEmptyText="true" ControlToValidate="ddlDisabilityType" SetFocusOnError="true" ClientValidationFunction="DisabilityValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvDisabilitySpecify">
                            <div class="form-group">
                                <asp:Label ID="lblSpecify" runat="server" Text="Specify"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox runat="server" ID="txtDisabilitySpecify" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVDisabilitySpecify" ValidateEmptyText="true" ControlToValidate="txtDisabilitySpecify" SetFocusOnError="true" ClientValidationFunction="DisabilitySpecifyValidate" Display="Dynamic" ErrorMessage="Please Enter Other Disability" CssClass="text-danger" runat="server"></asp:CustomValidator>

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblVcTraining" runat="server" Text="Any vocational course/training attended before project period"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblVocationalTraining" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblVocationalTraining" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblBaseline" runat="server" Text="Participated in Baseline Survey"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblBaselineSurvey" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblBaselineSurvey" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblClimate" runat="server" Text="Participated in Climate Change Vulnerability study"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblClimateStudy" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblClimateStudy" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblGenderStudy" runat="server" Text="Participated in Gender Vulnerability Study"></asp:Label><b style="color: red">*</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblGenderStudy" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblGenderStudy" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>

                     <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="IblICT" runat="server" Text="Access To ICT"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblICT" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblICT" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Iblfarm" runat="server" Text="On Farm Members"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblfarm" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblfarm" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="IblOfffarm" runat="server" Text="Off Farm Members"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblOfffarm" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblOfffarm" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Iblparticipate" runat="server" Text="Solely Participate"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblparticipate" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblparticipate" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Ibljointly" runat="server" Text="Jointly Participate"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rbljointly" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rbljointly" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="IblShare" runat="server" Text="Share Holder "></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblshare" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblshare" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        </div>
                          <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="IlbPercentage" runat="server" Text="Percentage of trained"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtPercentage" runat="server" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPercentage"
                                    ForeColor="Red" SetFocusOnError="true" Display="Dynamic"
                                    ErrorMessage="allow only number and .%" ID="txtPercentage1"
                                    ValidationExpression="^[0-9.%]*$">
                                </asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator runat="server" ID="txtPercentage2" CssClass="text-danger" ControlToValidate="txtPercentage" ErrorMessage="Please enter Percentage of trained" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Iblfinancial" runat="server" Text="Financial Literacy"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtfinancial" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="txtfinancial1" ValidateEmptyText="true" ControlToValidate="txtfinancial" SetFocusOnError="true" ClientValidationFunction="CheckfinancialValidate" Display="Dynamic" ErrorMessage="Please Enter financial literacy" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Ibldecisions" runat="server" Text="Participate Decisions"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtdecisions" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="txtdecisions1" ValidateEmptyText="true" ControlToValidate="txtdecisions" SetFocusOnError="true" ClientValidationFunction="CheckdecisionsValidate" Display="Dynamic" ErrorMessage="Please Enter decisions" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                           <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Iblincome" runat="server" Text="Family Income"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtIncome" runat="server" oninput="NumberCheck(this)" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Income" ControlToValidate="txtIncome" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblnumber" runat="server" Text="Contact Number"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtContact" runat="server" oninput="NumberCheck(this)" MaxLength="10" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" ControlToValidate="txtContact" ErrorMessage="Please Enter Contact Number" CssClass="text-danger" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" Display="Dynamic" ControlToValidate="txtContact" ErrorMessage="Enter Valid Mobile Number" ValidationExpression="^([0-9]{10})$" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8">
                            <div class="form-group">
                                <asp:Label ID="lblinformation" runat="server" Text="Other relevant information,if any"></asp:Label>
                                <asp:TextBox ID="txtinformation" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" TextMode="MultiLine" Rows="2"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                     <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblFPCWant" runat="server" Text="Want to FPC Member"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblWantFPC" OnSelectedIndexChanged="rblWantFPC_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblWantFPC" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvFPCName" runat="server">
                                <div class="form-group">
                                    <asp:Label ID="lblFPCName" runat="server" Text="FPC Name"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList ID="ddlFPCName" CssClass="form-control" runat="server">
                                        <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVFPCName" ValidateEmptyText="true" ControlToValidate="ddlFPCName" SetFocusOnError="true" ClientValidationFunction="FPCNameValidate" Display="Dynamic" ErrorMessage="Please Enter FPC Name" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                </div>

                <%--                    </ContentTemplate>
                </asp:UpdatePanel>--%>
                <div class="box-footer clearfix">
                    <a id="btnCancel" runat="server" class="btn btn-danger" href="WFInfo.aspx">Cancel</a><%--validationgroup="PreviewCheck"--%>
                    <%--<asp:Button runat="server" id="btnPreview" Text="Preview" class="btn btn-primary" ValidationGroup="PreviewCheck"/>--%>
                    <button id="btnPreview" class="btn btn-primary" onclick="return false">Preview</button>
                </div>
            </div>
            <div class="modal fade bd-example-modal-lg" id="PreviewPopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                    <div class="modal-content" id="printableArea">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Preview Application</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div style="text-align: center">
                                <p class="heading">WF Details</p>
                            </div>
                            <div class="row mt-3">
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-6">
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <table class="Preview" border="1" rules="all">
                                            <tr>
                                                <td style="width: 45%">Date :</td>
                                                <td id="pvDate"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th><strong>CSO </strong></th>
                                        <th><strong>State</strong></th>
                                        <th><strong>District</strong></th>
                                        <th><strong>Block</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdCSO"></td>
                                        <td id="tdState"></td>
                                        <td id="tdDistrict"></td>
                                        <td id="tdBlock"></td>
                                    </tr>
                                    <tr>
                                        <th><strong>Village  </strong></th>
                                        <th><strong>Grama Panchayat</strong></th>
                                        <th><strong>WFG</strong></th>
                                        <th><strong>Hamlet</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdVillage"></td>
                                        <td id="tdGrampanchayat"></td>
                                        <td id="tdWFG"></td>
                                        <td id="tdHamlet"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Women Details</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th><strong>Name</strong></th>
                                        <th><strong>Name Of Husband/Father</strong></th>
                                        <th><strong>Religion</strong></th>
                                        <th><strong>Social Category</strong></th>
                                        <th><strong>Aadhar No</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdName"></td>
                                        <td id="tdFather"></td>
                                        <td id="tdReligion"></td>
                                        <td id="tdSocialCategory"></td>
                                        <td id="tdAadharNo"></td>
                                    </tr>
                                    <tr>
                                        <th><strong>DOB</strong></th>
                                        <th><strong>Age</strong></th>
                                        <th><strong>Education Qualification</strong></th>
                                        <th><strong>Total No.of Family Members</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdDOB"></td>
                                        <td id="tdAge"></td>
                                        <td id="tdEducation"></td>
                                        <td id="tdTotalFamilyMembers"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Ration Card </p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th><strong>Ration Card holder</strong></th>
                                        <th><strong>RationCard Type</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdRation"></td>
                                        <td id="tdRationCardType"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Bank Details</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th><strong>Personal / Individual Bank Account</strong></th>
                                        <th><strong>Bank Name</strong></th>
                                        <th><strong>Branch Name</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdBank"></td>
                                        <td id="tdBankName"></td>
                                        <td id="tdBranchName"></td>
                                    </tr>
                                    <tr>
                                        <th><strong>Account Holder Name</strong></th>
                                        <th><strong>Account Number</strong></th>
                                        <th><strong>IFSC Code</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdAccountHolderName"></td>
                                        <td id="tdAccountNumber"></td>
                                        <td id="tdIFSC"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Member of Any CBO</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th><strong>Member of Any CBO</strong></th>
                                        <th><strong>Name of CBO</strong></th>
                                        <th><strong>Nature of the CBO</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdMemberCBO"></td>
                                        <td id="tdCBOName"></td>
                                        <td id="tdCBONature"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Ujjwala Gas Connection</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th><strong>Ujjwala Gas Connection</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdUjjwala"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Toilet Details</p>
                            </div>
                            <div>
                                <table class="Preview" id="tbldynamic" border="1" rules="all">
                                    <tr>
                                        <th><strong>Toilet present in home </strong></th>
                                        <th><strong>Toilet Function or not</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdToiletpresent"></td>
                                        <td id="tdToiletFunction"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Disability Details</p>
                            </div>
                            <div>
                                <table class="Preview" id="tbldynamic1" border="1" rules="all">
                                    <tr>
                                        <th><strong>Have Disability</strong></th>
                                        <th><strong>Type of Disability</strong></th>
                                        <th><strong>Specify Other Type, If any</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdDisability"></td>
                                        <td id="tdDisabilityType"></td>
                                        <td id="tdDisabilitySpecify"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Study Details</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th><strong>Any vocational course/training attended before project period</strong></th>
                                        <th><strong>Participated in Baseline Survey</strong></th>
                                        <th><strong>Participated in Climate Change Vulnerability study</strong></th>
                                        <th><strong>Participated in Gender Vulnerability Study</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdTraining"></td>
                                        <td id="tdBaseline"></td>
                                        <td id="tdClimate"></td>
                                        <td id="tdGenderStudy"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Details</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th><strong>Access To ICT</strong></th>
                                        <th><strong>On Farm Members</strong></th>
                                        <th><strong>Off Farm Members</strong></th>
                                        <th><strong>Solely Participate</strong></th>
                                        <th><strong>Jointly Participate</strong></th>
                                        <th><strong>Percentage of trained</strong></th>
                                        <th><strong>Financial Literacy</strong></th>
                                        <th><strong>Participate Decisions</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdICT"></td>
                                        <td id="tdOnFarm"></td>
                                        <td id="tdOffFarm"></td>
                                        <td id="tdSolely"></td>
                                        <td id="tdJointly"></td>                                                   
                                        <td id="tdPercentage"></td>
                                        <td id="tdLiteracy"></td>
                                        <td id="tdDecisions"></td>
                                    </tr>
                                </table>
                            </div>                       
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Contact Number</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th><strong>Contact Number</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdContactNumber"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Other relevant information,if any</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th><strong>Other relevant information,if any</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdOtherInfo"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:CheckBox ID="cbdeclare" runat="server" Text="Yes, I Agree with all Condition" />
                                </div>
                            </div>
                        </div>
                        <div class="box-footer clearfix">
                            <a onclick="printDiv('printableArea')" class="btn btn-info">Print</a>
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" ValidationGroup="Decleration" Text="Update" OnClick="btnSubmit_Click" />
                            <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">Close</span>
                            </button>
                        </div>
                    </div>
                </div>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            </div>
        </section>
        <asp:HiddenField ID="arrHiddenStaple" runat="server" />
    </form>
    <link href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.css" rel="stylesheet" />
    <script src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript">
        var FromEndDate = new Date();
        $('.datePicker').datepicker({
            autoclose: true,
            endDate: FromEndDate,
        });
        $(document).ready(function () {

            document.getElementById('dvRation').style.display = "none";
            document.getElementById('dvCBOName').style.display = "none";
            document.getElementById('dvCBOtype').style.display = "none";


            document.getElementById('dvBankName').style.display = "none";
            document.getElementById('dvToiletFunction').style.display = "none";



            document.getElementById('dvReligionSpecify').style.display = "none";
            document.getElementById('dvDisabilityType').style.display = "none";
            document.getElementById('dvDisabilitySpecify').style.display = "none";


            document.getElementById('dvOtherEducation').style.display = "none";
            $("#<%=btnSubmit.ClientID%>").prop('disabled', true);

            var ddl = $("#<%= rblRationCard.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvRation').style.display = "block";
            } else {
                document.getElementById('dvRation').style.display = "none";
            }

            var ddl = $("#<%= rblBank.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvBankName').style.display = "block";
            } else {
                document.getElementById('dvBankName').style.display = "none";
            }

            var ddl = $("#<%= rblToilet.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvToiletFunction').style.display = "block";
            } else {
                document.getElementById('dvToiletFunction').style.display = "none";
            }

            var ddl = $("#<%= rblCBO.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvCBOName').style.display = "block";
                document.getElementById('dvCBOtype').style.display = "block";
            } else {
                document.getElementById('dvCBOName').style.display = "none";
                document.getElementById('dvCBOtype').style.display = "none";
            }
            var ddl = $("#<%= ddlReligion.ClientID %> option:selected").val();
            if (ddl == 'Others') {
                document.getElementById('dvReligionSpecify').style.display = "block";
            } else {
                document.getElementById('dvReligionSpecify').style.display = "none";
            }
            var ddl = $("#<%= rblDisability.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvDisabilityType').style.display = "block";
            } else {
                document.getElementById('dvDisabilityType').style.display = "none";
                document.getElementById('dvDisabilitySpecify').style.display = "none";
            }


            var ddl = $("#<%= ddlDisabilityType.ClientID %> option:selected").val();
            if (ddl == 'Other') {
                document.getElementById('dvDisabilitySpecify').style.display = "block";
            } else {
                document.getElementById('dvDisabilitySpecify').style.display = "none";
            }

            var ddl = $("#<%= ddlEducationQualification.ClientID %> option:selected").val();
            if (ddl == 'Other') {
                document.getElementById('dvOtherEducation').style.display = "block";
            } else {
                document.getElementById('dvOtherEducation').style.display = "none";
            }
        });

        $('#<%=cbdeclare.ClientID%>').click(function () {
            //debugger;
            var thisCheck = $(this);
            if (this.checked) {
                $("#<%=btnSubmit.ClientID%>").prop('disabled', false);
            }
            else {
                $("#<%=btnSubmit.ClientID%>").prop('disabled', true);
            }
        });
        $('#<%=ddlReligion.ClientID %>').change(function () {
            //////debugger;
            var ddl = $("#<%= ddlReligion.ClientID %> option:selected").val();
            if (ddl == 'Others') {
                document.getElementById('dvReligionSpecify').style.display = "block";
            } else {
                document.getElementById('dvReligionSpecify').style.display = "none";
            }

        });

        $('#<%=rblBank.ClientID %>').change(function () {
            //////debugger;
            var ddl = $("#<%= rblBank.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvBankName').style.display = "block";
            } else {
                document.getElementById('dvBankName').style.display = "none";
            }

        });

        $('#<%=rblToilet.ClientID %>').change(function () {
            //////debugger;
            var ddl = $("#<%= rblToilet.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvToiletFunction').style.display = "block";
            } else {
                document.getElementById('dvToiletFunction').style.display = "none";
            }

        });
        $('#<%=rblDisability.ClientID %>').change(function () {
            //////debugger;
            var ddl = $("#<%= rblDisability.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvDisabilityType').style.display = "block";
            } else {
                document.getElementById('dvDisabilityType').style.display = "none";
                document.getElementById('dvDisabilitySpecify').style.display = "none";
            }

        });
        $('#<%=ddlDisabilityType.ClientID %>').change(function () {
            //////debugger;
            var ddl = $("#<%= ddlDisabilityType.ClientID %> option:selected").val();
            if (ddl == 'Other') {
                document.getElementById('dvDisabilitySpecify').style.display = "block";
            } else {
                document.getElementById('dvDisabilitySpecify').style.display = "none";
            }

        });

        $('#<%=rblRationCard.ClientID %>').change(function () {
            //////debugger;
            var ddl = $("#<%= rblRationCard.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvRation').style.display = "block";
            } else {
                document.getElementById('dvRation').style.display = "none";
            }

        });

        $('#<%=rblCBO.ClientID %>').change(function () {
            //////debugger;
            var ddl = $("#<%= rblCBO.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvCBOName').style.display = "block";
                document.getElementById('dvCBOtype').style.display = "block";
            } else {
                document.getElementById('dvCBOName').style.display = "none";
                document.getElementById('dvCBOtype').style.display = "none";
            }

        });



        $('#<%=ddlEducationQualification.ClientID %>').change(function () {
            //////debugger;
            var ddl = $("#<%= ddlEducationQualification.ClientID %>").val();
            if (ddl == 'Other') {
                document.getElementById('dvOtherEducation').style.display = "block";
            } else {
                document.getElementById('dvOtherEducation').style.display = "none";

            }

        });




        function ReligionValidate(source, arguments) {
            ////////debugger;

            //var name = document.getElementById('ContentPlaceHolder1_txtBankName');
            var name = document.getElementById('<%=txtOtherReligion.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= ddlReligion.ClientID %> option:selected").val();

            if (ddl == 'Others') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function BankValidate(source, arguments) {
            ////////debugger;

            //var name = document.getElementById('ContentPlaceHolder1_txtBankName');
            var name = document.getElementById('<%=txtBankName.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= rblBank.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function AccountNoValidate(source, arguments) {
            ////////debugger;

            // var name = document.getElementById('ContentPlaceHolder1_txtAccountNo');
            var name = document.getElementById('<%=txtAccountNo.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= rblBank.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function BranchValidate(source, arguments) {
            ////debugger;

            // var name = document.getElementById('ContentPlaceHolder1_txtBranchName');
            var name = document.getElementById('<%=txtBranchName.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= rblBank.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            }
            else {
                arguments.IsValid = true;
            }
        }
        function AccountHolderValidate(source, arguments) {
            ////////debugger;

            //var name = document.getElementById('ContentPlaceHolder1_txtAccountHolderName');
            var name = document.getElementById('<%=txtAccountHolderName.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= rblBank.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function IFSCValidate(source, arguments) {
            // //////debugger;

            //var name = document.getElementById('ContentPlaceHolder1_txtIFSC');
            var name = document.getElementById('<%=txtIFSC.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= rblBank.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function RCValidate(source, arguments) {
            //////debugger;
            var txt = document.getElementById('ContentPlaceHolder1_ddlRationCardType');

            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= rblRationCard.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function DisabilityValidate(source, arguments) {
            //////debugger;
            var txt = document.getElementById('ContentPlaceHolder1_ddlDisabilityType');

            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= rblDisability.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function DisabilitySpecifyValidate(source, arguments) {
            var name = document.getElementById('<%=txtDisabilitySpecify.ClientID%>');

            var ddl = $("#<%= ddlDisabilityType.ClientID %> option:selected").val();

            if (ddl == 'Other') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }



        function ToiletValidate(source, arguments) {
            //////debugger;
            var txt = document.getElementsByName("<%=rblToiletState.UniqueID%>");

            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= rblToilet.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                for (var i = 0; i < txt.length; i++) {
                    if (txt[i].checked) {
                        arguments.IsValid = txt[i].value == "Functional" || txt[i].value == "Not Functional"
                    }
                }
                //arguments.IsValid = txt.value == "Functional" || txt.value == "Not Functional"
            } else {
                arguments.IsValid = true;
            }
        }





        function CBOValidate(source, arguments) {
            //////debugger;
            // var name = document.getElementById('ContentPlaceHolder1_txtMemberofAnyCBOName');
            var name = document.getElementById('<%=txtMemberofAnyCBOName.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= rblCBO.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function CBONatureValidate(source, arguments) {
            //////debugger;
            //  var txt = document.getElementById('ContentPlaceHolder1_ddlCBOtype');
            var name = document.getElementById('<%=ddlCBOtype.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= rblCBO.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = name.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }





        function ValidateOtherQualification(source, arguments) {
            //////debugger;
            //  var txt = document.getElementById('ContentPlaceHolder1_ddlCBOtype');
            var name = document.getElementById('<%=txtOtherQualification.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= ddlEducationQualification.ClientID %>").val();

            if (ddl == 'Other') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

    </script>

    <link href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.css" rel="stylesheet" />
    <script src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.js"></script>

    <script>
        $("#btnPreview").click(function () {
            //debugger;
            if (typeof (Page_ClientValidate) == 'function') {
                //debugger;
               // Page_ClientValidate("PreviewCheck");
                if (Page_IsValid == true) {
                    ShowPreview();
                }
            } else {
                if ($(this).valid()) {
                    alert('the form is valid');
                }
            }
        });
        function ShowPreview() {
            debugger;
            $("#pvDate").html(new Date().toLocaleDateString());

            $("#tdCSO").html($("#<%=ddlCSO.ClientID%> option:selected").text());
            $("#tdState").html($("#<%=ddlstate.ClientID%> option:selected").text());
            $("#tdDistrict").html($("#<%=ddlDistrict.ClientID%> option:selected").text());
            $("#tdBlock").html($("#<%=ddlBlock.ClientID%> option:selected").text());
            $("#tdVillage").html($("#<%=ddlVillage.ClientID%> option:selected").text());
            $("#tdGrampanchayat").html($("#<%=txtGrampanchayat.ClientID%>").val());
            $("#tdWFG").html($("#<%=ddlWFG.ClientID%> option:selected").text());
            $("#tdHamlet").html($("#<%=txtHamlet.ClientID%>").val());

            $("#tdName").html($("#<%=txtNameofWomen.ClientID%>").val());
            $("#tdFather").html($("#<%=txtFatherName.ClientID%>").val());
            $("#tdReligion").html($("#<%=ddlReligion.ClientID%> option:selected").text());
            $("#tdSocialCategory").html($("#<%=ddlSocialCategory.ClientID%> option:selected").text());
            $("#tdAadharNo").html($("#<%=txtAadharNo.ClientID%>").val());
            $("#tdDOB").html($("#<%=txtDOB.ClientID%>").val());
            $("#tdAge").html($("#<%=txtAge.ClientID%>").val());
            debugger;
            var Education = $("#<%=ddlEducationQualification.ClientID%> option:selected").val();
            if (Education == "Other") {
                Education = $("#<%=txtOtherQualification.ClientID%>").val();
            }
            $("#tdEducation").html(Education);
            $("#tdTotalFamilyMembers").html($("#<%=txtFamilyMembers.ClientID%>").val());

            $("#tdRation").html($("#<%=rblRationCard.ClientID%> input:checked").val());
            if ($("#<%=rblRationCard.ClientID%> input:checked").val() == "Yes") {
                $("#tdRationCardType").html($("#<%=ddlRationCardType.ClientID%> option:selected").text());
            }
            else {
                $("#tdRationCardType").html("");
            }
            $("#tdBank").html($("#<%=rblBank.ClientID%> input:checked").val());
            $("#tdBankName").html($("#<%=txtBankName.ClientID%>").val());
            $("#tdBranchName").html($("#<%=txtBranchName.ClientID%>").val());
            $("#tdAccountHolderName").html($("#<%=txtAccountHolderName.ClientID%>").val());
            $("#tdAccountNumber").html($("#<%=txtAccountNo.ClientID%>").val())
            $("#tdIFSC").html($("#<%=txtIFSC.ClientID%>").val());

            $("#tdMemberCBO").html($("#<%=rblCBO.ClientID%> input:checked").val());
            if ($("#<%=rblCBO.ClientID%> input:checked").val() == "Yes") {
                $("#tdCBOName").html($("#<%=txtMemberofAnyCBOName.ClientID%>").val());
                $("#tdCBONature").html($("#<%=ddlCBOtype.ClientID%> option:selected").text());
            }
            else {
                $("#tdCBOName").html("");
                $("#tdCBONature").html("");
            }
            $("#tdUjjwala").html($("#<%=rblGas.ClientID%> input:checked").val());

            $("#tdToiletpresent").html($("#<%=rblToilet.ClientID%> input:checked").val());
            if ($("#<%=rblToilet.ClientID%> input:checked").val() == "Yes") {
                $("#tdToiletFunction").html($("#<%=rblToiletState.ClientID%> input:checked").val());
            }
            else {
                $("#tdToiletFunction").html("");
            }
            $("#tdDisability").html($("#<%=rblDisability.ClientID%> input:checked").val());
            if ($("#<%=rblDisability.ClientID%> input:checked").val() == "Yes") {
                $("#tdDisabilityType").html($("#<%=ddlDisabilityType.ClientID%> option:selected").val());
                $("#tdDisabilitySpecify").html($("#<%=txtDisabilitySpecify.ClientID%>").val());
            }
            else {
                $("#tdDisabilityType").html("");
                $("#tdDisabilitySpecify").html("");
            }

            $("#tdTraining").html($("#<%=rblVocationalTraining.ClientID%> input:checked").val());
            $("#tdBaseline").html($("#<%=rblBaselineSurvey.ClientID%> input:checked").val());
            $("#tdClimate").html($("#<%=rblClimateStudy.ClientID%> input:checked").val());
            $("#tdGenderStudy").html($("#<%=rblGenderStudy.ClientID%> input:checked").val());

            $("#tdContactNumber").html($("#<%=txtContact.ClientID%>").val());




            var elements = document.getElementsByClassName('otherpreviewrow');
            while (elements.length > 0) {
                elements[0].parentNode.removeChild(elements[0]);
            }




            $("#tdOtherInfo").html($("#<%=txtinformation.ClientID%>").val());



            var elements = document.getElementsByClassName('preview1');
            while (elements.length > 0) {
                elements[0].parentNode.removeChild(elements[0]);
            }


            $('#PreviewPopup').modal('show');
        }
    </script>
    <link href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.css" rel="stylesheet" />
    <script src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.js"></script>
    <script>
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
            printWindow.document.write('<style>.Preview {border-collapse: collapse;width: 100%;border-color: #dddddd;overflow-wrap: anywhere !important;} td, th {padding: 8px !important;}p.heading {margin-bottom: 0px;font-size: 20px;}.mt-3 {margin-top: 20px;}</style>');
            printWindow.document.write('</head><body>');
            printWindow.document.write(printContents);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
            //document.body.innerHTML = printContents;

            //window.print();

            //document.body.innerHTML = originalContents;
        }

        $('.datePicker').datepicker({
            autoclose: true
        });

        $('body').on('focus', ".datePicker", function () {
            ////debugger;
            $(this).datepicker({
                autoclose: true
            });
        });
    </script>


</asp:Content>

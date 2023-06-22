<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="AddCso.aspx.cs" Inherits="CF.AddCso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add CSO</title>
    <style>
        label {
            padding-left: 10px;
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

        function ShowAlert(msg, type) {
            //debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "CsoInfo.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
        }

        function validateEmail(emailField, lblid, filedid) {
            //debugger;
            var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            if (emailField.value != '') {
                if (reg.test(emailField.value) == false) {
                    //alert('Invalid Email Address');
                    $('#' + lblid).text('Please enter valid email');
                    $('#ContentPlaceHolder1_' + filedid).focus();
                    return false;
                }
                $('#' + lblid).text('');
                return true;
            }
            $('#' + lblid).text('');
            return true;
        }

        function NumberCheck(input) {
            //debugger;
            let value = input.value;
            let numbers = value.replace(/[^0-9]/g, "");
            input.value = numbers;
        }

        function MobileCheck(input) {
            //debugger;
            let value = input.value;
            let numbers = value.replace(/[^0-9,]/g, "");
            input.value = numbers;
        }

        function DecimalCheck(input) {
            //debugger;
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
        function SplCharCheck2(input) {
            //debugger;
            let value = input.value;
            let numbers = value.replace(/[^a-zA-Z0-9-./_&( )]/g, "").trimStart();
            input.value = numbers;
        }
        function SplCharCheck(input) {
            //debugger;
            let value = input.value;
            let numbers = value.replace(/[^a-zA-Z0-9-.,/_&( )]/g, "").trimStart();
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
                    <h3 class="box-title">Add CSO</h3>
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
                                        <asp:Label ID="lblCso" runat="server" Text="Name of CSO"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtCso" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" />
                                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter CSO" ControlToValidate="txtCso" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblStates" runat="server" Text="State"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlStates" CssClass="form-control" OnSelectedIndexChanged="ddlStates_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlStates" CssClass="text-danger" InitialValue="Select" ErrorMessage="Please select States" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lbldist" runat="server" Text="District"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlDisrtict" CssClass="form-control" OnSelectedIndexChanged="ddlDisrtict_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlDisrtict" InitialValue="Select" ErrorMessage="Please select District" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblblk" runat="server" Text="Block"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlBlocks" CssClass="form-control">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlBlocks" InitialValue="Select" ErrorMessage="Please select Block" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Panel ID="Panel1" runat="server" GroupingText="Registered Address">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="lblAddress" runat="server" Text="Address"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtregaddr" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Address" ControlToValidate="txtregaddr" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Lblphonenumber" runat="server" Text="Phone Number"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtregPhone" runat="server" oninput="MobileCheck(this)" placeholder="Mobile No , Seperator" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Mobile No" ControlToValidate="txtregPhone" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Correct Phone Number" ControlToValidate="txtregPhone" ClientValidationFunction="ValidateCSOContact" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Email" runat="server" Text="Email"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtregEmail" runat="server" placeholder="Email , Seperator" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Email" ControlToValidate="txtregEmail" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Correct Email" ControlToValidate="txtregEmail" ClientValidationFunction="ValidateCSOEmail" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Website" runat="server" Text="Website"></asp:Label>
                                    <asp:TextBox ID="txtregwebsite" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div>
                                <asp:CheckBox ID="checkd" runat="server" Text="Same as Registered Address" OnCheckedChanged="checkd_CheckedChanged" AutoPostBack="true" />
                            </div>
                            <asp:Panel ID="Panel2" runat="server" GroupingText="Correspondence Address">
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="Label1" runat="server" Text="Address"></asp:Label><b style="color: red"> *</b>
                                            <asp:TextBox ID="txtcraddr" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                            <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Address" ControlToValidate="txtcraddr" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="Label2" runat="server" Text="Phone Number"></asp:Label><b style="color: red"> *</b>
                                            <asp:TextBox ID="txtcrPhone" runat="server" placeholder="Mobile No , Seperator" CssClass="form-control" />
                                            <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Mobile No" ControlToValidate="txtcrPhone" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                            <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Correct Phone Number" ControlToValidate="txtcrPhone" ClientValidationFunction="ValidateCSOContact2" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="Label3" runat="server" Text="Email"></asp:Label><b style="color: red"> *</b>
                                            <asp:TextBox ID="txtcremail" runat="server" placeholder="Email , Seperator" CssClass="form-control" />
                                            <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Email" ControlToValidate="txtcremail" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                            <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Correct Email" ControlToValidate="txtcremail" ClientValidationFunction="ValidateCSOEmail2" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                        </div>
                                    </div>
                                    <%-- <div class="col-md-3">
                                        <div class="form-group">
                                            <asp:Label ID="Label4" runat="server" Text="Website"></asp:Label>
                                            <asp:TextBox ID="txtcrwebsite" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                        </div>
                                    </div>--%>
                                </div>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Panel ID="Panel3" runat="server" GroupingText="Contact Person Details">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label5" runat="server" Text="Name"></asp:Label>
                                    <asp:TextBox ID="txtcontname" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label6" runat="server" Text="Address"></asp:Label>
                                    <asp:TextBox ID="txtcontAddr" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label7" runat="server" Text="Phone"></asp:Label>
                                    <asp:TextBox ID="txtcontphone" runat="server" MaxLength="10" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RegularExpressionValidator runat="server" Display="Dynamic" ControlToValidate="txtcontphone" ErrorMessage="Enter Valid Mobile Number" ValidationExpression="^([0-9]{10})$" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label8" runat="server" Text="Email"></asp:Label>
                                    <asp:TextBox ID="txtcontemail" runat="server" CssClass="form-control" />
                                    <label id="emailidcontactperson" class="text-danger"></label>
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Corect Email" ControlToValidate="txtcontemail" ClientValidationFunction="ValidateCSOEmail2" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                    <asp:RegularExpressionValidator runat="server" CssClass="text-danger" ErrorMessage="Enter valid email" ValidationExpression="^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$" ValidationGroup="Address" ControlToValidate="txtcontemail" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <%-- <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label9" runat="server" Text="Website"></asp:Label>
                                    <asp:TextBox ID="txtcontwebsite" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                </div>
                            </div>--%>
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" GroupingText="Registration Details">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label10" runat="server" Text="Registration No"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtregno" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Registration No" ControlToValidate="txtregno" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label54" runat="server" Text="Registration Date"></asp:Label><b style="color: red"> *</b>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txtregdate" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Registration Date" ControlToValidate="txtregdate" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label11" runat="server" Text="Expiry Date"></asp:Label><b style="color: red"> *</b>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txtregExpire" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label20" runat="server" Text="Society Act"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList runat="server" ID="ddlSocietyAct" CssClass="form-control">
                                        <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="ACT No. 2004" Text="ACT No. 2004"></asp:ListItem>
                                        <asp:ListItem Value="Other" Text="Other"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select Society Act" ControlToValidate="ddlSocietyAct" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvOtherAct">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label22" runat="server" Text="If Other"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtOtherAct" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Society Act" ControlToValidate="txtOtherAct" ClientValidationFunction="ValidateOtherAct" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" GroupingText="FCRA Registration Detail">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label21" runat="server" Text="Registration No"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtFCRAregno" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Registration No" ControlToValidate="txtFCRAregno" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label19" runat="server" Text="Registration Date"></asp:Label><b style="color: red"> *</b>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txtFCRADate" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Registration Date" ControlToValidate="txtFCRADate" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label23" runat="server" Text="Expiry Date"></asp:Label>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txtFCRAExpiry" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label ID="lbldistPO" runat="server" Text="Distance from Project Office,Faizabad(in Km)"></asp:Label>
                                <asp:TextBox ID="txtdistPO" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                            </div>
                        </div>
                    </div>
                    <asp:Panel ID="Panel4" runat="server" GroupingText="Detail of Other Registration">
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Label ID="Label12" runat="server" Text="PAN"></asp:Label><b style="color: red"> *</b>
                            </div>
                            <div class="col-md-3">
                                <asp:RadioButtonList ID="rblPAN" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="rblPAN" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row" id="dvPANno">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label24" runat="server" Text="PAN No"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtPanNo" runat="server" CssClass="form-control" MaxLength="10" oninput="SplCharCheck(this)" />
                                    <asp:CustomValidator runat="server" ControlToValidate="txtPanNo" ErrorMessage="Please Enter PAN Number" Display="Dynamic" ClientValidationFunction="ValidatePANNo" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label25" runat="server" Text="Date"></asp:Label><b style="color: red">*</b>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txtPanDate" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                    <asp:CustomValidator runat="server" ControlToValidate="txtPanDate" ErrorMessage="Please Enter PAN Date" Display="Dynamic" ClientValidationFunction="ValidatePANDate" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label26" runat="server" Text="Expiry Date"></asp:Label>
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
                                <asp:Label ID="Label13" runat="server" Text="TAN"></asp:Label><b style="color: red"> *</b>
                            </div>
                            <div class="col-md-3">
                                <asp:RadioButtonList ID="rblTAN" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="rblTAN" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row" id="dvTANno">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label27" runat="server" Text="TAN No"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtTanNo" runat="server" CssClass="form-control" MaxLength="10" oninput="SplCharCheck(this)" />
                                    <asp:CustomValidator runat="server" ControlToValidate="txtTanNo" ErrorMessage="Please Enter TAN Number" Display="Dynamic" ClientValidationFunction="ValidateTANNo" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label28" runat="server" Text="Date"></asp:Label><b style="color: red">*</b>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txtTanDate" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                    <asp:CustomValidator runat="server" ControlToValidate="txtTanDate" ErrorMessage="Please Enter TAN Date" Display="Dynamic" ClientValidationFunction="ValidateTANDate" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label29" runat="server" Text="Expiry Date"></asp:Label>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txtTanExpiry" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Label ID="Label14" runat="server" Text="12 A"></asp:Label><b style="color: red"> *</b>
                            </div>
                            <div class="col-md-3">
                                <asp:RadioButtonList ID="rbl12A" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="rbl12A" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row" id="dv12Ano">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label30" runat="server" Text="12 A No"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txt12ANo" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" ControlToValidate="txt12ANo" ErrorMessage="Please Enter 12 A No" Display="Dynamic" ClientValidationFunction="Validate12ANo" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label31" runat="server" Text="Date"></asp:Label><b style="color: red">*</b>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txt12ADate" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                    <asp:CustomValidator runat="server" ControlToValidate="txt12ADate" ErrorMessage="Please Enter 12 A Date" Display="Dynamic" ClientValidationFunction="Validate12ADate" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label32" runat="server" Text="Expiry Date"></asp:Label>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txt12AExpiry" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Label ID="Label15" runat="server" Text="80G"></asp:Label><b style="color: red"> *</b>
                            </div>
                            <div class="col-md-3">
                                <asp:RadioButtonList ID="rbl80G" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="rbl80G" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row" id="dv80Gno">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label33" runat="server" Text="80G No"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txt80GNo" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" ControlToValidate="txt80GNo" ErrorMessage="Please Enter 80G No" Display="Dynamic" ClientValidationFunction="Validate80GNo" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label34" runat="server" Text="Date"></asp:Label><b style="color: red">*</b>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txt80GDate" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                    <asp:CustomValidator runat="server" ControlToValidate="txt80GDate" ErrorMessage="Please Enter 80G Date" Display="Dynamic" ClientValidationFunction="Validate80GDate" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label35" runat="server" Text="Expiry Date"></asp:Label>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txt80GExpiry" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Label ID="Label16" runat="server" Text="GST"></asp:Label><b style="color: red"> *</b>
                            </div>
                            <div class="col-md-3">
                                <asp:RadioButtonList ID="rblGST" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="rblGST" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row" id="dvGSTno">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label36" runat="server" Text="GST No"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtGSTNo" runat="server" oninput="SplCharCheck(this)" MaxLength="15" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" ControlToValidate="txtGSTNo" ErrorMessage="Please Enter GST No" Display="Dynamic" ClientValidationFunction="ValidateGSTNo" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label37" runat="server" Text="Date"></asp:Label><b style="color: red">*</b>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txtGSTDate" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                    <asp:CustomValidator runat="server" ControlToValidate="txtGSTDate" ErrorMessage="Please Enter GST Date" Display="Dynamic" ClientValidationFunction="ValidateGSTDate" ValidateEmptyText="true" SetFocusOnError="true" CssClass="text-danger" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label38" runat="server" Text="Expiry Date"></asp:Label>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txtGSTExpiry" runat="server" CssClass="form-control pull-right datePicker" placeholder="dd-MM-yyyy"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Label ID="Label17" runat="server" Text="Other If any:NGO Darpan"></asp:Label><b style="color: red"> *</b>
                            </div>
                            <div class="col-md-3">
                                <asp:RadioButtonList ID="rblNGO" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text=" No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="rblNGO" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <asp:Panel runat="server" GroupingText="NGO Details" ID="pnlNGO">
                            <div class="row" id="NGO0">
                                <div class="col-md-3 form-group">
                                    <label>NGO Name</label>
                                    <asp:TextBox runat="server" ID="txtNGOName0" oninput="SplCharCheck2(this)" onblur="GetFilterData()" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" ControlToValidate="txtNGOName0" CssClass="text-danger" Display="Dynamic" SetFocusOnError="true" ValidateEmptyText="true" ErrorMessage="Please Enter Name of NGO" ClientValidationFunction="ValidatetxtNGOName0"></asp:CustomValidator>
                                </div>
                                <div class="col-md-3 form-group">
                                    <label>Date of Registration</label>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox runat="server" ID="txtNGODate0" onblur="GetFilterData()" class="form-control pull-right datePicker" placeholder="dd-MM-yyyy" />
                                    </div>
                                    <asp:CustomValidator runat="server" ControlToValidate="txtNGODate0" CssClass="text-danger" Display="Dynamic" SetFocusOnError="true" ValidateEmptyText="true" ErrorMessage="Please Enter Date of Registration" ClientValidationFunction="ValidatetxtNGODate0"></asp:CustomValidator>
                                </div>
                                <div class="col-md-3 form-group">
                                    <label>Date of Expiry(if Any)</label>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <input id="txtNGOExpiry0" onblur="GetFilterData()" class="form-control pull-right datePicker" placeholder="dd-MM-yyyy" />
                                    </div>
                                </div>
                            </div>
                            <div id="dynamicNGO">
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <a onclick="return false" id="lnkAddFilter" runat="server" style="cursor: pointer;"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                                    </div>
                                </div>
                            </div>
                            <asp:HiddenField ID="hiddenDivRowId" runat="server" Value="1" />
                            <asp:HiddenField ID="hiddenDataArrayId" runat="server" />
                        </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="Panel6" runat="server" GroupingText="Organization Information">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Label ID="lblOV" runat="server" Text="Organization Vision"></asp:Label>
                                    <asp:TextBox ID="txtOV" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" TextMode="MultiLine" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Label ID="lblOM" runat="server" Text="Organization Mission"></asp:Label>
                                    <asp:TextBox ID="txtOM" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" TextMode="MultiLine" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Label ID="lblOC" runat="server" Text="Organization coverage or project area"></asp:Label>
                                    <asp:TextBox ID="txtOC" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" TextMode="MultiLine" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Label ID="lblTC" runat="server" Text="Target Community"></asp:Label>
                                    <asp:TextBox ID="txtTC" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" TextMode="MultiLine" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel5" runat="server" GroupingText="Major programmatic focus">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="lblAD" runat="server" Text="Agriculture development"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblAD" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblAD" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="lblWEG" runat="server" Text="Women empowerment and Governance"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblWEG" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblWEG" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="lblED" runat="server" Text="Education"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblED" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblED" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="lblHT" runat="server" Text="Health"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblHT" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblHT" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="lblWS" runat="server" Text="Water and Sanitation"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblWS" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblWS" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="lblSD" runat="server" Text="Skill Development"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblSD" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text=" No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblSD" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="lblOA" runat="server" Text="Other if any"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblOA" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text=" No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblOA" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <asp:Panel runat="server" GroupingText="Other programmatic focus" ID="pnlFocus">
                            <div class="row">
                                <div class="col-md-3 form-group" id="dvfocus0">
                                    <asp:TextBox runat="server" ID="txtprogrammatic0" oninput="SplCharCheck2(this)" onblur="GetFocusData()" class="form-control" />
                                    <asp:CustomValidator runat="server" ControlToValidate="txtprogrammatic0" CssClass="text-danger" ValidateEmptyText="true" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Please Enter programmatic focus" ClientValidationFunction="validatetxtprogrammatic0"></asp:CustomValidator>
                                </div>
                                <div class="col-md-1"></div>
                                <div id="dynamicprogrammatic">
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <a onclick="return false" id="lblFocus" runat="server"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                                    </div>
                                </div>
                                <asp:HiddenField ID="hfFocuscount" runat="server" Value="1" />
                                <asp:HiddenField ID="hfFocusData" runat="server" />
                            </div>
                            <%--<div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <a onclick="return false" id="A1" runat="server"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                                    </div>
                                </div>
                            </div>--%>
                        </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="Panel7" runat="server" GroupingText="Community based organizations">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Women SHG"></asp:Label>
                                    <asp:TextBox ID="txtWSHG" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Women Farmers Groups"></asp:Label>
                                    <asp:TextBox ID="txtWFG" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Adolescent Girls Group"></asp:Label>
                                    <asp:TextBox ID="txtAGG" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Joint Liability Group"></asp:Label>
                                    <asp:TextBox ID="txtJLG" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Other If any"></asp:Label>
                                    <asp:TextBox ID="txtOIF" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Detail of Fedration if any"></asp:Label>
                                    <asp:TextBox ID="txtDFA" runat="server" oninput="SplCharCheck2(this)" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Nari Sangh"></asp:Label>
                                    <asp:TextBox ID="TXTNariSingh" runat="server" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel8" runat="server" GroupingText="Work Experience">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <asp:Label ID="lblWE" runat="server" Text="Promotion of Farmers Producer Company (FPC)"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblFPCPromotion" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text=" No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblFPCPromotion" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvFPCPromotion">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label39" runat="server" Text="No. of FPC"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtPromotion1" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter No. of FPC" ControlToValidate="txtPromotion1" ClientValidationFunction="ValidatePromotion1" ValidateEmptyText="true" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label40" runat="server" Text="Associates"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtPromotion2" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Associates" ControlToValidate="txtPromotion2" ClientValidationFunction="ValidatePromotion2" ValidateEmptyText="true" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label41" runat="server" Text="Details"></asp:Label>
                                    <asp:TextBox ID="txtPromotion3" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <asp:Label ID="lblEWF" runat="server" Text="Women Farmers, Agriculture, Climate Change and Gender etc (if any)"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblWFACG" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text=" No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblWFACG" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvWFACG">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label42" runat="server" Text="How many years"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtWFACG1" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter How many years" ControlToValidate="txtWFACG1" ClientValidationFunction="ValidateWFACG1" ValidateEmptyText="true" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label43" runat="server" Text="Associates"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtWFACG2" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Associates" ControlToValidate="txtWFACG2" ClientValidationFunction="ValidateWFACG2" ValidateEmptyText="true" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label44" runat="server" Text="Details"></asp:Label>
                                    <asp:TextBox ID="txtWFACG3" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <asp:Label ID="lblIGP" runat="server" Text="Experience in implementing IGP/Entrepreneurships"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblIGPE" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text=" No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblIGPE" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvIGPE">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label45" runat="server" Text="How many years"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtIGPE1" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter How many years" ControlToValidate="txtIGPE1" ClientValidationFunction="ValidateIGPE1" ValidateEmptyText="true" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label46" runat="server" Text="Associates"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtIGPE2" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Associates" ControlToValidate="txtIGPE2" ClientValidationFunction="ValidateIGPE2" ValidateEmptyText="true" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label47" runat="server" Text="Details"></asp:Label>
                                    <asp:TextBox ID="txtIGPE3" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <asp:Label ID="lblPRI" runat="server" Text="Experience in working with PRI, Local Admin and Government Departments"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblWPRIL" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text=" No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblWPRIL" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvWPRIL">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label48" runat="server" Text="How many years"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtWPRIL1" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter How many years" ControlToValidate="txtWPRIL1" ClientValidationFunction="ValidateWPRIL1" ValidateEmptyText="true" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label49" runat="server" Text="Associates"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtWPRIL2" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Associates" ControlToValidate="txtWPRIL2" ClientValidationFunction="ValidateWPRIL2" ValidateEmptyText="true" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label50" runat="server" Text="Details"></asp:Label>
                                    <asp:TextBox ID="txtWPRIL3" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <asp:Label ID="lblStA" runat="server" Text="Any striking accomplishment by the organization (Unique, something different)"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblASCO" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text=" No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblASCO" CssClass="text-danger" ErrorMessage="Please Select an Option" Display="Dynamic" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvASCO">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label51" runat="server" Text="How many years"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtASCO1" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter How many years" ControlToValidate="txtASCO1" ClientValidationFunction="ValidateASCO1" ValidateEmptyText="true" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label52" runat="server" Text="Associates"></asp:Label><b style="color: red">*</b>
                                    <asp:TextBox ID="txtASCO2" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" />
                                    <asp:CustomValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Associates" ControlToValidate="txtASCO2" ClientValidationFunction="ValidateASCO2" ValidateEmptyText="true" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label53" runat="server" Text="Details"></asp:Label>
                                    <asp:TextBox ID="txtASCO3" runat="server" oninput="SplCharCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label ID="Label18" runat="server" Text="Upload Your Logo"></asp:Label><b style="color: red"> *</b>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:FileUpload runat="server" class="custom-file-input" onchange="showpreview(this)" ID="Csologo" accept=".jpg,.png,.jpeg" />
                                <label class="custom-file-label" id="lblCsologo" for="Csologo" style="overflow: hidden">Choose file</label>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Csologo" ErrorMessage="Please select .jpg,.png,.jpeg files" CssClass="text-danger" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer clearfix">
                    <a id="btnCancel" runat="server" class="btn btn-danger" href="CsoInfo.aspx">Cancel</a><%--validationgroup="PreviewCheck"--%>
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
                                <p class="heading">CSO Details</p>
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
                                        <th class="headLeft"><strong>CSO Name</strong></th>
                                        <th class="headLeft"><strong>State</strong></th>
                                        <th class="headLeft"><strong>District</strong></th>
                                        <th class="headLeft"><strong>Block</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdCSO"></td>
                                        <td id="tdState"></td>
                                        <td id="tdDistrict"></td>
                                        <td id="tdBlock"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Registered Address</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th class="headLeft"><strong>Address</strong></th>
                                        <th class="headLeft"><strong>Phone Number</strong></th>
                                        <th class="headLeft"><strong>Email</strong></th>
                                        <th class="headLeft"><strong>Website</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdregaddr"></td>
                                        <td id="tdregphone"></td>
                                        <td id="tdregemail"></td>
                                        <td id="tdregwebsite"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Correspondence Address</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th class="headLeft"><strong>Address</strong></th>
                                        <th class="headLeft"><strong>Phone Number</strong></th>
                                        <th class="headLeft"><strong>Email</strong></th>
                                        <%--<th class="headLeft"><strong>Website</strong></th>--%>
                                    </tr>
                                    <tr>
                                        <td id="tdcraddr"></td>
                                        <td id="tdcrphone"></td>
                                        <td id="tdcremail"></td>
                                        <%--<td id="tdcrwebsite"></td>--%>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Contact Person Details</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th class="headLeft"><strong>Name</strong></th>
                                        <th class="headLeft"><strong>Address</strong></th>
                                        <th class="headLeft"><strong>Phone Number</strong></th>
                                        <th class="headLeft"><strong>Email</strong></th>
                                        <%--<th class="headLeft"><strong>Website</strong></th>--%>
                                    </tr>
                                    <tr>
                                        <td id="tdconname"></td>
                                        <td id="tdconaddr"></td>
                                        <td id="tdconphone"></td>
                                        <td id="tdconemail"></td>
                                        <%--<td id="tdconwebsite"></td>--%>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Registration Details</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th class="headLeft"><strong>Registration No</strong></th>
                                        <th class="headLeft"><strong>Registration Date</strong></th>
                                        <th class="headLeft"><strong>Expiry Date</strong></th>
                                        <th class="headLeft"><strong>Society Act </strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdregno"></td>
                                        <td id="tdregdate"></td>
                                        <td id="tdregexpiry"></td>
                                        <td id="tdregsocial"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">FCRA Registration Detail</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th class="headLeft"><strong>Registration No</strong></th>
                                        <th class="headLeft"><strong>Registration Date</strong></th>
                                        <th class="headLeft"><strong>Expiry Date</strong></th>
                                        <th class="headLeft"><strong>Distance from Project Office(in KM)</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdfcraregno"></td>
                                        <td id="tdfcraregdate"></td>
                                        <td id="tdfcraregexpiry"></td>
                                        <td id="tddistPO"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Detail of Other Registration</p>
                            </div>
                            <div>
                                <table class="Preview" id="tbldynamic" border="1" rules="all">
                                    <tr>
                                        <th class="headLeft"><strong>PAN</strong></th>
                                        <th class="headLeft"><strong>PAN No</strong></th>
                                        <th class="headLeft"><strong>Registration Date</strong></th>
                                        <th class="headLeft"><strong>Expiry Date</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdPAN"></td>
                                        <td id="tdPANNo"></td>
                                        <td id="tdPANDate"></td>
                                        <td id="tdPANExpiry"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>TAN</strong></th>
                                        <th class="headLeft"><strong>TAN No</strong></th>
                                        <th class="headLeft"><strong>Registration Date</strong></th>
                                        <th class="headLeft"><strong>Expiry Date</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdTAN"></td>
                                        <td id="tdTANNo"></td>
                                        <td id="tdTANDate"></td>
                                        <td id="tdTANExpiry"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>12 A</strong></th>
                                        <th class="headLeft"><strong>12 A No</strong></th>
                                        <th class="headLeft"><strong>Registration Date</strong></th>
                                        <th class="headLeft"><strong>Expiry Date</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="td12A"></td>
                                        <td id="td12ANo"></td>
                                        <td id="td12ADate"></td>
                                        <td id="td12AExpiry"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>80G</strong></th>
                                        <th class="headLeft"><strong>80G No</strong></th>
                                        <th class="headLeft"><strong>Registration Date</strong></th>
                                        <th class="headLeft"><strong>Expiry Date</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="td80G"></td>
                                        <td id="td80GNo"></td>
                                        <td id="td80GDate"></td>
                                        <td id="td80GExpiry"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>GST</strong></th>
                                        <th class="headLeft"><strong>GST No</strong></th>
                                        <th class="headLeft"><strong>Registration Date</strong></th>
                                        <th class="headLeft"><strong>Expiry Date</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdGST"></td>
                                        <td id="tdGSTNo"></td>
                                        <td id="tdGSTDate"></td>
                                        <td id="tdGSTExpiry"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>Other NGO</strong></th>
                                        <th class="headLeft"><strong>NGO No</strong></th>
                                        <th class="headLeft"><strong>Registration Date</strong></th>
                                        <th class="headLeft"><strong>Expiry Date</strong></th>
                                    </tr>
                                    <%--<tr>
                                        <div id="tdotherngo">
                                        </div>
                                    </tr>--%>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Organization Information</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th class="headLeft"><strong>Organization Vision</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdVision"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>Organization Mission</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdMission"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>Organization coverage or project area</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdProject"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>Target Community</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdCommunity"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Major programmatic focus</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th class="headLeft"><strong>Agriculture development </strong></th>
                                        <th class="headLeft"><strong>Women empowerment and Governance </strong></th>
                                        <th class="headLeft"><strong>Education </strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdAgriculture"></td>
                                        <td id="tdWEG"></td>
                                        <td id="tdEducation"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>Health  </strong></th>
                                        <th class="headLeft"><strong>Water and Sanitation </strong></th>
                                        <th class="headLeft"><strong>Skill Development </strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdHealth"></td>
                                        <td id="tdWAS"></td>
                                        <td id="tdSkill"></td>
                                    </tr>
                                    <tr>
                                        <th colspan="3" class="headLeft"><strong>Other if any </strong></th>
                                    </tr>
                                    <tr>
                                        <td colspan="1" id="tdOtherMPF"></td>
                                        <td colspan="2" id="tdOtherMPFData"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Community based organizations</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th class="headLeft"><strong>Women SHG</strong></th>
                                        <th class="headLeft"><strong>Women Farmers Groups</strong></th>
                                        <th class="headLeft"><strong>Adolescent Girls Group</strong></th>
                                        <th class="headLeft"><strong>Joint Liability Group</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdWSHG"></td>
                                        <td id="tdWFG"></td>
                                        <td id="tdAGF"></td>
                                        <td id="tdJLG"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>Other If any</strong></th>
                                        <th class="headLeft"><strong>Detail of Fedration if any</strong></th>
                                        <th class="headLeft"><strong>Nari Sangh</strong></th>
                                        <th class="headLeft"></th>
                                    </tr>
                                    <tr>
                                        <td id="tdOIF"></td>
                                        <td id="tdDFIA"></td>
                                        <td id="tdNarisingh"></td>
                                        <td></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Work Experience</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <th class="headLeft"><strong>Promotion of Farmers Producer Company (FPC)</strong></th>
                                        <th class="headLeft"><strong>No. of FPC</strong></th>
                                        <th class="headLeft"><strong>Associates</strong></th>
                                        <th class="headLeft"><strong>Details</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdPFPC"></td>
                                        <td id="tdPFPCNo"></td>
                                        <td id="tdPFPCAss"></td>
                                        <td id="tdPFPCDeta"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>Women Farmers, Agriculture, Climate Change and Gender etc (if any)</strong></th>
                                        <th class="headLeft"><strong>How many years</strong></th>
                                        <th class="headLeft"><strong>Associates</strong></th>
                                        <th class="headLeft"><strong>Details</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdWFAC"></td>
                                        <td id="tdWFACNo"></td>
                                        <td id="tdWFACAss"></td>
                                        <td id="tdWFACDeta"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>Experience in implementing IGP/Entrepreneurships</strong></th>
                                        <th class="headLeft"><strong>How many years</strong></th>
                                        <th class="headLeft"><strong>Associates</strong></th>
                                        <th class="headLeft"><strong>Details</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdIGPE"></td>
                                        <td id="tdIGPENo"></td>
                                        <td id="tdIGPEAss"></td>
                                        <td id="tdIGPEDeta"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>Experience in working with PRI, Local Admin and Government Departments</strong></th>
                                        <th class="headLeft"><strong>How many years</strong></th>
                                        <th class="headLeft"><strong>Associates</strong></th>
                                        <th class="headLeft"><strong>Details</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdWRIPL"></td>
                                        <td id="tdWRIPLNo"></td>
                                        <td id="tdWRIPLAss"></td>
                                        <td id="tdWRIPLDeta"></td>
                                    </tr>
                                    <tr>
                                        <th class="headLeft"><strong>Any striking accomplishment by the organization (Unique, something different)</strong></th>
                                        <th class="headLeft"><strong>How many years</strong></th>
                                        <th class="headLeft"><strong>Associates</strong></th>
                                        <th class="headLeft"><strong>Details</strong></th>
                                    </tr>
                                    <tr>
                                        <td id="tdASAO"></td>
                                        <td id="tdASAONo"></td>
                                        <td id="tdASAOAss"></td>
                                        <td id="tdASAODeta"></td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" class="headLeft"><strong>Your Logo</strong></th>
                                        <td colspan="3">
                                            <img src="" id="imgpreview" title="Logo" height="100" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:CheckBox ID="cbdeclare" runat="server" Text="I hereby declare that the above information is correct." />
                                </div>
                            </div>
                        </div>
                        <div class="box-footer clearfix">
                            <a onclick="printDiv('printableArea')" class="btn btn-info">Print</a>
                            <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" ValidationGroup="Decleration" Text="Save" OnClick="btnSubmit_Click" />
                            <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">Close</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </form>
    <link href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.css" rel="stylesheet" />
    <script src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript">
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
            debugger;
            $(this).datepicker({
                autoclose: true
            });
        });

        function showpreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgpreview').css('visibility', 'visible');
                    $('#imgpreview').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        $(".custom-file-input").on("change", function () {
            ////debugger;
            var fileName = $(this).val().split("\\").pop();
            $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
        });

        $(document).ready(function () {
            $("#liCSO").addClass("active");

            document.getElementById('dvPANno').style.display = "none";
            document.getElementById('dvTANno').style.display = "none";
            document.getElementById('dv12Ano').style.display = "none";
            document.getElementById('dvGSTno').style.display = "none";
            document.getElementById('dv80Gno').style.display = "none";
            document.getElementById('ContentPlaceHolder1_pnlNGO').style.display = "none";
            document.getElementById('ContentPlaceHolder1_pnlFocus').style.display = "none";
            document.getElementById('dvFPCPromotion').style.display = "none";
            document.getElementById('dvWFACG').style.display = "none";
            document.getElementById('dvIGPE').style.display = "none";
            document.getElementById('dvWPRIL').style.display = "none";
            document.getElementById('dvASCO').style.display = "none";
            document.getElementById('dvOtherAct').style.display = "none";
            $("#<%=Button1.ClientID%>").prop('disabled', true);
            ////debugger;
        });

        $("#ContentPlaceHolder1_lnkAddFilter").click(function (e) {
            //debugger;
            var id = $("#<%=hiddenDivRowId.ClientID %>").val();
            e.preventDefault();
            $("#dynamicNGO").append('<div class="row" id="NGO' + id + '"><div class="col-md-3 form-group"><label>NGO Name</label><input type="text" id="txtNGOName' + id + '" oninput="SplCharCheck2(this)" onblur="GetFilterData()" class="form-control" /></div><div class="col-md-3 form-group"><label>Date of Registration</label> <div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input id="txtNGODate' + id + '" onblur="GetFilterData()" Class="form-control pull-right datePicker" placeholder="dd-MM-yyyy" /></div></div><div class="col-md-3 form-group"><label>Date of Expiry(if Any)</label><div class="input-group date"><div class="input-group-addon"><i class="fa fa-calendar"></i></div><input id="txtNGOExpiry' + id + '" onblur="GetFilterData()" Class="form-control pull-right datePicker" placeholder="dd-MM-yyyy" /></div></div><div class="col-md-1 form-group"><br><br><a onclick = "RemoveCurrentDiv(&apos;#NGO' + id + '&apos;,&apos;' + (parseInt(id) - 1) + '&apos;);" style="color:red"><i class="fa fa-remove"></i></a></div></div>');
            id++;
            $("#<%=hiddenDivRowId.ClientID %>").val(id);
            console.log(id);
            GetFilterData();
            return false;
        });

        $("#ContentPlaceHolder1_lblFocus").click(function (e) {
            //debugger;
            var id = $("#<%=hfFocuscount.ClientID %>").val();
            e.preventDefault();
            $("#dynamicprogrammatic").append('<div id="dvfocus' + id + '"><div class="col-md-3 form-group" ><input type ="text" id ="txtprogrammatic' + id + '" onblur ="GetFocusData()" oninput="SplCharCheck2(this)" class= "form-control" /></div><div class="col-md-1 form-group"><a onclick = "RemoveFocusDiv(&apos;#dvfocus' + id + '&apos;);" style="color:red"><i class="fa fa-remove"></i></a></div></div>');
            id++;
            $("#<%=hfFocuscount.ClientID %>").val(id);
            console.log(id);
            GetFocusData();
            return false;
        });

        function GetFilterData() {
            debugger;
        
            var DataCount = $("#<%=hiddenDivRowId.ClientID %>").val();
            var Data = $("#<%=txtNGOName0.ClientID%>").val() + ':' + $("#<%=txtNGODate0.ClientID%>").val() + ':' + $("#txtNGOExpiry0").val();

            for (var i = 1; i < DataCount; i++) {
                var txtNGOName = "txtNGOName" + i;
                var txtNGODate = "txtNGODate" + i;
                var txtNGOExpiry = "txtNGOExpiry" + i;
                if ($('#' + txtNGOName).val() != undefined && $('#' + txtNGODate).val() != undefined && $('#' + txtNGOExpiry).val() != undefined) {
                    if ($('#' + txtNGOName).val() != '' && $('#' + txtNGODate).val() != '' && $('#' + txtNGOExpiry).val() != '') {
                        if (Data != "") {
                            Data += '$' + $('#' + txtNGOName).val() + ':' + $('#' + txtNGODate).val() + ':' + $('#' + txtNGOExpiry).val();
                        }
                        else {
                            Data += $('#' + txtNGOName).val() + ':' + $('#' + txtNGODate).val() + ':' + $('#' + txtNGOExpiry).val();
                        }
                    }
                }
            }

            $("#<%=hiddenDataArrayId.ClientID %>").val(Data);
            console.log($("#<%=hiddenDataArrayId.ClientID %>").val());
        }

        function GetFocusData() {
            var DataCount = $("#<%=hfFocuscount.ClientID %>").val();
            var Data = $("#<%=txtprogrammatic0.ClientID%>").val();

            for (var i = 1; i < DataCount; i++) {
                var txtprogrammatic = "txtprogrammatic" + i;
                if ($('#' + txtprogrammatic).val() != undefined) {
                    if ($('#' + txtprogrammatic).val() != '') {
                        if (Data != "") {
                            Data += ',' + $('#' + txtprogrammatic).val();
                        }
                        else {
                            Data += $('#' + txtprogrammatic).val();
                        }
                    }
                }
            }

            $("#<%=hfFocusData.ClientID %>").val(Data);
            console.log($("#<%=hfFocusData.ClientID %>").val());
        }
        function RemoveCurrentDiv(div) {
            ////debugger;
            $(div).remove();
            GetFilterData();
            return false;
        };

        function RemoveFocusDiv(div) {
            ////debugger;
            $(div).remove();
            GetFilterData();
            return false;
        };
        $('#<%=rblPAN.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rblPAN.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvPANno').style.display = "block";
            } else {
                document.getElementById('dvPANno').style.display = "none";
            }
        });

        $('#<%=rblTAN.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rblTAN.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvTANno').style.display = "block";
            } else {
                document.getElementById('dvTANno').style.display = "none";
            }
        });
        $('#<%=rbl12A.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rbl12A.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dv12Ano').style.display = "block";
            } else {
                document.getElementById('dv12Ano').style.display = "none";
            }
        });
        $('#<%=rbl80G.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rbl80G.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dv80Gno').style.display = "block";
            } else {
                document.getElementById('dv80Gno').style.display = "none";
            }
        });
        $('#<%=rblGST.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rblGST.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvGSTno').style.display = "block";
            } else {
                document.getElementById('dvGSTno').style.display = "none";
            }
        });
        $('#<%=rblNGO.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rblNGO.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('ContentPlaceHolder1_pnlNGO').style.display = "block";
            } else {
                document.getElementById('ContentPlaceHolder1_pnlNGO').style.display = "none";
            }
        });
        $('#<%=rblOA.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rblOA.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('ContentPlaceHolder1_pnlFocus').style.display = "block";
            } else {
                document.getElementById('ContentPlaceHolder1_pnlFocus').style.display = "none";
            }
        });
        $('#<%=rblFPCPromotion.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rblFPCPromotion.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvFPCPromotion').style.display = "block";
            } else {
                document.getElementById('dvFPCPromotion').style.display = "none";
            }
        });
        $('#<%=rblWFACG.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rblWFACG.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvWFACG').style.display = "block";
            } else {
                document.getElementById('dvWFACG').style.display = "none";
            }
        });
        $('#<%=rblIGPE.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rblIGPE.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvIGPE').style.display = "block";
            } else {
                document.getElementById('dvIGPE').style.display = "none";
            }
        });
        $('#<%=rblWPRIL.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rblWPRIL.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvWPRIL').style.display = "block";
            } else {
                document.getElementById('dvWPRIL').style.display = "none";
            }
        });
        $('#<%=rblASCO.ClientID %>').change(function () {
            //debugger;
            var ddl = $("#<%= rblASCO.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvASCO').style.display = "block";
            } else {
                document.getElementById('dvASCO').style.display = "none";
            }
        });

        $('#<%=ddlSocietyAct.ClientID %>').change(function () {
            debugger;
            var ddl = $("#<%= ddlSocietyAct.ClientID %> option:selected").text();
            if (ddl == 'Other') {
                document.getElementById('dvOtherAct').style.display = "block";
            } else {
                document.getElementById('dvOtherAct').style.display = "none";
            }
        });

        function ValidateOtherAct(source, arguments) {
            //debugger;
            var txt = document.getElementById('<%=txtOtherAct.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=ddlSocietyAct.ClientID %> option:selected").text();

            if (ddl == 'Other') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidatePANNo(source, arguments) {
            //debugger;
            var txt = document.getElementById('<%=txtPanNo.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
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
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
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
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
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
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblTAN.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function Validate12ANo(source, arguments) {
            //debugger;
            var txt = document.getElementById('<%=txt12ANo.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rbl12A.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function Validate12ADate(source, arguments) {
            //debugger;
            var txt = document.getElementById('<%=txt12ADate.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rbl12A.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function Validate80GNo(source, arguments) {
            //debugger;
            var txt = document.getElementById('<%=txt80GNo.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rbl80G.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function Validate80GDate(source, arguments) {
            //debugger;
            var txt = document.getElementById('<%=txt80GDate.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rbl80G.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidateGSTNo(source, arguments) {
            //debugger;
            var txt = document.getElementById('<%=txtGSTNo.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
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
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblGST.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidatetxtNGOName0(source, arguments) {
            var txt = document.getElementById('<%=txtNGOName0.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblNGO.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidatetxtNGODate0(source, arguments) {
            var txt = document.getElementById('<%=txtNGODate0.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblNGO.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function validatetxtprogrammatic0(source, arguments) {
            var txt = document.getElementById('<%=txtprogrammatic0.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblOA.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        $('#<%=cbdeclare.ClientID%>').click(function () {
            debugger;
            var thisCheck = $(this);
            if (this.checked) {
                $("#<%=Button1.ClientID%>").prop('disabled', false);
            }
            else {
                $("#<%=Button1.ClientID%>").prop('disabled', true);
            }
        });

        function ValidatePromotion1(source, arguments) {
            var txt = document.getElementById('<%=txtPromotion1.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblFPCPromotion.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidatePromotion2(source, arguments) {
            var txt = document.getElementById('<%=txtPromotion2.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblFPCPromotion.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidateWFACG1(source, arguments) {
            var txt = document.getElementById('<%=txtWFACG1.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblWFACG.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidateWFACG2(source, arguments) {
            var txt = document.getElementById('<%=txtWFACG2.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblWFACG.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidateIGPE1(source, arguments) {
            var txt = document.getElementById('<%=txtIGPE1.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblIGPE.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidateIGPE2(source, arguments) {
            var txt = document.getElementById('<%=txtIGPE2.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblIGPE.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidateWPRIL1(source, arguments) {
            var txt = document.getElementById('<%=txtWPRIL1.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblWPRIL.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidateWPRIL2(source, arguments) {
            var txt = document.getElementById('<%=txtWPRIL2.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblWPRIL.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidateASCO1(source, arguments) {
            var txt = document.getElementById('<%=txtASCO1.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblASCO.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidateASCO2(source, arguments) {
            var txt = document.getElementById('<%=txtASCO2.ClientID%>');
            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%=rblASCO.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function ValidateCSOEmail(source, arguments) {
            //debugger;
            var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            var txt = $("#<%=txtregEmail.ClientID %>").val();
            var Email = txt.split(',');
            for (var i = 0; i < Email.length; i++) {
                if (reg.test(Email[i]) == false) {
                    //alert('Invalid Email Address');
                    arguments.IsValid = false;
                    return false;
                }
                else {
                    arguments.IsValid = true;
                }
            }
        }

        function ValidateCSOEmail2(source, arguments) {
            //debugger;
            var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            var txt = $("#<%=txtcremail.ClientID %>").val();
            if (txt != "") {
                var Email = txt.split(',');
                for (var i = 0; i < Email.length; i++) {
                    if (reg.test(Email[i]) == false) {
                        //alert('Invalid Email Address');
                        arguments.IsValid = false;
                        return false;
                    }
                    else {
                        arguments.IsValid = true;
                    }
                }
            }
        }

        function ValidateCSOContact(source, arguments) {
            //debugger;
            var txt = $("#<%=txtregPhone.ClientID %>").val();
            var Phone = txt.split(',');
            for (var i = 0; i < Phone.length; i++) {
                if (Phone[i].length == 10) {
                    //alert('Invalid Email Address');
                    arguments.IsValid = true;
                }
                else {
                    arguments.IsValid = false;
                    return false;
                }
            }
        }

        function ValidateCSOContact2(source, arguments) {
            //debugger;
            var txt = $("#<%=txtcrPhone.ClientID %>").val();
            if (txt != "") {
                var Phone = txt.split(',');
                for (var i = 0; i < Phone.length; i++) {
                    if (Phone[i].length == 10) {
                        //alert('Invalid Email Address');
                        arguments.IsValid = true;
                    }
                    else {
                        arguments.IsValid = false;
                        return false;
                    }
                }
            }
        }

        $("#btnPreview").click(function () {
            //debugger;
            if (typeof (Page_ClientValidate) == 'function') {
                //debugger;
                Page_ClientValidate("PreviewCheck");
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
            //debugger;
            $("#pvDate").html(new Date().toLocaleDateString());
            $("#tdCSO").html($("#<%=txtCso.ClientID%>").val());
            $("#tdState").html($("#<%=ddlStates.ClientID%> option:selected").text());
            $("#tdDistrict").html($("#<%=ddlDisrtict.ClientID%> option:selected").text());
            $("#tdBlock").html($("#<%=ddlBlocks.ClientID%> option:selected").text());
            $("#tdregaddr").html($("#<%=txtregaddr.ClientID%>").val());
            $("#tdregphone").html($("#<%=txtregPhone.ClientID%>").val());
            $("#tdregemail").html($("#<%=txtregEmail.ClientID%>").val());
            $("#tdregwebsite").html($("#<%=txtregwebsite.ClientID%>").val());
            $("#tdcraddr").html($("#<%=txtcraddr.ClientID%>").val());
            $("#tdcrphone").html($("#<%=txtcrPhone.ClientID%>").val());
            $("#tdcremail").html($("#<%=txtcremail.ClientID%>").val());
            ////$("#tdcrwebsite").html($("#<txtcrwebsite.ClientID%>").val());
            $("#tdconname").html($("#<%=txtcontname.ClientID%>").val());
            $("#tdconaddr").html($("#<%=txtcontAddr.ClientID%>").val());
            $("#tdconphone").html($("#<%=txtcontphone.ClientID%>").val());
            $("#tdconemail").html($("#<%=txtcontemail.ClientID%>").val());
            ////$("#tdconwebsite").html($("#<txtcontwebsite.ClientID%>").val());

            $("#tdregno").html($("#<%=txtregno.ClientID%>").val());
            $("#tdregdate").html($("#<%=txtregdate.ClientID%>").val());
            $("#tdregexpiry").html($("#<%=txtregExpire.ClientID%>").val());
            $("#tdregsocial").html($("#<%=ddlSocietyAct.ClientID%> option:selected").text());
            if ($("#<%=ddlSocietyAct.ClientID%> option:selected").text() == "Other") {
                $("#tdregsocial").html($("#<%=txtFCRAregno.ClientID%>").val());
            }
            $("#tdfcraregno").html($("#<%=txtFCRAregno.ClientID%>").val());
            $("#tdfcraregdate").html($("#<%=txtFCRAregno.ClientID%>").val());
            $("#tdfcraregexpiry").html($("#<%=txtFCRAExpiry.ClientID%>").val());
            $("#tddistPO").html($("#<%=txtdistPO.ClientID%>").val());

            console.log($("#<%=rblPAN.ClientID%> input:checked").val());
            $("#tdPAN").html($("#<%=rblPAN.ClientID%> input:checked").val());
            $("#tdPANNo").html($("#<%=txtPanNo.ClientID%>").val());
            $("#tdPANDate").html($("#<%=txtPanDate.ClientID%>").val());
            $("#tdPANExpiry").html($("#<%=txtPanExpiry.ClientID%>").val());
            $("#tdTAN").html($("#<%=rblTAN.ClientID%> input:checked").val());
            $("#tdTANNo").html($("#<%=txtTanNo.ClientID%>").val());
            $("#tdTANDate").html($("#<%=txtTanDate.ClientID%>").val());
            $("#tdTANExpiry").html($("#<%=txtTanExpiry.ClientID%>").val());
            $("#td12A").html($("#<%=rbl12A.ClientID%> input:checked").val());
            $("#td12ANo").html($("#<%=txt12ANo.ClientID%>").val());
            $("#td12ADate").html($("#<%=txt12ADate.ClientID%>").val());
            $("#td12AExpiry").html($("#<%=txt12AExpiry.ClientID%>").val());
            $("#td80G").html($("#<%=rbl80G.ClientID%> input:checked").val());
            $("#td80GNo").html($("#<%=txt80GNo.ClientID%>").val());
            $("#td80GDate").html($("#<%=txt80GDate.ClientID%>").val());
            $("#td80GExpiry").html($("#<%=txt80GExpiry.ClientID%>").val());
            $("#tdGST").html($("#<%=rblGST.ClientID%> input:checked").val());
            $("#tdGSTNo").html($("#<%=txtGSTNo.ClientID%>").val());
            $("#tdGSTDate").html($("#<%=txtGSTDate.ClientID%>").val());
            $("#tdGSTExpiry").html($("#<%=txtGSTExpiry.ClientID%>").val());
            //debugger;
            var NGOdata = $("#<%=hiddenDataArrayId.ClientID%>").val();
            var elements = document.getElementsByClassName('previewrow');
            while (elements.length > 0) {
                elements[0].parentNode.removeChild(elements[0]);
            }
            var splitdata = NGOdata.split('$');
            var columns = "";
            if ($("#<%=rblNGO.ClientID %> input:checked").val() == "Yes") {
                for (var i = 0; i < splitdata.length; i++) {
                    var values = splitdata[i].split(":");
                    console.log(values);
                    if (i == 0) {
                        columns += "<tr class='previewrow'><td rowspan='" + $("#<%=hiddenDivRowId.ClientID%>").val() + "'>" + $("#<%=rblNGO.ClientID %> input:checked").val() + "</td><td>" + values[0] + "</td><td>" + values[1] + "</td><td>" + values[2] + "</td></tr>";
                    }
                    else {
                        columns += "<tr class='previewrow'><td>" + values[0] + "</td><td>" + values[1] + "</td><td>" + values[2] + "</td></tr>";
                    }
                }
            }
            else {
                columns += "<tr class='previewrow'><td>" + $("#<%=rblNGO.ClientID %> input:checked").val() + "</td><td></td><td></td><td></td></tr>";
            }
            $("#tbldynamic").append(columns);
            $("#tdVision").html($("#<%=txtOV.ClientID%>").val());
            $("#tdMission").html($("#<%=txtOM.ClientID%>").val());
            $("#tdProject").html($("#<%=txtOC.ClientID%>").val());
            $("#tdCommunity").html($("#<%=txtTC.ClientID%>").val());

            $("#tdAgriculture").html($("#<%=rblAD.ClientID%> input:checked").val());
            $("#tdWEG").html($("#<%=rblWEG.ClientID%> input:checked").val());
            $("#tdEducation").html($("#<%=rblED.ClientID%> input:checked").val());
            $("#tdHealth").html($("#<%=rblHT.ClientID%> input:checked").val());
            $("#tdWAS").html($("#<%=rblWS.ClientID%> input:checked").val());
            $("#tdSkill").html($("#<%=rblSD.ClientID%> input:checked").val());
            $("#tdOtherMPF").html($("#<%=rblOA.ClientID%> input:checked").val());
            $("#tdOtherMPFData").html($("#<%=hfFocusData.ClientID%>").val());

            $("#tdWSHG").html($("#<%=txtWSHG.ClientID%>").val());
            $("#tdWFG").html($("#<%=txtWFG.ClientID%>").val());
            $("#tdAGF").html($("#<%=txtAGG.ClientID%>").val());
            $("#tdJLG").html($("#<%=txtJLG.ClientID%>").val());
            $("#tdOIF").html($("#<%=txtOIF.ClientID%>").val());
            $("#tdDFIA").html($("#<%=txtDFA.ClientID%>").val());
            $("#tdNarisingh").html($("#<%=TXTNariSingh.ClientID%>").val());
            $("#tdPFPC").html($("#<%=rblFPCPromotion.ClientID%> input:checked").val());

            var fp = $("#<%=rblFPCPromotion.ClientID%> input:checked").val();
            if (fp == 'Yes') {
                $("#tdPFPCNo").html($("#<%=txtPromotion1.ClientID%>").val());
                $("#tdPFPCAss").html($("#<%=txtPromotion2.ClientID%>").val());
                $("#tdPFPCDeta").html($("#<%=txtPromotion3.ClientID%>").val());
            }
            else {
                $("#tdPFPCNo").html("");
                $("#tdPFPCAss").html("");
                $("#tdPFPCDeta").html("");
            }

            $("#tdWFAC").html($("#<%=rblWFACG.ClientID%> input:checked").val());
            if ($("#<%=rblWFACG.ClientID%> input:checked").val() == "Yes") {
                $("#tdWFACNo").html($("#<%=txtWFACG1.ClientID%>").val());
                $("#tdWFACAss").html($("#<%=txtWFACG2.ClientID%>").val());
                $("#tdWFACDeta").html($("#<%=txtWFACG3.ClientID%>").val());
            }
            else {
                $("#tdWFACNo").html("");
                $("#tdWFACAss").html("");
                $("#tdWFACDeta").html("");
            }
            $("#tdIGPE").html($("#<%=rblIGPE.ClientID%> input:checked").val());
            if ($("#<%=rblIGPE.ClientID%> input:checked").val() == "Yes") {
                $("#tdIGPENo").html($("#<%=txtIGPE1.ClientID%>").val());
                $("#tdIGPEAss").html($("#<%=txtIGPE2.ClientID%>").val());
                $("#tdIGPEDeta").html($("#<%=txtIGPE3.ClientID%>").val());
            }
            else {
                $("#tdIGPENo").html("");
                $("#tdIGPEAss").html("");
                $("#tdIGPEDeta").html("");
            }
            $("#tdWRIPL").html($("#<%=rblWPRIL.ClientID%> input:checked").val());
            if ($("#<%=rblWPRIL.ClientID%> input:checked").val() == "Yes") {
                //debugger;
                $("#tdWRIPLNo").html($("#<%=txtWPRIL1.ClientID%>").val());
                $("#tdWRIPLAss").html($("#<%=txtWPRIL2.ClientID%>").val());
                $("#tdWRIPLDeta").html($("#<%=txtWPRIL3.ClientID%>").val());
            }
            else {
                $("#tdWRIPLNo").html("");
                $("#tdWRIPLAss").html("");
                $("#tdWRIPLDeta").html("");
            }

            $("#tdASAO").html($("#<%=rblASCO.ClientID%> input:checked").val());
            if ($("#<%=rblASCO.ClientID%> input:checked").val() == "Yes") {
                $("#tdASAONo").html($("#<%=txtASCO1.ClientID%>").val());
                $("#tdASAOAss").html($("#<%=txtASCO2.ClientID%>").val());
                $("#tdASAODeta").html($("#<%=txtASCO3.ClientID%>").val());
            }
            else {
                $("#tdASAONo").html("");
                $("#tdASAOAss").html("");
                $("#tdASAODeta").html("");
            }
            $('#PreviewPopup').modal('show');
        }
    </script>
</asp:Content>

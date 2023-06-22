<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="AddWFG.aspx.cs" Inherits="CF.AddWFG" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add WFG</title>
    <style>
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
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "WFGInfo.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
        }

        function validateEmail(emailField) {
            //debugger;
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm1" runat="server"></asp:ScriptManager>
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Add WFG</h3>
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
                            <div class="row" id="dvCSO" runat="server">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblCSO" runat="server" Text="Select CSO:"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlCSO" CssClass="form-control" OnSelectedIndexChanged="ddlCso_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select CSO" ControlToValidate="ddlCSO" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="Div1" runat="server">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label3" runat="server" Text="State:"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="dvDistrict" runat="server">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label1" runat="server" Text="District:"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="dvBlock" runat="server">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label2" runat="server" Text="Block:"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlBlock" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblVillage" runat="server" Text="Select Village:"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlVillage" CssClass="form-control" OnSelectedIndexChanged="ddlVillage_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select Village" ControlToValidate="ddlVillage" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="DivPC" runat="server">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblGM" runat="server" Text="Gram Panchayat:"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:TextBox runat="server" ID="txtGramPanchayat" ReadOnly="true" CssClass="form-control"></asp:TextBox>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label4" runat="server" Text="Select Hamlet (if Any):"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlHamlet" CssClass="form-control">
                                            <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label ID="lblNameofWFG" runat="server" Text="Name of Women Farmers Group (WFG):"></asp:Label><b style="color: red"> *</b>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:TextBox ID="txtNameofWFG" runat="server" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Name of Women Farmers Group (WFG)" ControlToValidate="txtNameofWFG" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label ID="lblNoofMembers" runat="server" Text="Total No. of members in WFG:"></asp:Label><b style="color: red"> *</b>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:TextBox ID="txtNoofMembers" runat="server" oninput="NumberCheck(this)" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter No. Of members in WFG" ControlToValidate="txtNoofMembers" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <asp:Label ID="lblSocialCaegory" runat="server" Text="Social Category:"></asp:Label><b style="color: red"> *</b>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlSocialCaegory0" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select Social Category" ControlToValidate="ddlSocialCaegory0" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <asp:Panel runat="server" GroupingText="Bank Details">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label5" runat="server" Text="Name of Bank"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:TextBox ID="txtBank" runat="server" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Name of Bank" ControlToValidate="txtBank" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label8" runat="server" Text="Account Holder Name"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:TextBox ID="txtBankHolder" runat="server" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Account Holder Name" ControlToValidate="txtBankHolder" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label6" runat="server" Text="Bank Account Number"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:TextBox ID="txtACCNo" runat="server" oninput="NumberCheck(this)" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Bank Account Number" ControlToValidate="txtACCNo" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label7" runat="server" Text="Bank IFSC Code"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:TextBox ID="txtIFSC" runat="server" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Bank IFSC Code" ControlToValidate="txtIFSC" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" GroupingText="President Details">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="lblPresident" runat="server" Text="Name of President of the group"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:TextBox ID="txtPresident" runat="server" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Name of President of the group" ControlToValidate="txtPresident" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group" style="margin-bottom: 0px;">
                                    <asp:Label ID="lblPresidentContact" runat="server" Text="Contact No. of the president:"></asp:Label><b style="color: red"> *</b>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:TextBox ID="txtPresidentContact" runat="server" MaxLength="10" oninput="NumberCheck(this)" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Contact No.of the president" ControlToValidate="txtPresidentContact" SetFocusOnError="true" Display="Dynamic" ValidationGroup="PreviewCheck"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" Display="Dynamic" ControlToValidate="txtPresidentContact" ErrorMessage="Enter Valid Mobile Number" ValidationExpression="^([0-9]{10})$" CssClass="text-danger" SetFocusOnError="true" ValidationGroup="PreviewCheck"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label ID="lblRemarks" runat="server" Text="Remarks:"></asp:Label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:TextBox ID="txtRemarks" TextMode="MultiLine" Rows="3" runat="server" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer clearfix">
                    <a id="btnCancel" runat="server" class="btn btn-danger" href="WFGInfo.aspx">Cancel</a>
                    <button id="btnPreview" class="btn btn-primary" onclick="return false">Preview</button>
                </div>
                <asp:HiddenField runat="server" ID="arrHiddenSCGs" />
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
                                <p class="heading">Woman Farmer Group Details</p>
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
                                        <td class="headLeft" style="width: 50%;"><strong>CSO Name</strong></td>
                                        <td id="tdCSO"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>State</strong></td>
                                        <td id="tdState"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>District</strong></td>
                                        <td id="tdDistrict"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>Block</strong></td>
                                        <td id="tdBlock"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>Village</strong></td>
                                        <td id="tdVillage"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>Gram Panchayat</strong></td>
                                        <td id="tdGP"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>Hamlet</strong></td>
                                        <td id="tdHamlet"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>Group Name</strong></td>
                                        <td id="tdWFG"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>Total Members</strong></td>
                                        <td id="tdMEmbers"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>Social Category</strong></td>
                                        <td id="tdCategory"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">Bank Details</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <td class="headLeft" style="width: 50%;"><strong>Name of Bank</strong></td>
                                        <td id="tdBank"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>Account Holder Name</strong></td>
                                        <td id="tdHolder"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>Bank Account Number </strong></td>
                                        <td id="tdAccNo"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>IFSC Code</strong></td>
                                        <td id="tdIFSC"></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="mt-3" style="text-align: left">
                                <p class="heading">President Details</p>
                            </div>
                            <div>
                                <table class="Preview" border="1" rules="all">
                                    <tr>
                                        <td class="headLeft" style="width: 50%;"><strong>Name of President of the group</strong></td>
                                        <td id="tdPresident"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>Contact No. of the president</strong></td>
                                        <td id="tdPresidentContact"></td>
                                    </tr>
                                    <tr>
                                        <td class="headLeft"><strong>Remarks</strong></td>
                                        <td id="tdRemarks"></td>
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
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Add" OnClick="btnSubmit_Click" />
                            <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">Close</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#liWFG").addClass("active");

                $("#<%=btnSubmit.ClientID%>").prop('disabled', true);
            });
            $('#<%=cbdeclare.ClientID%>').click(function () {
                debugger;
                var thisCheck = $(this);
                if (this.checked) {
                    $("#<%=btnSubmit.ClientID%>").prop('disabled', false);
                }
                else {
                    $("#<%=btnSubmit.ClientID%>").prop('disabled', true);
                }
            });
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
                $("#pvDate").html(new Date().toLocaleDateString());
                $("#tdWFG").html($("#<%=txtNameofWFG.ClientID%>").val());
                $("#tdCSO").html($("#<%=ddlCSO.ClientID%> option:selected").text());
                $("#tdState").html($("#<%=ddlState.ClientID%> option:selected").text());
                $("#tdDistrict").html($("#<%=ddlDistrict.ClientID%> option:selected").text());
                $("#tdBlock").html($("#<%=ddlBlock.ClientID%> option:selected").text());
                $("#tdVillage").html($("#<%=ddlVillage.ClientID%> option:selected").text());
                $("#tdGP").html($("#<%=txtGramPanchayat.ClientID%>").val());
                var hamlet = $("#<%=ddlHamlet.ClientID%> option:selected").text();
                if (hamlet == "Select") {
                    hamlet = "";
                }
                $("#tdHamlet").html(hamlet);
                $("#tdWFG").html($("#<%=txtNameofWFG.ClientID%>").val());
                $("#tdMEmbers").html($("#<%=txtNoofMembers.ClientID%>").val());
                $("#tdCategory").html($("#<%=ddlSocialCaegory0.ClientID%> option:selected").text());
                $("#tdBank").html($("#<%=txtBank.ClientID%>").val());
                $("#tdHolder").html($("#<%=txtBankHolder.ClientID%>").val());
                $("#tdAccNo").html($("#<%=txtACCNo.ClientID%>").val());
                $("#tdIFSC").html($("#<%=txtIFSC.ClientID%>").val());
                $("#tdPresident").html($("#<%=txtPresident.ClientID%>").val());
                $("#tdPresidentContact").html($("#<%=txtPresidentContact.ClientID%>").val());
                $("#tdRemarks").html($("#<%=txtRemarks.ClientID%>").val());
                $('#PreviewPopup').modal('show');

            }

        </script>
        <%--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>--%>
        <%-- <script>
            $("#ContentPlaceHolder1_lnkSCGs").click(function (e) {
                debugger;
                if ($("#<%=Hiddencountval.ClientID %>").val() < $("#<%=txtNoofMembers.ClientID %>").val()) {
                    var id = $("#<%=HiddenSCGs.ClientID %>").val();
                    e.preventDefault();
                    $("#ContentPlaceHolder1_pnlSCGs").append('<div class="dlt" id="divSCGs' + id + '"><div class="col-md-3 form-group"><select id="ddlSocialCaegory' + id + '" class="form-control"></select></div><div class="col-md-3 form-group"><input class="form-control" id="txtmembers' + id + '" placeholder="No. of Members" oninput="NumberCheck(this)" onblur="GetSCGs();" type="text" name="textbox" /><a href="#txtmembers0" onclick = "removeSCGsDiv(&apos;#divSCGs' + id + '&apos;,&apos;#txtmembers0&apos;);" style="color:red"><i class="fa fa-remove"></i></a></div></div>');
                    var itm = $("#<%=ddlSocialCaegory0.ClientID %>").html();
                    $("#ddlSocialCaegory" + id).html(itm);
                    id++;
                    $("#<%=HiddenSCGs.ClientID %>").val(id);
                    console.log(id);
                    return false;
                }
                else if ($("#<%=Hiddencountval.ClientID %>").val() == $("#<%=txtNoofMembers.ClientID %>").val()) {
                    $("#<%=lblcounmatch.ClientID %>").html("Count of members are matched");
                }
                else {
                    $("#<%=lblcounmatch.ClientID %>").html("Count of members are more in the category");
                }
            });

        function removeSCGsDiv(id, id1) {
            debugger;
            $(id).remove();
            window.location.href = "AddWFG.aspx#" + id1;
            GetSCGs();
            return false;
        };

        function GetSCGs() {
            debugger;
            var SCGsCount = $("#<%=HiddenSCGs.ClientID %>").val();
            var SCGsData = $("#<%=ddlSocialCaegory0.ClientID %>").val() + ':' + $("#<%=txtmembers0.ClientID %>").val();
            var totalcount = $("#<%=txtmembers0.ClientID %>").val();

            for (var i = 1; i < SCGsCount; i++) {
                var ddlSCGsNameId = "ddlSocialCaegory" + i;
                var txtmembersId = "txtmembers" + i;
                totalcount += $('#' + txtmembersId).val();
                if ($('#' + ddlSCGsNameId).val() != 'Select' && $('#' + txtmembersId).val() != undefined) {
                    if (SCGsData != "") {
                        SCGsData += ',' + $('#' + ddlSCGsNameId).val() + ':' + $('#' + txtmembersId).val();
                    }
                    else {
                        SCGsData += $('#' + ddlSCGsNameId).val() + ':' + $('#' + txtmembersId).val();
                    }
                }
            }

            $("#<%=Hiddencountval.ClientID %>").val(totalcount);

            if ($("#<%=Hiddencountval.ClientID %>").val() < $("#<%=txtNoofMembers.ClientID %>").val()) {
                $("#<%=lblcounmatch.ClientID %>").html("Count of members are Less in Category");
                $("#<%=lblcounmatch.ClientID %>").addClass("text-success");
            }
            else if ($("#<%=Hiddencountval.ClientID %>").val() == $("#<%=txtNoofMembers.ClientID %>").val()) {
                $("#<%=lblcounmatch.ClientID %>").html("Count of members are matched");
                $("#<%=lblcounmatch.ClientID %>").addClass("text-success");
            }
            else {
                $("#<%=lblcounmatch.ClientID %>").html("Count of members are more in the category");
                $("#<%=lblcounmatch.ClientID %>").addClass("text-danger");
            }

        $("#<%=arrHiddenSCGs.ClientID %>").val(SCGsData);
            console.log('SCGs Values');
            console.log($("#<%=arrHiddenSCGs.ClientID %>").val());
        }
        </script>--%>
    </form>
    <script>

</script>
</asp:Content>

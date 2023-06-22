<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="AddCSOCapacity.aspx.cs" Inherits="CF.AddCSOCapacity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add CSO Capacity</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.css" rel="stylesheet" />
    <script>
        function ShowAlert(msg, type) {
            //debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "CsoCapacityInfo.aspx";
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

        function funNumber(a) {
            let value = a.value;
            let numbers = value.replace(/[^0-9]/g, "");
            a.value = numbers;
            if (numbers <= 5 || numbers >= 0) {
                a.value = numbers.substring(0, 2);
                return true;
            }
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
    <section class="content">
        <form id="form1" runat="server">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Add CSO Capacity</h3>
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <asp:ScriptManager runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="lblCSO" runat="server" Text="Select CSO"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlCSO" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlCSO_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select CSO" ControlToValidate="ddlCSO" SetFocusOnError="true" InitialValue="Select" Display="Dynamic"></asp:RequiredFieldValidator>
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
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label runat="server" Text="Year"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtYear" CssClass="form-control YearPicker" AutoPostBack="true" OnTextChanged="txtYear_TextChanged"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Year" ControlToValidate="txtYear" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label runat="server" Text="Quarter"></asp:Label>
                                        <asp:DropDownList runat="server" ID="ddlQuarter" CssClass="form-control">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" InitialValue="select" CssClass="text-danger" ErrorMessage="Please Select Quarter" ControlToValidate="ddlQuarter" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Long Term Visioning Capacity"></asp:Label>
                                <asp:TextBox runat="server" ID="txtLTVC" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Long Term Visioning Capacity" ControlToValidate="txtLTVC" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Strategic Planning and Implementation Capacity"></asp:Label>
                                <asp:TextBox runat="server" ID="txtSPIC" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Strategic Planning and Implementation Capacity" ControlToValidate="txtSPIC" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Fund Raising Skills"></asp:Label>
                                <asp:TextBox runat="server" ID="txtFRS" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Fund raising skills" ControlToValidate="txtFRS" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Senior Leadership Quality"></asp:Label>
                                <asp:TextBox runat="server" ID="txtSLQ" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Senior Leadership Quality" ControlToValidate="txtSLQ" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Leadership Quality-Networking & Advocacy"></asp:Label>
                                <asp:TextBox runat="server" ID="txtLQNA" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Leadership Quality-Networking & Advocacy" ControlToValidate="txtLQNA" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Program Management"></asp:Label>
                                <asp:TextBox runat="server" ID="txtPM" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Program Management" ControlToValidate="txtPM" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Financial Management"></asp:Label>
                                <asp:TextBox runat="server" ID="txtFM" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Financial Management" ControlToValidate="txtFM" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <asp:Panel runat="server" GroupingText="Thematic Expertise Area">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="FPC Formation and Support"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtTEAFS" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter FPC Formation and Support" ControlToValidate="txtTEAFS" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Women Empowerment"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtTEAE" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Women Empowerment" ControlToValidate="txtTEAE" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Sustainable Agriculture Practice"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtTESAP" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Sustainable Agriculture Practice" ControlToValidate="txtTESAP" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Usage of digital program management and learning systems"></asp:Label>
                                <asp:TextBox runat="server" ID="txtUDPMLS" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Usage of digital program management and learning systems" ControlToValidate="txtUDPMLS" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Monitoring and evaluation including documentation and report, database management"></asp:Label>
                                <asp:TextBox runat="server" ID="txtMEIDM" CssClass="form-control" oninput="funNumber(this)" onchange="calculateQuarterScore();"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Monitoring and evaluation including documentation and report, database management" ControlToValidate="txtMEIDM" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label runat="server" Text="Quarter Score"></asp:Label>
                                <asp:TextBox runat="server" ID="txtScore" CssClass="form-control" oninput="funNumber(this)" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <asp:HiddenField runat="server" ID="hfOverallScore" />
                    <asp:HiddenField runat="server" ID="hfoverallScoreStatus" />
                </div>
                <div class="box-footer clearfix">
                    <a id="btnCancel" runat="server" class="btn btn-danger" href="CSOCapacityInfo.aspx">Cancel</a><%--validationgroup="PreviewCheck"--%>
                    <%--<asp:Button runat="server" id="btnPreview" Text="Preview" class="btn btn-primary" ValidationGroup="PreviewCheck"/>--%>
                    <asp:Button ID="btnsubmit" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="btnsubmit_Click" />
                </div>
            </div>
        </form>
        <script>
            $(document).ready(function () {
                $("#liDataManage").parentsUntil(".sidebar-menu > .treeview-menu").siblings().removeClass('active menu-open').end().addClass('active menu-open');
                $("#liCSOCapacity").addClass("active");
            });
            function pageLoad(sender, args) {
                $(".YearPicker").datepicker({
                    format: " yyyy", // Notice the Extra space at the beginning
                    viewMode: "years",
                    minViewMode: "years",
                    autoclose: true
                });
            };

            $(".YearPicker").datepicker({
                format: " yyyy", // Notice the Extra space at the beginning
                viewMode: "years",
                minViewMode: "years",
                autoclose: true
            });

            $(document).ready(function () {
                calculateQuarterScore();
            })

            function calculateQuarterScore() {
                var LTVC = $('#ContentPlaceHolder1_txtLTVC').val();
                if (LTVC != "") {
                    LTVC = LTVC;
                }
                else {
                    LTVC = 0;
                }

                var SPIC = $('#ContentPlaceHolder1_txtSPIC').val();
                if (SPIC != "") {
                    SPIC = SPIC;
                }
                else {
                    SPIC = 0;
                }

                var FRS = $('#ContentPlaceHolder1_txtFRS').val();
                if (FRS != "") {
                    FRS = FRS;
                }
                else {
                    FRS = 0;
                }

                var SLQ = $('#ContentPlaceHolder1_txtSLQ').val();
                if (SLQ != "") {
                    SLQ = SLQ;
                }
                else {
                    SLQ = 0;
                }

                var LQNA = $('#ContentPlaceHolder1_txtLQNA').val();
                if (LQNA != "") {
                    LQNA = LQNA;
                }
                else {
                    LQNA = 0;
                }

                var PM = $('#ContentPlaceHolder1_txtPM').val();
                if (PM != "") {
                    PM = PM;
                }
                else {
                    PM = 0;
                }

                var FM = $('#ContentPlaceHolder1_txtFM').val();
                if (FM != "") {
                    FM = FM;
                }
                else {
                    FM = 0;
                }

                var TEAFS = $('#ContentPlaceHolder1_txtTEAFS').val();
                if (TEAFS != "") {
                    TEAFS = TEAFS;
                }
                else {
                    TEAFS = 0;
                }

                var TEAE = $('#ContentPlaceHolder1_txtTEAE').val();
                if (TEAE != "") {
                    TEAE = TEAE;
                }
                else {
                    TEAE = 0;
                }

                var TESAP = $('#ContentPlaceHolder1_txtTESAP').val();
                if (TESAP != "") {
                    TESAP = TESAP;
                }
                else {
                    TESAP = 0;
                }

                var UDPMLS = $('#ContentPlaceHolder1_txtUDPMLS').val();
                if (UDPMLS != "") {
                    UDPMLS = UDPMLS;
                }
                else {
                    UDPMLS = 0;
                }

                var MEIDM = $('#ContentPlaceHolder1_txtMEIDM').val();
                if (MEIDM != "") {
                    MEIDM = MEIDM;
                }
                else {
                    MEIDM = 0;
                }

                var overallScore = parseFloat(LTVC) + parseFloat(SPIC) + parseFloat(FRS) + parseFloat(SLQ) + parseFloat(LQNA) + parseFloat(PM) + parseFloat(FM) + parseFloat(TEAFS) + parseFloat(TEAE) + parseFloat(TESAP) + parseFloat(UDPMLS) + parseFloat(MEIDM);

                $('#ContentPlaceHolder1_hfOverallScore').val(overallScore);

                if (overallScore == 0) {
                    $('#ContentPlaceHolder1_txtScore').val("No Change");
                    $('#ContentPlaceHolder1_hfoverallScoreStatus').val("No Change");
                }
                else if (overallScore > 0 && overallScore <= 20) {
                    $('#ContentPlaceHolder1_txtScore').val("Developmental");
                    $('#ContentPlaceHolder1_hfoverallScoreStatus').val("Developmental");
                }
                else if (overallScore >= 21 && overallScore <= 40) {
                    $('#ContentPlaceHolder1_txtScore').val("Transitional");
                    $('#ContentPlaceHolder1_hfoverallScoreStatus').val("Transitional");
                }
                else if (overallScore >= 41) {
                    $('#ContentPlaceHolder1_txtScore').val("Transformational");
                    $('#ContentPlaceHolder1_hfoverallScoreStatus').val("Transformational");
                }
            }
        </script>
    </section>
</asp:Content>

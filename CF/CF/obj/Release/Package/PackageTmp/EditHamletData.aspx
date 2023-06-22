<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="EditHamletData.aspx.cs" Inherits="CF.EditHamletData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Edit Hamlet Data</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.css" rel="stylesheet" />
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
                    window.location = "HamletDataInfo.aspx";
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

        function PercentCheck(input) {
            debugger;
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

            if (parseFloat(numbers) > 100) {
                numbers = numbers.substring(0, numbers.length - 1);
            }
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
    <script src="scripts/jquery-3.0.0.js"></script>
    <style>
        .dynamicTB {
            width: 21%;
            margin-right: 15px;
            margin-left: 15px;
            margin-bottom: 15px;
        }

        @media only screen and (max-width: 740px) {
            .dynamicTB {
                width: 91%;
                margin-right: 15px;
                margin-left: 15px;
                margin-bottom: 15px;
            }
        }

        .dynamicTB1 {
            width: 49%;
            margin-right: 15px;
            margin-left: 15px;
            margin-bottom: 15px;
        }

        @media only screen and (max-width: 740px) {
            .dynamicTB1 {
                width: 91%;
                margin-right: 15px;
                margin-left: 15px;
                margin-bottom: 15px;
            }
        }

        .LableSpace, label {
            font-weight: 500 !important;
            margin-right: 40px !important;
            margin-left: 5px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm1" runat="server"></asp:ScriptManager>
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Add Hamlet</h3>
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
                                        <asp:Label ID="Label10" runat="server" Text="Distance of District"></asp:Label>
                                        <asp:TextBox ID="txtdistDistrictdistance" oninput="NumberCheck(this)" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label7" runat="server" Text="Sub District Name"></asp:Label>
                                        <asp:TextBox ID="txtsubdist" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label15" runat="server" Text="Sub District Distance"></asp:Label>
                                        <asp:TextBox ID="txtDistsubdist" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label1" runat="server" Text="Name Of Block"></asp:Label>
                                        <asp:TextBox ID="txtBlock" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label11" runat="server" Text="Distance Of Block"></asp:Label>
                                        <asp:TextBox ID="txtDistBlock" oninput="DecimalCheck(this)" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label4" runat="server" Text="Gram Panchayat Name"></asp:Label>
                                        <asp:TextBox ID="txtGramPanchayat" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label12" runat="server" Text="Gram Panchayat Distance"></asp:Label>
                                        <asp:TextBox ID="txtDistGramPanchayat" oninput="DecimalCheck(this)" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label3" runat="server" Text="Village Name"></asp:Label>
                                        <asp:TextBox ID="txtvillagename" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label9" runat="server" Text="Village Distance"></asp:Label>
                                        <asp:TextBox ID="txtDistvillagename" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label284" runat="server" Text="Name Of Hamlet"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox ID="txtHamlet" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label5" runat="server" Text="Post Office Name"></asp:Label>
                                        <asp:TextBox ID="txtPostoffice" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label13" runat="server" Text="Post Office Distance"></asp:Label>
                                        <asp:TextBox ID="txtDistPostoffice" oninput="DecimalCheck(this)" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label281" runat="server" Text="Pincode"></asp:Label>
                                        <asp:TextBox ID="txtpostpin" runat="server" oninput="NumberCheck(this)" MaxLength="6" MinLength="6" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label6" runat="server" Text="Police Station Name"></asp:Label>
                                        <asp:TextBox ID="txtPoliceStation" runat="server" CssClass="form-control" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label14" runat="server" Text="Police Station Distance"></asp:Label>
                                        <asp:TextBox ID="txtDistPoliceStation" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" ReadOnly="true" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label23" runat="server" Text="Year"></asp:Label>
                                        <asp:TextBox OnTextChanged="txtYear_TextChanged" AutoPostBack="true" ID="txtYear" runat="server" CssClass="form-control YearPicker" oninput="NumberCheck(this)" MaxLength="4" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label39" runat="server" Text="Ranking"></asp:Label>
                                        <asp:TextBox ID="txtRanking" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRanking" ErrorMessage="Enter Ranking" CssClass="text-danger" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Panel ID="Panel1" runat="server" GroupingText="Hamlet Population details">
                        <legend style="font-size: 18px;">No of Households</legend>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>SC</label>
                                    <asp:TextBox runat="server" ID="txtSCHH" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>ST</label>
                                    <asp:TextBox runat="server" ID="txtSTHH" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>OBC</label>
                                    <asp:TextBox runat="server" ID="txtOBCHH" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>General</label>
                                    <asp:TextBox runat="server" ID="txtGenHH" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <%--<div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Minority</label>
                                    <asp:TextBox runat="server" ID="txtMinHH" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                </div>
                            </div>
                        </div>--%>

                        <%--  <legend style="font-size: 18px;">Population Details</legend>--%>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label18" runat="server" Text="Population"></asp:Label>
                                    <asp:TextBox ID="txtPopulation" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label16" runat="server" Text="Male"></asp:Label>
                                    <asp:TextBox ID="txtmalePop" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label19" runat="server" Text="Female"></asp:Label>
                                    <asp:TextBox ID="txtfemalePop" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label20" runat="server" Text="Boys"></asp:Label>
                                    <asp:TextBox ID="txtboyPop" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label21" runat="server" Text="Girls"></asp:Label>
                                    <asp:TextBox ID="txtgirlsPop" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label22" runat="server" Text="Transgender"></asp:Label>
                                    <asp:TextBox ID="txttransgenderPop" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                </div>
                            </div>
                        </div>

                    </asp:Panel>
                    <asp:Panel runat="server" ID="category" GroupingText="Category">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label17" runat="server" Text="SC"></asp:Label>
                                    <asp:TextBox ID="txtsc" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label24" runat="server" Text="ST"></asp:Label>
                                    <asp:TextBox ID="txtst" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <asp:Label ID="Label25" runat="server" Text="OBC"></asp:Label>
                                    <asp:TextBox ID="txtobc" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <asp:Label ID="Label26" runat="server" Text="General"></asp:Label>
                                    <asp:TextBox ID="txtgeneral" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <%--<div class="col-md-2">
                                <div class="form-group">
                                    <asp:Label ID="Label27" runat="server" Text="Minority"></asp:Label>
                                    <asp:TextBox ID="txtminority" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>--%>

                        </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel2" runat="server" GroupingText="Natural Resource Management">
                        <div class="row ">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label28" runat="server" Text="Total Land(in acres)"></asp:Label>
                                    <asp:TextBox ID="txttotalland" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label29" runat="server" Text="Cultivable Land(in acres)"></asp:Label>
                                    <asp:TextBox ID="txtcultiland" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label30" runat="server" Text="Land under ploughing(in acres)"></asp:Label>
                                    <asp:TextBox ID="txtlandplough" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label31" runat="server" Text="Irrigated Land(in acres)"></asp:Label>
                                    <asp:TextBox ID="txtirrgate" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label32" runat="server" Text="Unirrigated Land(in acres)"></asp:Label>
                                    <asp:TextBox ID="txtunirrgate" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label33" runat="server" Text="Land under forest(in acres)"></asp:Label>
                                    <asp:TextBox ID="txtforestland" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label34" runat="server" Text="Waste Land(in acres)"></asp:Label>
                                    <asp:TextBox ID="txtwasteland" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label35" runat="server" Text="Pasture Land(in acres)"></asp:Label>
                                    <asp:TextBox ID="txtpastureland" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label36" runat="server" Text="Other Land(in acres)"></asp:Label>
                                    <asp:TextBox ID="txtotherland" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label38" runat="server" Text="Land upto 1 hectares"></asp:Label>
                                    <asp:TextBox ID="txtlessthanoneland" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label280" runat="server" Text="Land 1 to 2 hectares"></asp:Label>
                                    <asp:TextBox ID="txtonetotwo" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label282" runat="server" Text="Land 2 to 4 hectares"></asp:Label>
                                    <asp:TextBox ID="txt2to4" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label283" runat="server" Text="Land More than 4 hectares"></asp:Label>
                                    <asp:TextBox ID="txtMorethen4" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label37" runat="server" Text="Landless Families"></asp:Label>
                                    <asp:TextBox ID="txtlandless" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="Panel5" runat="server" GroupingText="Fodder availability for animals">
                        <div class="row">

                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label148" runat="server" Text="Jan"></asp:Label>
                                    <asp:TextBox ID="txtJan" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label149" runat="server" Text="Feb"></asp:Label>
                                    <asp:TextBox ID="txtFeb" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label150" runat="server" Text="Mar"></asp:Label>
                                    <asp:TextBox ID="txtMar" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label147" runat="server" Text="Apr"></asp:Label>
                                    <asp:TextBox ID="txtApr" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">

                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label151" runat="server" Text="May"></asp:Label>
                                    <asp:TextBox ID="txtMay" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label152" runat="server" Text="Jun"></asp:Label>
                                    <asp:TextBox ID="txtJun" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label153" runat="server" Text="Jul"></asp:Label>
                                    <asp:TextBox ID="txtJul" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label154" runat="server" Text="Aug"></asp:Label>
                                    <asp:TextBox ID="txtAug" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">

                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label155" runat="server" Text="Sep"></asp:Label>
                                    <asp:TextBox ID="txtSep" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label156" runat="server" Text="Oct"></asp:Label>
                                    <asp:TextBox ID="txtOct" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label157" runat="server" Text="Nov"></asp:Label>
                                    <asp:TextBox ID="txtNov" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label158" runat="server" Text="Dec"></asp:Label>
                                    <asp:TextBox ID="txtDec" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel6" runat="server" GroupingText="Condition of Water availability">
                        <div class="row">

                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="Label159" runat="server" Text="Average water level in village"></asp:Label>
                                    <asp:TextBox ID="txtavgwtrlvl" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label ID="Label160" runat="server" Text="Average water TDS in drinking sources"></asp:Label>
                                    <asp:TextBox ID="txtwtrTDS" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel7" runat="server" GroupingText="Details on water sources">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label161" runat="server" Text="Total sources drinking water source"></asp:Label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label162" runat="server" Text="Public Wells"></asp:Label>
                                    <asp:TextBox ID="txtPublicwalls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label163" runat="server" Text="Private wells"></asp:Label>
                                    <asp:TextBox ID="txtPrivatewalls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label164" runat="server" Text="Public hand pumps"></asp:Label>
                                    <asp:TextBox ID="txtPublichandPumps" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label166" runat="server" Text="Private hand pumps"></asp:Label>
                                    <asp:TextBox ID="txtPrivateHandPumps" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label167" runat="server" Text="Public Taps"></asp:Label>
                                    <asp:TextBox ID="txtPublicTaps" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label168" runat="server" Text="Public Ponds"></asp:Label>
                                    <asp:TextBox ID="txtPublicPonds" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label165" runat="server" Text="Total sources irrigation water source"></asp:Label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label169" runat="server" Text="Canal"></asp:Label>
                                    <asp:TextBox ID="txtCanal" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label170" runat="server" Text="Public tubewell"></asp:Label>
                                    <asp:TextBox ID="txtPublicTubwell" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label171" runat="server" Text="Private tubewell"></asp:Label>
                                    <asp:TextBox ID="txtPrivateTubwell" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label172" runat="server" Text="Diesel pumps"></asp:Label>
                                    <asp:TextBox ID="txtDieselPumps" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel8" runat="server" GroupingText="Working source">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label174" runat="server" Text="Drinking water source"></asp:Label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label175" runat="server" Text="Public Wells"></asp:Label>
                                    <asp:TextBox ID="txtWSPublicWells" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label176" runat="server" Text="Private well"></asp:Label>
                                    <asp:TextBox ID="txtWSPrivateWell" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label177" runat="server" Text="Public hand pumps"></asp:Label>
                                    <asp:TextBox ID="txtWSPublicHandPump" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label178" runat="server" Text="Private hand pumps"></asp:Label>
                                    <asp:TextBox ID="txtWSPrivateHandPump" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label179" runat="server" Text="Public Taps"></asp:Label>
                                    <asp:TextBox ID="txtWSPublicTaps" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label180" runat="server" Text="Public Ponds"></asp:Label>
                                    <asp:TextBox ID="txtWSPublicPonds" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">

                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label181" runat="server" Text="Irrigation water source"></asp:Label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label182" runat="server" Text="Canal"></asp:Label>
                                    <asp:TextBox ID="txtWSCanal" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label183" runat="server" Text="Public tubewell"></asp:Label>
                                    <asp:TextBox ID="txtWSPublicTubWell" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label184" runat="server" Text="Private tubewell"></asp:Label>
                                    <asp:TextBox ID="txtWSPrivateTubwell" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label185" runat="server" Text="Diesel pumps"></asp:Label>
                                    <asp:TextBox ID="txtWSDieselPump" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label186" runat="server" Text="Other - Pumping set"></asp:Label>
                                    <asp:TextBox ID="txtWSOtherPumpset" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel9" runat="server" GroupingText="Condition of Health Centres">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label187" runat="server" Text="Health Centres Availability (Yes/No)"></asp:Label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label188" runat="server" Text="Sub centre/ANM"></asp:Label>
                                    <asp:RadioButtonList runat="server" ID="rblCHCSubcentreorANM" CssClass="LableSpace" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label189" runat="server" Text="PHC"></asp:Label>
                                    <asp:RadioButtonList runat="server" ID="rblCHCPHC" CssClass="LableSpace" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label190" runat="server" Text="CHC"></asp:Label>
                                    <asp:RadioButtonList runat="server" ID="rblCHCCHC" CssClass="LableSpace" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label192" runat="server" Text="Private Clinic"></asp:Label>
                                    <asp:RadioButtonList runat="server" ID="rblCHCPrivateClinic" CssClass="LableSpace" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label193" runat="server" Text="Animal Dispensary"></asp:Label>
                                    <asp:RadioButtonList runat="server" ID="rblCHCAnimalDispensary" CssClass="LableSpace" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label194" runat="server" Text="Volunteer health worker"></asp:Label>
                                    <asp:RadioButtonList runat="server" ID="rblCHCVolunteerhealthworker" CssClass="LableSpace" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label191" runat="server" Text="Quality of services provided by the centre (NA, Bad, Average, Good, Very Good)"></asp:Label>

                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label195" runat="server" Text="Sub centre/ANM"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddlQSSubcentreorANM" CssClass="form-control">
                                        <asp:ListItem Value="NA" Text="NA"></asp:ListItem>
                                        <asp:ListItem Value="Bad" Text="Bad"></asp:ListItem>
                                        <asp:ListItem Value="Average" Text="Average"></asp:ListItem>
                                        <asp:ListItem Value="Good" Text="Good"></asp:ListItem>
                                        <asp:ListItem Value="Very Good" Text="Very Good"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label196" runat="server" Text="PHC"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddlQSPHC" CssClass="form-control">
                                        <asp:ListItem Value="NA" Text="NA"></asp:ListItem>
                                        <asp:ListItem Value="Bad" Text="Bad"></asp:ListItem>
                                        <asp:ListItem Value="Average" Text="Average"></asp:ListItem>
                                        <asp:ListItem Value="Good" Text="Good"></asp:ListItem>
                                        <asp:ListItem Value="Very Good" Text="Very Good"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label197" runat="server" Text="CHC"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddlQSCHC" CssClass="form-control">
                                        <asp:ListItem Value="NA" Text="NA"></asp:ListItem>
                                        <asp:ListItem Value="Bad" Text="Bad"></asp:ListItem>
                                        <asp:ListItem Value="Average" Text="Average"></asp:ListItem>
                                        <asp:ListItem Value="Good" Text="Good"></asp:ListItem>
                                        <asp:ListItem Value="Very Good" Text="Very Good"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label198" runat="server" Text="Private Clinic"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddlQSPrivateClinic" CssClass="form-control">
                                        <asp:ListItem Value="NA" Text="NA"></asp:ListItem>
                                        <asp:ListItem Value="Bad" Text="Bad"></asp:ListItem>
                                        <asp:ListItem Value="Average" Text="Average"></asp:ListItem>
                                        <asp:ListItem Value="Good" Text="Good"></asp:ListItem>
                                        <asp:ListItem Value="Very Good" Text="Very Good"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label199" runat="server" Text="Animal Dispensary"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddlQSAnimalDispensary" CssClass="form-control">
                                        <asp:ListItem Value="NA" Text="NA"></asp:ListItem>
                                        <asp:ListItem Value="Bad" Text="Bad"></asp:ListItem>
                                        <asp:ListItem Value="Average" Text="Average"></asp:ListItem>
                                        <asp:ListItem Value="Good" Text="Good"></asp:ListItem>
                                        <asp:ListItem Value="Very Good" Text="Very Good"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label200" runat="server" Text="Volunteer health worker"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddlQSVolunteerhealthworker" CssClass="form-control">
                                        <asp:ListItem Value="NA" Text="NA"></asp:ListItem>
                                        <asp:ListItem Value="Bad" Text="Bad"></asp:ListItem>
                                        <asp:ListItem Value="Average" Text="Average"></asp:ListItem>
                                        <asp:ListItem Value="Good" Text="Good"></asp:ListItem>
                                        <asp:ListItem Value="Very Good" Text="Very Good"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel10" runat="server" GroupingText="Condition of Sanitation">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label201" runat="server" Text="Overall village open defecation "></asp:Label>
                                    <asp:TextBox ID="txtOpenDefecation" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label202" runat="server" Text="HHs with toilets"></asp:Label>
                                    <asp:TextBox ID="txtHHToilets" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label203" runat="server" Text="HHs utilizing toilets"></asp:Label>
                                    <asp:TextBox ID="txtHHUtilizingToilets" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label204" runat="server" Text="HHs using public toilets"></asp:Label>
                                    <asp:TextBox ID="txtHHPublicToilets" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label205" runat="server" Text="HHs connected with drainage"></asp:Label>
                                    <asp:TextBox ID="txtHHDrainage" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                        </div>

                    </asp:Panel>

                    <asp:Panel ID="Panel14" runat="server" GroupingText="Status of Education in Village">
                        <legend style="font-size: 18px;">Primary school in Village</legend>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label228" runat="server" Text="Primary school"></asp:Label>
                                    <asp:RadioButtonList ID="rblPrimaryScholDetails" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblPrimaryScholDetails" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4" id="dvPrimary1">
                                <div class="form-group">
                                    <asp:Label ID="Label285" runat="server" Text="Distance from village"></asp:Label>
                                    <asp:TextBox ID="txtPrimarySchoolDistance" runat="server" CssClass="form-control" oninput="SplCharCheck(input)" />
                                </div>
                            </div>
                            <div class="col-md-4" id="dvPrimary2">
                                <div class="form-group">
                                    <asp:Label ID="Label286" runat="server" Text="Boys"></asp:Label>
                                    <asp:TextBox ID="txtPrimaryCshoolBoys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvPrimary3">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label287" runat="server" Text="Girls"></asp:Label>
                                    <asp:TextBox ID="txtPrimarySchoolGirls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form--group">
                                    <asp:Label ID="Label288" runat="server" Text="TransGender"></asp:Label>
                                    <asp:TextBox ID="txtPrimarySchoolTransgender" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label289" runat="server" Text="Total"></asp:Label>
                                    <asp:TextBox ID="txtPrimarySchoolTotal" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvPrimary4">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label206" runat="server" Text="No. of Boys children never attended school"></asp:Label>
                                    <asp:TextBox ID="txtPrimaryNeverAttendedBoys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label207" runat="server" Text="No. of Girls children never attended school"></asp:Label>
                                    <asp:TextBox ID="txtPrimaryNeverAttendedGirls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label208" runat="server" Text="No. of Boys children dropped out from school"></asp:Label>
                                    <asp:TextBox ID="txtPrimaryBoysDropped" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvPrimary5">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label209" runat="server" Text="No. of Girls children dropped out from school"></asp:Label>
                                    <asp:TextBox ID="txtPrimaryGuirlsDropped" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label210" runat="server" Text="Total No. of Boys school going children  "></asp:Label>
                                    <asp:TextBox ID="txtPrimaryBoysGoing" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label223" runat="server" Text="Total No. of Girls school going children  "></asp:Label>
                                    <asp:TextBox ID="txtPrimaryGirlsGoing" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvPrimary6">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label224" runat="server" Text="Total No. of Boys 6-11 year children in village"></asp:Label>
                                    <asp:TextBox ID="txtPrimary6to11Boys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label225" runat="server" Text="Total No. of Girls 6-11 year children in village"></asp:Label>
                                    <asp:TextBox ID="txtPrimary6to11Girls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label226" runat="server" Text="Status of literacy in the village in percentage"></asp:Label>
                                    <asp:TextBox ID="txtPrimaryLiteracyStatus" runat="server" CssClass="form-control" oninput="PercentCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <legend style="font-size: 18px;">Upper Primary school in Village</legend>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label229" runat="server" Text="Upper Primary School"></asp:Label>
                                    <asp:RadioButtonList ID="rblUpperPrimary" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblUpperPrimary" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4" id="dvUpperPrimary1">
                                <div class="form-group">
                                    <asp:Label ID="Label292" runat="server" Text="Distance from village"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimarySchoolDistance" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4" id="dvUpperPrimary2">
                                <div class="form-group">
                                    <asp:Label ID="Label293" runat="server" Text="Boys"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimaryCshoolBoys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvUpperPrimary3">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label294" runat="server" Text="Girls"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimarySchoolGirls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form--group">
                                    <asp:Label ID="Label295" runat="server" Text="TransGender"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimarySchoolTransgender" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label296" runat="server" Text="Total"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimarySchoolTotal" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvUpperPrimary4">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label227" runat="server" Text="No. of Boys children never attended school"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimaryNeverAttendedBoys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label233" runat="server" Text="No. of Girls children never attended school"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimaryNeverAttendedGirls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label234" runat="server" Text="No. of Boys children dropped out from school"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimaryBoysDropped" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvUpperPrimary5">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label235" runat="server" Text="No. of Girls children dropped out from school"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimaryGuirlsDropped" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label236" runat="server" Text="Total No. of Boys school going children  "></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimaryBoysGoing" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label237" runat="server" Text="Total No. of Girls school going children  "></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimaryGirlsGoing" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvUpperPrimary6">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label238" runat="server" Text="Total No. of Boys 11-12 year children in village"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimary6to11Boys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label239" runat="server" Text="Total No. of Girls 11-12 year children in village"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimary6to11Girls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label240" runat="server" Text="Status of literacy in the village in percentage"></asp:Label>
                                    <asp:TextBox ID="txtUpperPrimaryLiteracyStatus" runat="server" CssClass="form-control" oninput="PercentCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <legend style="font-size: 18px;">Secondary school in Village</legend>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label230" runat="server" Text="Secondary School"></asp:Label>
                                    <asp:RadioButtonList ID="rblSecondary" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblSecondary" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4" id="dvSecondary1">
                                <div class="form-group">
                                    <asp:Label ID="Label301" runat="server" Text="Distance"></asp:Label>
                                    <asp:TextBox ID="txtSecondarySchoolDistance" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4" id="dvSecondary2">
                                <div class="form-group">
                                    <asp:Label ID="Label297" runat="server" Text="Boys"></asp:Label>
                                    <asp:TextBox ID="txtSecondaryCshoolBoys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvSecondary3">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label298" runat="server" Text="Girls"></asp:Label>
                                    <asp:TextBox ID="txtSecondarySchoolGirls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form--group">
                                    <asp:Label ID="Label299" runat="server" Text="TransGender"></asp:Label>
                                    <asp:TextBox ID="txtSecondarySchoolTransgender" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label300" runat="server" Text="Total"></asp:Label>
                                    <asp:TextBox ID="txtSecondarySchoolTotal" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvSecondary4">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label241" runat="server" Text="No. of Boys children never attended school"></asp:Label>
                                    <asp:TextBox ID="txtSecondaryNeverAttendedBoys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label242" runat="server" Text="No. of Girls children never attended school"></asp:Label>
                                    <asp:TextBox ID="txtSecondaryNeverAttendedGirls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label246" runat="server" Text="No. of Boys children dropped out from school"></asp:Label>
                                    <asp:TextBox ID="txtSecondaryBoysDropped" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvSecondary5">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label247" runat="server" Text="No. of Girls children dropped out from school"></asp:Label>
                                    <asp:TextBox ID="txtSecondaryGuirlsDropped" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label266" runat="server" Text="Total No. of Boys school going children  "></asp:Label>
                                    <asp:TextBox ID="txtSecondaryBoysGoing" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label267" runat="server" Text="Total No. of Girls school going children  "></asp:Label>
                                    <asp:TextBox ID="txtSecondaryGirlsGoing" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvSecondary6">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label268" runat="server" Text="Total No. of Boys 13-15 year children in village"></asp:Label>
                                    <asp:TextBox ID="txtSecondary6to11Boys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label269" runat="server" Text="Total No. of Girls 13-15 year children in village"></asp:Label>
                                    <asp:TextBox ID="txtSecondary6to11Girls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label270" runat="server" Text="Status of literacy in the village in percentage"></asp:Label>
                                    <asp:TextBox ID="txtSecondaryLiteracyStatus" runat="server" CssClass="form-control" oninput="PercentCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <legend style="font-size: 18px;">Higher Secondary School in Village</legend>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label231" runat="server" Text="Higher Secondary School"></asp:Label>
                                    <asp:RadioButtonList ID="rblHigherSecondary" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblHigherSecondary" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4" id="dvHigher1">
                                <div class="form-group">
                                    <asp:Label ID="Label302" runat="server" Text="Distance"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondarySchoolDistance" runat="server" CssClass="form-control" oninput="DecimalCheck(input)" />
                                </div>
                            </div>
                            <div class="col-md-4" id="dvHigher2">
                                <div class="form-group">
                                    <asp:Label ID="Label303" runat="server" Text="Boys"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondaryCshoolBoys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvHigher3">
                            <div class="col-md-4" id="dvGirls3">
                                <div class="form-group">
                                    <asp:Label ID="Label304" runat="server" Text="Girls"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondarySchoolGirls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form--group">
                                    <asp:Label ID="Label305" runat="server" Text="TransGender"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondarySchoolTransgender" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label306" runat="server" Text="Total"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondarySchoolTotal" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvHigher4">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label271" runat="server" Text="No. of Boys children never attended school"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondaryNeverAttendedBoys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label272" runat="server" Text="No. of Girls children never attended school"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondaryNeverAttendedGirls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label273" runat="server" Text="No. of Boys children dropped out from school"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondaryBoysDropped" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvHigher5">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label277" runat="server" Text="No. of Girls children dropped out from school"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondaryGuirlsDropped" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label278" runat="server" Text="Total No. of Boys school going children  "></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondaryBoysGoing" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label290" runat="server" Text="Total No. of Girls school going children  "></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondaryGirlsGoing" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvHigher6">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label291" runat="server" Text="Total No. of Boys 17-18 year children in village"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondary6to11Boys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label312" runat="server" Text="Total No. of Girls 17-18 year children in village"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondary6to11Girls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label313" runat="server" Text="Status of literacy in the village in percentage"></asp:Label>
                                    <asp:TextBox ID="txtHigherSecondaryLiteracyStatus" runat="server" CssClass="form-control" oninput="PercentCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <legend style="font-size: 18px;">Private Madarsa School in Village</legend>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label232" runat="server" Text="Private school Madarsa"></asp:Label>
                                    <asp:RadioButtonList ID="rblMadrasa" CssClass="LableSpace" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="Yes" Text=" Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblMadrasa" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4" id="dvMadarsa1">
                                <div class="form-group">
                                    <asp:Label ID="Label307" runat="server" Text="Distance"></asp:Label>
                                    <asp:TextBox ID="txtMadrasaSchoolDistance" runat="server" CssClass="form-control" oninput="DecimalCheck(input)" />
                                </div>
                            </div>
                            <div class="col-md-4" id="dvMadarsa2">
                                <div class="form-group">
                                    <asp:Label ID="Label308" runat="server" Text="Boys"></asp:Label>
                                    <asp:TextBox ID="txtMadrasaCshoolBoys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvMadarsa3">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label309" runat="server" Text="Girls"></asp:Label>
                                    <asp:TextBox ID="txtMadrasaSchoolGirls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form--group">
                                    <asp:Label ID="Label310" runat="server" Text="TransGender"></asp:Label>
                                    <asp:TextBox ID="txtMadrasaSchoolTransgender" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4" id="dvTotal4">
                                <div class="form-group">
                                    <asp:Label ID="Label311" runat="server" Text="Total"></asp:Label>
                                    <asp:TextBox ID="txtMadrasaSchoolTotal" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvMadarsa4">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label243" runat="server" Text="No. of Boys children never attended school"></asp:Label>
                                    <asp:TextBox ID="txtMadrasaNeverAttendedBoys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label274" runat="server" Text="No. of Girls children never attended school"></asp:Label>
                                    <asp:TextBox ID="txtMadrasaNeverAttendedGirls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label244" runat="server" Text="No. of Boys children dropped out from school"></asp:Label>
                                    <asp:TextBox ID="txtMadrasaBoysDropped" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvMadarsa5">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label275" runat="server" Text="No. of Girls children dropped out from school"></asp:Label>
                                    <asp:TextBox ID="txtMadrasaGuirlsDropped" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label245" runat="server" Text="Total No. of Boys school going children  "></asp:Label>
                                    <asp:TextBox ID="txtMadrasaBoysGoing" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label276" runat="server" Text="Total No. of Girls school going children  "></asp:Label>
                                    <asp:TextBox ID="txtMadrasaGirlsGoing" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvMadarsa6">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label248" runat="server" Text="Total No. of Boys 14-16 year children in village"></asp:Label>
                                    <asp:TextBox ID="txtMadrasa6to11Boys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label279" runat="server" Text="Total No. of Girls 14-16 year children in village"></asp:Label>
                                    <asp:TextBox ID="txtMadrasa6to11Girls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label249" runat="server" Text="Status of literacy in the village in percentage"></asp:Label>
                                    <asp:TextBox ID="txtMadrasaLiteracyStatus" runat="server" CssClass="form-control" oninput="PercentCheck(this)" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel16" runat="server" GroupingText="Household link with social security scheme ">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label250" runat="server" Text="No. of families having Widows & destitute/ Families having Child With Disabilities/ Person With Disabilities"></asp:Label>
                                    <asp:TextBox ID="txtWidows" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label251" runat="server" Text="Public distribution system cards"></asp:Label>
                                    <asp:TextBox ID="txtDistributionCards" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label252" runat="server" Text="House hold cover with Atal Pension Scheme"></asp:Label>
                                    <asp:TextBox ID="txtAtlaScheme" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label253" runat="server" Text="House hold cover with accidental insurance"></asp:Label>
                                    <asp:TextBox ID="txtAccidentalInsurance" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label254" runat="server" Text="House hold cover with life insurance"></asp:Label>
                                    <asp:TextBox ID="txtLifeInsurance" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label255" runat="server" Text="House hold having labour registration card"></asp:Label>
                                    <asp:TextBox ID="txtLabourCard" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel17" runat="server" GroupingText="Community based institution">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label256" runat="server" Text="No. of Women  Self Help Groups(WSHGs) formed in the village"></asp:Label>
                                    <asp:TextBox ID="txtWSHGs" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label257" runat="server" Text="Name of the WSHGs"></asp:Label>
                                    <asp:TextBox ID="txtNameofWSHGs" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label258" runat="server" Text="Total No. of members in WSHGs"></asp:Label>
                                    <asp:TextBox ID="txtWSHGmembers" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label259" runat="server" Text="No. of Women Farmers Groups(WFGs)"></asp:Label>
                                    <asp:TextBox ID="txtWFGs" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label260" runat="server" Text="Total No. of members in WFGs"></asp:Label>
                                    <asp:TextBox ID="txtWFGMembers" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label261" runat="server" Text="No. of Other CBOs (Nari Sangh/Women Health Groups etc)"></asp:Label>
                                    <asp:TextBox ID="txtOtherCBO" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label262" runat="server" Text="Total No. of members in other CBOs"></asp:Label>
                                    <asp:TextBox ID="txtOtherCBOMembers" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label263" runat="server" Text="Electricity facility available (yes/ No/ Partial)"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddlElectricity" CssClass="form-control">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        <asp:ListItem Value="Partially" Text="Partially"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label264" runat="server" Text="Household having LPG gas connection "></asp:Label>
                                    <asp:TextBox ID="txtLPGs" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label265" runat="server" Text="Major sector wise needs"></asp:Label>
                                    <asp:TextBox ID="txtMajorNeeds" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:HiddenField ID="hiddenDivRowId" runat="server" Value="1" />
                    <asp:HiddenField ID="hiddenDataArrayId" runat="server" />
                    <%--</asp:Panel>--%>
                </div>
                <div class="box-footer clearfix">
                    <a id="btnCancel" runat="server" class="btn btn-danger" href="HamletDataInfo.aspx">Cancel</a>
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-warning" Text="Update" OnClick="btnSubmit_Click" />
                </div>
            </div>
        </section>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#liVillages").addClass("active");

            $(".YearPicker").datepicker({
                format: "yyyy", // Notice the Extra space at the beginning
                viewMode: "years",
                minViewMode: "years",
                autoclose: true
            });
            var ddl = $("#<%= rblPrimaryScholDetails.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvPrimary1').style.display = "block";
                document.getElementById('dvPrimary2').style.display = "block";
                document.getElementById('dvPrimary3').style.display = "block";
                document.getElementById('dvPrimary4').style.display = "block";
                document.getElementById('dvPrimary5').style.display = "block";
                document.getElementById('dvPrimary6').style.display = "block";

            }
            else {
                document.getElementById('dvPrimary1').style.display = "none";
                document.getElementById('dvPrimary2').style.display = "none";
                document.getElementById('dvPrimary3').style.display = "none";
                document.getElementById('dvPrimary4').style.display = "none";
                document.getElementById('dvPrimary5').style.display = "none";
                document.getElementById('dvPrimary6').style.display = "none";

            }

            var ddl1 = $("#<%= rblUpperPrimary.ClientID %> input:checked").val();
            if (ddl1 == 'Yes') {
                document.getElementById('dvUpperPrimary1').style.display = "block";
                document.getElementById('dvUpperPrimary2').style.display = "block";
                document.getElementById('dvUpperPrimary3').style.display = "block";
                document.getElementById('dvUpperPrimary4').style.display = "block";
                document.getElementById('dvUpperPrimary5').style.display = "block";
                document.getElementById('dvUpperPrimary6').style.display = "block";

            } else {
                document.getElementById('dvUpperPrimary1').style.display = "none";
                document.getElementById('dvUpperPrimary2').style.display = "none";
                document.getElementById('dvUpperPrimary3').style.display = "none";
                document.getElementById('dvUpperPrimary4').style.display = "none";
                document.getElementById('dvUpperPrimary5').style.display = "none";
                document.getElementById('dvUpperPrimary6').style.display = "none";

            }

            var ddl2 = $("#<%= rblSecondary.ClientID %> input:checked").val();
            if (ddl2 == 'Yes') {
                document.getElementById('dvSecondary1').style.display = "block";
                document.getElementById('dvSecondary2').style.display = "block";
                document.getElementById('dvSecondary3').style.display = "block";
                document.getElementById('dvSecondary4').style.display = "block";
                document.getElementById('dvSecondary5').style.display = "block";
                document.getElementById('dvSecondary6').style.display = "block";

            } else {
                document.getElementById('dvSecondary1').style.display = "none";
                document.getElementById('dvSecondary2').style.display = "none";
                document.getElementById('dvSecondary3').style.display = "none";
                document.getElementById('dvSecondary4').style.display = "none";
                document.getElementById('dvSecondary5').style.display = "none";
                document.getElementById('dvSecondary6').style.display = "none";

            }

            var ddl3 = $("#<%= rblHigherSecondary.ClientID %> input:checked").val();
            if (ddl3 == 'Yes') {
                document.getElementById('dvHigher1').style.display = "block";
                document.getElementById('dvHigher2').style.display = "block";
                document.getElementById('dvHigher3').style.display = "block";
                document.getElementById('dvHigher4').style.display = "block";
                document.getElementById('dvHigher5').style.display = "block";
                document.getElementById('dvHigher6').style.display = "block";

            } else {
                document.getElementById('dvHigher1').style.display = "none";
                document.getElementById('dvHigher2').style.display = "none";
                document.getElementById('dvHigher3').style.display = "none";
                document.getElementById('dvHigher4').style.display = "none";
                document.getElementById('dvHigher5').style.display = "none";
                document.getElementById('dvHigher6').style.display = "none";

            }

            var ddl4 = $("#<%= rblMadrasa.ClientID %> input:checked").val();
            if (ddl4 == 'Yes') {
                document.getElementById('dvMadarsa1').style.display = "block";
                document.getElementById('dvMadarsa2').style.display = "block";
                document.getElementById('dvMadarsa3').style.display = "block";
                document.getElementById('dvMadarsa4').style.display = "block";
                document.getElementById('dvMadarsa5').style.display = "block";
                document.getElementById('dvMadarsa6').style.display = "block";

            } else {
                document.getElementById('dvMadarsa1').style.display = "none";
                document.getElementById('dvMadarsa2').style.display = "none";
                document.getElementById('dvMadarsa3').style.display = "none";
                document.getElementById('dvMadarsa4').style.display = "none";
                document.getElementById('dvMadarsa5').style.display = "none";
                document.getElementById('dvMadarsa6').style.display = "none";

            }
        });

        $('#<%=rblPrimaryScholDetails.ClientID %>').change(function () {
            debugger;
            var ddl = $("#<%= rblPrimaryScholDetails.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvPrimary1').style.display = "block";
                document.getElementById('dvPrimary2').style.display = "block";
                document.getElementById('dvPrimary1').style.display = "block";
                document.getElementById('dvPrimary4').style.display = "block";
                document.getElementById('dvPrimary5').style.display = "block";
                document.getElementById('dvPrimary6').style.display = "block";

            }
            else {
                document.getElementById('dvPrimary1').style.display = "none";
                document.getElementById('dvPrimary2').style.display = "none";
                document.getElementById('dvPrimary1').style.display = "none";
                document.getElementById('dvPrimary4').style.display = "none";
                document.getElementById('dvPrimary5').style.display = "none";
                document.getElementById('dvPrimary6').style.display = "none";

            }

        });
        $('#<%=rblUpperPrimary.ClientID %>').change(function () {
            debugger;
            var ddl = $("#<%= rblUpperPrimary.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvUpperPrimary1').style.display = "block";
                document.getElementById('dvUpperPrimary2').style.display = "block";
                document.getElementById('dvUpperPrimary3').style.display = "block";
                document.getElementById('dvUpperPrimary4').style.display = "block";
                document.getElementById('dvUpperPrimary5').style.display = "block";
                document.getElementById('dvUpperPrimary6').style.display = "block";

            } else {
                document.getElementById('dvUpperPrimary1').style.display = "none";
                document.getElementById('dvUpperPrimary2').style.display = "none";
                document.getElementById('dvUpperPrimary3').style.display = "none";
                document.getElementById('dvUpperPrimary4').style.display = "none";
                document.getElementById('dvUpperPrimary5').style.display = "none";
                document.getElementById('dvUpperPrimary6').style.display = "none";

            }

        });
        $('#<%=rblSecondary.ClientID %>').change(function () {
            debugger;
            var ddl = $("#<%= rblSecondary.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvSecondary1').style.display = "block";
                document.getElementById('dvSecondary2').style.display = "block";
                document.getElementById('dvSecondary3').style.display = "block";
                document.getElementById('dvSecondary4').style.display = "block";
                document.getElementById('dvSecondary5').style.display = "block";
                document.getElementById('dvSecondary6').style.display = "block";

            } else {
                document.getElementById('dvSecondary1').style.display = "none";
                document.getElementById('dvSecondary2').style.display = "none";
                document.getElementById('dvSecondary3').style.display = "none";
                document.getElementById('dvSecondary4').style.display = "none";
                document.getElementById('dvSecondary5').style.display = "none";
                document.getElementById('dvSecondary6').style.display = "none";

            }

        });
        $('#<%= rblHigherSecondary.ClientID %>').change(function () {
            debugger;
            var ddl = $("#<%= rblHigherSecondary.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvHigher1').style.display = "block";
                document.getElementById('dvHigher2').style.display = "block";
                document.getElementById('dvHigher3').style.display = "block";
                document.getElementById('dvHigher4').style.display = "block";
                document.getElementById('dvHigher5').style.display = "block";
                document.getElementById('dvHigher6').style.display = "block";

            } else {
                document.getElementById('dvHigher1').style.display = "none";
                document.getElementById('dvHigher2').style.display = "none";
                document.getElementById('dvHigher3').style.display = "none";
                document.getElementById('dvHigher4').style.display = "none";
                document.getElementById('dvHigher5').style.display = "none";
                document.getElementById('dvHigher6').style.display = "none";

            }

        });
        $('#<%=rblMadrasa.ClientID %>').change(function () {
            debugger;
            var ddl = $("#<%= rblMadrasa.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvMadarsa1').style.display = "block";
                document.getElementById('dvMadarsa2').style.display = "block";
                document.getElementById('dvMadarsa3').style.display = "block";
                document.getElementById('dvMadarsa4').style.display = "block";
                document.getElementById('dvMadarsa5').style.display = "block";
                document.getElementById('dvMadarsa6').style.display = "block";

            } else {
                document.getElementById('dvMadarsa1').style.display = "none";
                document.getElementById('dvMadarsa2').style.display = "none";
                document.getElementById('dvMadarsa3').style.display = "none";
                document.getElementById('dvMadarsa4').style.display = "none";
                document.getElementById('dvMadarsa5').style.display = "none";
                document.getElementById('dvMadarsa6').style.display = "none";

            }

        });
        $(document).ready(function () {
            debugger;

            $("#ContentPlaceHolder1_lnkAddAddress").click(function (e) {
                debugger;
                var id = $("#<%=hiddenDivRowId.ClientID %>").val();
                e.preventDefault();
                $("#dynamicDDLs").append('<div class="row" id="addres' + id + '"><div  class="col-md-4 form-group">Name<input type="text" onblur="GetDataAddress();" oninput="SplCharCheck2(this)" id="Txtname' + id + '" class="form-control"></div><div class="col-md-4 form-group">designation<input type="text" onblur="GetDataAddress();" oninput="SplCharCheck2(this)" id="Txtdesignation' + id + '" class="form-control"></div><div class="col-md-4 form-group">Department<input type="text" onblur="GetDataAddress();" oninput="SplCharCheck2(this)" id="TxtDepartment' + id + '" class="form-control"></div><div class="col-md-4 form-group">Address<input type="text" onblur="GetDataAddress();" oninput="SplCharCheck2(this)" id="TxtAddress' + id + '" class="form-control"></div><div class="col-md-4 form-group">contact no<input type="text" onblur="GetDataAddress();" oninput="NumberCheck(this)" id="Txtcontactno' + id + '" class="form-control"></div><a href="#" onclick = "RemoveCurrentDiv(&apos;#addres' + id + '&apos;);" style="color:red"><i class="fa fa-remove"></i></a></div>'); id++;
                $("#<%=hiddenDivRowId.ClientID %>").val(id);
                console.log(id);

                return false;
            });
        });
        function GetDataAddress() {
            //debugger;
            var DataCount = $("#<%=hiddenDivRowId.ClientID %>").val();
            var Data = $("#ContentPlaceHolder1_Txtname0").val() + ':' + $("#ContentPlaceHolder1_Txtdesignation0").val() + ':' + $("#ContentPlaceHolder1_TxtDepartment0").val() + ':' + $("#ContentPlaceHolder1_TxtAddress0").val() + ':' + $("#ContentPlaceHolder1_Txtcontactno0").val();

            for (var i = 1; i < DataCount; i++) {
                var Txtname = "Txtname" + i;
                var Txtdesignation = "Txtdesignation" + i;
                var TxtDepartment = "TxtDepartment" + i;
                var TxtAddress = "TxtAddress" + i;
                var Txtcontactno = "Txtcontactno" + i;
                if ($('#' + Txtname).val() != '' && $('#' + Txtdesignation).val() != undefined && $('#' + TxtDepartment).val() != undefined && $('#' + TxtAddress).val() != undefined && $('#' + Txtcontactno).val() != undefined) {
                    if (Data != "") {
                        Data += '$' + $('#' + Txtname).val() + ':' + $('#' + Txtdesignation).val() + ':' + $('#' + TxtDepartment).val() + ':' + $('#' + TxtAddress).val() + ':' + $('#' + Txtcontactno).val();
                    }
                    else {
                        Data += $('#' + Txtname).val() + ':' + $('#' + Txtdesignation).val() + ':' + $('#' + TxtDepartment).val() + ':' + $('#' + TxtAddress).val() + ':' + $('#' + Txtcontactno).val();;
                    }
                }
            }

            $("#<%=hiddenDataArrayId.ClientID %>").val(Data);
            console.log('Selected Values');
            console.log($("#<%=hiddenDataArrayId.ClientID %>").val());
        }
        function RemoveCurrentDiv(id) {
            //debugger;
            $(id).remove();
            GetDataAddress();
            $("#ContentPlaceHolder1_Txtname0").focus();
            return false;
        };
    </script>
</asp:Content>

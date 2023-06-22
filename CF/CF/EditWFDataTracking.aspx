<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="EditWFDataTracking.aspx.cs" Inherits="CF.EditWFDataTracking" UnobtrusiveValidationMode="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Edit Woman Farmer Data</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.css" rel="stylesheet" />
    <style type="text/css">
        .LableSpace, label {
            font-weight: 500 !important;
            margin-right: 40px !important;
            margin-left: 5px !important;
        }

        .auto-style1 {
            color: #FFFFFF;
            background-color: #006600;
        }

        #tblIndent, tr, td, label {
            padding-left: 5px;
        }

        #ContentPlaceHolder1_Panel3 {
            overflow: hidden;
        }
    </style>
    <script>
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

        function NumberCheck(input) {
            ////debugger;
            let value = input.value;
            let numbers = value.replace(/[^0-9]/g, "");
            input.value = numbers;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <form runat="server">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Add Woman Farmer Indicator</h3>
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
                                        <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select CSO" ControlToValidate="ddlCSO" SetFocusOnError="true" InitialValue="Select" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label27" runat="server" Text="State"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlstate" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlstate_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ValidationGroup="PreviewCheck" CssClass="text-danger" ErrorMessage="Please Select State" ControlToValidate="ddlstate" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label30" runat="server" Text="District"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ValidationGroup="PreviewCheck" CssClass="text-danger" ErrorMessage="Please Select District" ControlToValidate="ddlDistrict" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label31" runat="server" Text="Block"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlBlock" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlBlock_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ValidationGroup="PreviewCheck" CssClass="text-danger" ErrorMessage="Please Select Block" ControlToValidate="ddlBlock" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblVillage" runat="server" Text="Village"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlVillage" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlVillage_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ValidationGroup="PreviewCheck" CssClass="text-danger" ErrorMessage="Please Select Village" ControlToValidate="ddlVillage" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblWFG" runat="server" Text="Woman Former Group"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlWFG" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlWFG_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ValidationGroup="PreviewCheck" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select WFG" ControlToValidate="ddlWFG" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label1" runat="server" Text="Woman Formers"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlWF" CssClass="form-control" runat="server" onchange="GetDate()">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ValidationGroup="PreviewCheck" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select WF" ControlToValidate="ddlWF" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="row">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label3" runat="server" Text="Year of Enrollment"></asp:Label><b style="color: red"> *</b>
                                        <asp:TextBox ID="txtYear" runat="server" CssClass="form-control YearPicker" OnTextChanged="txtYear_TextChanged" oninput="SplCharCheck(this)"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Year" ControlToValidate="txtYear" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label44" runat="server" Text="Major Income Source of the Family"></asp:Label><b style="color: red"> *</b>
                                <asp:DropDownList runat="server" ID="ddlMajorSource" CssClass="form-control">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                    <asp:ListItem Value="Agriculture" Text="Agriculture"></asp:ListItem>
                                    <asp:ListItem Value="Agriculture- labour" Text="Agriculture- labour"></asp:ListItem>
                                    <asp:ListItem Value="Animal Husbandary" Text="Animal Husbandary"></asp:ListItem>
                                    <asp:ListItem Value="Government Job" Text="Government Job"></asp:ListItem>
                                    <asp:ListItem Value="Private Job" Text="Private Job"></asp:ListItem>
                                    <asp:ListItem Value="Small business" Text="Small business"></asp:ListItem>
                                    <asp:ListItem Value="Skilled work" Text="Skilled work"></asp:ListItem>
                                    <asp:ListItem Value="Other" Text="Any Other"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" InitialValue="Select" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Type of Source" ControlToValidate="ddlMajorSource" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvOtherSource">
                            <div class="form-group">
                                <asp:Label ID="Label4" runat="server" Text="Other Source"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtOtherSource" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator11" ValidateEmptyText="true" ControlToValidate="txtOtherSource" SetFocusOnError="true" ClientValidationFunction="MajorSourcevalidate" Display="Dynamic" ErrorMessage="Please Enter Other Source" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblIncome" runat="server" Text="Income (Rs)(Annual)"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtIncome" runat="server" CssClass="form-control" oninput="DecimalCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Income" ControlToValidate="txtIncome" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label97" runat="server" Text="Family Income (Rs)(Annual)"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtTotalIncome" runat="server" CssClass="form-control" oninput="DecimalCheck(this)"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Total Income" ControlToValidate="txtTotalIncome" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label7" runat="server" Text="is Woman working as Labourer"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblLabourer" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblLabourer" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvNatureofWork">
                            <div class="form-group">
                                <asp:Label ID="Label8" runat="server" Text="Type of Labour"></asp:Label>
                                <asp:TextBox ID="txtNatureofWork" oninput="SplCharCheck2(this)" runat="server" CssClass="form-control" />
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator10" ValidateEmptyText="true" ControlToValidate="txtNatureofWork" SetFocusOnError="true" ClientValidationFunction="NatureofWorkvalidate" Display="Dynamic" ErrorMessage="Please Enter Type of Labour" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblMNREGA" runat="server" Text="The Woman has MGNREGA job card"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblMNREGA" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblMNREGA" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvMNREGADays">
                            <div class="form-group">
                                <asp:Label ID="Label2" runat="server" Text="Since How Many Days (<=365)"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox runat="server" ID="txtMNREGADays" CssClass="form-control" onkeyup="funNumber(this)" MaxLength="3"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator2" ValidateEmptyText="true" ControlToValidate="txtMNREGADays" SetFocusOnError="true" ClientValidationFunction="MNREGADaysvalidate" Display="Dynamic" ErrorMessage="Please Enter Days" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label10" runat="server" Text="Woman has any Livestock"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblLivestock" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblLivestock" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvNoofLivestock">
                            <div class="form-group">
                                <asp:Label ID="lblLivestock" runat="server" Text="No.of Livestock if any"></asp:Label>
                                <asp:TextBox ID="txtLivestock" runat="server" oninput="NumberCheck(this)" MaxLength="2" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvCow">
                            <div class="form-group">
                                <asp:Label ID="Label11" runat="server" Text="Cow"></asp:Label>
                                <asp:TextBox ID="txtCow" runat="server" oninput="NumberCheck(this)" MaxLength="2" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvBuffalo">
                            <div class="form-group">
                                <asp:Label ID="Label12" runat="server" Text="Buffalo"></asp:Label>
                                <asp:TextBox ID="txtBuffalo" runat="server" oninput="NumberCheck(this)" MaxLength="2" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row" id="dvLiveStock">
                        <div class="col-md-3" id="dvGoat">
                            <div class="form-group">
                                <asp:Label ID="Label13" runat="server" Text="Goat"></asp:Label>
                                <asp:TextBox ID="txtGoat" runat="server" oninput="NumberCheck(this)" MaxLength="2" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvPoultry">
                            <div class="form-group">
                                <asp:Label ID="Label14" runat="server" Text="Poultry"></asp:Label>
                                <asp:TextBox ID="txtPoultry" runat="server" oninput="NumberCheck(this)" MaxLength="2" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvMilk">
                            <div class="form-group">
                                <asp:Label ID="Label36" runat="server" Text="Milk (litres/Annual)"></asp:Label>
                                <asp:TextBox ID="txtMilk" runat="server" oninput="NumberCheck(this)" MaxLength="2" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvOther">
                            <div class="form-group">
                                <asp:Label ID="Label37" runat="server" Text="Other"></asp:Label>
                                <asp:TextBox ID="txtOther" runat="server" oninput="NumberCheck(this)" MaxLength="2" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label54" runat="server" Text="is land in the name of woman"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblownlandSelfName" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblownlandSelfName" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvOwnLand">
                            <div class="form-group">
                                <asp:Label ID="Label15" runat="server" Text="Field (in Acr)"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtownlandSelfName" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" onblur="GetTotalLand()"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator3" ValidateEmptyText="true" ControlToValidate="txtownlandSelfName" SetFocusOnError="true" ClientValidationFunction="OwnLandCheck" Display="Dynamic" ErrorMessage="Please Enter Amount" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                            <asp:HiddenField runat="server" ID="hfLandinHectore" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label18" runat="server" Text="Other Own Land(in Acr)"></asp:Label>
                                <asp:TextBox ID="txtOwnLand" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" onblur="GetTotalLand()"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label19" runat="server" Text="Land on Lease (in Acr)"></asp:Label>
                                <asp:TextBox ID="txtRentalLand" runat="server" CssClass="form-control" oninput="DecimalCheck(this)" onblur="GetTotalLand()"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label16" runat="server" Text="Total Land (in Acr)"></asp:Label>
                                <asp:TextBox ID="txtLandinHectore" runat="server" oninput="DecimalCheck(this)" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label17" runat="server" Text="Is Irrigated Land"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblIrrigatedLand" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblIrrigatedLand" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvTotlairrigationland">
                            <div class="form-group">
                                <asp:Label ID="lblTotlairrigationland" runat="server" Text="Total Irrigated Land(in Acr)"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtTotlairrigationland" runat="server" oninput="DecimalCheck(this)" MaxLength="6" CssClass="form-control"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" runat="server" ID="CVTotlairrigationland" ValidateEmptyText="true" ControlToValidate="txtTotlairrigationland" ClientValidationFunction="TotlairrigationlandValidate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Please Enter Irrigated Land Value" CssClass="text-danger"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvIrrigationSource">
                            <div class="form-group">
                                <asp:Label ID="lblIrrigation" runat="server" Text="Source of Irrigation"></asp:Label><b style="color: red"> *</b>
                                <asp:DropDownList ID="ddlIrrigation" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                    <asp:ListItem Value="Bore well" Text="Bore well"></asp:ListItem>
                                    <asp:ListItem Value="Canal" Text="Canal"></asp:ListItem>
                                    <asp:ListItem Value="Pump Set" Text="Pump Set"></asp:ListItem>
                                    <asp:ListItem Value="Other" Text="Any Other"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" runat="server" ID="CustomValidator13" ValidateEmptyText="true" ControlToValidate="ddlIrrigation" ClientValidationFunction="IrrigationSourceValidate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Please Enter Irrigated Land Value" CssClass="text-danger"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvIrrigationSpecify">
                            <div class="form-group">
                                <asp:Label ID="Label45" runat="server" Text="Specify"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox runat="server" ID="txtIrrigationSpecify" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVIrrigationSpecify" ValidateEmptyText="true" ControlToValidate="txtIrrigationSpecify" SetFocusOnError="true" ClientValidationFunction="IrrigationSpecifyValidate" Display="Dynamic" ErrorMessage="Please Enter Other Religion" CssClass="text-danger" runat="server"></asp:CustomValidator>

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblNonirrigated" runat="server" Text="Total Non irrigated land,if any (in Acr)"></asp:Label>
                                <asp:TextBox ID="txtNonirrigated" runat="server" CssClass="form-control" oninput="DecimalCheck(this)"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblOwnerShipinland" runat="server" Text="Ownership in land"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblOwnerShipinland" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblOwnerShipinland" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvLandHaving">
                            <div class="form-group">
                                <asp:Label ID="lblLandHaving" runat="server" Text="Total Land Holding (in Acr)"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtLandHaving" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator4" ValidateEmptyText="true" ControlToValidate="txtLandHaving" SetFocusOnError="true" ClientValidationFunction="LandHavingValidate" Display="Dynamic" ErrorMessage="Please Enter Land Holding" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblDemoPlot" runat="server" Text="Demo Plot"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblDemoPlot" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblDemoPlot" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblGovScheme" runat="server" Text="Have accessed govt. schemes after facilitation by project team"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblGovScheme" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblGovScheme" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvGovScheme">
                            <div class="form-group">
                                <asp:Label ID="lblGovScheme1" runat="server" Text="Which Scheme"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtGovScheme" runat="server" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" runat="server" ID="CVGovScheme" ValidateEmptyText="true" ControlToValidate="txtGovScheme" ClientValidationFunction="GovSchemeValidate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Please Enter Irrigated Land Value" CssClass="text-danger"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvGovSchemeAmt">
                            <div class="form-group">
                                <asp:Label ID="Label93" runat="server" Text="Amount received (INR)"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtGovAmt" runat="server" oninput="DecimalCheck(this)" CssClass="form-control"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" runat="server" ID="CustomValidator25" ValidateEmptyText="true" ControlToValidate="txtGovAmt" ClientValidationFunction="GovSchemeAmtValidate" SetFocusOnError="true" Display="Dynamic" ErrorMessage="Please Enter Irrigated Land Value" CssClass="text-danger"></asp:CustomValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblBenifits" runat="server" Text="Benefits availing from govt schemes"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblBenifits" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Select an option" ControlToValidate="rblBenifits" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvBenfitName">
                            <div class="form-group">
                                <asp:Label ID="Label9" runat="server" Text="Name of Benefit Scheme"></asp:Label><b style="color: red"> *</b>
                                <asp:DropDownList runat="server" ID="ddlBenfitName" CssClass="form-control">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                    <asp:ListItem Value="PDS" Text="PDS"></asp:ListItem>
                                    <asp:ListItem Value="Awas Yojna" Text="Awas Yojna"></asp:ListItem>
                                    <asp:ListItem Value="KCC" Text="KCC"></asp:ListItem>
                                    <asp:ListItem Value="Fasal Bima Yojna" Text="Fasal Bima Yojna"></asp:ListItem>
                                    <asp:ListItem Value="Fishery" Text="Fishery"></asp:ListItem>
                                    <asp:ListItem Value="Animal Husbandry" Text="Animal Husbandry"></asp:ListItem>
                                    <asp:ListItem Value="Labor Registration" Text="Labor Registration"></asp:ListItem>
                                    <asp:ListItem Value="Jan Dhan Yojna" Text="Jan Dhan Yojna"></asp:ListItem>
                                    <asp:ListItem Value="Swachh Bharat Mission" Text="Swachh Bharat Mission"></asp:ListItem>
                                    <asp:ListItem Value="Ayushman Bharat" Text="Ayushman Bharat"></asp:ListItem>
                                    <asp:ListItem Value="Disability pension" Text="Disability pension"></asp:ListItem>
                                    <asp:ListItem Value="Widow pension" Text="Widow pension"></asp:ListItem>
                                    <asp:ListItem Value="Old age pension" Text="Old age pension"></asp:ListItem>
                                    <asp:ListItem Value="Jananai Suraksha Yojna" Text="Jananai Suraksha Yojna"></asp:ListItem>
                                    <asp:ListItem Value="Kishan Samman Nidhi" Text="Kishan Samman Nidhi"></asp:ListItem>
                                    <asp:ListItem Value="Soil Health Card" Text="Soil Health Card"></asp:ListItem>
                                    <asp:ListItem Value="Other" Text="Any Other"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVBenfitSchem" ControlToValidate="ddlBenfitName" SetFocusOnError="true" ClientValidationFunction="Benfitsvalidate" Display="Dynamic" ErrorMessage="Please Select Name of Benefit Scheme" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvOtherBenfits">
                            <div class="form-group">
                                <asp:Label ID="Label80" runat="server" Text="Other Benefit Scheme"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtOtherBenfit" runat="server" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator12" ValidateEmptyText="true" ControlToValidate="txtOtherBenfit" SetFocusOnError="true" ClientValidationFunction="OtherBenfitsvalidate" Display="Dynamic" ErrorMessage="Please Enter Other Benfit" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvBenfitAmount">
                            <div class="form-group">
                                <asp:Label ID="Label47" runat="server" Text="Amount (Rs)(Annual)"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtBenfitAmount" runat="server" oninput="NumberCheck(this)" onblur="GetFilterBenefit()" CssClass="form-control"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVBenefitAmount" ValidateEmptyText="true" ControlToValidate="txtBenfitAmount" SetFocusOnError="true" ClientValidationFunction="BenfitAmountvalidate" Display="Dynamic" ErrorMessage="Please Enter Amount" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                    </div>
                    <asp:Panel ID="Panel2" runat="server" GroupingText="Major crop grown by Woman">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Paddy"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblPaddy" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblPaddy" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvPaddy">
                                <div class="form-group">
                                    <asp:Label ID="Label20" runat="server" Text="Paddy Area (in Acr)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtPaddy" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVPaddy" ValidateEmptyText="true" ControlToValidate="txtPaddy" SetFocusOnError="true" ClientValidationFunction="PaddyValidate" Display="Dynamic" ErrorMessage="Please Enter Paddy value" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvPaddyAvg">
                                <div class="form-group">
                                    <asp:Label ID="Label38" runat="server" Text="Average Production (in kg)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtPaddyAvg" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVPaddyAvg" ValidateEmptyText="true" ControlToValidate="txtPaddyAvg" SetFocusOnError="true" ClientValidationFunction="PaddyAvgValidate" Display="Dynamic" ErrorMessage="Please Enter Average Production " CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Wheat"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblWheat" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblWheat" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvWheat">
                                <div class="form-group">
                                    <asp:Label ID="Label21" runat="server" Text="Wheat Area (in Acr)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtWheat" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVWheat" ValidateEmptyText="true" ControlToValidate="txtWheat" SetFocusOnError="true" ClientValidationFunction="WheatValidate" Display="Dynamic" ErrorMessage="Please Enter Paddy value" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvWheatAvg">
                                <div class="form-group">
                                    <asp:Label ID="Label39" runat="server" Text="Average Production (in kg)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtWheatAvg" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVWheatAvg" ValidateEmptyText="true" ControlToValidate="txtWheatAvg" SetFocusOnError="true" ClientValidationFunction="WheatAvgValidate" Display="Dynamic" ErrorMessage="Please Enter Average Production " CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Pulse Crops"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblPulseCrops" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblPulseCrops" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvPulse">
                                <div class="form-group">
                                    <asp:Label ID="Label22" runat="server" Text="Pulse Crop Area (in Acr)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtPulseCrop" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVPulseCrop" ValidateEmptyText="true" ControlToValidate="txtPulseCrop" SetFocusOnError="true" ClientValidationFunction="PulseValidate" Display="Dynamic" ErrorMessage="Please Enter Pulse Crop value" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvPulseAvg">
                                <div class="form-group">
                                    <asp:Label ID="Label40" runat="server" Text="Average Production (in kg)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtPulseCropAvg" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVPulseCropAvg" ValidateEmptyText="true" ControlToValidate="txtPulseCropAvg" SetFocusOnError="true" ClientValidationFunction="PulseAvgValidate" Display="Dynamic" ErrorMessage="Please Enter Average Production " CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvPulseType">
                                <div class="form-group">
                                    <asp:Label ID="Label56" runat="server" Text="Type of Pulse"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList runat="server" ID="ddlPulseType" CssClass="form-control">
                                        <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="Bambara Beans" Text="Bambara Beans"></asp:ListItem>
                                        <asp:ListItem Value="Chickpeas" Text="Chickpeas"></asp:ListItem>
                                        <asp:ListItem Value="Cowpeas" Text="Cowpeas"></asp:ListItem>
                                        <asp:ListItem Value="Dry Beans" Text="Dry Beans"></asp:ListItem>
                                        <asp:ListItem Value="Dry Peas" Text="Dry Peas"></asp:ListItem>
                                        <asp:ListItem Value="Faba Beans" Text="Faba Beans"></asp:ListItem>
                                        <asp:ListItem Value="Lentils" Text="Lentils"></asp:ListItem>
                                        <asp:ListItem Value="Lupins" Text="Lupins"></asp:ListItem>
                                        <asp:ListItem Value="Pigeon Peas" Text="Pigeon Peas"></asp:ListItem>
                                        <asp:ListItem Value="Vetches" Text="Vetches"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator8" ValidateEmptyText="true" ControlToValidate="ddlPulseType" SetFocusOnError="true" ClientValidationFunction="PulseTypeValidate" Display="Dynamic" ErrorMessage="Please Select Pulse Type" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Oil Crops"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblOilCrop" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblOilCrop" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvOil">
                                <div class="form-group">
                                    <asp:Label ID="Label23" runat="server" Text="Oil Crop Area (in Acr)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtOilCrop" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVOilCrop" ValidateEmptyText="true" ControlToValidate="txtOilCrop" SetFocusOnError="true" ClientValidationFunction="OilValidate" Display="Dynamic" ErrorMessage="Please Enter Pulse Crop value" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvOilAvg">
                                <div class="form-group">
                                    <asp:Label ID="Label41" runat="server" Text="Average Production (in kg)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtOilCropAvg" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVOilCropAvg" ValidateEmptyText="true" ControlToValidate="txtOilCropAvg" SetFocusOnError="true" ClientValidationFunction="OilAvgValidate" Display="Dynamic" ErrorMessage="Please Enter Average Production " CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvOilType">
                                <div class="form-group">
                                    <asp:Label ID="Label55" runat="server" Text="Type of Oils"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList runat="server" ID="ddlOilType" CssClass="form-control">
                                        <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="Coconuts" Text="Coconuts"></asp:ListItem>
                                        <asp:ListItem Value="Cotton Seed" Text="Cotton Seed"></asp:ListItem>
                                        <asp:ListItem Value="Groundnuts" Text="Groundnuts"></asp:ListItem>
                                        <asp:ListItem Value="Maize" Text="Maize"></asp:ListItem>
                                        <asp:ListItem Value="Olive" Text="Olive"></asp:ListItem>
                                        <asp:ListItem Value="Palm" Text="Palm"></asp:ListItem>
                                        <asp:ListItem Value="Palm Kernels" Text="Palm Kernels"></asp:ListItem>
                                        <asp:ListItem Value="Rapeseed" Text="Rapeseed"></asp:ListItem>
                                        <asp:ListItem Value="Safflower" Text="Safflower"></asp:ListItem>
                                        <asp:ListItem Value="Sesame Seed" Text="Sesame Seed"></asp:ListItem>
                                        <asp:ListItem Value="Sunflower Seed" Text="Sunflower Seed"></asp:ListItem>
                                        <asp:ListItem Value="Soya Beans" Text="Soya Beans"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator7" ValidateEmptyText="true" ControlToValidate="ddlOilType" SetFocusOnError="true" ClientValidationFunction="OilTypeValidate" Display="Dynamic" ErrorMessage="Please Select Oil Type" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Vegetables Crops"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblVegitables" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblVegitables" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvVegitable">
                                <div class="form-group">
                                    <asp:Label ID="Label24" runat="server" Text="Vegetables Crop Area (in Acr)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtVegitables" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVVegitables" ValidateEmptyText="true" ControlToValidate="txtVegitables" SetFocusOnError="true" ClientValidationFunction="VegitablesValidate" Display="Dynamic" ErrorMessage="Please Enter Vegitables value" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvVegitableAvg">
                                <div class="form-group">
                                    <asp:Label ID="Label42" runat="server" Text="Average Production (in kg)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtVegitablesAvg" runat="server" CssClass="form-control" oninput="NumberCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVVegitablesAvg" ValidateEmptyText="true" ControlToValidate="txtVegitablesAvg" SetFocusOnError="true" ClientValidationFunction="VegitablesAvgValidate" Display="Dynamic" ErrorMessage="Please Enter Average Production " CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvVegitableType">
                                <div class="form-group">
                                    <asp:Label ID="Label57" runat="server" Text="Type of Vegetables"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList runat="server" ID="ddlVegitableType" CssClass="form-control">
                                        <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        <asp:ListItem Value="Bulb / Stem" Text="Bulb / Stem"></asp:ListItem>
                                        <asp:ListItem Value="Fruit" Text="Fruit"></asp:ListItem>
                                        <asp:ListItem Value="Leaf / Flower" Text="Leaf / Flower"></asp:ListItem>
                                        <asp:ListItem Value="Leafy salad" Text="Leafy salad"></asp:ListItem>
                                        <asp:ListItem Value="Perennial" Text="Perennial"></asp:ListItem>
                                        <asp:ListItem Value="Pod or Grain Bearing" Text="Pod or Grain Bearing"></asp:ListItem>
                                        <asp:ListItem Value="Root" Text="Root"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator6" ValidateEmptyText="true" ControlToValidate="ddlVegitableType" SetFocusOnError="true" ClientValidationFunction="VegitablesTypeValidate" Display="Dynamic" ErrorMessage="Please Select Vegitables Type" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label runat="server" Text="Other Crops"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblOtherCrops" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblOtherCrops" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvOtherCropName">
                                <div class="form-group">
                                    <asp:Label ID="Label26" runat="server" Text="Crop Name"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtOtherCrop" oninput="SplCharCheck2(this)" runat="server" CssClass="form-control" />
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVOtherCropName" ValidateEmptyText="true" ControlToValidate="txtOtherCrop" SetFocusOnError="true" ClientValidationFunction="OtherCropNameValidate" Display="Dynamic" ErrorMessage="Please Enter Crop Name" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvOtherCropAcr">
                                <div class="form-group">
                                    <asp:Label ID="Label25" runat="server" Text="Crop Area (in Acr)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtOtherCropAcr" runat="server" CssClass="form-control" oninput="DecimalCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVOtherCropValue" ValidateEmptyText="true" ControlToValidate="txtOtherCropAcr" SetFocusOnError="true" ClientValidationFunction="OtherCropValueValidate" Display="Dynamic" ErrorMessage="Please Enter Crop Name" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3" id="dvOtherCropProd">
                                <div class="form-group">
                                    <asp:Label ID="Label43" runat="server" Text="Average Production (in kg)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtOtherCropAvg" runat="server" CssClass="form-control" oninput="DecimalCheck(this)"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVOtherCropAvg" ValidateEmptyText="true" ControlToValidate="txtOtherCropAvg" SetFocusOnError="true" ClientValidationFunction="OtherCropAvgValidate" Display="Dynamic" ErrorMessage="Please Enter Average Production " CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label81" runat="server" Text="Has attended trainings"></asp:Label><b style="color: red">*</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblAttendedTrainings" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblAttendedTrainings" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvTraining">
                            <div class="form-group">
                                <asp:Label ID="lblTraining" runat="server" Text="Name of the training attended"></asp:Label><b style="color: red"> *</b>
                                <asp:DropDownList ID="ddlTraining" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                    <asp:ListItem Value="Socio-economic rights, participation & managerial skills" Text="Socio-economic rights, participation & managerial skills"></asp:ListItem>
                                    <asp:ListItem Value="Gender sensitive governance" Text="Gender sensitive governance"></asp:ListItem>
                                    <asp:ListItem Value="Locally relevant methods & techniques of climate informed agriculture" Text="Locally relevant methods & techniques of climate informed agriculture"></asp:ListItem>
                                    <asp:ListItem Value="Entrepreneurship development" Text="Entrepreneurship development"></asp:ListItem>
                                    <asp:ListItem Value="Exposure visit to Demo Plot" Text="Exposure visit to Demo Plot"></asp:ListItem>
                                    <asp:ListItem Value="Other" Text="Any Other"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVTraining" ValidateEmptyText="true" ControlToValidate="ddlTraining" SetFocusOnError="true" ClientValidationFunction="TrainingValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvTrainingSpecify">
                            <div class="form-group">
                                <asp:Label ID="lblTrainingSpecify" runat="server" Text="Specify"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox runat="server" ID="txtTrainingSpecify" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVTrainingSpecify" ValidateEmptyText="true" ControlToValidate="txtTrainingSpecify" SetFocusOnError="true" ClientValidationFunction="TrainingSpecifyValidate" Display="Dynamic" ErrorMessage="Please Enter Other Training Attended" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvTrainingNo">
                            <div class="form-group">
                                <asp:Label ID="Label82" runat="server" Text="Number of follow up visits"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox runat="server" ID="txtTrainingNo" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVTrainingNo" ValidateEmptyText="true" ControlToValidate="txtTrainingNo" SetFocusOnError="true" ClientValidationFunction="TrainingNoValidate" Display="Dynamic" ErrorMessage="Please Enter Other Training Attended" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="lblsharecropper" runat="server" Text="Whether a sharecropper"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblsharecropper" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblsharecropper" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvAreaofland">
                            <div class="form-group">
                                <asp:Label ID="lblAreaofland" runat="server" Text="Area of land"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtAreaofland" runat="server" oninput="DecimalCheck(this)" MaxLength="6" CssClass="form-control"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator5" ValidateEmptyText="true" ControlToValidate="txtAreaofland" SetFocusOnError="true" ClientValidationFunction="AreaoflandHavingValidate" Display="Dynamic" ErrorMessage="Please Select CBO Type" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label5" runat="server" Text="Access To Business Services"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblBuisness" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblBuisness" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvService">
                            <div class="form-group">
                                <asp:Label ID="Label96" runat="server" Text="Which Service"></asp:Label><b style="color: red"> *</b>
                                <asp:DropDownList runat="server" ID="ddlAccessService" CssClass="form-control">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                    <asp:ListItem Value="Entrepreneurial mentoring" Text="Entrepreneurial mentoring"></asp:ListItem>
                                    <asp:ListItem Value="Advisory services-Business/finance Related" Text="Advisory services-Business/finance Related"></asp:ListItem>
                                    <asp:ListItem Value="Advisory Services-Technical -assistance for diversified businesses" Text="Advisory Services-Technical -assistance for diversified businesses"></asp:ListItem>
                                    <asp:ListItem Value="Other" Text="Other"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator27" ValidateEmptyText="true" ControlToValidate="ddlAccessService" SetFocusOnError="true" ClientValidationFunction="BusinessServiceValidate" Display="Dynamic" ErrorMessage="Please Select Service" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvServiceOther">
                            <div class="form-group">
                                <asp:Label ID="Label6" runat="server" Text="Which Service"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtAccessService" runat="server" oninput="SplCharCheck(this)" CssClass="form-control"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator1" ValidateEmptyText="true" ControlToValidate="txtAccessService" SetFocusOnError="true" ClientValidationFunction="BusinessServiceOtherValidate" Display="Dynamic" ErrorMessage="Please Enter Service" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label28" runat="server" Text="Practising Climate Friendly Agriculture"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblClimateFriendly" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblClimateFriendly" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <asp:Panel runat="server" GroupingText="Nature/Type Of Practice" ID="dvNaturePractice">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label29" runat="server" Text="Use of organic manure"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblNUOM" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator9" ValidateEmptyText="true" ControlToValidate="rblNUOM" SetFocusOnError="true" ClientValidationFunction="NUOMValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label84" runat="server" Text="Use of water conservation.-Micro irrigantion facilites"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblNUMIF" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator17" ValidateEmptyText="true" ControlToValidate="rblNUMIF" SetFocusOnError="true" ClientValidationFunction="NUMIFValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label85" runat="server" Text="Use of multi-cropping"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblNUMC" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator18" ValidateEmptyText="true" ControlToValidate="rblNUMC" SetFocusOnError="true" ClientValidationFunction="NUMCValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label86" runat="server" Text="O tillage farming"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblNOTF" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator19" ValidateEmptyText="true" ControlToValidate="rblNOTF" SetFocusOnError="true" ClientValidationFunction="NOTFValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label87" runat="server" Text="Direct seeded rice-BSR"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblNDSBSR" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator20" ValidateEmptyText="true" ControlToValidate="rblNDSBSR" SetFocusOnError="true" ClientValidationFunction="NDSBSRValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label88" runat="server" Text="Sysytem of Root Intensification"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblNSRI" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator21" ValidateEmptyText="true" ControlToValidate="rblNSRI" SetFocusOnError="true" ClientValidationFunction="NSRIValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label89" runat="server" Text="Carbon Reduction"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblNCR" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator22" ValidateEmptyText="true" ControlToValidate="rblNCR" SetFocusOnError="true" ClientValidationFunction="NCRValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label90" runat="server" Text="Use of Seeds Variety"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblNUSV" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator23" ValidateEmptyText="true" ControlToValidate="rblNUSV" SetFocusOnError="true" ClientValidationFunction="NUSVValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label91" runat="server" Text="Mixed cropping"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblNMC" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator24" ValidateEmptyText="true" ControlToValidate="rblNMC" SetFocusOnError="true" ClientValidationFunction="NMCValidate" Display="Dynamic" ErrorMessage="Please select an option" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label92" runat="server" Text="Other-Please specify"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtOtherPracticeType" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label32" runat="server" Text="Cultivating 3 or More Crops"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblMoreCultivating" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblMoreCultivating" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvCultivationg">
                            <div class="form-group">
                                <asp:Label ID="Label94" runat="server" Text="Which Crop"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtCultivatingCrop" runat="server" oninput="DecimalCheck(this)" MaxLength="6" CssClass="form-control"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator26" ValidateEmptyText="true" ControlToValidate="txtCultivatingCrop" SetFocusOnError="true" ClientValidationFunction="CultivatingCropValidate" Display="Dynamic" ErrorMessage="Please Enter Which Crop" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label33" runat="server" Text="Land Under Agriculture Use (in Acr)"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtAgriUse" runat="server" oninput="DecimalCheck(this)" MaxLength="6" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Land Under Agriculture Use" ControlToValidate="txtAgriUse" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label34" runat="server" Text="Land Under Agriculture-Under Productive & Sustainable Agriculture (in Acr)"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtProUse" runat="server" oninput="DecimalCheck(this)" MaxLength="6" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Land Under Productive & Sustainable Agriculture" ControlToValidate="txtProUse" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label35" runat="server" Text="Demonstrate And Increase In knowledge & Skills"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblDIKS" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblDIKS" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label46" runat="server" Text="Percentage of Woman Trained"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtPrecTrained" runat="server" oninput="DecimalCheck(this)" MaxLength="6" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Percentage Trained" ControlToValidate="txtPrecTrained" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label48" runat="server" Text="Pre Training score"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtPreTrainig" runat="server" oninput="DecimalCheck(this)" MaxLength="6" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Pre Training score" ControlToValidate="txtPreTrainig" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label49" runat="server" Text="Post Training score"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox ID="txtPostTraining" runat="server" oninput="DecimalCheck(this)" MaxLength="6" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please Enter Post Training score" ControlToValidate="txtPostTraining" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <asp:Label ID="Label50" runat="server" Text="Knows How To Obtain a Loan From a Formal Financial Institution"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblKOLFI" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    <asp:ListItem Value="Not Sure" Text="Not Sure"></asp:ListItem>
                                    <asp:ListItem Value="Some What" Text="Some What"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblKOLFI" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label95" runat="server" Text="WFG members that have developed financial literacy"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblFinance" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblFinance" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <asp:Label ID="Label51" runat="server" Text="Feels Confident In Managing Money"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblManageMoney" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    <asp:ListItem Value="Not Sure" Text="Not Sure"></asp:ListItem>
                                    <asp:ListItem Value="Some What" Text="Some What"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblManageMoney" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <asp:Label ID="Label52" runat="server" Text="Buisness Plans Developed"></asp:Label><b style="color: red"> *</b>
                                <asp:RadioButtonList CssClass="LableSpace" ID="rblBuisnessDevelop" RepeatDirection="Horizontal" runat="server">
                                    <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                    <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblBuisnessDevelop" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-3" id="dvBusinessType">
                            <div class="form-group">
                                <asp:Label ID="Label83" runat="server" Text="Type of Business"></asp:Label><b style="color: red"> *</b>
                                <asp:TextBox runat="server" ID="txtBusinessPlanType" CssClass="form-control" oninput="SplCharCheck(this)"></asp:TextBox>
                                <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator16" ValidateEmptyText="true" ControlToValidate="txtBusinessPlanType" SetFocusOnError="true" ClientValidationFunction="TypeofBusinessValidate" Display="Dynamic" ErrorMessage="Please Enter Type of Business" CssClass="text-danger" runat="server"></asp:CustomValidator>
                            </div>
                        </div>
                    </div>
                    <asp:Panel runat="server" GroupingText="Participate In Decisions About Use Of Productive Resources">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label53" runat="server" Text="Have Access to ICT"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblICTAccess" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblICTAccess" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label58" runat="server" Text="Choice of crops"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblCropChoice" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblCropChoice" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label59" runat="server" Text="Inputs-Material investment in agriculture"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblInput" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblInput" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label60" runat="server" Text="Deciding crop cycle"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblDeciding" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblDeciding" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label61" runat="server" Text="Timing of cropping"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblTimimg" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblTimimg" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label62" runat="server" Text="Deciding crop sowing time"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblDecidingTime" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblDecidingTime" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label63" runat="server" Text="Crop harvesting"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblHarvesting" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblHarvesting" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label64" runat="server" Text="Sale/transfer of land"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblSaleLand" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblSaleLand" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" GroupingText="Participate (solely) In Decisions About HH income">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label65" runat="server" Text="Women Self Development"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblSoWomen" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblSoWomen" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label66" runat="server" Text="Material/investment in agriculture"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblSoMaterial" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblSoMaterial" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label67" runat="server" Text="Selling agro-produce"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblSoAgro" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblSoAgro" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label68" runat="server" Text="Selling/transferring land"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblSoSelling" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblSoSelling" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label69" runat="server" Text="Expenditure planning of income"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblSoExpenditure" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblSoExpenditure" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" GroupingText="Participate (jointly) In Decisions About HH income">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label70" runat="server" Text="Women Self Development"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblJoWomen" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblJoWomen" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label71" runat="server" Text="Material/investment in agriculture"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblJoMaterial" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblJoMaterial" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label72" runat="server" Text="Selling agro-produce"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblJoAgro" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblJoAgro" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label73" runat="server" Text="Selling/transferring land"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblJoSelling" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblJoSelling" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label74" runat="server" Text="Expenditure planning of income"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblJoExpenditure" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblJoExpenditure" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label75" runat="server" Text="Member is Part of ON farm in FPC"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblOnFarm" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblOnFarm" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label76" runat="server" Text="Member is Part of OFF farm in FPC"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblOffFarm" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblOffFarm" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label77" runat="server" Text="Has Become a Shareholder In a FPC"></asp:Label><b style="color: red"> *</b>
                                    <asp:RadioButtonList CssClass="LableSpace" ID="rblShareHolder" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ValidationGroup="PreviewCheck" runat="server" CssClass="text-danger" ErrorMessage="Please select an option" ControlToValidate="rblShareHolder" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="dvFPCShareHolder">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label78" runat="server" Text="Name Of FPC of Which the WF Is Member"></asp:Label><b style="color: red"> *</b>
                                    <asp:DropDownList runat="server" ID="ddlFPCName" CssClass="form-control">
                                        <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator14" ValidateEmptyText="true" ControlToValidate="ddlFPCName" SetFocusOnError="true" ClientValidationFunction="FPCNamevalidate" Display="Dynamic" ErrorMessage="Please Enter Other Source" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <asp:Label ID="Label79" runat="server" Text="How many shares"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox runat="server" ID="txtFPCShares" onblur="GetFilterTable()" class="form-control"></asp:TextBox>
                                    <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CustomValidator15" ValidateEmptyText="true" ControlToValidate="txtFPCShares" SetFocusOnError="true" ClientValidationFunction="FPCSharevalidate" Display="Dynamic" ErrorMessage="Please Enter Other Source" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                       <asp:UpdatePanel runat="server" ID="upfpc">
                        <ContentTemplate>
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
                                        <asp:DropDownList ID="ddlFPCName1" CssClass="form-control" runat="server">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:CustomValidator ValidationGroup="PreviewCheck" ID="CVFPCName" ValidateEmptyText="true" ControlToValidate="ddlFPCName1" SetFocusOnError="true" ClientValidationFunction="FPCNameValidate1" Display="Dynamic" ErrorMessage="Please Enter FPC Name" CssClass="text-danger" runat="server"></asp:CustomValidator>
                                    </div>
                                </div>
                            </div>
                        
                   </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="box-footer clearfix">
                    <a id="btnCancel" runat="server" class="btn btn-danger" href="WFDataTrackingInfo.aspx">Cancel</a>
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" ValidationGroup="PreviewCheck" CssClass="btn btn-primary" OnClick="btnsubmit_Click" />
                </div>

            </div>
        </form>
    </section>
    <script>
        $(document).ready(function () {
            $("#liDataManage").addClass('active menu-open');
            $("#liWFDatatrack").addClass("active");

            $(".YearPicker").datepicker({
                format: "yyyy", // Notice the Extra space at the beginning
                viewMode: "years",
                minViewMode: "years",
                autoclose: true
            });
            document.getElementById('dvMNREGADays').style.display = "none";
            document.getElementById('dvNatureofWork').style.display = "none";
            document.getElementById('dvOtherSource').style.display = "none";
            document.getElementById('dvBenfitName').style.display = "none";
            document.getElementById('dvOtherBenfits').style.display = "none";
            document.getElementById('dvBenfitAmount').style.display = "none";
            document.getElementById('dvNoofLivestock').style.display = "none";
            document.getElementById('dvCow').style.display = "none";
            document.getElementById('dvBuffalo').style.display = "none";
            document.getElementById('dvLiveStock').style.display = "none";
            document.getElementById('dvOwnLand').style.display = "none";
            document.getElementById('dvTotlairrigationland').style.display = "none";
            document.getElementById('dvIrrigationSource').style.display = "none";
            document.getElementById('dvIrrigationSpecify').style.display = "none";
            document.getElementById('dvPaddy').style.display = "none";
            document.getElementById('dvWheat').style.display = "none";
            document.getElementById('dvPulse').style.display = "none";
            document.getElementById('dvOil').style.display = "none";
            document.getElementById('dvVegitable').style.display = "none";
            document.getElementById('dvOtherCropName').style.display = "none";
            document.getElementById('dvOtherCropAcr').style.display = "none";
            document.getElementById('dvOtherCropProd').style.display = "none";
            document.getElementById('dvPaddyAvg').style.display = "none";
            document.getElementById('dvWheatAvg').style.display = "none";
            document.getElementById('dvPulseAvg').style.display = "none";
            document.getElementById('dvPulseType').style.display = "none";
            document.getElementById('dvOilAvg').style.display = "none";
            document.getElementById('dvOilType').style.display = "none";
            document.getElementById('dvVegitableAvg').style.display = "none";
            document.getElementById('dvVegitableType').style.display = "none";
            document.getElementById('dvAreaofland').style.display = "none";
            document.getElementById('dvService').style.display = "none";
            document.getElementById('ContentPlaceHolder1_dvNaturePractice').style.display = "none";
            document.getElementById('dvFPCShareHolder').style.display = "none";
            document.getElementById('dvGovScheme').style.display = "none";
            document.getElementById('dvGovSchemeAmt').style.display = "none";
            document.getElementById('dvLandHaving').style.display = "none";
            document.getElementById('dvTraining').style.display = "none";
            document.getElementById('dvTrainingSpecify').style.display = "none";
            document.getElementById('dvTrainingNo').style.display = "none";
            document.getElementById('dvBusinessType').style.display = "none";
            document.getElementById('dvCultivationg').style.display = "none";
            document.getElementById('dvServiceOther').style.display = "none";

            var rbl = $("#<%= ddlAccessService.ClientID %> input:checked").val();
            if (rbl == 'Other') {
                document.getElementById('dvServiceOther').style.display = "block";
            } else {
                document.getElementById('dvServiceOther').style.display = "none";
            }

            var rbl = $("#<%= rblOwnerShipinland.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvLandHaving').style.display = "block";
            } else {
                document.getElementById('dvLandHaving').style.display = "none";
            }

            var rbl = $("#<%= rblMoreCultivating.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvCultivationg').style.display = "block";
            } else {
                document.getElementById('dvCultivationg').style.display = "none";
            }

            var ddl = $("#<%= rblAttendedTrainings.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvTraining').style.display = "block";
                document.getElementById('dvTrainingNo').style.display = "block";
            } else {
                document.getElementById('dvTraining').style.display = "none";
                document.getElementById('dvTrainingSpecify').style.display = "none";
                document.getElementById('dvTrainingNo').style.display = "none";
            }

            var ddl = $("#<%= ddlTraining.ClientID %> option:selected").val();
            if (ddl == 'Other') {
                document.getElementById('dvTrainingSpecify').style.display = "block";
            } else {
                document.getElementById('dvTrainingSpecify').style.display = "none";
            }

            var rbl = $("#<%= rblGovScheme.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvGovScheme').style.display = "block";
                document.getElementById('dvGovSchemeAmt').style.display = "block";
            } else {
                document.getElementById('dvGovScheme').style.display = "none";
                document.getElementById('dvGovSchemeAmt').style.display = "none";
            }

            var rbl = $("#<%= rblShareHolder.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvFPCShareHolder').style.display = "block";
            } else {
                document.getElementById('dvFPCShareHolder').style.display = "none";
            }

            var rbl = $("#<%= rblClimateFriendly.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('ContentPlaceHolder1_dvNaturePractice').style.display = "block";
            } else {
                document.getElementById('ContentPlaceHolder1_dvNaturePractice').style.display = "none";
            }

            var rbl = $("#<%= rblBuisness.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvService').style.display = "block";
            } else {
                document.getElementById('dvService').style.display = "none";
            }

            var rbl = $("#<%= rblsharecropper.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvAreaofland').style.display = "block";
            } else {
                document.getElementById('dvAreaofland').style.display = "none";
            }

            var rbl = $("#<%= rblMNREGA.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvMNREGADays').style.display = "block";
            } else {
                document.getElementById('dvMNREGADays').style.display = "none";
            }

            var rbl = $("#<%= rblLabourer.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvNatureofWork').style.display = "block";
            } else {
                document.getElementById('dvNatureofWork').style.display = "none";
            }

            var ddl = $("#<%= ddlMajorSource.ClientID %> option:selected").val();
            if (ddl == 'Other') {
                document.getElementById('dvOtherSource').style.display = "block";
            } else {
                document.getElementById('dvOtherSource').style.display = "none";
            }

            var rbl = $("#<%= rblBenifits.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvBenfitName').style.display = "block";
                document.getElementById('dvBenfitAmount').style.display = "block";
            } else {
                document.getElementById('dvBenfitName').style.display = "none";
                document.getElementById('dvBenfitAmount').style.display = "none";
            }

            var ddl = $("#<%= ddlBenfitName.ClientID %> option:selected").val();
            if (ddl == 'Other') {
                document.getElementById('dvOtherBenfits').style.display = "block";
            } else {
                document.getElementById('dvOtherBenfits').style.display = "none";
            }

            var rbl = $("#<%= rblLivestock.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvNoofLivestock').style.display = "block";
                document.getElementById('dvCow').style.display = "block";
                document.getElementById('dvBuffalo').style.display = "block";
                document.getElementById('dvLiveStock').style.display = "block";
            } else {
                document.getElementById('dvNoofLivestock').style.display = "none";
                document.getElementById('dvCow').style.display = "none";
                document.getElementById('dvBuffalo').style.display = "none";
                document.getElementById('dvLiveStock').style.display = "none";
            }

            var rbl = $("#<%= rblownlandSelfName.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvOwnLand').style.display = "block";
            } else {
                document.getElementById('dvOwnLand').style.display = "none";
            }

            var rbl = $("#<%= rblIrrigatedLand.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvTotlairrigationland').style.display = "block";
                document.getElementById('dvIrrigationSource').style.display = "block";
            } else {
                document.getElementById('dvTotlairrigationland').style.display = "none";
                document.getElementById('dvIrrigationSource').style.display = "none";
            }

            var ddl = $("#<%= ddlIrrigation.ClientID %> option:selected").val();
            if (ddl == 'Other') {
                document.getElementById('dvIrrigationSpecify').style.display = "block";
            } else {
                document.getElementById('dvIrrigationSpecify').style.display = "none";
            }

            var rbl = $("#<%= rblPaddy.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvPaddy').style.display = "block";
                document.getElementById('dvPaddyAvg').style.display = "block";
            } else {
                document.getElementById('dvPaddy').style.display = "none";
                document.getElementById('dvPaddyAvg').style.display = "none";
            }

            var rbl = $("#<%= rblWheat.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvWheat').style.display = "block";
                document.getElementById('dvWheatAvg').style.display = "block";
            } else {
                document.getElementById('dvWheat').style.display = "none";
                document.getElementById('dvWheatAvg').style.display = "none";
            }

            var rbl = $("#<%= rblPulseCrops.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvPulse').style.display = "block";
                document.getElementById('dvPulseAvg').style.display = "block";
                document.getElementById('dvPulseType').style.display = "block";
            } else {
                document.getElementById('dvPulse').style.display = "none";
                document.getElementById('dvPulseAvg').style.display = "none";
                document.getElementById('dvPulseType').style.display = "none";
            }

            var rbl = $("#<%= rblOilCrop.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvOil').style.display = "block";
                document.getElementById('dvOilAvg').style.display = "block";
                document.getElementById('dvOilType').style.display = "block";

            } else {
                document.getElementById('dvOil').style.display = "none";
                document.getElementById('dvOilAvg').style.display = "none";
                document.getElementById('dvOilType').style.display = "none";
            }

            var rbl = $("#<%= rblVegitables.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvVegitable').style.display = "block";
                document.getElementById('dvVegitableAvg').style.display = "block";
                document.getElementById('dvVegitableType').style.display = "block";
            } else {
                document.getElementById('dvVegitable').style.display = "none";
                document.getElementById('dvVegitableAvg').style.display = "none";
                document.getElementById('dvVegitableType').style.display = "none";
            }

            var rbl = $("#<%= rblOtherCrops.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvOtherCropName').style.display = "block";
                document.getElementById('dvOtherCropAcr').style.display = "block";
                document.getElementById('dvOtherCropProd').style.display = "block";
            } else {
                document.getElementById('dvOtherCropName').style.display = "none";
                document.getElementById('dvOtherCropAcr').style.display = "none";
                document.getElementById('dvOtherCropProd').style.display = "none";
            }
        });

        $('#<%=ddlAccessService.ClientID %>').change(function () {
            var rbl = $("#<%= ddlAccessService.ClientID %> input:checked").val();
            if (rbl == 'Other') {
                document.getElementById('dvServiceOther').style.display = "block";
            } else {
                document.getElementById('dvServiceOther').style.display = "none";
            }
        });

        $('#<%=rblOwnerShipinland.ClientID %>').change(function () {
            var rbl = $("#<%= rblOwnerShipinland.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvLandHaving').style.display = "block";
            } else {
                document.getElementById('dvLandHaving').style.display = "none";
            }
        });

        $('#<%=rblMoreCultivating.ClientID %>').change(function () {
            var rbl = $("#<%= rblMoreCultivating.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvCultivationg').style.display = "block";
            } else {
                document.getElementById('dvCultivationg').style.display = "none";
            }
        });

        $('#<%=rblAttendedTrainings.ClientID %>').change(function () {
            var ddl = $("#<%= rblAttendedTrainings.ClientID %> input:checked").val();
            if (ddl == 'Yes') {
                document.getElementById('dvTraining').style.display = "block";
                document.getElementById('dvTrainingNo').style.display = "block";
            } else {
                document.getElementById('dvTraining').style.display = "none";
                document.getElementById('dvTrainingSpecify').style.display = "none";
                document.getElementById('dvTrainingNo').style.display = "none";
            }
        });
        $('#<%=ddlTraining.ClientID %>').change(function () {
            var ddl = $("#<%= ddlTraining.ClientID %> option:selected").val();
            if (ddl == 'Other') {
                document.getElementById('dvTrainingSpecify').style.display = "block";
            } else {
                document.getElementById('dvTrainingSpecify').style.display = "none";
            }
        });

        $('#<%=rblGovScheme.ClientID %>').change(function () {
            var rbl = $("#<%= rblGovScheme.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvGovScheme').style.display = "block";
                document.getElementById('dvGovSchemeAmt').style.display = "block";
            } else {
                document.getElementById('dvGovScheme').style.display = "none";
                document.getElementById('dvGovSchemeAmt').style.display = "none";
            }
        });

        $('#<%=rblShareHolder.ClientID %>').change(function () {
            var rbl = $("#<%= rblShareHolder.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvFPCShareHolder').style.display = "block";
            } else {
                document.getElementById('dvFPCShareHolder').style.display = "none";
            }
        });

        $('#<%=rblClimateFriendly.ClientID %>').change(function () {
            var rbl = $("#<%= rblClimateFriendly.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('ContentPlaceHolder1_dvNaturePractice').style.display = "block";
            } else {
                document.getElementById('ContentPlaceHolder1_dvNaturePractice').style.display = "none";
            }
        });

        $('#<%=rblBuisness.ClientID %>').change(function () {
            var rbl = $("#<%= rblBuisness.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvService').style.display = "block";
            } else {
                document.getElementById('dvService').style.display = "none";
            }
        });

        $('#<%=rblsharecropper.ClientID %>').change(function () {
            var rbl = $("#<%= rblsharecropper.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvAreaofland').style.display = "block";
            } else {
                document.getElementById('dvAreaofland').style.display = "none";
            }
        });

        $('#<%=rblMNREGA.ClientID %>').change(function () {
            var rbl = $("#<%= rblMNREGA.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvMNREGADays').style.display = "block";
            } else {
                document.getElementById('dvMNREGADays').style.display = "none";
            }
        });

        $('#<%=rblLabourer.ClientID %>').change(function () {
            var rbl = $("#<%= rblLabourer.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvNatureofWork').style.display = "block";
            } else {
                document.getElementById('dvNatureofWork').style.display = "none";
            }
        });

        $('#<%=ddlMajorSource.ClientID %>').change(function () {
            var ddl = $("#<%= ddlMajorSource.ClientID %> option:selected").val();
            if (ddl == 'Other') {
                document.getElementById('dvOtherSource').style.display = "block";
            } else {
                document.getElementById('dvOtherSource').style.display = "none";
            }

        });

        $('#<%=rblBenifits.ClientID %>').change(function () {
            var rbl = $("#<%= rblBenifits.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvBenfitName').style.display = "block";
                document.getElementById('dvBenfitAmount').style.display = "block";
            } else {
                document.getElementById('dvBenfitName').style.display = "none";
                document.getElementById('dvBenfitAmount').style.display = "none";
            }

        });

        $('#<%=ddlBenfitName.ClientID %>').change(function () {
            var ddl = $("#<%= ddlBenfitName.ClientID %> option:selected").val();
            if (ddl == 'Other') {
                document.getElementById('dvOtherBenfits').style.display = "block";
            } else {
                document.getElementById('dvOtherBenfits').style.display = "none";
            }
        });

        $('#<%=rblLivestock.ClientID %>').change(function () {
            var rbl = $("#<%= rblLivestock.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvNoofLivestock').style.display = "block";
                document.getElementById('dvCow').style.display = "block";
                document.getElementById('dvBuffalo').style.display = "block";
                document.getElementById('dvLiveStock').style.display = "block";
            } else {
                document.getElementById('dvNoofLivestock').style.display = "none";
                document.getElementById('dvCow').style.display = "none";
                document.getElementById('dvBuffalo').style.display = "none";
                document.getElementById('dvLiveStock').style.display = "none";
            }
        });

        $('#<%=rblownlandSelfName.ClientID %>').change(function () {
            var rbl = $("#<%= rblownlandSelfName.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvOwnLand').style.display = "block";
            } else {
                document.getElementById('dvOwnLand').style.display = "none";
            }
        });

        $('#<%=rblIrrigatedLand.ClientID %>').change(function () {
            var rbl = $("#<%= rblIrrigatedLand.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvTotlairrigationland').style.display = "block";
                document.getElementById('dvIrrigationSource').style.display = "block";
            } else {
                document.getElementById('dvTotlairrigationland').style.display = "none";
                document.getElementById('dvIrrigationSource').style.display = "none";
            }
        });

        $('#<%=ddlIrrigation.ClientID %>').change(function () {
            var ddl = $("#<%= ddlIrrigation.ClientID %> option:selected").val();
            if (ddl == 'Other') {
                document.getElementById('dvIrrigationSpecify').style.display = "block";
            } else {
                document.getElementById('dvIrrigationSpecify').style.display = "none";
            }
        });

        $('#<%=rblPaddy.ClientID %>').change(function () {
            var rbl = $("#<%= rblPaddy.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvPaddy').style.display = "block";
                document.getElementById('dvPaddyAvg').style.display = "block";
            } else {
                document.getElementById('dvPaddy').style.display = "none";
                document.getElementById('dvPaddyAvg').style.display = "none";
            }

        });

        $('#<%=rblWheat.ClientID %>').change(function () {
            var rbl = $("#<%= rblWheat.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvWheat').style.display = "block";
                document.getElementById('dvWheatAvg').style.display = "block";
            } else {
                document.getElementById('dvWheat').style.display = "none";
                document.getElementById('dvWheatAvg').style.display = "none";
            }

        });

        $('#<%=rblPulseCrops.ClientID %>').change(function () {
            var rbl = $("#<%= rblPulseCrops.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvPulse').style.display = "block";
                document.getElementById('dvPulseAvg').style.display = "block";
                document.getElementById('dvPulseType').style.display = "block";
            } else {
                document.getElementById('dvPulse').style.display = "none";
                document.getElementById('dvPulseAvg').style.display = "none";
                document.getElementById('dvPulseType').style.display = "none";
            }
        });

        $('#<%=rblOilCrop.ClientID %>').change(function () {
            var rbl = $("#<%= rblOilCrop.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvOil').style.display = "block";
                document.getElementById('dvOilAvg').style.display = "block";
                document.getElementById('dvOilType').style.display = "block";

            } else {
                document.getElementById('dvOil').style.display = "none";
                document.getElementById('dvOilAvg').style.display = "none";
                document.getElementById('dvOilType').style.display = "none";
            }
        });

        $('#<%=rblVegitables.ClientID %>').change(function () {
            var rbl = $("#<%= rblVegitables.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvVegitable').style.display = "block";
                document.getElementById('dvVegitableAvg').style.display = "block";
                document.getElementById('dvVegitableType').style.display = "block";
            } else {
                document.getElementById('dvVegitable').style.display = "none";
                document.getElementById('dvVegitableAvg').style.display = "none";
                document.getElementById('dvVegitableType').style.display = "none";
            }
        });

        $('#<%=rblOtherCrops.ClientID %>').change(function () {
            var rbl = $("#<%= rblOtherCrops.ClientID %> input:checked").val();
            if (rbl == 'Yes') {
                document.getElementById('dvOtherCropName').style.display = "block";
                document.getElementById('dvOtherCropAcr').style.display = "block";
                document.getElementById('dvOtherCropProd').style.display = "block";
            } else {
                document.getElementById('dvOtherCropName').style.display = "none";
                document.getElementById('dvOtherCropAcr').style.display = "none";
                document.getElementById('dvOtherCropProd').style.display = "none";
            }
        });

        function MNREGADaysvalidate(source, arguments) {
            var txt = document.getElementById('<%=txtMNREGADays.ClientID%>');
            var rbl = $("#<%= rblMNREGA.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function NatureofWorkvalidate(source, arguments) {
            var txt = document.getElementById('<%=txtNatureofWork.ClientID%>');
            var rbl = $("#<%= rblLabourer.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function MajorSourcevalidate(source, arguments) {
            var txt = document.getElementById('<%=txtOtherSource.ClientID%>');
            var ddl = $("#<%= ddlMajorSource.ClientID %> option:selected").val();

            if (ddl == 'Other') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function Benfitsvalidate(source, arguments) {
            var ddl = document.getElementById('<%=ddlBenfitName.ClientID%>');
            var rbl = $("#<%= rblBenifits.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = ddl.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function OtherBenfitsvalidate(source, arguments) {
            var txt = document.getElementById('<%=txtOtherBenfit.ClientID%>');
            var ddl = $("#<%= ddlBenfitName.ClientID %> option:selected").val();

            if (ddl == 'Other') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function FPCNameValidate1(source, arguments) {
            var txt = document.getElementById('ContentPlaceHolder1_ddlFPCName1');

            //var ddl = document.getElementById('ContentPlaceHolder1_rblRationCard');
            var ddl = $("#<%= rblWantFPC.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function BenfitAmountvalidate(source, arguments) {
            var txt = document.getElementById('<%=txtBenfitAmount.ClientID%>');
            var rbl = $("#<%= rblBenifits.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function OwnLandCheck(source, arguments) {
            var txt = document.getElementById('<%=txtownlandSelfName.ClientID%>');
            var rbl = $("#<%= rblownlandSelfName.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function TotlairrigationlandValidate(source, arguments) {
            var txt = document.getElementById('<%=txtTotlairrigationland.ClientID%>');
            var rbl = $("#<%= rblIrrigatedLand.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function IrrigationSourceValidate(source, arguments) {
            var ddl = document.getElementById('<%=ddlIrrigation.ClientID%>');
            var rbl = $("#<%= rblIrrigatedLand.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = ddl.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function IrrigationSpecifyValidate(source, arguments) {
            var ddl = $("#<%= ddlIrrigation.ClientID %> option:selected").val();
            var txt = document.getElementById('<%=txtIrrigationSpecify.ClientID%>');
            var rbl = $("#<%= rblIrrigatedLand.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                if (ddl == "Other") {
                    arguments.IsValid = txt.value.length > 0;
                }
                else {
                    arguments.IsValid = true;
                }
            }
            else {
                arguments.IsValid = true;
            }
        }

        function LandHavingValidate(source, arguments) {
            var txt = document.getElementById('<%=txtLandHaving.ClientID%>');
            var rbl = $("#<%= rblOwnerShipinland.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function GovSchemeValidate(source, arguments) {
            var txt = document.getElementById('<%=txtGovScheme.ClientID%>');
            var rbl = $("#<%= rblGovScheme.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function GovSchemeAmtValidate(source, arguments) {
            var txt = document.getElementById('<%=txtGovAmt.ClientID%>');
            var rbl = $("#<%= rblGovScheme.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = txt.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function PaddyValidate(source, arguments) {
            var name = document.getElementById('<%=txtPaddy.ClientID%>');
            var rbl = $("#<%= rblPaddy.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function PaddyAvgValidate(source, arguments) {
            var name = document.getElementById('<%=txtPaddyAvg.ClientID%>');
            var rbl = $("#<%= rblPaddy.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function VegitablesValidate(source, arguments) {
            var name = document.getElementById('<%=txtVegitables.ClientID%>');
            var rbl = $("#<%= rblVegitables.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function VegitablesAvgValidate(source, arguments) {
            var name = document.getElementById('<%=txtVegitablesAvg.ClientID%>');
            var rbl = $("#<%= rblVegitables.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function VegitablesTypeValidate(source, arguments) {
            var name = document.getElementById('<%=ddlVegitableType.ClientID%>');
            var rbl = $("#<%= rblVegitables.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function WheatValidate(source, arguments) {
            var name = document.getElementById('<%=txtWheat.ClientID%>');
            var rbl = $("#<%= rblWheat.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function WheatAvgValidate(source, arguments) {
            var name = document.getElementById('<%=txtWheatAvg.ClientID%>');
            var rbl = $("#<%= rblWheat.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function PulseValidate(source, arguments) {
            var name = document.getElementById('<%=txtPulseCrop.ClientID%>');
            var rbl = $("#<%= rblPulseCrops.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function PulseAvgValidate(source, arguments) {
            var name = document.getElementById('<%=txtPulseCropAvg.ClientID%>');
            var rbl = $("#<%= rblPulseCrops.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function PulseTypeValidate(source, arguments) {
            var name = document.getElementById('<%=ddlPulseType.ClientID%>');
            var rbl = $("#<%= rblPulseCrops.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function OilValidate(source, arguments) {
            var name = document.getElementById('<%=txtOilCrop.ClientID%>');
            var rbl = $("#<%= rblOilCrop.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function OilAvgValidate(source, arguments) {
            var name = document.getElementById('<%=txtOilCropAvg.ClientID%>');
            var rbl = $("#<%= rblOilCrop.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function OilTypeValidate(source, arguments) {
            var name = document.getElementById('<%=ddlOilType.ClientID%>');
            var rbl = $("#<%= rblOilCrop.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function OtherCropNameValidate(source, arguments) {
            var name = document.getElementById('<%=txtOtherCrop.ClientID%>');
            var rbl = $("#<%= rblOtherCrops.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function OtherCropAvgValidate(source, arguments) {
            var name = document.getElementById('<%=txtOtherCropAvg.ClientID%>');
            var rbl = $("#<%= rblOtherCrops.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function OtherCropValueValidate(source, arguments) {
            var name = document.getElementById('<%=txtOtherCropAcr.ClientID%>');
            var rbl = $("#<%= rblOtherCrops.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function AreaoflandHavingValidate(source, arguments) {
            var name = document.getElementById('<%=txtAreaofland.ClientID%>');
            var rbl = $("#<%= rblsharecropper.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function BusinessServiceValidate(source, arguments) {
            var name = document.getElementById('<%=ddlAccessService.ClientID%>');
            var rbl = $("#<%= rblBuisness.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function BusinessServiceOtherValidate(source, arguments) {
            var name = document.getElementById('<%=txtAccessService.ClientID%>');
            var rbl = $("#<%= rblBuisness.ClientID %> input:checked").val();
            var ddl = $('#<%=ddlAccessService.ClientID%> option:selected').val();

            if (rbl == 'Yes') {
                if (ddl == "Other") {
                    arguments.IsValid = name.value.length > 0;
                }
                else {
                    arguments.IsValid = true;
                }
            } else {
                arguments.IsValid = true;
            }
        }

        function NUOMValidate(source, arguments) {
            var name = $("#<%= rblNUOM.ClientID %> input:checked").val();
            var rbl = $("#<%= rblClimateFriendly.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name == "Yes" || name == "No";
            } else {
                arguments.IsValid = true;
            }
        }

        function NUMIFValidate(source, arguments) {
            var name = $("#<%= rblNUMIF.ClientID %> input:checked").val();
            var rbl = $("#<%= rblClimateFriendly.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name == "Yes" || name == "No";
            } else {
                arguments.IsValid = true;
            }
        }

        function NUMCValidate(source, arguments) {
            var name = $("#<%= rblNUMC.ClientID %> input:checked").val();
            var rbl = $("#<%= rblClimateFriendly.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name == "Yes" || name == "No";
            } else {
                arguments.IsValid = true;
            }
        }

        function NOTFValidate(source, arguments) {
            var name = $("#<%= rblNOTF.ClientID %> input:checked").val();
            var rbl = $("#<%= rblClimateFriendly.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name == "Yes" || name == "No";
            } else {
                arguments.IsValid = true;
            }
        }

        function NDSBSRValidate(source, arguments) {
            var name = $("#<%= rblNDSBSR.ClientID %> input:checked").val();
            var rbl = $("#<%= rblClimateFriendly.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name == "Yes" || name == "No";
            } else {
                arguments.IsValid = true;
            }
        }

        function NSRIValidate(source, arguments) {
            var name = $("#<%= rblNSRI.ClientID %> input:checked").val();
            var rbl = $("#<%= rblClimateFriendly.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name == "Yes" || name == "No";
            } else {
                arguments.IsValid = true;
            }
        }

        function NCRValidate(source, arguments) {
            var name = $("#<%= rblNCR.ClientID %> input:checked").val();
            var rbl = $("#<%= rblClimateFriendly.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name == "Yes" || name == "No";
            } else {
                arguments.IsValid = true;
            }
        }


        function NUSVValidate(source, arguments) {
            var name = $("#<%= rblNCR.ClientID %> input:checked").val();
            var rbl = $("#<%= rblClimateFriendly.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name == "Yes" || name == "No";
            } else {
                arguments.IsValid = true;
            }
        }

        function CultivatingCropValidate(source, arguments) {
            var name = document.getElementById('<%=txtCultivatingCrop.ClientID%>');
            var rbl = $("#<%= rblMoreCultivating.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function FPCNamevalidate(source, arguments) {
            var name = document.getElementById('<%=ddlFPCName.ClientID%>');
            var rbl = $("#<%=rblShareHolder.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function FPCSharevalidate(source, arguments) {
            var name = document.getElementById('<%=txtFPCShares.ClientID%>');
            var rbl = $("#<%=rblShareHolder.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function TrainingValidate(source, arguments) {
            var txt = document.getElementById('ContentPlaceHolder1_ddlTraining');

            var ddl = $("#<%= rblAttendedTrainings.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = txt.selectedIndex > 0;
            } else {
                arguments.IsValid = true;
            }
        }
        function TrainingSpecifyValidate(source, arguments) {
            var name = document.getElementById('<%=txtTrainingSpecify.ClientID%>');
            var rbl = $("#<%= rblAttendedTrainings.ClientID %> input:checked").val();
            var ddl = $("#<%= ddlTraining.ClientID %> option:selected").val();
            if (rbl == 'Yes') {
                if (ddl == 'Other') {
                    arguments.IsValid = name.value.length > 0;
                } else {
                    arguments.IsValid = true;
                }
            }
            else {
                arguments.IsValid = true;
            }
        }
        function TrainingNoValidate(source, arguments) {
            var name = document.getElementById('<%=txtTrainingNo.ClientID%>');
            var ddl = $("#<%= rblAttendedTrainings.ClientID %> input:checked").val();

            if (ddl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function TypeofBusinessValidate(source, arguments) {
            var name = document.getElementById('<%=txtBusinessPlanType.ClientID%>');
            var rbl = $("#<%= rblBuisnessDevelop.ClientID %> input:checked").val();

            if (rbl == 'Yes') {
                arguments.IsValid = name.value.length > 0;
            } else {
                arguments.IsValid = true;
            }
        }

        function GetTotalLand() {
            var rbl = $("#<%=rblownlandSelfName.ClientID%> input:checked").val()
            var Ownland = '0';
            if (rbl == "Yes") {
                Ownland = $("#<%=txtownlandSelfName.ClientID%>").val();
                if (Ownland.trim() == "") {
                    Ownland = '0';
                }
            }
            var OtherOwnLand = $("#<%=txtOwnLand.ClientID%>").val();
            if (OtherOwnLand.trim() == "") {
                OtherOwnLand = '0';
            }
            var RentalLand = $("#<%=txtRentalLand.ClientID%>").val();
            if (RentalLand.trim() == "") {
                RentalLand = '0';
            }
            var total = parseFloat(Ownland) + parseFloat(OtherOwnLand) + parseFloat(RentalLand);
            $("#<%=txtLandinHectore.ClientID%>").val(total);
            $("#<%=hfLandinHectore.ClientID%>").val(total);
        }
    </script>
</asp:Content>



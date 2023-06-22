<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="AddWFIndicator.aspx.cs" Inherits="CF.AddWFIndicator" UnobtrusiveValidationMode="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add Woman Farmer Indicator</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.css" rel="stylesheet" />
    <style type="text/css">
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
                                        <asp:Label ID="Label27" runat="server" Text="State:"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlstate" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlstate_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select State" ControlToValidate="ddlstate" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label30" runat="server" Text="District:"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select District" ControlToValidate="ddlDistrict" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label31" runat="server" Text="Block:"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlBlock" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlBlock_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select Block" ControlToValidate="ddlBlock" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select Village" ControlToValidate="ddlVillage" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblWFG" runat="server" Text="Woman Former Group"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlWFG" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlWFG_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select WFG" ControlToValidate="ddlWFG" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label1" runat="server" Text="Woman Formers"></asp:Label><b style="color: red"> *</b>
                                        <asp:DropDownList ID="ddlWF" CssClass="form-control" runat="server" onchange="GetDate()">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" InitialValue="Select" CssClass="text-danger" ErrorMessage="Please Select WF" ControlToValidate="ddlWF" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Panel ID="Panel3" runat="server" GroupingText="Yearly Details of Women Farmer">
                        <%-- <asp:Button ID="Button1" runat="server" Text="Export" CssClass="btn btn-success" />--%>
                        <div class="row" style="overflow: hidden;">
                            <div class="col-md-12" id="TableId" style="overflow: scroll;">
                                <table id="tblIndent" style="border: 1px solid black; border-collapse: collapse; width: 3610px!important" rules="all">
                                    <%--Height="200px" width: 1050px; Width="1050px"--%>
                                    <%----%>
                                    <tr>
                                        <th style="width: 150px;">Year</th>
                                        <th style="width: 150px;">Access To Business Services</th>
                                        <th style="width: 150px;">Which Service</th>
                                        <th style="width: 150px;">Practising Climate Friendly Agriculture</th>
                                        <th style="width: 150px;">Nature/Type Of Practice</th>
                                        <th style="width: 150px;">Cultivating 3 or More Crops</th>
                                        <th style="width: 150px;">Land Under Agriculture Use (in bigha)</th>
                                        <th style="width: 150px;">Land Under Agriculture-Under Productive & Sustainable Agriculture (in bigha)</th>
                                        <th style="width: 150px;">Demonstrate And Increase In knowledge & Skills</th>
                                        <th style="width: 150px;">Percentage of Woman Trained</th>
                                        <th style="width: 150px;">Pre Training score</th>
                                        <th style="width: 150px;">Post Training score</th>
                                        <th style="width: 150px;">Knows How To Obtain a Loan From a Formal Financial Institution</th>
                                        <th style="width: 150px;">Feels Confident In Managing Money</th>
                                        <th style="width: 150px;">Buisness Plans Developed</th>
                                        <th style="width: 150px;">Have Access to ICT</th>
                                        <th style="width: 270px;">Participate In Decisions About Use Of Productive Resources </th>
                                        <th style="width: 230px;">Participate (solely) In Decisions About HH income</th>
                                        <th style="width: 230px;">Participate (jointly) In  Decisions About HH Income</th>
                                        <th style="width: 150px;">Member is Part of ON farm in FPC</th>
                                        <th style="width: 150px;">Member is Part of OFF farm in FPC</th>
                                        <th style="width: 150px;">Name Of FPC of Which the WF Is a Member</th>
                                        <th style="width: 150px;">Has Become a Shareholder In a FPC</th>
                                        <th style="width: 150px;">How many shares</th>
                                        <th></th>
                                    </tr>
                                    <tr id="TableId0">
                                        <td>
                                            <input type="text" id="txtTableYear0" required oninvalid="this.setCustomValidity(&apos;Please Enter Year&apos;)" class="form-control YearPicker" oninput="setCustomValidity(&apos;&apos;);" onchange="setCustomValidity(&apos;&apos;);" /></td>
                                        <td>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblBuisnessYes0" name="Buisness0" value="Yes" onchange="BusinessService('Buisness0','txtAccessService0');" required /><label for="rblBuisnessYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblBuisnessNo0" name="Buisness0" value="No" onchange="BusinessService('Buisness0','txtAccessService0');" required /><label for="rblBuisnessNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" id="txtAccessService0" required oninvalid="this.setCustomValidity(&apos;Please Enter Service&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td>
                                        <td>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblClimateFriendlyYes0" name="climate0" value="Yes" onchange="PracticeTypeCheck('climate0','txtPracticeType0');" required /><label for="rblClimateFriendlyYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblClimateFriendlyNo0" name="climate0" value="No" onchange="PracticeTypeCheck('climate0','txtPracticeType0');" required /><label for="rblClimateFriendlyNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                            <input type="text" id="txtPracticeType0" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Nature/Type Of Practice&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td>
                                        <td>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblMoreCultivatingYes0" name="more0" value="Yes" required /><label for="rblMoreCultivatingYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblMoreCultivatingNo0" name="more0" value="No" required /><label for="rblMoreCultivatingNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                            <input type="text" id="txtAgriUse0" class="form-control" oninput="setCustomValidity(&apos;&apos;);" required oninvalid="this.setCustomValidity(&apos;Please Enter Land Under Agriculture Use&apos;)" /></td>
                                        <td>
                                            <input type="text" id="txtProUse0" class="form-control" oninput="setCustomValidity(&apos;&apos;);" required oninvalid="this.setCustomValidity(&apos;Please Enter Land Under Agriculture-Under Productive & Sustainable Agriculture&apos;)" oninput="setCustomValidity(&apos;&apos;);" />
                                        </td>
                                        <td>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblPercTrainedYes0" name="perc0" value="Yes" required /><label for="rblPercTrainedYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblPercTrainedNo0" name="perc0" value="No" required /><label for="rblPercTrainedNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                            <input type="text" id="txtPrecTrained0" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Percentage Trained&apos;)" oninput="setCustomValidity(&apos;&apos;);DecimalCheck(this);" /></td>
                                        <td>
                                            <input type="text" id="txtPreTrainig0" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Pre Training score&apos;)" oninput="setCustomValidity(&apos;&apos;);DecimalCheck(this);" /></td>
                                        <td>
                                            <input type="text" id="txtPostTraining0" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Post Training score&apos;)" oninput="setCustomValidity(&apos;&apos;);DecimalCheck(this);" /></td>
                                        <td>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblLoanObtainYes0" name="loan0" value="Yes" required /><label for="rblLoanObtainYes0">Yes</label></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblLoanObtainNo0" name="loan0" value="No" required /><label for="rblLoanObtainNo0">No</label>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblLoanObtainNS0" name="loan0" value="NotSure" required /><label for="rblLoanObtainNS0">Not Sure</label></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblLoanObtainSW0" name="loan0" value="SomeWhat" required /><label for="rblLoanObtainSW0">Some What</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblManageMoneyYes0" name="manage0" value="Yes" required /><label for="rblManageMoneyYes0">Yes</label></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblManageMoneyNo0" name="manage0" value="No" required /><label for="rblManageMoneyNo0">No</label></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblManageMoneyNS0" name="manage0" value="NotSure" required /><label for="rblManageMoneyNS0">Not Sure</label></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblManageMoneySW0" name="manage0" value="SomeWhat" required /><label for="rblManageMoneySW0">Some What</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblBuisnessDevelopYes0" name="develop0" value="Yes" required /><label for="rblBuisnessDevelopYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblBuisnessDevelopNo0" name="develop0" value="No" required /><label for="rblBuisnessDevelopNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblICTAccessYes0" name="ict0" value="Yes" required /><label for="rblICTAccessYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblICTAccessNo0" name="ict0" value="No" required /><label for="rblICTAccessNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>

                                        <td><span>Choice of crops</span><table>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <input type="radio" id="rblCropChoiceYes0" name="cropchoice0" value="Yes" required /><label for="rblCropChoiceYes0">Yes</label></td>
                                                    <td>
                                                        <input type="radio" id="rblCropChoiceNo0" name="cropchoice0" value="No" required /><label for="rblCropChoiceNo0">No</label></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                            <span>Inputs-Material investment in agriculture</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblInputYes0" name="input0" value="Yes" required><label for="rblInputYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblInputNo0" name="input0" value="No" required /><label for="rblInputNo0v">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <span>Deciding crop cycle</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblDecidingYes0" name="decide0" value="Yes" required /><label for="rblDecidingYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblDecidingNo0" name="decide0" value="No" required /><label for="rblDecidingNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <span>Timing of cropping</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblTimimgYes0" name="time0" value="Yes" required /><label for="rblTimimgYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblTimimgNo0" name="time0" value="No" required /><label for="rblTimimgNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <span>Deciding crop sowing time</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblDecidingTimeYes0" name="decidetime0" value="Yes" required /><label for="rblDecidingTimeYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblDecidingTimeNo0" name="decidetime0" value="No" required /><label for="rblDecidingTimeNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <span>Crop harvesting</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblHarvestingYes0" name="harvest0" value="Yes" required /><label for="rblHarvestingYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblHarvestingNo0" name="harvest0" value="No" required /><label for="rblHarvestingNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <span>Sale/transfer of land</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblSaleLandYes0" name="sale0" value="Yes" required /><label for="rblSaleLandYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblSaleLandNo0" name="sale0" value="No" required /><label for="rblSaleLandNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td><span>Women Self Development</span><table>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <input type="radio" id="rblSoWomenYes0" name="Sowomen0" value="Yes" required /><label for="rblSoWomenYes0">Yes</label></td>
                                                    <td>
                                                        <input type="radio" id="rblSoWomenNo0" name="Sowomen0" value="No" required /><label for="rblSoWomenNo0">No</label></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                            <span>Material/investment in agriculture</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblSoMaterialYes0" name="Somaterial0" value="Yes" required /><label for="rblSoMaterialYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblSoMaterialNo0" name="Somaterial0" value="No" required /><label for="rblSoMaterialNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <span>Selling agro-produce</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblSoAgroYes0" name="Soagro0" value="Yes" required /><label for="rblSoAgroYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblSoAgroNo0" name="Soagro0" value="No" required /><label for="rblSoAgroNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <span>Selling/transferring land</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblSoSellingYes0" name="Sosell0" value="Yes" required /><label for="rblSoSellingYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblSoSellingNo0" name="Sosell0" value="No" required /><label for="rblSoSellingNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <span>Expenditure planning of income</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblSoExpenditureYes0" name="Soexpend0" value="Yes" required /><label for="rblSoExpenditureYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblSoExpenditureNo0" name="Soexpend0" value="No" required /><label for="rblSoExpenditureNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td><span>Women Self Development</span><table>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <input type="radio" id="rblJoWomenYes0" name="jowomen0" value="Yes" required /><label for="rblJoWomenYes0">Yes</label></td>
                                                    <td>
                                                        <input type="radio" id="rblJoWomenNo0" name="jowomen0" value="No" required /><label for="rblJoWomenNo0">No</label></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                            <span>Material/investment in agriculture</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblJoMaterialYes0" name="jomaterial0" value="Yes" required /><label for="rblJoMaterialYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblJoMaterialNo0" name="jomaterial0" value="No" required /><label for="rblJoMaterialNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <span>Selling agro-produce</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblJoAgroYes0" name="joagro0" value="Yes" required /><label for="rblJoAgroYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblJoAgroNo0" name="joagro0" value="No" required /><label for="rblJoAgroNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <span>Selling/transferring land</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblJoSellingYes0" name="josell0" value="Yes" required /><label for="rblJoSellingYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblJoSellingNo0" name="josell0" value="No" required /><label for="rblJoSellingNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <span>Expenditure planning of income</span><table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblJoExpenditureYes0" name="joexpend0" value="Yes" required /><label for="rblJoExpenditureYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblJoExpenditureNo0" name="joexpend0" value="No" required /><label for="rblJoExpenditureNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblOnFarmYes0" name="onfarm0" value="Yes" required /><label for="rblOnFarmYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblOnFarmNo0" name="onfarm0" value="No" required /><label for="rblOnFarmNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblOffFarmYes0" name="offarm0" value="Yes" required /><label for="rblOffFarmYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblOffFarmNo0" name="offarm0" value="No" required /><label for="rblOffFarmNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                            <input type="text" id="txtFPCName0" onblur="GetFilterTable()" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Name Of FPC&apos;)" oninput="setCustomValidity(&apos;&apos;);" />
                                        </td>
                                        <td>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="radio" id="rblShareHolderYes0" name="share0" value="Yes" onchange="FPCCheck('share0','txtFPCShares0');" required /><label for="rblShareHolderYes0">Yes</label></td>
                                                        <td>
                                                            <input type="radio" id="rblShareHolderNo0" name="share0" value="No" onchange="FPCCheck('share0','txtFPCShares0');" required /><label for="rblShareHolderNo0">No</label></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td>
                                            <input type="text" id="txtFPCShares0" onblur="GetFilterTable()" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Name Of Shares&apos;)" oninput="setCustomValidity(&apos;&apos;);" />
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <a onclick="return false" id="lnkAddTable" runat="server" style="margin-left: 20px"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                                </div>
                            </div>
                            <asp:HiddenField ID="hiddenDivRowTable" runat="server" Value="1" />
                            <asp:HiddenField ID="hiddenDataArrayTable" runat="server" />
                        </div>
                    </asp:Panel>
                    <table>
                        <tbody>
                            <tr>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="box-footer clearfix">
                    <a id="btnCancel" runat="server" class="btn btn-danger" href="WFIndicatorInfo.aspx">Cancel</a><%--validationgroup="PreviewCheck"--%>
                    <%--<asp:Button runat="server" id="btnPreview" Text="Preview" class="btn btn-primary" ValidationGroup="PreviewCheck"/>--%>
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnsubmit_Click" />
                </div>

            </div>
        </form>
    </section>
    <script>
        $(document).ready(function () {
            $("#liWFIndicator").addClass("active");
        });
        $(".YearPicker").datepicker({
            format: " yyyy", // Notice the Extra space at the beginning
            viewMode: "years",
            minViewMode: "years"
        });

        $("#ContentPlaceHolder1_lnkAddTable").click(function (e) {
            debugger;
            var id = $("#<%=hiddenDivRowTable.ClientID %>").val();
            e.preventDefault();
            $("#tblIndent").append('<tr id="TableId' + id + '"><td><input type="text" id="txtTableYear' + id + '" required oninvalid="this.setCustomValidity(&apos;Please Enter Year&apos;)" class="form-control YearPicker" oninput="setCustomValidity(&apos;&apos;);" onchange="setCustomValidity(&apos;&apos;);" /></td><td><table><tbody><tr><td><input type="radio" id="rblBuisnessYes' + id + '" name="Buisness' + id + '" value="Yes" onchange="BusinessService(&apos;Buisness' + id + '&apos;,&apos;txtAccessService' + id + '&apos;);" required /><label for="rblBuisnessYes' + id + '">Yes</label></td><td><input type="radio" id="rblBuisnessNo' + id + '" name="Buisness' + id + '" value="No" onchange="BusinessService(&apos;Buisness' + id + '&apos;,&apos;txtAccessService' + id + '&apos;);" required /><label for="rblBuisnessNo' + id + '">No</label></td></tr></tbody></table></td><td><input type="text" class="form-control" id="txtAccessService' + id + '" required oninvalid="this.setCustomValidity(&apos;Please Enter Service&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td><td><table><tbody><tr><td><input type="radio" id="rblClimateFriendlyYes' + id + '" name="climate' + id + '" value="Yes" onchange="PracticeTypeCheck(&apos;climate' + id + '&apos;,&apos;txtPracticeType' + id + '&apos;);"  required /><label for="rblClimateFriendlyYes' + id + '">Yes</label></td><td><input type="radio" id="rblClimateFriendlyNo' + id + '" name="climate' + id + '" value="No" onchange="PracticeTypeCheck(&apos;climate' + id + '&apos;,&apos;txtPracticeType' + id + '&apos;);"  required /><label for="rblClimateFriendlyNo' + id + '">No</label></td></tr></tbody></table></td><td><input type="text" id="txtPracticeType' + id + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Nature/Type Of Practice&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td><td><table><tbody><tr><td><input type="radio" id="rblMoreCultivatingYes' + id + '" name="more' + id + '" value="Yes" required /><label for="rblMoreCultivatingYes' + id + '">Yes</label></td><td><input type="radio" id="rblMoreCultivatingNo' + id + '" name="more' + id + '" value="No" required /><label for="rblMoreCultivatingNo' + id + '">No</label></td></tr></tbody></table></td><td><input type="text" id="txtAgriUse' + id + '" class="form-control" oninput="setCustomValidity(&apos;&apos;);" required oninvalid="this.setCustomValidity(&apos;Please Enter Land Under Agriculture Use&apos;)" /></td><td><input type="text" id="txtProUse' + id + '" class="form-control" oninput="setCustomValidity(&apos;&apos;);" required oninvalid="this.setCustomValidity(&apos;Please Enter Land Under Agriculture-Under Productive & Sustainable Agriculture&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td><td><table><tbody><tr><td><input type="radio" id="rblPercTrainedYes' + id + '" name="perc' + id + '" value="Yes" required /><label for="rblPercTrainedYes' + id + '">Yes</label></td><td><input type="radio" id="rblPercTrainedNo' + id + '" name="perc' + id + '" value="No" required /><label for="rblPercTrainedNo' + id + '">No</label></td></tr></tbody></table></td><td><input type="text" id="txtPrecTrained' + id + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Percentage Trained&apos;)" oninput="setCustomValidity(&apos;&apos;);DecimalCheck(this);" /></td><td><input type="text" id="txtPreTrainig' + id + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Pre Training score&apos;)" oninput="setCustomValidity(&apos;&apos;);DecimalCheck(this);" /></td><td><input type="text" id="txtPostTraining' + id + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Post Training score&apos;)" oninput="setCustomValidity(&apos;&apos;);DecimalCheck(this);" /></td><td><table><tbody><tr><td><input type="radio" id="rblLoanObtainYes' + id + '" name="loan' + id + '" value="Yes" required /><label for="rblLoanObtainYes' + id + '">Yes</label></td></tr><tr><td><input type="radio" id="rblLoanObtainNo' + id + '" name="loan' + id + '" value="No" required /><label for="rblLoanObtainNo' + id + '">No</label></tr><tr><td><input type="radio" id="rblLoanObtainNS' + id + '" name="loan' + id + '" value="NotSure" required /><label for="rblLoanObtainNS' + id + '">Not Sure</label></td></tr><tr><td><input type="radio" id="rblLoanObtainSW' + id + '" name="loan' + id + '" value="SomeWhat" required /><label for="rblLoanObtainSW' + id + '">Some What</label></td></tr></tbody></table></td><td><table><tbody><tr><td><input type="radio" id="rblManageMoneyYes' + id + '" name="manage' + id + '" value="Yes" required /><label for="rblManageMoneyYes' + id + '">Yes</label></td></tr><tr><td><input type="radio" id="rblManageMoneyNo' + id + '" name="manage' + id + '" value="No" required /><label for="rblManageMoneyNo' + id + '">No</label></td></tr><tr><td><input type="radio" id="rblManageMoneyNS' + id + '" name="manage' + id + '" value="NotSure" required /><label for="rblManageMoneyNS' + id + '">Not Sure</label></td></tr><tr><td><input type="radio" id="rblManageMoneySW' + id + '" name="manage' + id + '" value="SomeWhat" required /><label for="rblManageMoneySW' + id + '">Some What</label></td></tr></tbody></table></td><td><table><tbody><tr><td><input type="radio" id="rblBuisnessDevelopYes' + id + '" name="develop' + id + '" value="Yes" required /><label for="rblBuisnessDevelopYes' + id + '">Yes</label></td><td><input type="radio" id="rblBuisnessDevelopNo' + id + '" name="develop' + id + '" value="No" required /><label for="rblBuisnessDevelopNo' + id + '">No</label></td></tr></tbody></table></td><td><table><tbody><tr><td><input type="radio" id="rblICTAccessYes' + id + '" name="ict' + id + '" value="Yes" required /><label for="rblICTAccessYes' + id + '">Yes</label></td><td><input type="radio" id="rblICTAccessNo' + id + '" name="ict' + id + '" value="No" required /><label for="rblICTAccessNo' + id + '">No</label></td></tr></tbody></table></td><td><span>Choice of crops</span><table><tbody><tr><td><input type="radio" id="rblCropChoiceYes' + id + '" name="cropchoice' + id + '" value="Yes" required /><label for="rblCropChoiceYes' + id + '">Yes</label></td><td><input type="radio" id="rblCropChoiceNo' + id + '" name="cropchoice' + id + '" value="No" required /><label for="rblCropChoiceNo' + id + '">No</label></td></tr></tbody></table><span>Inputs-Material investment in agriculture</span><table><tbody><tr><td><input type="radio" id="rblInputYes' + id + '" name="input' + id + '" value="Yes" required ><label for="rblInputYes' + id + '">Yes</label></td><td><input type="radio" id="rblInputNo' + id + '" name="input' + id + '" value="No" required /><label for="rblInputNo' + id + 'v">No</label></td></tr></tbody></table><span>Deciding crop cycle</span><table><tbody><tr><td><input type="radio" id="rblDecidingYes' + id + '" name="decide' + id + '" value="Yes" required /><label for="rblDecidingYes' + id + '">Yes</label></td><td><input type="radio" id="rblDecidingNo' + id + '" name="decide' + id + '" value="No" required /><label for="rblDecidingNo' + id + '">No</label></td></tr></tbody></table><span>Timing of cropping</span><table><tbody><tr><td><input type="radio" id="rblTimimgYes' + id + '" name="time' + id + '" value="Yes" required /><label for="rblTimimgYes' + id + '">Yes</label></td><td><input type="radio" id="rblTimimgNo' + id + '" name="time' + id + '" value="No" required /><label for="rblTimimgNo' + id + '">No</label></td></tr></tbody></table><span>Deciding crop sowing time</span><table><tbody><tr><td><input type="radio" id="rblDecidingTimeYes' + id + '" name="decidetime' + id + '" value="Yes" required /><label for="rblDecidingTimeYes' + id + '">Yes</label></td><td><input type="radio" id="rblDecidingTimeNo' + id + '" name="decidetime' + id + '" value="No" required /><label for="rblDecidingTimeNo' + id + '">No</label></td></tr></tbody></table><span>Crop harvesting</span><table><tbody><tr><td><input type="radio" id="rblHarvestingYes' + id + '" name="harvest' + id + '" value="Yes" required /><label for="rblHarvestingYes' + id + '">Yes</label></td><td><input type="radio" id="rblHarvestingNo' + id + '" name="harvest' + id + '" value="No" required /><label for="rblHarvestingNo' + id + '">No</label></td></tr></tbody></table><span>Sale/transfer of land</span><table><tbody><tr><td><input type="radio" id="rblSaleLandYes' + id + '" name="sale' + id + '" value="Yes" required /><label for="rblSaleLandYes' + id + '">Yes</label></td><td><input type="radio" id="rblSaleLandNo' + id + '" name="sale' + id + '" value="No" required /><label for="rblSaleLandNo' + id + '">No</label></td></tr></tbody></table></td><td><span>Women Self Development</span><table><tbody><tr><td><input type="radio" id="rblSoWomenYes' + id + '" name="Sowomen' + id + '" value="Yes" required /><label for="rblSoWomenYes' + id + '">Yes</label></td><td><input type="radio" id="rblSoWomenNo' + id + '" name="Sowomen' + id + '" value="No" required /><label for="rblSoWomenNo' + id + '">No</label></td></tr></tbody></table><span>Material/investment in agriculture</span><table><tbody><tr><td><input type="radio" id="rblSoMaterialYes' + id + '" name="Somaterial' + id + '" value="Yes" required /><label for="rblSoMaterialYes' + id + '">Yes</label></td><td><input type="radio" id="rblSoMaterialNo' + id + '" name="Somaterial' + id + '" value="No" required /><label for="rblSoMaterialNo' + id + '">No</label></td></tr></tbody></table><span>Selling agro-produce</span><table><tbody><tr><td><input type="radio" id="rblSoAgroYes' + id + '" name="Soagro' + id + '" value="Yes" required /><label for="rblSoAgroYes' + id + '">Yes</label></td><td><input type="radio" id="rblSoAgroNo' + id + '" name="Soagro' + id + '" value="No" required /><label for="rblSoAgroNo' + id + '">No</label></td></tr></tbody></table><span>Selling/transferring land</span><table><tbody><tr><td><input type="radio" id="rblSoSellingYes' + id + '" name="Sosell' + id + '" value="Yes" required /><label for="rblSoSellingYes' + id + '">Yes</label></td><td><input type="radio" id="rblSoSellingNo' + id + '" name="Sosell' + id + '" value="No" required /><label for="rblSoSellingNo' + id + '">No</label></td></tr></tbody></table><span>Expenditure planning of income</span><table><tbody><tr><td><input type="radio" id="rblSoExpenditureYes' + id + '" name="Soexpend' + id + '" value="Yes" required /><label for="rblSoExpenditureYes' + id + '">Yes</label></td><td><input type="radio" id="rblSoExpenditureNo' + id + '" name="Soexpend' + id + '" value="No" required /><label for="rblSoExpenditureNo' + id + '">No</label></td></tr></tbody></table></td><td><span>Women Self Development</span><table><tbody><tr><td><input type="radio" id="rblJoWomenYes' + id + '" name="jowomen' + id + '" value="Yes" required /><label for="rblJoWomenYes' + id + '">Yes</label></td><td><input type="radio" id="rblJoWomenNo' + id + '" name="jowomen' + id + '" value="No" required /><label for="rblJoWomenNo' + id + '">No</label></td></tr></tbody></table><span>Material/investment in agriculture</span><table><tbody><tr><td><input type="radio" id="rblJoMaterialYes' + id + '" name="jomaterial' + id + '" value="Yes" required /><label for="rblJoMaterialYes' + id + '">Yes</label></td><td><input type="radio" id="rblJoMaterialNo' + id + '" name="jomaterial' + id + '" value="No" required /><label for="rblJoMaterialNo' + id + '">No</label></td></tr></tbody></table><span>Selling agro-produce</span><table><tbody><tr><td><input type="radio" id="rblJoAgroYes' + id + '" name="joagro' + id + '" value="Yes" required /><label for="rblJoAgroYes' + id + '">Yes</label></td><td><input type="radio" id="rblJoAgroNo' + id + '" name="joagro' + id + '" value="No" required /><label for="rblJoAgroNo' + id + '">No</label></td></tr></tbody></table><span>Selling/transferring land</span><table><tbody><tr><td><input type="radio" id="rblJoSellingYes' + id + '" name="josell' + id + '" value="Yes" required /><label for="rblJoSellingYes' + id + '">Yes</label></td><td><input type="radio" id="rblJoSellingNo' + id + '" name="josell' + id + '" value="No" required /><label for="rblJoSellingNo' + id + '">No</label></td></tr></tbody></table><span>Expenditure planning of income</span><table><tbody><tr><td><input type="radio" id="rblJoExpenditureYes' + id + '" name="joexpend' + id + '" value="Yes" required /><label for="rblJoExpenditureYes' + id + '">Yes</label></td><td><input type="radio" id="rblJoExpenditureNo' + id + '" name="joexpend' + id + '" value="No" required /><label for="rblJoExpenditureNo' + id + '">No</label></td></tr></tbody></table></td><td><table><tbody><tr><td><input type="radio" id="rblOnFarmYes' + id + '" name="onfarm' + id + '" value="Yes" required /><label for="rblOnFarmYes' + id + '">Yes</label></td><td><input type="radio" id="rblOnFarmNo' + id + '" name="onfarm' + id + '" value="No" required /><label for="rblOnFarmNo' + id + '">No</label></td></tr></tbody></table></td><td><table><tbody><tr><td><input type="radio" id="rblOffFarmYes' + id + '" name="offarm' + id + '" value="Yes" required /><label for="rblOffFarmYes' + id + '">Yes</label></td><td><input type="radio" id="rblOffFarmNo' + id + '" name="offarm' + id + '" value="No" required /><label for="rblOffFarmNo' + id + '">No</label></td></tr></tbody></table></td><td><input type="text" id="txtFPCName' + id + '" onblur="GetFilterTable()" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Name Of FPC&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td><td><table><tbody><tr><td><input type="radio" id="rblShareHolderYes' + id + '" name="share' + id + '" value="Yes"  onchange="FPCCheck(&apos;share' + id + '&apos;,&apos;txtFPCShares' + id + '&apos;);" required /><label for="rblShareHolderYes' + id + '">Yes</label></td><td><input type="radio" id="rblShareHolderNo' + id + '" name="share' + id + '" value="No"  onchange="FPCCheck(&apos;share' + id + '&apos;,&apos;txtFPCShares' + id + '&apos;);" required /><label for="rblShareHolderNo' + id + '">No</label></td></tr></tbody></table></td><td><input type="text" id="txtFPCShares' + id + '" onblur="GetFilterTable()" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Name Of Shares&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td><td><a onclick="RemoveTableDiv(&apos;#TableId' + id + '&apos;)" style="color: red"><i class="fa fa-remove"></i></a></td></tr>');
            $(".YearPicker").datepicker({
                format: " yyyy", // Notice the Extra space at the beginning
                viewMode: "years",
                minViewMode: "years"
            });
            $("txtTableYear" + id).focus();
            id++;
            $("#<%=hiddenDivRowTable.ClientID %>").val(id);
            console.log(id);
            GetFilterTable();
            return false;
        });
        $('body').change(function () {
            GetFilterTable();
        });
        function GetFilterTable() {
            debugger;
            var DataCount = $("#<%=hiddenDivRowTable.ClientID %>").val();
            var Data = "";
            for (var i = 0; i < DataCount; i++) {
                //debugger;
                var txtTableYear = "txtTableYear" + i;
                var rblBuisness = "Buisness" + i;
                var txtAccessService = "txtAccessService" + i;
                var rblClimateFriendly = "climate" + i;
                var txtPracticeType = "txtPracticeType" + i;
                var rblMoreCultivating = "more" + i;
                var txtAgriUse = "txtAgriUse" + i;
                var txtProUse = "txtProUse" + i;
                var rblDemonstrate = "perc" + i;
                var txtPercTrained = "txtPrecTrained" + i;
                var txtPreTrainig = "txtPreTrainig" + i;
                var txtPostTraining = "txtPostTraining" + i;
                var rblLoanObtain = "loan" + i;
                var rblManageMoney = "manage" + i;
                var rblBuisnessDevelop = "develop" + i;
                var rblICTAccess = "ict" + i;
                var rblOnFarm = "onfarm" + i;
                var rblOffFarm = "offarm" + i;
                var rblCropChoice = "cropchoice" + i;
                var rblInput = "input" + i;
                var rblDeciding = "decide" + i;
                var rblTimimg = "time" + i;
                var rblDecidingTime = "decidetime" + i;
                var rblHarvesting = "harvest" + i;
                var rblSaleLand = "sale" + i;
                var rblSoWomen = "Sowomen" + i;
                var rblSoMaterial = "Somaterial" + i;
                var rblSoAgro = "Soagro" + i;
                var rblSoSelling = "Sosell" + i;
                var rblSoExpenditure = "Soexpend" + i;
                var rblJoWomen = "jowomen" + i;
                var rblJoMaterial = "jomaterial" + i;
                var rblJoAgro = "joagro" + i;
                var rblJoSelling = "josell" + i;
                var rblJoExpenditure = "joexpend" + i;
                var rblShareHolder = "share" + i;
                var txtFPCName = "txtFPCName" + i;
                var txtFPCShare = "txtFPCShares" + i;
                //debugger;
                if ($('#' + txtTableYear).val() != undefined) {
                    if (Data != "") {
                        Data += '$' + $('#' + txtTableYear).val() + ':' + $('input[name=' + rblBuisness + ']:checked').val() + ':' + $('#' + txtAccessService).val() + ':' + $('input[name=' + rblClimateFriendly + ']:checked').val() + ':' + $('#' + txtPracticeType).val() + ':' + $('input[name=' + rblMoreCultivating + ']:checked').val() + ':' + $('#' + txtAgriUse).val() + ':' + $('#' + txtProUse).val() + ':' + $('input[name=' + rblDemonstrate + ']:checked').val() + ':' + $('#' + txtPercTrained).val() + ':' + $('#' + txtPreTrainig).val() + ':' + $('#' + txtPostTraining).val() + ':' + $('input[name=' + rblLoanObtain + ']:checked').val() + ':' + $('input[name=' + rblManageMoney + ']:checked').val() + ':' + $('input[name=' + rblBuisnessDevelop + ']:checked').val() + ':' + $('input[name=' + rblICTAccess + ']:checked').val() + ':' + $('input[name=' + rblOnFarm + ']:checked').val() + ':' + $('input[name=' + rblOffFarm + ']:checked').val() + ':' + $('input[name=' + rblCropChoice + ']:checked').val() + ':' + $('input[name=' + rblInput + ']:checked').val() + ':' + $('input[name=' + rblDeciding + ']:checked').val() + ':' + $('input[name=' + rblTimimg + ']:checked').val() + ':' + $('input[name=' + rblDecidingTime + ']:checked').val() + ':' + $('input[name=' + rblHarvesting + ']:checked').val() + ':' + $('input[name=' + rblSaleLand + ']:checked').val() + ':' + $('input[name=' + rblSoWomen + ']:checked').val() + ':' + $('input[name=' + rblSoMaterial + ']:checked').val() + ':' + $('input[name=' + rblSoAgro + ']:checked').val() + ':' + $('input[name=' + rblSoSelling + ']:checked').val() + ':' + $('input[name=' + rblSoExpenditure + ']:checked').val() + ':' + $('input[name=' + rblJoWomen + ']:checked').val() + ':' + $('input[name=' + rblJoMaterial + ']:checked').val() + ':' + $('input[name=' + rblJoAgro + ']:checked').val() + ':' + $('input[name=' + rblJoSelling + ']:checked').val() + ':' + $('input[name=' + rblJoExpenditure + ']:checked').val() + ':' + $('input[name=' + rblShareHolder + ']:checked').val() + ':' + $('#' + txtFPCName).val() + ':' + $('#' + txtFPCShare).val();
                    }
                    else {
                        Data += $('#' + txtTableYear).val() + ':' + $('input[name=' + rblBuisness + ']:checked').val() + ':' + $('#' + txtAccessService).val() + ':' + $('input[name=' + rblClimateFriendly + ']:checked').val() + ':' + $('#' + txtPracticeType).val() + ':' + $('input[name=' + rblMoreCultivating + ']:checked').val() + ':' + $('#' + txtAgriUse).val() + ':' + $('#' + txtProUse).val() + ':' + $('input[name=' + rblDemonstrate + ']:checked').val() + ':' + $('#' + txtPercTrained).val() + ':' + $('#' + txtPreTrainig).val() + ':' + $('#' + txtPostTraining).val() + ':' + $('input[name=' + rblLoanObtain + ']:checked').val() + ':' + $('input[name=' + rblManageMoney + ']:checked').val() + ':' + $('input[name=' + rblBuisnessDevelop + ']:checked').val() + ':' + $('input[name=' + rblICTAccess + ']:checked').val() + ':' + $('input[name=' + rblOnFarm + ']:checked').val() + ':' + $('input[name=' + rblOffFarm + ']:checked').val() + ':' + $('input[name=' + rblCropChoice + ']:checked').val() + ':' + $('input[name=' + rblInput + ']:checked').val() + ':' + $('input[name=' + rblDeciding + ']:checked').val() + ':' + $('input[name=' + rblTimimg + ']:checked').val() + ':' + $('input[name=' + rblDecidingTime + ']:checked').val() + ':' + $('input[name=' + rblHarvesting + ']:checked').val() + ':' + $('input[name=' + rblSaleLand + ']:checked').val() + ':' + $('input[name=' + rblSoWomen + ']:checked').val() + ':' + $('input[name=' + rblSoMaterial + ']:checked').val() + ':' + $('input[name=' + rblSoAgro + ']:checked').val() + ':' + $('input[name=' + rblSoSelling + ']:checked').val() + ':' + $('input[name=' + rblSoExpenditure + ']:checked').val() + ':' + $('input[name=' + rblJoWomen + ']:checked').val() + ':' + $('input[name=' + rblJoMaterial + ']:checked').val() + ':' + $('input[name=' + rblJoAgro + ']:checked').val() + ':' + $('input[name=' + rblJoSelling + ']:checked').val() + ':' + $('input[name=' + rblJoExpenditure + ']:checked').val() + ':' + $('input[name=' + rblShareHolder + ']:checked').val() + ':' + $('#' + txtFPCName).val() + ':' + $('#' + txtFPCShare).val();
                    }
                }
            }
            $("#<%=hiddenDataArrayTable.ClientID %>").val(Data);
        }

        function FillData() {
            debugger;
            $("#<%=hiddenDivRowTable.ClientID %>").val();
            var data = $("#<%=hiddenDataArrayTable.ClientID %>").val();
            var dataarray = data.split('$');
            for (var id = 0; id < dataarray.length; id++) {
                var object = dataarray[id].split(':');
                if (id != 0) {
                    $("#tblIndent").append('<tr id="TableId' + id + '"><td><input type="text" id="txtTableYear' + id + '" required oninvalid="this.setCustomValidity(&apos;Please Enter Year&apos;)" class="form-control YearPicker" oninput="setCustomValidity(&apos;&apos;);" onchange="setCustomValidity(&apos;&apos;);" /></td><td><table><tbody><tr><td><input type="radio" id="rblBuisnessYes' + id + '" name="Buisness' + id + '" value="Yes" onchange="BusinessService(&apos;Buisness' + id + '&apos;,&apos;txtAccessService' + id + '&apos;);" required /><label for="rblBuisnessYes' + id + '">Yes</label></td><td><input type="radio" id="rblBuisnessNo' + id + '" name="Buisness' + id + '" value="No" onchange="BusinessService(&apos;Buisness' + id + '&apos;,&apos;txtAccessService' + id + '&apos;);" required /><label for="rblBuisnessNo' + id + '">No</label></td></tr></tbody></table></td><td><input type="text" class="form-control" id="txtAccessService' + id + '" required oninvalid="this.setCustomValidity(&apos;Please Enter Service&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td><td><table><tbody><tr><td><input type="radio" id="rblClimateFriendlyYes' + id + '" name="climate' + id + '" value="Yes" onchange="PracticeTypeCheck(&apos;climate' + id + '&apos;,&apos;txtPracticeType' + id + '&apos;);"  required /><label for="rblClimateFriendlyYes' + id + '">Yes</label></td><td><input type="radio" id="rblClimateFriendlyNo' + id + '" name="climate' + id + '" value="No" onchange="PracticeTypeCheck(&apos;climate' + id + '&apos;,&apos;txtPracticeType' + id + '&apos;);"  required /><label for="rblClimateFriendlyNo' + id + '">No</label></td></tr></tbody></table></td><td><input type="text" id="txtPracticeType' + id + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Nature/Type Of Practice&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td><td><table><tbody><tr><td><input type="radio" id="rblMoreCultivatingYes' + id + '" name="more' + id + '" value="Yes" required /><label for="rblMoreCultivatingYes' + id + '">Yes</label></td><td><input type="radio" id="rblMoreCultivatingNo' + id + '" name="more' + id + '" value="No" required /><label for="rblMoreCultivatingNo' + id + '">No</label></td></tr></tbody></table></td><td><input type="text" id="txtAgriUse' + id + '" class="form-control" oninput="setCustomValidity(&apos;&apos;);" required oninvalid="this.setCustomValidity(&apos;Please Enter Land Under Agriculture Use&apos;)" /></td><td><input type="text" id="txtProUse' + id + '" class="form-control" oninput="setCustomValidity(&apos;&apos;);" required oninvalid="this.setCustomValidity(&apos;Please Enter Land Under Agriculture-Under Productive & Sustainable Agriculture&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td><td><table><tbody><tr><td><input type="radio" id="rblPercTrainedYes' + id + '" name="perc' + id + '" value="Yes" required /><label for="rblPercTrainedYes' + id + '">Yes</label></td><td><input type="radio" id="rblPercTrainedNo' + id + '" name="perc' + id + '" value="No" required /><label for="rblPercTrainedNo' + id + '">No</label></td></tr></tbody></table></td><td><input type="text" id="txtPrecTrained' + id + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Percentage Trained&apos;)" oninput="setCustomValidity(&apos;&apos;);DecimalCheck(this);" /></td><td><input type="text" id="txtPreTrainig' + id + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Pre Training score&apos;)" oninput="setCustomValidity(&apos;&apos;);DecimalCheck(this);" /></td><td><input type="text" id="txtPostTraining' + id + '" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Post Training score&apos;)" oninput="setCustomValidity(&apos;&apos;);DecimalCheck(this);" /></td><td><table><tbody><tr><td><input type="radio" id="rblLoanObtainYes' + id + '" name="loan' + id + '" value="Yes" required /><label for="rblLoanObtainYes' + id + '">Yes</label></td></tr><tr><td><input type="radio" id="rblLoanObtainNo' + id + '" name="loan' + id + '" value="No" required /><label for="rblLoanObtainNo' + id + '">No</label></tr><tr><td><input type="radio" id="rblLoanObtainNS' + id + '" name="loan' + id + '" value="NotSure" required /><label for="rblLoanObtainNS' + id + '">Not Sure</label></td></tr><tr><td><input type="radio" id="rblLoanObtainSW' + id + '" name="loan' + id + '" value="SomeWhat" required /><label for="rblLoanObtainSW' + id + '">Some What</label></td></tr></tbody></table></td><td><table><tbody><tr><td><input type="radio" id="rblManageMoneyYes' + id + '" name="manage' + id + '" value="Yes" required /><label for="rblManageMoneyYes' + id + '">Yes</label></td></tr><tr><td><input type="radio" id="rblManageMoneyNo' + id + '" name="manage' + id + '" value="No" required /><label for="rblManageMoneyNo' + id + '">No</label></td></tr><tr><td><input type="radio" id="rblManageMoneyNS' + id + '" name="manage' + id + '" value="NotSure" required /><label for="rblManageMoneyNS' + id + '">Not Sure</label></td></tr><tr><td><input type="radio" id="rblManageMoneySW' + id + '" name="manage' + id + '" value="SomeWhat" required /><label for="rblManageMoneySW' + id + '">Some What</label></td></tr></tbody></table></td><td><table><tbody><tr><td><input type="radio" id="rblBuisnessDevelopYes' + id + '" name="develop' + id + '" value="Yes" required /><label for="rblBuisnessDevelopYes' + id + '">Yes</label></td><td><input type="radio" id="rblBuisnessDevelopNo' + id + '" name="develop' + id + '" value="No" required /><label for="rblBuisnessDevelopNo' + id + '">No</label></td></tr></tbody></table></td><td><table><tbody><tr><td><input type="radio" id="rblICTAccessYes' + id + '" name="ict' + id + '" value="Yes" required /><label for="rblICTAccessYes' + id + '">Yes</label></td><td><input type="radio" id="rblICTAccessNo' + id + '" name="ict' + id + '" value="No" required /><label for="rblICTAccessNo' + id + '">No</label></td></tr></tbody></table></td><td><span>Choice of crops</span><table><tbody><tr><td><input type="radio" id="rblCropChoiceYes' + id + '" name="cropchoice' + id + '" value="Yes" required /><label for="rblCropChoiceYes' + id + '">Yes</label></td><td><input type="radio" id="rblCropChoiceNo' + id + '" name="cropchoice' + id + '" value="No" required /><label for="rblCropChoiceNo' + id + '">No</label></td></tr></tbody></table><span>Inputs-Material investment in agriculture</span><table><tbody><tr><td><input type="radio" id="rblInputYes' + id + '" name="input' + id + '" value="Yes" required ><label for="rblInputYes' + id + '">Yes</label></td><td><input type="radio" id="rblInputNo' + id + '" name="input' + id + '" value="No" required /><label for="rblInputNo' + id + 'v">No</label></td></tr></tbody></table><span>Deciding crop cycle</span><table><tbody><tr><td><input type="radio" id="rblDecidingYes' + id + '" name="decide' + id + '" value="Yes" required /><label for="rblDecidingYes' + id + '">Yes</label></td><td><input type="radio" id="rblDecidingNo' + id + '" name="decide' + id + '" value="No" required /><label for="rblDecidingNo' + id + '">No</label></td></tr></tbody></table><span>Timing of cropping</span><table><tbody><tr><td><input type="radio" id="rblTimimgYes' + id + '" name="time' + id + '" value="Yes" required /><label for="rblTimimgYes' + id + '">Yes</label></td><td><input type="radio" id="rblTimimgNo' + id + '" name="time' + id + '" value="No" required /><label for="rblTimimgNo' + id + '">No</label></td></tr></tbody></table><span>Deciding crop sowing time</span><table><tbody><tr><td><input type="radio" id="rblDecidingTimeYes' + id + '" name="decidetime' + id + '" value="Yes" required /><label for="rblDecidingTimeYes' + id + '">Yes</label></td><td><input type="radio" id="rblDecidingTimeNo' + id + '" name="decidetime' + id + '" value="No" required /><label for="rblDecidingTimeNo' + id + '">No</label></td></tr></tbody></table><span>Crop harvesting</span><table><tbody><tr><td><input type="radio" id="rblHarvestingYes' + id + '" name="harvest' + id + '" value="Yes" required /><label for="rblHarvestingYes' + id + '">Yes</label></td><td><input type="radio" id="rblHarvestingNo' + id + '" name="harvest' + id + '" value="No" required /><label for="rblHarvestingNo' + id + '">No</label></td></tr></tbody></table><span>Sale/transfer of land</span><table><tbody><tr><td><input type="radio" id="rblSaleLandYes' + id + '" name="sale' + id + '" value="Yes" required /><label for="rblSaleLandYes' + id + '">Yes</label></td><td><input type="radio" id="rblSaleLandNo' + id + '" name="sale' + id + '" value="No" required /><label for="rblSaleLandNo' + id + '">No</label></td></tr></tbody></table></td><td><span>Women Self Development</span><table><tbody><tr><td><input type="radio" id="rblSoWomenYes' + id + '" name="Sowomen' + id + '" value="Yes" required /><label for="rblSoWomenYes' + id + '">Yes</label></td><td><input type="radio" id="rblSoWomenNo' + id + '" name="Sowomen' + id + '" value="No" required /><label for="rblSoWomenNo' + id + '">No</label></td></tr></tbody></table><span>Material/investment in agriculture</span><table><tbody><tr><td><input type="radio" id="rblSoMaterialYes' + id + '" name="Somaterial' + id + '" value="Yes" required /><label for="rblSoMaterialYes' + id + '">Yes</label></td><td><input type="radio" id="rblSoMaterialNo' + id + '" name="Somaterial' + id + '" value="No" required /><label for="rblSoMaterialNo' + id + '">No</label></td></tr></tbody></table><span>Selling agro-produce</span><table><tbody><tr><td><input type="radio" id="rblSoAgroYes' + id + '" name="Soagro' + id + '" value="Yes" required /><label for="rblSoAgroYes' + id + '">Yes</label></td><td><input type="radio" id="rblSoAgroNo' + id + '" name="Soagro' + id + '" value="No" required /><label for="rblSoAgroNo' + id + '">No</label></td></tr></tbody></table><span>Selling/transferring land</span><table><tbody><tr><td><input type="radio" id="rblSoSellingYes' + id + '" name="Sosell' + id + '" value="Yes" required /><label for="rblSoSellingYes' + id + '">Yes</label></td><td><input type="radio" id="rblSoSellingNo' + id + '" name="Sosell' + id + '" value="No" required /><label for="rblSoSellingNo' + id + '">No</label></td></tr></tbody></table><span>Expenditure planning of income</span><table><tbody><tr><td><input type="radio" id="rblSoExpenditureYes' + id + '" name="Soexpend' + id + '" value="Yes" required /><label for="rblSoExpenditureYes' + id + '">Yes</label></td><td><input type="radio" id="rblSoExpenditureNo' + id + '" name="Soexpend' + id + '" value="No" required /><label for="rblSoExpenditureNo' + id + '">No</label></td></tr></tbody></table></td><td><span>Women Self Development</span><table><tbody><tr><td><input type="radio" id="rblJoWomenYes' + id + '" name="jowomen' + id + '" value="Yes" required /><label for="rblJoWomenYes' + id + '">Yes</label></td><td><input type="radio" id="rblJoWomenNo' + id + '" name="jowomen' + id + '" value="No" required /><label for="rblJoWomenNo' + id + '">No</label></td></tr></tbody></table><span>Material/investment in agriculture</span><table><tbody><tr><td><input type="radio" id="rblJoMaterialYes' + id + '" name="jomaterial' + id + '" value="Yes" required /><label for="rblJoMaterialYes' + id + '">Yes</label></td><td><input type="radio" id="rblJoMaterialNo' + id + '" name="jomaterial' + id + '" value="No" required /><label for="rblJoMaterialNo' + id + '">No</label></td></tr></tbody></table><span>Selling agro-produce</span><table><tbody><tr><td><input type="radio" id="rblJoAgroYes' + id + '" name="joagro' + id + '" value="Yes" required /><label for="rblJoAgroYes' + id + '">Yes</label></td><td><input type="radio" id="rblJoAgroNo' + id + '" name="joagro' + id + '" value="No" required /><label for="rblJoAgroNo' + id + '">No</label></td></tr></tbody></table><span>Selling/transferring land</span><table><tbody><tr><td><input type="radio" id="rblJoSellingYes' + id + '" name="josell' + id + '" value="Yes" required /><label for="rblJoSellingYes' + id + '">Yes</label></td><td><input type="radio" id="rblJoSellingNo' + id + '" name="josell' + id + '" value="No" required /><label for="rblJoSellingNo' + id + '">No</label></td></tr></tbody></table><span>Expenditure planning of income</span><table><tbody><tr><td><input type="radio" id="rblJoExpenditureYes' + id + '" name="joexpend' + id + '" value="Yes" required /><label for="rblJoExpenditureYes' + id + '">Yes</label></td><td><input type="radio" id="rblJoExpenditureNo' + id + '" name="joexpend' + id + '" value="No" required /><label for="rblJoExpenditureNo' + id + '">No</label></td></tr></tbody></table></td><td><table><tbody><tr><td><input type="radio" id="rblOnFarmYes' + id + '" name="onfarm' + id + '" value="Yes" required /><label for="rblOnFarmYes' + id + '">Yes</label></td><td><input type="radio" id="rblOnFarmNo' + id + '" name="onfarm' + id + '" value="No" required /><label for="rblOnFarmNo' + id + '">No</label></td></tr></tbody></table></td><td><table><tbody><tr><td><input type="radio" id="rblOffFarmYes' + id + '" name="offarm' + id + '" value="Yes" required /><label for="rblOffFarmYes' + id + '">Yes</label></td><td><input type="radio" id="rblOffFarmNo' + id + '" name="offarm' + id + '" value="No" required /><label for="rblOffFarmNo' + id + '">No</label></td></tr></tbody></table></td><td><table><tbody><tr><td><input type="radio" id="rblShareHolderYes' + id + '" name="share' + id + '" value="Yes"  onchange="FPCCheck(&apos;share' + id + '&apos;,&apos;txtFPCName' + id + '&apos;);" required /><label for="rblShareHolderYes' + id + '">Yes</label></td><td><input type="radio" id="rblShareHolderNo' + id + '" name="share' + id + '" value="No"  onchange="FPCCheck(&apos;share' + id + '&apos;,&apos;txtFPCName' + id + '&apos;);" required /><label for="rblShareHolderNo' + id + '">No</label></td></tr></tbody></table></td><td><input type="text" id="txtFPCName' + id + '" onblur="GetFilterTable()" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Name Of FPC&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td><td><input type="text" id="txtFPCShares' + id + '" onblur="GetFilterTable()" class="form-control" required oninvalid="this.setCustomValidity(&apos;Please Enter Name Of Shares&apos;)" oninput="setCustomValidity(&apos;&apos;);" /></td><td><a onclick="RemoveTableDiv(&apos;#TableId' + id + '&apos;)" style="color: red"><i class="fa fa-remove"></i></a></td></tr>');
                    $(".YearPicker").datepicker({
                        format: " yyyy", // Notice the Extra space at the beginning
                        viewMode: "years",
                        minViewMode: "years"
                    });
                }
                $('#txtTableYear' + id).val(object[0]);
                $('input[name=Buisness' + id + '][value=' + object[1] + ']').prop('checked', true);
                $('#txtAccessService' + id).val(object[2]);
                $('input[name=climate' + id + '][value=' + object[3] + ']').prop('checked', true);
                $('#txtPracticeType' + id).val(object[4]);
                $('input[name=more' + id + '][value=' + object[5] + ']').prop('checked', true);
                $('#txtAgriUse' + id).val(object[6]);
                $('#txtProUse' + id).val(object[7]);
                $('#txtPrecTrained' + id).val(object[8]);
                $('input[name=perc' + id + '][value=' + object[9] + ']').prop('checked', true);
                $('#txtPreTrainig' + id).val(object[10]);
                $('#txtPostTraining' + id).val(object[11]);
                $('input[name=loan' + id + '][value=' + object[12] + ']').prop('checked', true);
                $('input[name=manage' + id + '][value=' + object[13] + ']').prop('checked', true);
                $('input[name=develop' + id + '][value=' + object[14] + ']').prop('checked', true);
                $('input[name=ict' + id + '][value=' + object[15] + ']').prop('checked', true);
                $('input[name=onfarm' + id + '][value=' + object[16] + ']').prop('checked', true);
                $('input[name=offarm' + id + '][value=' + object[17] + ']').prop('checked', true);
                $('input[name=cropchoice' + id + '][value=' + object[18] + ']').prop('checked', true);
                $('input[name=input' + id + '][value=' + object[19] + ']').prop('checked', true);
                $('input[name=decide' + id + '][value=' + object[20] + ']').prop('checked', true);
                $('input[name=time' + id + '][value=' + object[21] + ']').prop('checked', true);
                $('input[name=decidetime' + id + '][value=' + object[22] + ']').prop('checked', true);
                $('input[name=harvest' + id + '][value=' + object[23] + ']').prop('checked', true);
                $('input[name=sale' + id + '][value=' + object[24] + ']').prop('checked', true);
                $('input[name=Sowomen' + id + '][value=' + object[25] + ']').prop('checked', true);
                $('input[name=Somaterial' + id + '][value=' + object[26] + ']').prop('checked', true);
                $('input[name=Soagro' + id + '][value=' + object[27] + ']').prop('checked', true);
                $('input[name=Sosell' + id + '][value=' + object[28] + ']').prop('checked', true);
                $('input[name=Soexpend' + id + '][value=' + object[29] + ']').prop('checked', true);
                $('input[name=jowomen' + id + '][value=' + object[30] + ']').prop('checked', true);
                $('input[name=jomaterial' + id + '][value=' + object[31] + ']').prop('checked', true);
                $('input[name=joagro' + id + '][value=' + object[32] + ']').prop('checked', true);
                $('input[name=josell' + id + '][value=' + object[33] + ']').prop('checked', true);
                $('input[name=joexpend' + id + '][value=' + object[34] + ']').prop('checked', true);
                $('input[name=share' + id + '][value=' + object[35] + ']').prop('checked', true);
                $('#txtFPCName' + id).val(object[36]);
                $('#txtFPCShares' + id).val(object[37]);
            }
            if (dataarray.length > 0) {
                $("#<%=hiddenDivRowTable.ClientID %>").val(dataarray.length);
            }
        }
        function RemoveTableDiv(div) {
            debugger;
            $(div).remove();
            GetFilterTable();
            return false;
        };

        function GetDate() {
            debugger;
            var wfno = $("#<%=ddlWF.ClientID%>").val();
            $.ajax({
                type: "POST",
                async: "false",
                url: "AddWFIndicator.aspx/SocialCategory",
                data: JSON.stringify({ WFno: wfno }),
                contentType: "application/json; charset=utf-8",
                dataType: "Json",
                success: function (data, textStatus, xhr) {
                    $("#<%=hiddenDataArrayTable.ClientID %>").val(data.d);
                    FillData();
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.log('Error in Operation');
                }
            });

        };

        function BusinessService(radio, text) {
            var rblval = $('input[name=' + radio + ']:checked').val();
            if (rblval == "Yes") {
                $("#" + text).removeAttr("disabled");
                $("#" + text).attr("Required", "required");
            }
            else {
                $("#" + text).val("");
                $("#" + text).attr("disabled", "disabled");
                $("#" + text).removeAttr("Required");
            }
        }
        function PracticeTypeCheck(radio, text) {
            var rblval = $('input[name=' + radio + ']:checked').val();
            if (rblval == "Yes") {
                $("#" + text).removeAttr("disabled");
                $("#" + text).attr("Required", "required");
            }
            else {
                $("#" + text).val("");
                $("#" + text).attr("disabled", "disabled");
                $("#" + text).removeAttr("Required");
            }
        }

        function FPCCheck(radio, text) {
            var rblval = $('input[name=' + radio + ']:checked').val();
            if (rblval == "Yes") {
                $("#" + text).removeAttr("disabled");
                $("#" + text).attr("Required", "required");
            }
            else {
                $("#" + text).val("");
                $("#" + text).attr("disabled", "disabled");
                $("#" + text).removeAttr("Required");
            }
        }
    </script>
</asp:Content>



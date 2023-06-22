<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="AddSkillDevelopment.aspx.cs" Inherits="CF.AdSkillDevelopment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add Skill Development</title>
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
                    window.location = "SkillDevelopmentinfo .aspx";
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
                    <h3 class="box-title">Add Skill Development</h3>
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

                    <asp:Panel ID="Panel12" runat="server" GroupingText="Skill Development and Livelihood Enhancement">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label211" runat="server" Text=" Number of BPL HHs"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtNumber" runat="server" CssClass="form-control" oninput="NumberCheck(input)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter  Number of BPL HHs " ControlToValidate="txtNumber" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>


                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label212" runat="server" Text="Employment status"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtstatus" runat="server" CssClass="form-control" oninput="SplCharCheck(input)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter  Employment status " ControlToValidate="txtstatus" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label213" runat="server" Text="Percentage of people unemployed"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtunemployed" runat="server" CssClass="form-control" oninput="DecimalCheck(input)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter  Percentage of people unemployed " ControlToValidate="txtunemployed" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label214" runat="server" Text="Percentage of Youth looking for employment"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtlookingforemployment" runat="server" CssClass="form-control" oninput="DecimalCheck(input)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter  PePercentage of Youth looking for employment " ControlToValidate="txtlookingforemployment" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label215" runat="server" Text="Percentage of Youth interested in training"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtinterestedintraining" runat="server" CssClass="form-control" oninput="DecimalCheck(input)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter  Percentage of Youth interested in training " ControlToValidate="txtinterestedintraining" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label216" runat="server" Text="Percentage of Youth interested in entrepreneurship"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtentrepreneurship" runat="server" CssClass="form-control" oninput="DecimalCheck(input)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter  Percentage of Youth interested in entrepreneurship " ControlToValidate="txtentrepreneurship" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label217" runat="server" Text="Percentage of Women looking for income generation "></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtincomegeneration" runat="server" CssClass="form-control" oninput="DecimalCheck(input)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter  Percentage of Women looking for income generation activity" ControlToValidate="txtincomegeneration" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label218" runat="server" Text="Percentage of households migrates for employment" oninput="DecimalCheck(input)"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtmigratesforemploymen" runat="server" CssClass="form-control" oninput="DecimalCheck(input)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter  Percentage of households migrates for employmenty" ControlToValidate="txtmigratesforemploymen" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label219" runat="server" Text="Households having MGNREGA job cards"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtMGNREGAjobcards" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter  Households having MGNREGA job cards" ControlToValidate="txtMGNREGAjobcards" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label220" runat="server" Text="No. of families involved in farm based livelihood activities"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtfarmbasedlivelihood" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter  No. of families involved in farm based livelihood activities" ControlToValidate="txtfarmbasedlivelihood" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label221" runat="server" Text="No. of families involved in non-farm based livelihood "></asp:Label>
                                    <asp:TextBox ID="txtnonfarmbasedlivelihood" runat="server" CssClass="form-control" oninput="NumberCheck(input)" />

                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label222" runat="server" Text="Percentage of HHs with Kitchen gardens"></asp:Label><b style="color: red"> *</b>
                                    <asp:TextBox ID="txtKitchengardens" runat="server" CssClass="form-control" oninput="DecimalCheck(input)" />
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter  Percentage of HHs with Kitchen gardens" ControlToValidate="txtKitchengardens" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
                <div class="box-footer clearfix">
                    <a id="A1" runat="server" class="btn btn-danger" href="SkillDevelopmentinfo.aspx">Cancel</a>
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSubmit_Click" />
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

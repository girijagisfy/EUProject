<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="EditAnganwadi.aspx.cs" Inherits="CF.EditAnganwadi" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Edit Anganwadi Details</title>
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
                    window.location = "AnganwadiInfo.aspx";
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
                    <h3 class="box-title">Edit Anganwadi Details</h3>
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
                    <asp:Panel runat="server" GroupingText="Anganwadi details">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label223" runat="server" Text="Name of Anganwadi Centre"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txtAnganwadi" runat="server" CssClass="form-control" oninput="SplCharCheck(this)" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAnganwadi" ErrorMessage="Enter Anganwadi name" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label5" runat="server" Text="Enrolment in Anganwadi Centre"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txtEnroll" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEnroll" ErrorMessage="Enter Total Enrolment" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label269" runat="server" Text="Anganwadi Functional"></asp:Label><b class="text-red">*</b>
                                    <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control">
                                        <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlStatus" InitialValue="Select" ErrorMessage="Select Anganwadi Functional" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label224" runat="server" Text="0 To 1 Age Group Boys"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txt0to1boys" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txt0to1boys" ErrorMessage="Enter 0 To 1 Age Group" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label6" runat="server" Text="0 To 1 Age Group Girls"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txt0to1girls" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txt0to1girls" ErrorMessage="Enter 0 To 1 Age Group" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label270" runat="server" Text="1 To 3 Age Group Boys"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txt1to3Boys" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txt1to3Boys" ErrorMessage="Enter 1 To 3 Age Group" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label7" runat="server" Text="1 To 3 Age Group Girls"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txt1to3Girls" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txt1to3Girls" ErrorMessage="Enter 1 To 3 Age Group" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label225" runat="server" Text="3 To 6 Age Group Boys"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txt3to6Boys" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txt3to6Boys" ErrorMessage="Enter 3 To 6 Age Group" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label9" runat="server" Text="3 To 6 Age Group Girls"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txt3to6Girls" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txt3to6Girls" ErrorMessage="Enter 3 To 6 Age Group" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label233" runat="server" Text="12 To 45 Age Group"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txt12to45" runat="server" CssClass="form-control" oninput="NumberCheck(this)" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txt12to45" ErrorMessage="Enter 12 To 45 Age Group" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label226" runat="server" Text="No of Pregnant Women"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txtPregnent" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPregnent" ErrorMessage="Enter No of Pregnants" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label227" runat="server" Text="No of Lactating Women"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txtLactating" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLactating" ErrorMessage="Enter No of Lactating" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label4" runat="server" Text="No of Adolescent Girls Enrolled"></asp:Label><b class="text-red">*</b>
                                    <asp:TextBox ID="txtAdults" runat="server" oninput="NumberCheck(this)" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAdults" ErrorMessage="Enter No of Adult Girls" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
                <div class="box-footer clearfix">
                    <a id="btnCancel" runat="server" class="btn btn-danger" href="AnganwadiInfo.aspx">Cancel</a>
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-warning" Text="Update" OnClick="btnSubmit_Click" />
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

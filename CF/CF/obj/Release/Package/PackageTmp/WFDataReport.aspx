<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="WFDataReport.aspx.cs" Inherits="CF.WFDataReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>WF Data Report</title>
    <script>
        function ShowAlert(msg, type) {
            ////debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "WFDataReport.aspx";
                });
            }
            else {
                swal("", msg, type);
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
                    <h3 class="box-title">Woman Farmer Indicator Report</h3>
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
                                        <asp:Label ID="lblCSO" runat="server" Text="Select CSO"></asp:Label><b class="text-danger">*</b>
                                        <asp:DropDownList ID="ddlCSO" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlCSO_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" InitialValue="Select" ControlToValidate="ddlCSO" ErrorMessage="Please Select CSO" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label27" runat="server" Text="State"></asp:Label>
                                        <asp:DropDownList ID="ddlstate" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlstate_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label30" runat="server" Text="District"></asp:Label>
                                        <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label31" runat="server" Text="Block"></asp:Label>
                                        <asp:DropDownList ID="ddlBlock" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlBlock_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="lblVillage" runat="server" Text="Village"></asp:Label>
                                        <asp:DropDownList ID="ddlVillage" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlVillage_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="lblWFG" runat="server" Text="Woman Former Group"></asp:Label>
                                        <asp:DropDownList ID="ddlWFG" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlWFG_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label1" runat="server" Text="Woman Formers"></asp:Label>
                                        <asp:DropDownList ID="ddlWF" CssClass="form-control" runat="server" onchange="GetDate()">
                                            <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <asp:Label ID="Label3" runat="server" Text="Year"></asp:Label><b class="text-danger">*</b>
                                        <asp:TextBox ID="txtYear" runat="server" CssClass="form-control YearPicker" MaxLength="4" oninput="NumberCheck(this)"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtYear" ErrorMessage="Please Enter Year" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="box-footer">
                    <a href="WFDataTrackingInfo.aspx" class="btn btn-danger">Cancel</a>
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Generate" OnClick="btnExcel_Click" />
                </div>
            </div>
        </form>
        <script>
            $(document).ready(function () {
                $("#liDataManage").addClass('active menu-open');
                $("#liWFDatatrack").addClass("active");
            })
            $(document).ready(function () {
                $(".YearPicker").datepicker({
                    format: "yyyy", // Notice the Extra space at the beginning
                    viewMode: "years",
                    minViewMode: "years",
                    autoclose: true
                });
            });

            var prm = Sys.WebForms.PageRequestManager.getInstance();
            if (prm != null) {
                prm.add_endRequest(function (sender, e) {
                    if (sender._postBackSettings.panelsToUpdate != null) {
                        $(".YearPicker").datepicker({
                            format: "yyyy", // Notice the Extra space at the beginning
                            viewMode: "years",
                            minViewMode: "years",
                            autoclose: true
                        });
                    }
                });
            };
        </script>
    </section>
</asp:Content>

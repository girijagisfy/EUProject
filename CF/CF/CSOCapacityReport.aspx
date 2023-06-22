<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="CSOCapacityReport.aspx.cs" Inherits="CF.CSOCapacityReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>CSO Capacity Report</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <form runat="server">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">CSO Capacity Report</h3>
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="col-md-3">
                        <div class="form-group">
                            <asp:Label ID="Label3" runat="server" Text="Year"></asp:Label>
                            <asp:TextBox ID="txtYear" runat="server" CssClass="form-control YearPicker" MaxLength="4" oninput="NumberCheck(this)"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Enter Year" ControlToValidate="txtYear" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <br />
                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Generate" OnClick="btnSubmit_Click" />
                    </div>
                </div>
            </div>
        </form>
        <script>
            $(document).ready(function () {
                $(".YearPicker").datepicker({
                    format: "yyyy", // Notice the Extra space at the beginning
                    viewMode: "years",
                    minViewMode: "years",
                    autoclose: true
                });
            });
        </script>
    </section>
</asp:Content>

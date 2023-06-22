<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="AddVillage.aspx.cs" Inherits="CF.AddVillage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add Village</title>

    <script type="text/javascript">

        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "VillagesInfo.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
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
            <div class="box box-success">
                <div class="box-header with-border">
                    <h3 class="box-title">Add Village</h3>
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
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblCso" runat="server" Text="CSO"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlCso" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlCso_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ControlToValidate="ddlCso" InitialValue="Select" ErrorMessage="Please select CSO" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
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
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lbldist" runat="server" Text="Name of District"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlDistrict" InitialValue="Select" ErrorMessage="Please select District" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblblk" runat="server" Text="Block"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlBlock" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlBlock" InitialValue="Select" ErrorMessage="Please select Block" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label1" runat="server" Text="Name of Gram Panchayat"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:TextBox runat="server" ID="txtGramPamchayat" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select Gram Panchayat Name" ControlToValidate="txtGramPamchayat" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblRevenueVillageName" runat="server" Text="Name of Village"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlVillage" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select Village" ControlToValidate="ddlVillage" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="box-footer clearfix">
                        <a id="btnCancel" runat="server" class="btn btn-danger" href="VillagesInfo.aspx">Cancel</a>
                        <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" CssClass="btn btn-primary" Text="Add" />
                    </div>
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

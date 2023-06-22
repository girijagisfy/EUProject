<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="WFDocsAdd.aspx.cs" Inherits="CF.WFDocsAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add WF Docs</title>
    <style>
        label {
            padding-left: 10px;
        }

        .modal-lg, .modal-xl {
            max-width: 70%;
        }

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
            //debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "WFGDocs.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm1" runat="server"></asp:ScriptManager>
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Add WF Docs</h3>
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>

                <div class="box-body">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <%--<div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblStates" runat="server" Text="State"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlStates" CssClass="form-control" OnSelectedIndexChanged="ddlStates_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlStates" CssClass="text-danger" InitialValue="Select" ErrorMessage="Please select States" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lbldist" runat="server" Text="District"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlDisrtict" CssClass="form-control" OnSelectedIndexChanged="ddlDisrtict_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlDisrtict" InitialValue="Select" ErrorMessage="Please select District" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lblblk" runat="server" Text="Block"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlBlocks" CssClass="form-control" OnSelectedIndexChanged="ddlBlocks_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlBlocks" InitialValue="Select" ErrorMessage="Please select Block" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>--%>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label1" runat="server" Text="CSO"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlCSO" CssClass="form-control" OnSelectedIndexChanged="ddlCSO_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlCSO" InitialValue="Select" ErrorMessage="Please select CSO" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label3" runat="server" Text="Village"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlvillage" CssClass="form-control" OnSelectedIndexChanged="ddlvillage_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlvillage" InitialValue="Select" ErrorMessage="Please select Village" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label2" runat="server" Text="WFG"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlwfg" CssClass="form-control" OnSelectedIndexChanged="ddlwfg_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlwfg" InitialValue="Select" ErrorMessage="Please select WFG" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="Label4" runat="server" Text="Women Farmer"></asp:Label><b style="color: red"> *</b>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:DropDownList runat="server" ID="ddlWF" CssClass="form-control">
                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlWF" InitialValue="Select" ErrorMessage="Please select Woman" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label ID="Label18" runat="server" Text="Upload Your Document"></asp:Label><b style="color: red"> *</b>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:FileUpload runat="server" class="custom-file-input" onchange="showpreview(this)" ID="CsoDocs" accept=".pdf" />
                                <label class="custom-file-label" id="lblCsologo" for="CsoDocs" style="overflow: hidden">Choose file</label>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="CsoDocs" ErrorMessage="Please select .pdf files" CssClass="text-danger" SetFocusOnError="true" Display="Dynamic" ></asp:RequiredFieldValidator>
                                 <asp:RegularExpressionValidator runat="server" ControlToValidate="CsoDocs" ErrorMessage="Only .pdf files are allowed." CssClass="text-danger" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.pdf)$" SetFocusOnError="true"></asp:RegularExpressionValidator>  
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer clearfix">
                    <a id="btnCancel" runat="server" class="btn btn-danger" href="WFDocs.aspx">Cancel</a>
                    <asp:Button runat="server" ID="btnSubmit" Text="save" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                </div>
            </div>
        </section>
    </form>
    <script>
        $(document).ready(function () {
            $("#liDocs").addClass('active menu-open');
            $("#liWFDocs").addClass("active");
        });
        $(".custom-file-input").on("change", function () {
            ////debugger;
            var fileName = $(this).val().split("\\").pop();
            $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
        });
    </script>
</asp:Content>

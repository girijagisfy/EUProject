<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="WFAssignPage.aspx.cs" Inherits="CF.WFAssignPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Women Transfer</title>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <%--<link href="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css"
        rel="stylesheet" type="text/css" />--%>
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js"></script>
    <link href="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/css/bootstrap-multiselect.css"
        rel="stylesheet" type="text/css" />
    <script src="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/js/bootstrap-multiselect.js"
        type="text/javascript"></script>

    <script>
        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "WFAssignPage.aspx";
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
                    <h3 class="box-title">Assign Women Farmers to Group</h3>
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <%--                <asp:UpdatePanel runat="server">
                    <ContentTemplate>--%>

                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label ID="Label3" runat="server" Text="Select CSO"></asp:Label><b style="color: red"> *</b>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlCSO" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlCSO_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select CSO" ControlToValidate="ddlCSO" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label ID="lblVillage" runat="server" Text="Select Village"></asp:Label><b style="color: red"> *</b>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlVillage" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlVillage_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select Village" ControlToValidate="ddlVillage" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label ID="Label1" runat="server" Text="Select Women Profiles"></asp:Label><b style="color: red"> *</b>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:ListBox ID="ddlWFs" CssClass="form-control" runat="server" SelectionMode="Multiple"></asp:ListBox>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select Women Profiles" ControlToValidate="ddlWFs" InitialValue="" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:Label ID="Label2" runat="server" Text="Select Women Farmer Group"></asp:Label><b style="color: red"> *</b>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <asp:DropDownList ID="ddlWFGs" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="Please Select Women Farmer Group" ControlToValidate="ddlWFGs" InitialValue="Select" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer clearfix">
                        <a id="btnCancel" runat="server" class="btn btn-danger" href="WFAssignPage.aspx">Cancel</a>
                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Transfer" OnClick="btnSubmit_Click" />
                    </div>
                </div>
            </div>
        </section>
        <script type="text/javascript">
            $(function () {
                $("#<%=ddlWFs.ClientID%>").multiselect({
                    includeSelectAllOption: true
                });
            });
        </script>
    </form>
</asp:Content>

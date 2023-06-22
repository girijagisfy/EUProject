<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="CF.aspx.cs" Inherits="CF.CF" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title></title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm1" runat="server"></asp:ScriptManager>

        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <asp:Label ID="lblNoofHamlets" runat="server" Text="Number and names of hamlets"></asp:Label>
                </div>
            </div>
            <asp:HiddenField ID="hiddenHamlet" runat="server" Value="1" />

            <div class="col-md-8">
                <div class="row" runat="server" id="Hamlet">
                    <div class="col-md-3">
                        <div class="form-group">
                            <asp:TextBox ID="txtNoofHamlets0" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Panel ID="pnlTextBoxes" runat="server">
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="col-md-1" style="margin-top: 0.5%;">
                        <div class="form-group">
                            <asp:LinkButton ID="lbkAddHamlet" runat="server" OnClick="AddTextBox"><i class="fa fa-plus-circle fa-2x"></i></asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>


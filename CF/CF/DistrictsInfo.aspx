﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="DistrictsInfo.aspx.cs" Inherits="CF.DistrictsInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Districts Info</title>
    <style>
        td {
            vertical-align: middle !important;
        }
    </style>
    <script>
        function ConfirmAlert(btnConfirm) {
            if (btnConfirm.dataset.confirmed) {
                // The action was already confirmed by the user, proceed with server event
                btnConfirm.dataset.confirmed = false;
                return true;
            } else {
                // Ask the user to confirm/cancel the action
                event.preventDefault();
                swal({
                    title: "Are you sure to delete ?",
                    //text: "Once submitted, you will not be able to edit this form!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then((willConfirm) => {
                    if (willConfirm) {
                        // Set data-confirmed attribute to indicate that the action was confirmed
                        btnConfirm.dataset.confirmed = true;
                        // Trigger button click programmatically
                        btnConfirm.click();
                    }
                    else {
                        //swal("Your imaginary file is safe!");
                    }
                });
            }
        }

        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "DistrictsInfo.aspx";
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
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h1 class="box-title">Districts Information</h1>
                    <div class="pull-right box-tools">
                        <a id="btnAddNew" runat="server" class="btn btn-success" href="AddDistrict.aspx"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                    </div>
                    <div class="pull-right box-tools" style="width: 20%; margin-right: 2%; margin-bottom: 1%;">

                        <asp:DropDownList runat="server" ID="searchStates" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="searchStatess_SelectedIndexChanged">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="pull-right box-tools" style="margin-right: 1%;">
                        <h4>State Filter</h4>
                    </div>
                </div>
                <div class="box-body">
                    <div style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                        <asp:GridView ID="gvDistrict" runat="server" DataKeyNames="DistrictID" CssClass="table table-striped table-bordered table-condensed table-hover" AutoGenerateColumns="false" AllowSorting="True" EmptyDataRowStyle-CssClass="infoarea" AlternatingRowStyle-CssClass="infoarea" OnRowCommand="gvDistrict_RowCommand" AllowPaging="true" OnSorting="gvDistrict_Sorting" OnPageIndexChanging="gvDistrict_PageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="StateName" HeaderText="State Name" SortExpression="StateName" />
                                <asp:BoundField DataField="District" HeaderText="District Name" SortExpression="District" />
                                <asp:ButtonField ButtonType="Link" ControlStyle-Font-Size="x-large" CommandName="btnEdit" ControlStyle-CssClass="nav-icon fa fa-edit" HeaderText="Edit" HeaderStyle-CssClass="text-blue" />
                                <asp:TemplateField HeaderStyle-CssClass="text-blue">
                                    <HeaderTemplate>
                                        Delete
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelete" ForeColor="Red" Font-Size="X-Large" runat="server" Text="<i class='nav-icon fa fa-trash-o'></i>" OnClientClick="ConfirmAlert(this)" OnClick="btnDelete_Click"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </section>
    </form>
    <script>
        $(document).ready(function () {
            //debugger;
            $("#liDistricts").addClass("active");
        });
    </script>
</asp:Content>

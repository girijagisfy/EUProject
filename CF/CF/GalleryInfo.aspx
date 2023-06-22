<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="GalleryInfo.aspx.cs" Inherits="CF.GalleryInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>GalleryInfo</title>
    <style>
        td {
            vertical-align: middle !important;
        }

        img {
            height: 100px;
            width: 100px;
            cursor: zoom-in;
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
                    window.location = "GalleryInfo.aspx";
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
            <div class="box box-success">
                <div class="box-header with-border">
                    <h1 class="box-title">Gallery Info</h1>
                    <div class="pull-right box-tools">

                        <a id="btnAddNew" runat="server" class="btn btn-success" href="~/AddGalleryPhotos.aspx"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>
                    </div>
                </div>
                <div class="box-body">
                    <div class="col-xs-6" style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                        <asp:GridView ID="gallery" runat="server" DataKeyNames="ImageId" CssClass="table table-striped table-bordered table-condensed table-hover" AutoGenerateColumns="false" AllowSorting="True" EmptyDataRowStyle-CssClass="infoarea" AlternatingRowStyle-CssClass="infoarea" OnRowCommand="gallery_RowCommand" AllowPaging="true" PageSize="5" OnSorting="gallery_Sorting" OnPageIndexChanging="gallery_PageIndexChanging">
                            <Columns>
                                <asp:ImageField DataImageUrlField="ImagePath" HeaderText="Images" ItemStyle-Width="300px">
                                </asp:ImageField>



                                <%-- 
                                <asp:ButtonField ButtonType="Link" ControlStyle-Font-Size="x-large" CommandName="btnEdit" HeaderText="Edit" ControlStyle-CssClass="nav-icon fa fa-edit" HeaderStyle-CssClass="text-blue" />--%>
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

                    <div class="col-xs-6" style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                        <asp:GridView ID="gvVideos" runat="server" DataKeyNames="ImageId" CssClass="table table-striped table-bordered table-condensed table-hover" AutoGenerateColumns="false" AllowSorting="True" EmptyDataRowStyle-CssClass="infoarea" AlternatingRowStyle-CssClass="infoarea" OnRowCommand="gvVideos_RowCommand" AllowPaging="true" PageSize="5" OnSorting="gallery_Sorting" OnPageIndexChanging="gallery_PageIndexChanging">
                            <Columns>

                                <asp:TemplateField HeaderText="Video" ItemStyle-Width="100px">
                                    <ItemTemplate>
                                        <video controls="controls" width="260" height="180">
                                            <source src='<%#Eval("VideoPath")%>' type="video/mp4">
                                        </video>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <%-- 
                                <asp:ButtonField ButtonType="Link" ControlStyle-Font-Size="x-large" CommandName="btnEdit" HeaderText="Edit" ControlStyle-CssClass="nav-icon fa fa-edit" HeaderStyle-CssClass="text-blue" />--%>
                                <asp:TemplateField HeaderStyle-CssClass="text-blue">
                                    <HeaderTemplate>
                                        Delete
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelete" ForeColor="Red" Font-Size="X-Large" runat="server" Text="<i class='nav-icon fa fa-trash-o'></i>" OnClientClick="ConfirmAlert(this)" OnClick="btnDelete_Click1"></asp:LinkButton>
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
            $("#liVillages").addClass("active");
        });
    </script>
    <script>
        $('img').addClass('img-enlargable').click(function () {
            var src = $(this).attr('src');
            $('<div>').css({
                background: 'RGBA(0,0,0,.5) url(' + src + ') no-repeat center',
                backgroundSize: 'contain',
                width: '100%', height: '100%',
                position: 'fixed',
                zIndex: '10000',
                top: '0', left: '0',
                cursor: 'zoom-out'
            }).click(function () {
                $(this).remove();
            }).appendTo('body');
        });

    </script>
</asp:Content>

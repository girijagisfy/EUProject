<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="AddGalleryPhotos.aspx.cs" Inherits="CF.GalleryPhotos" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Gallery</title>
    <script>

        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {

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
        function validateEmail(emailField) {
            //debugger;
            var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            if ($('#ContentPlaceHolder1_txtUserName').val() != '') {
                if (reg.test(emailField.value) == false) {
                    //alert('Invalid Email Address');
                    $('#lblemail').text('Please enter valid email');
                    $('#ContentPlaceHolder1_txtUserName').focus();
                    return false;
                }
                $('#lblemail').text('');
                return true;
            }
            $('#lblemail').text('');
            return true;

        }

    </script>

    <script type="text/javascript">



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
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Gallery</h3>
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-box-tool">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <div class="box-body">

                    <asp:Panel ID="Gallery" runat="server">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="lblcompany" runat="server" Text="Upload Images Videos"></asp:Label><b style="color: red"> *</b>
                                    <asp:FileUpload ID="Imageupload" AllowMultiple="true" runat="server" CssClass="form-control"  accept=".jpg,.jpeg,.png,.mp4" />

                                </div>
                            </div>
                        </div>


                        <%--     <div class="col-md-4">
                                <div class="form-group">
                                    <asp:Label ID="Label1" runat="server" Text="Upload Vidoes"></asp:Label><b style="color: red"> *</b>
                                    <asp:FileUpload ID="VidoeUpload" runat="server" CssClass="form-control" />

                                </div>
                            </div>--%>







                        <div class="row">
                            <div class="box-footer clearfix">
                                <a id="A1" runat="server" class="btn btn-danger" href="~/GalleryInfo.aspx">Cancel</a>
                                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="UpLoad" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </asp:Panel>


                </div>
            </div>
        </section>
    </form>


</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="WfFilter.aspx.cs" Inherits="CF.WfFilter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>WF Filter</title>
    <style>
        .loader {
            position: fixed;
            left: 50%;
            top: 40%;
            width: 100%;
            height: 100%;
            z-index: 99999999;
        }

        .dvloader {
            margin: 0px;
            display: none;
            padding: 0px;
            position: absolute;
            right: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            background-color: rgb(255, 255, 255);
            z-index: 300;
            opacity: 0.8;
        }
    </style>
    <script>
        function ShowAlert(msg, type) {
            debugger;
            if (type == 'success') {
                swal("", msg, type).then(function () {
                    window.location = "WFInfo.aspx";
                });
            }
            else {
                swal("", msg, type);
            }
        }

        function DownloadExcel(url) {
            window.open(url, "_blank");
        }

        function ConfirmAlert(btnConfirm) {
            if (btnConfirm.dataset.confirmed) {
                // The action was already confirmed by the user, proceed with server event
                btnConfirm.dataset.confirmed = false;
                return true;
            } else {
                // Ask the user to confirm/cancel the action
                event.preventDefault();
                swal({
                    title: "Are you sure to " + btnConfirm.value + " ?",
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
        var loading;
        function ShowLoader() {
            debugger;
            loading = $("#loading");
            loading.show();
        };

        function HideLoader() {
            loading = $("#loading");
            loading.show();
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm1"></asp:ScriptManager>
        <!-- Modal -->
        <div class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h1 class="box-title">Filter</h1>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <asp:LinkButton ID="lnkAddFilter" runat="server"><i class="fa fa-plus-circle">&nbsp;Add Filter</i></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <div class="row" id="filter0">
                        <div class="col-md-4 form-group">
                            <select id="ddlFilterColumn0" class="form-control ColumnType">
                                <option value="Select">Select</option>
                            </select>
                        </div>
                        <div class="col-md-2 form-group">
                            <select id="ddlExp0" class="form-control ExpType">
                                <option value="Is">Is</option>
                                <option value="Is Not">Is Not</option>
                                <option value="Is Less Than">Is Less Than</option>
                                <option value="Is Greater Than">Is Greater Than</option>
                                <option value="Is Less Than Equal">Is Less Than Equal</option>
                                <option value="Is Greater Than Equal">Is Greater Than Equal</option>
                            </select>
                        </div>
                        <div class="col-md-3 form-group">
                            <select id="ddlFilterData0" class="form-control SelectdData">
                                <option value="Select">Select</option>
                            </select>
                        </div>
                        <div class="col-md-2 form-group">
                            <select id="ddlOperation0" class="form-control OperationType">
                                <option value="And">And</option>
                                <option value="Or">Or</option>
                            </select>
                        </div>
                    </div>
                    <div id="dynamicDDL">
                    </div>
                </div>
                <div class="box-footer">
                    <a class="btn btn-danger" href="WFInfo.aspx">Close</a>
                    <asp:Button CssClass="btn btn-primary" ID="btnApply" runat="server" OnClick="btnApply_Click" Text="Apply" />
                </div>

                <asp:HiddenField ID="hiddenDivRowId" runat="server" Value="1" />
                <asp:HiddenField ID="hiddenDataArrayId" runat="server" />
            </div>
            <br />
            <%----%>
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h1 class="box-title">Filtered WF's Info</h1>
                    <div class="pull-right box-tools">
                        <%--<a id="btnAddNew" runat="server" class="btn btn-success" href="AddWF.aspx"><i class="fa fa-plus-circle">&nbsp;Add New</i></a>--%>
                    </div>
                    <div class="pull-right box-tools" style="margin-right: 10px;">
                        <asp:LinkButton ID="btnReport" Font-Size="X-Large" OnClick="btnReport_Click" runat="server">
                                <img src="Images/Excel.png" style="width: 30px;" /></asp:LinkButton>
                    </div>
                </div>
                <asp:UpdatePanel runat="server" ID="up1">
                    <ContentTemplate>
                        <div class="box-body">
                            <div style="background: white; margin-left: -7.5px; margin-right: -7.5px">
                                <asp:GridView runat="server" CssClass="table table-striped table-bordered table-condensed table-hover infoarea" ID="gvWF" DataKeyNames="WfNo, Status" AutoGenerateColumns="false" OnRowCommand="gvWF_RowCommand" AllowSorting="true" AllowPaging="true" PageSize="50" OnSorting="gvWF_Sorting" OnPageIndexChanging="gvWF_PageIndexChanging" OnRowDataBound="gvWF_RowDataBound" OnRowCreated="Gridview1_RowCreated">
                                    <Columns>
                                        <asp:BoundField DataField="WomenName" HeaderText="Women Name" SortExpression="WomenName" />
                                        <asp:BoundField DataField="Village" HeaderText="Village Name" SortExpression="Village" />
                                        <asp:BoundField DataField="CSOName" HeaderText="CSO Name " SortExpression="CSOName" />
                                        <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" SortExpression="ContactNumber" />
                                        <asp:ButtonField ButtonType="Link" ControlStyle-Font-Size="x-large" HeaderText="Edit" CommandName="btnEdit" ControlStyle-CssClass="nav-icon fa fa-edit" HeaderStyle-CssClass="text-blue" />
                                        <asp:TemplateField HeaderStyle-CssClass="text-blue">
                                            <HeaderTemplate>
                                                Active/Inactive
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Button ID="btnStatus" runat="server" CommandName="" Text="" OnClientClick="ConfirmAlert(this)" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-CssClass="text-blue">
                                            <HeaderTemplate>
                                                Delete
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnDelete" ForeColor="Red" Font-Size="X-Large" runat="server" Text="<i class='nav-icon fa fa-trash-o'></i>" OnClick="btnDelete_Click" OnClientClick="ConfirmAlert(this,'Delete')"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div id="loading" class="dvloader" style="display: none">
                <div class="loader">
                    <img src="Images/waiting.gif" />
                </div>
            </div>
        </div>
    </form>
    <script>
        $(document).ready(function () {
            //debugger;
            BindColumns();
            $("#ContentPlaceHolder1_lnkAddFilter").click(function (e) {
                //debugger;
                var id = $("#<%=hiddenDivRowId.ClientID %>").val();
                e.preventDefault();
                $("#dynamicDDL").append('<div class="row" id="filter' + id + '"><div class="col-md-4 form-group"><select id="ddlFilterColumn' + id + '" class="form-control ColumnType"><option value="Select">Select</option></select></div><div class="col-md-2 form-group"><select id="ddlExp' + id + '" class="form-control ExpType"><option value="Is">Is</option><option value="Is Not">Is Not</option><option value="Is Less Than">Is Less Than</option><option value="Is Greater Than">Is Greater Than</option><option value="Is Less Than Equal">Is Less Than Equal</option><option value="Is Greater Than Equal">Is Greater Than Equal</option></select></div><div class="col-md-3 form-group"><select id="ddlFilterData' + id + '" class="form-control SelectdData"><option value="Select">Select</option></select></div><div class="col-md-2 form-group"><select id="ddlOperation' + id + '" class="form-control OperationType"><option value="And">And</option><option value="Or">Or</option></select></div><div class="col-md-1 form-group"><a href="#" onclick = "RemoveCurrentDiv(&apos;#filter' + id + '&apos;);" style="color:red"><i class="fa fa-remove"></i></a></div></div>');
                id++;
                $("#<%=hiddenDivRowId.ClientID %>").val(id);
                console.log(id);
                BindColumns();
                return false;
            });
        });

        function GetFilterData() {
            //debugger;
            var DataCount = $("#<%=hiddenDivRowId.ClientID %>").val();
            var Data = $("#ddlFilterColumn0").val() + ':' + $("#ddlExp0").val() + ':' + $("#ddlOperation0").val() + ':' + $("#ddlFilterData0").val();

            for (var i = 1; i < DataCount; i++) {
                var ddlColumnId = "ddlFilterColumn" + i;
                var ddlExp = "ddlExp" + i;
                var ddlOp = "ddlOperation" + i;
                var ddlData = "ddlFilterData" + i;
                if ($('#' + ddlColumnId).val() != '' && $('#' + ddlExp).val() != undefined && $('#' + ddlOp).val() != undefined && $('#' + ddlData).val() != undefined) {
                    if (Data != "") {
                        Data += '$' + $('#' + ddlColumnId).val() + ':' + $('#' + ddlExp).val() + ':' + $('#' + ddlOp).val() + ':' + $('#' + ddlData).val();
                    }
                    else {
                        Data += $('#' + ddlColumnId).val() + ':' + $('#' + ddlExp).val() + ':' + $('#' + ddlOp).val() + ':' + $('#' + ddlData).val();
                    }
                }
            }

            $("#<%=hiddenDataArrayId.ClientID %>").val(Data);
            console.log('Selected Values');
            console.log($("#<%=hiddenDataArrayId.ClientID %>").val());
        }

        function RemoveCurrentDiv(id) {
            //debugger;
            $(id).remove();
            GetFilterData();
            return false;
        };

        $('body').on('change', 'Select', function () {
            //debugger;
            GetFilterData();
        });

        $('body').on('change', '.ColumnType', function () {
            //debugger;
            GetFilterData();
            var selectedDDLId = this.id;
            var lastId = selectedDDLId.slice(selectedDDLId.length - 1);
            var selectedDDLValue = $(this).val();

            var DataClmnId = "ddlFilterData" + lastId;

            console.log(DataClmnId);
            console.log(selectedDDLValue);

            $.ajax({
                type: "POST",
                async: false,
                url: "WfFilter.aspx/BindDataFromColumns",
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify({ selectedColumn: selectedDDLValue }),
                success: function (res) {
                    //debugger;
                    console.log(res);
                    console.log(res.d);
                    $("#" + DataClmnId).empty();
                    $("#" + DataClmnId).append($("<option value='Select'>Select</option>"));
                    $.each(res.d, function (data, value) {
                        $("#" + DataClmnId).append($("<option></option>").val(value.selectedColumnData).html(value.selectedColumnData));
                    })
                }
            });


        });
    </script>
    <script src="scripts/jquery-3.0.0.min.js"></script>
    <script>
        $(document).ready(function () {
            //debugger;
            $("#liWF").addClass("active");
        });

        function BindColumns() {
            debugger;
            $.ajax({
                type: "POST",
                async: false,
                url: "WfFilter.aspx/BindColumns",
                dataType: "json",
                contentType: "application/json",
                success: function (res) {
                    $.each(res.d, function (data, value) {
                        $(".ColumnType").append($("<option></option>").val(value.COLUMN_NAME).html(value.COLUMN_NAME));
                    })
                }
            });
        };
    </script>

</asp:Content>

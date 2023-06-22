<%@ Page Title="" Language="C#" MasterPageFile="~/AdminTemplate.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" EnableEventValidation="false" Inherits="CF.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Dashboard</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.css" rel="stylesheet" />

    <style>
        .loader {
            position: fixed;
            left: 40%;
            top: 25%;
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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptmanager"></asp:ScriptManager>
        <div class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="row">
                        <div class="col-md-3">
                            <h1 class="box-title" style="margin-top: 6%; font-size: 25px;">Dashboard</h1>
                        </div>
                        <div class="col-md-9">
                            <div class="row">
                                <div class="col-md-4">
                                    <label>State</label>
                                    <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                        <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    <label>District</label>
                                    <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    <label>Block</label>
                                    <asp:DropDownList ID="ddlBlock" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlBlock_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <label>CSO</label>
                                    <asp:DropDownList runat="server" ID="ddlCSO" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCSO_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3">
                                    <div runat="server" id="DVVillage">
                                        <label>Village</label>
                                        <asp:DropDownList runat="server" ID="ddlvillage" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlvillage_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label>WFG</label>
                                    <asp:DropDownList runat="server" ID="ddlWFG" CssClass="form-control">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label>Year</label>
                                    <asp:TextBox ID="txtyear" runat="server" CssClass="form-control YearPicker"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--</ContentTemplate>
                    </asp:UpdatePanel>--%>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-12 col-sm-6 col-md-3">
                            <div class="info-box">
                                <span class="info-box-icon bg-green"><i class="ion ion-location"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text"><b style="font-size: 15px">Districts</b></span>
                                    <small><span>Total No. of Districts</span></small>
                                    <span class="info-box-number">
                                        <label id="lblDistricts"></label>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-md-3">
                            <div class="info-box">
                                <span class="info-box-icon bg-maroon"><i class="ion ion-location"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text"><b style="font-size: 15px">Blocks</b></span>
                                    <small><span>Total No. of Blocks</span></small>
                                    <span class="info-box-number">
                                        <label id="lblBlocks"></label>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-md-3">
                            <div class="info-box">
                                <span class="info-box-icon bg-fuchsia"><i class="ion ion-person-stalker"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text"><b style="font-size: 15px">CSO's</b></span>
                                    <small><span>Total No. of CSO's</span></small>
                                    <span class="info-box-number">
                                        <label id="lblCSOs"></label>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-md-3">
                            <div class="info-box">
                                <span class="info-box-icon bg-blue"><i class="ion ion-location"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text"><b style="font-size: 15px">Panchayath</b></span>
                                    <small><span>Total No. of Panchayath</span></small>
                                    <span class="info-box-number">
                                        <label id="lblPanchayath"></label>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 col-sm-6 col-md-3">
                            <div class="info-box">
                                <span class="info-box-icon bg-orange"><i class="ion ion-home"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text"><b style="font-size: 15px">Villages</b></span>
                                    <small><span>Total No. of Villages</span></small>
                                    <span class="info-box-number">
                                        <label id="lblVillages"></label>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-md-3">
                            <div class="info-box">
                                <span class="info-box-icon bg-yellow"><i class="ion ion-person-stalker"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text"><b style="font-size: 15px">WFG's</b></span>
                                    <small><span>Total No. of WFG's</span></small>
                                    <span class="info-box-number">
                                        <label id="lblWFGs"></label>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 col-md-3">
                            <div class="info-box">
                                <span class="info-box-icon bg-aqua"><i class="ion ion-person"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text"><b style="font-size: 15px">WF's</b></span>
                                    <small><span>Total No. of WF's</span></small>
                                    <span class="info-box-number">
                                        <label id="lblWFs"></label>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                        </div>
                    </div>
                    <!--BAR CHART START -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-info">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Social Category 
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="SocialCategoryChart" style="height: 300px"></div>
                                    </div>
                                    <!-- /.box-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-success">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Age</h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="AgeChart" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <div class="box box-warning">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Educational Qualification
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="EducationalQualificationChart" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Ration Card Holder   
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="RationCardholderChart" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Type of Ration Card
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="rationcardtypeChart" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-default">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Member of any CBO 
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="MemberofanyCBOChart" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">CBO Types
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="CBOChart" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-success">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">WFG's Member Linked to Govt. Scheme 
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="govtid" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Women has MGNREGA job card
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="MNREGAid" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-info">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Major Source of income of the family  
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="far fa-chart-bar"></i>
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="Famliyid" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>

                        <%--                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-warning">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Women Ownership In land  
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="landid" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>--%>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Source of irrigation
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="SOIid" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Total Irrigated Land 
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="Irrigatedchart" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Disability
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="divDisability" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Type of disability
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="divDisabilitytype" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Family Land Ownership
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="FamilyLandOwnership" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Whether woman has ownership in land
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="Whetherwomanhasownershipinland" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Whether a sharecropper
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="divsharecropper" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Demo plot
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="divDemoplot" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Have accessed govt. schemes after facilitation by project team
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="Haveaccessedgovt" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Participated in Baseline Survey
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="ParticipatedinBaselineSurvey" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Participated in Climate Change Vulnerability study
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="divClimateChange" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Participated in Gender Vulnerability Study
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="GenderVulnerability" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Has attended trainings
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="trainings" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">members with access to business incubator services with support 
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="businessincubator" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Which Service
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="WhichService" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">WFG members (on agricultural land) practising climate friendly agriculture
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="divClimateFriendly" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">WFG members cultivating 3 or more crops thanks to support of this Action, disaggregated 
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="DivWFGmemberscultivating" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Percentage of trained WFG members that demonstrate an increase in knowledge and skills 
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="PercentageoftrainedWFG" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Has a bank account
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="Hasabankaccount" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Knows how to obtain a loan from a formal financial institution
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="Knowshowtoobtainaloan" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Feels confident in managing money
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="managingmoney" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">WFG members with business plans developed 
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="WFGmemberswithbusinessplansdeveloped" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">WFG members have access to ICT
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="WFGmembershaveaccesstoICT" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">On farm members part of FPC 
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="OnfarmmemberspartofFPC" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Off farm members part of FPC
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="OfffarmmemberspartofFPC" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">WFG members has become a shareholder in a FPC 
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="shareholderinaFPC" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Name of the Training attended
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="Trainingattended" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="box box-danger">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Ujjwala Yojana
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="divUjjwala" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <div class="box box-primary">
                                    <div class="box-header with-border">
                                        <h1 class="box-title" style="font-size: 17px">Benefit/s availing if any from  govt schemes
                                        </h1>
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div id="govtschemes" style="height: 300px"></div>
                                    </div>
                                    <!-- /.card-body-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="loading" class="dvloader" style="display: none">
                        <div class="loader">
                            <img src="Images/Loading.gif" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hfUserType" />
        <asp:HiddenField runat="server" ID="hfClientID" />
        <%--<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>--%>

        <script>
            //import * as console from "console";

            var loading;
            $(document).ajaxStart(function () {
                loading = $("#loading");
                loading.show();
            });

            $(document).ajaxStop(function () {
                loading = $("#loading");
                loading.hide();
            });

            $(document).ready(function () {

                $(".YearPicker").datepicker({
                    format: "yyyy", // Notice the Extra space at the beginning
                    viewMode: "years",
                    minViewMode: "years",
                    autoclose: true
                });
                function bindChart() {
                    //console.log('enter bindChart');
                    var stateId = $('#<%=ddlState.ClientID%>').val() || 'All';
                    var districtId = $('#<%=ddlDistrict.ClientID%>').val() || 'All';
                    var blockId = $('#<%=ddlBlock.ClientID%>').val() || 'All';
                    var year = $('#<%=txtyear.ClientID%>').val()
                    var VillageId = $('#<%=ddlvillage.ClientID%>').val() || 'All';
                    var CSOId = $('#<%=ddlCSO.ClientID%>').val() || 'All';
                    var WFGID = $('#<%=ddlWFG.ClientID%>').val() || 'All';

                    //  SocialCategory
                    $.ajax({
                        type: "POST",
                        async: "false",
                        url: "Dashboard.aspx/SocialCategory",
                        data: JSON.stringify({ stateId: stateId, districtId: districtId, blockId: blockId, CSOId: CSOId, VillageId: VillageId, WFGID: WFGID }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "Json",
                        success: function (dataSocialCategory, textStatus, xhr) {

                            var title = ["SocialCategory", "No of women", { role: "style" },];
                            var table = [];
                            table.push(title);
                            for (var l = 0; l < dataSocialCategory.d.length; l++) {
                                var object = dataSocialCategory.d[l];
                                table.push(object);
                            }
                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var dataSocialCategory = google.visualization.arrayToDataTable(table);

                                var optionsSocialCategory = {
                                    /*title: 'Social Category',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    //colors: ['green', 'Orange', 'purple', 'blue', 'red'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart4 = new google.visualization.PieChart(document.getElementById('SocialCategoryChart'));
                                chart4.draw(dataSocialCategory, optionsSocialCategory);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    //Age
                    $.ajax({
                        type: "POST",
                        async: "false",
                        url: "Dashboard.aspx/Age",
                        data: JSON.stringify({ stateId: stateId, districtId: districtId, blockId: blockId, CSOId: CSOId, VillageId: VillageId, WFGID: WFGID }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data, textStatus, xhr) {

                            //console.log(data.d);

                            var tData = data.d.split(',');

                            var one = parseInt(tData[0]);
                            var two = parseInt(tData[1]);
                            var three = parseInt(tData[2]);
                            var Four = parseInt(tData[3]);
                            var Five = parseInt(tData[4]);
                            var Six = parseInt(tData[5]);
                            //Drain Types bar chart
                            google.charts.load("current", { packages: ['corechart'] });
                            google.charts.setOnLoadCallback(drawChartDrain);
                            function drawChartDrain() {
                                var AgeData = google.visualization.arrayToDataTable([
                                    ["Age", "No of women", { role: "style" }],
                                    ["Under 18", one, "rgb(255, 209, 140)"],
                                    ["18-30", two, "#dc3912"],
                                    ["31-40", three, "#b87333"],
                                    ["41-50", Four, "#ff9900"],
                                    ["51-60", Five, "#dc3912"],
                                    ["Above 60", Six, "#b87333"]
                                ]);

                                var Ageview = new google.visualization.DataView(AgeData);
                                Ageview.setColumns([0, 1,
                                    {
                                        calc: "stringify",
                                        sourceColumn: 1,
                                        type: "string",
                                        role: "annotation"
                                    },
                                    2]);

                                var Ageoptions = {
                                    /*title: "Age Breakup",*/
                                    legend: { position: "none" },
                                };

                                var Drainchart = new google.visualization.ColumnChart(document.getElementById("AgeChart"));
                                Drainchart.draw(AgeData, Ageoptions);
                            }
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    // CBOCategory
                    $.ajax({
                        type: "POST",
                        async: "false",
                        url: "Dashboard.aspx/CBOCategory",
                        data: JSON.stringify({ stateId: stateId, districtId: districtId, blockId: blockId, CSOId: CSOId, VillageId: VillageId, WFGID: WFGID }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data, textStatus, xhr) {

                            //console.log(data.d);

                            var title = ["CBO Nature", "Total", { role: "style" },];
                            var table = [];
                            table.push(title);
                            for (var l = 0; l < data.d.length; l++) {
                                var object = data.d[l];
                                table.push(object);
                            }
                            //Drain Types bar chart
                            //console.log(data.d);
                            google.charts.load('current', { 'packages': ['corechart'] });
                            google.charts.setOnLoadCallback(drawChart);

                            function drawChart() {
                                var dataCount = google.visualization.arrayToDataTable(table);

                                var optionsStatus = {
                                   /* title: 'CBO Types',*/

                                    legend:
                                        { position: 'none' }
                                };

                                var chart4 = new google.visualization.ColumnChart(document.getElementById('CBOChart'));
                                chart4.draw(dataCount, optionsStatus);


                            }
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    //RationCardholder
                    $.ajax({
                        type: "POST",
                        async: "false",
                        url: "Dashboard.aspx/RationCardholder",
                        data: JSON.stringify({ stateId: stateId, districtId: districtId, blockId: blockId, CSOId: CSOId, VillageId: VillageId, WFGID: WFGID }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "Json",
                        success: function (data, textStatus, xhr) {

                            var RationCardholderData = data.d.split(',');

                            var NO = parseFloat(RationCardholderData[0]);
                            var Yes = parseFloat(RationCardholderData[1]);

                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var dataRationCardholder = google.visualization.arrayToDataTable([
                                    ['RationCardholder', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', NO],

                                ]);

                                var optionsRationCardholder = {
                                    /*title: 'Ration Card holder',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart4 = new google.visualization.PieChart(document.getElementById('RationCardholderChart'));
                                chart4.draw(dataRationCardholder, optionsRationCardholder);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    //Rationcardtype
                    $.ajax({
                        type: "POST",
                        async: "false",
                        url: "Dashboard.aspx/Rationcardtype",
                        data: JSON.stringify({ stateId: stateId, districtId: districtId, blockId: blockId, CSOId: CSOId, VillageId: VillageId, WFGID: WFGID }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "Json",
                        success: function (data, textStatus, xhr) {

                            var title = ["Ration Card holder", "No of women", { role: "style" },];
                            var table = [];
                            table.push(title);
                            for (var l = 0; l < data.d.length; l++) {
                                var object = data.d[l];
                                table.push(object);
                            }

                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var dataRationCardholder = google.visualization.arrayToDataTable(table);

                                var optionsRationCardholder = {
                                    /*title: 'Ration Card holder Type',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    //colors: ['brown', 'orange', 'blue'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart4 = new google.visualization.PieChart(document.getElementById('rationcardtypeChart'));
                                chart4.draw(dataRationCardholder, optionsRationCardholder);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    // MemberofanyCBO 
                    $.ajax({
                        type: "POST",
                        async: "false",
                        url: "Dashboard.aspx/MemberofanyCBO",
                        data: JSON.stringify({ stateId: stateId, districtId: districtId, blockId: blockId, CSOId: CSOId, VillageId: VillageId, WFGID: WFGID }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "Json",
                        success: function (dataCBO, textStatus, xhr) {
                            debugger;
                            var CBOData = dataCBO.d.split(',');

                            var Yes = parseFloat(CBOData[0]);
                            var No = parseFloat(CBOData[1]);

                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var dataCBO = google.visualization.arrayToDataTable([
                                    ['Member CBO', 'Total Member'],
                                    ['Yes', Yes],
                                    ['No', No],
                                ]);

                                var optionsCBO = {
                                    /*title: 'Member CBO',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chartCBO = new google.visualization.PieChart(document.getElementById('MemberofanyCBOChart'));
                                chartCBO.draw(dataCBO, optionsCBO);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    var Obj = new Object();
                    Obj.stateId = stateId;
                    Obj.districtId = districtId;
                    Obj.blockId = blockId;
                    Obj.year = 'All';
                    Obj.CSOId = CSOId;
                    Obj.VillageId = VillageId;
                    Obj.WFGID = WFGID;
                    //console.log('object');
                    //console.log(Obj);

                    // Number Charts
                    Obj.ChartName = "RecordsCount";
                    debugger;
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {
                            //console.log('datagovtschemes');
                            //console.log(datagovtschemes);

                            var DistCount = 0;
                            var BlockCount = 0;
                            var CSOCount = 0;
                            var PanchayathCount = 0;
                            var VillageCount = 0;
                            var WFGCount = 0;
                            var WFCount = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {
                                    DistCount = obj.DistCount;
                                    BlockCount = obj.BlockCount;
                                    CSOCount = obj.CSOCount;
                                    PanchayathCount = obj.PanchayathCount;
                                    VillageCount = obj.VillageCount;
                                    WFGCount = obj.WFGCount;
                                    WFCount = obj.WFCount;
                                });
                            }
                            $("#lblDistricts").html(DistCount);
                            $("#lblBlocks").html(BlockCount);
                            $("#lblCSOs").html(CSOCount);
                            $("#lblPanchayath").html(PanchayathCount);
                            $("#lblVillages").html(VillageCount);
                            $("#lblWFGs").html(WFGCount);
                            $("#lblWFs").html(WFCount);

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    //EducationalQualification new
                    Obj.ChartName = "EducationCount";
                    Obj.year = "";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',

                        success: function (dataFamily, textStatus, xhr) {
                            // [{"Type":"BA","Count":283},
                            //    { "Type": "Can not read at all", "Count": 10459 }, { "Type": "Can read Name/signature", "Count": 1417 }, { "Type": "MA", "Count": 35 }, { "Type": "Other", "Count": 30 }, { "Type": "Upto 10th", "Count": 443 }, { "Type": "Upto 12th", "Count": 324 }, { "Type": "Upto 5th", "Count": 1501 }, { "Type": "Upto 8th", "Count": 1030 }]
                            //console.log("Qualification");
                            //console.log(dataFamily);
                            var Cannotreadatall = 0;

                            var CanreadName = 0;

                            var uppto5 = 0;
                            var uppto8 = 0;
                            var uppto10 = 0;
                            var uppto12 = 0;
                            var BA = 0;
                            var MA = 0;
                            var Other = 0;

                            if (dataFamily != 'Errer') {
                                $.each(JSON.parse(dataFamily), function (idx, obj) {
                                    Cannotreadatall = parseFloat(obj.Cannotreadatall);
                                    CanreadName = parseFloat(obj.CanreadNamesignature);
                                    uppto5 = parseFloat(obj.Upto5th);
                                    uppto8 = parseFloat(obj.Upto8th);
                                    uppto10 = parseFloat(obj.Upto10th);
                                    uppto12 = parseFloat(obj.Upto12th);
                                    BA = parseFloat(obj.BA);
                                    Other = parseFloat(obj.Other)
                                    MA = parseFloat(obj.MA);
                                });
                            }
                            //
                            debugger;
                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var dataFamily = google.visualization.arrayToDataTable([
                                    ['Qualification', 'No of women', { role: "style" }],
                                    ['Can not read at all', Cannotreadatall, '#003f5c'],
                                    ['Can read Name/signature', CanreadName, '#2f4b7c'],
                                    ['Upto 5th', uppto5, '#665191'],
                                    ['Upto 8th', uppto8, '#a05195'],
                                    ['Upto 10th', uppto10, '#d45087'],
                                    ['Upto 12th', uppto12, '#f95d6a'],
                                    ['BA', BA, '#ff7c43'],
                                    ['MA', MA, '#ff7c48'],
                                    ['Others', Other, '#ffa600']
                                ]);

                                var optionsFamily = new google.visualization.DataView(dataFamily);
                                optionsFamily.setColumns([0, 1,
                                    {
                                        calc: "stringify",
                                        sourceColumn: 1,
                                        type: "string",
                                        role: "annotation"
                                    },
                                    2]);

                                var Familyoptions = {
                                   /* title: 'Educational Qualification Status',*/
                                    legend: { position: "none" },
                                };

                                var chart5 = new google.visualization.ColumnChart(document.getElementById('EducationalQualificationChart'));
                                chart5.draw(dataFamily, Familyoptions);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    Obj.year = year;
                    Obj.ChartName = "MajorSourceofincomeofthefamily";

                    // MajorSourceofincomeofthefamily with year
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',

                        success: function (dataFamily, textStatus, xhr) {


                            var Agriculture = 0;
                            var Agriculturelabour = 0;
                            var AnimalHusbandary = 0;
                            var GovernmentJob = 0;
                            var PrivateJob = 0;
                            var Smallbusiness = 0;
                            var Skilledwork = 0;
                            var Others = 0;
                            if (dataFamily != 'Errer') {


                                $.each(JSON.parse(dataFamily), function (idx, obj) {



                                    Agriculture = parseFloat(obj.Agriculture);
                                    Agriculturelabour = parseFloat(obj.Agriculturelabour);
                                    AnimalHusbandary = parseFloat(obj.AnimalHusbandary);
                                    GovernmentJob = parseFloat(obj.GovernmentJob);
                                    PrivateJob = parseFloat(obj.PrivateJob);
                                    Smallbusiness = parseFloat(obj.Smallbusiness);
                                    Skilledwork = parseFloat(obj.Skilledwork);
                                    Others = parseFloat(obj.Others);
                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var dataFamily = google.visualization.arrayToDataTable([
                                    ['Major Source of income of the family', 'No of women', { role: "style" }],
                                    ['Agriculture', Agriculture, '#003f5c'],
                                    ['Agriculture- labour', Agriculturelabour, '#2f4b7c'],
                                    ['Animal Husbandary', AnimalHusbandary, '#665191'],
                                    ['Government Job', GovernmentJob, '#a05195'],
                                    ['Private Job', PrivateJob, '#d45087'],
                                    ['Small business', Smallbusiness, '#f95d6a'],
                                    ['Skilled work', Skilledwork, '#ff7c43'],

                                    ['Other', Others, '#ffa600']

                                ]);

                                var optionsFamily = new google.visualization.DataView(dataFamily);
                                optionsFamily.setColumns([0, 1,
                                    {
                                        calc: "stringify",
                                        sourceColumn: 1,
                                        type: "string",
                                        role: "annotation"
                                    },
                                    2]);

                                var Familyoptions = {
                                   /* title: "Major Source of income of the family",*/
                                    legend: { position: "none" },
                                };

                                var chart5 = new google.visualization.ColumnChart(document.getElementById('Famliyid'));
                                chart5.draw(dataFamily, Familyoptions);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    var Obj = new Object();
                    Obj.stateId = stateId;
                    Obj.districtId = districtId;
                    Obj.blockId = blockId;
                    Obj.year = 'All';
                    Obj.CSOId = CSOId;
                    Obj.VillageId = VillageId;
                    Obj.WFGID = WFGID;
                    // govtschemes year
                    Obj.ChartName = "govtschemes";
                    debugger;
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        async: "false",
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {
                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.IsBenefit == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.IsBenefit == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['WFGs Member Linked to Govt.Scheme', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],
                                ]);

                                var optionsgovtschemes = {
                                   /* title: 'WFGs Member Linked to Govt.Scheme ',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart6 = new google.visualization.PieChart(document.getElementById('govtid'));
                                chart6.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    // WomanMNREGAjobcard year
                    Obj.ChartName = "WomanMNREGAjobcard";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {
                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.isMNREGA == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.isMNREGA == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['Women has MGNREGA job card', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: ' Women has MGNREGA job card',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart7 = new google.visualization.PieChart(document.getElementById('MNREGAid'));
                                chart7.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    Obj.ChartName = "Sourceofirrigation";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {

                            var Borewell = 0;
                            var Pumpset = 0;
                            var Canal = 0;
                            var Others = 0;
                            var Tubewell = 0;
                            var ElectricMotor = 0;

                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    Borewell = obj.Borewell;
                                    Pumpset = obj.Pumpset;
                                    Canal = obj.Canal;
                                    Others = obj.Others;
                                    Tubewell = obj.Tubewell;
                                    ElectricMotor = obj.ElectricMotor;


                                });
                            }

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['Source of irrigation', 'No of women', { role: "style" }],
                                    ['Borewell', Borewell, "#dc3912"],
                                    ['Pumpset', Pumpset, "#dc3912"],
                                    ['Canal', Canal, "#b87333"],
                                    ['Others', Others, 'rgb(128, 0, 128)'],
                                    ['Tubewell', Tubewell,'#b73334'],
                                    ['ElectricMotor',ElectricMotor,"#dc3913"],

                                ]);

                                var Sourceoptions = {
                                    /*title: "Source of irrigation",*/
                                    legend: { position: "none" },
                                };
                                var optionsgovtschemes = new google.visualization.DataView(datagovtschemes);
                                optionsgovtschemes.setColumns([0, 1,
                                    {
                                        calc: "stringify",
                                        sourceColumn: 1,
                                        type: "string",
                                        role: "annotation"
                                    },
                                    2]);
                                var chart8 = new google.visualization.ColumnChart(document.getElementById('SOIid'));
                                chart8.draw(datagovtschemes, Sourceoptions);
                            }
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    Obj.ChartName = "TotalIrrigatedLand";

                    $.ajax({
                        url: "api/Filter/TotalIrrigatedLand",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (data, textStatus, xhr) {

                            console.log(data);
                            var title = ["Total Land in Hectors", "Total", { role: "style" },];
                            var table = [];
                            table.push(title);
                            var datarows = JSON.parse(data);
                            //table.push(JSON.parse(data));


                            for (var l = 0; l < datarows.length; l++) {
                                var object = datarows[l];
                                table.push(object);
                            }
                            //Drain Types bar chart
                            // //console.log(data.d);
                            console.log(table);
                            google.charts.load('current', { 'packages': ['corechart'] });
                            google.charts.setOnLoadCallback(drawChart);

                            function drawChart() {
                                var dataCount = google.visualization.arrayToDataTable(table);


                                var optionsStatus = {
                                    /*title: 'Total Irrigated Land',*/

                                    //, 'Orange', 'purple', 'blue'
                                    legend:
                                        { position: 'none' }
                                };

                                var optirrigatedland = new google.visualization.DataView(dataCount);
                                optirrigatedland.setColumns([0, 1,
                                    {
                                        calc: "stringify",
                                        sourceColumn: 1,
                                        type: "string",
                                        role: "annotation"
                                    }]);
                                var chart4 = new google.visualization.ColumnChart(document.getElementById('Irrigatedchart'));

                                chart4.draw(dataCount, optionsStatus);

                                //var Drainchart = new google.visualization.ColumnChart(document.getElementById("EducationalQualificationChart"));
                                //Drainchart.draw(AgeData, Ageoptions);
                            }
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    // new bind
                    // Disability
                    Obj.ChartName = "Disability";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.IsDisable == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.IsDisable == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['Disability', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                   /* title: 'Disability',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('divDisability'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    // DisabilityType

                    Obj.ChartName = "DisabilityType";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {

                            //

                            //console.log(data);

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                google.charts.load("current", { packages: ["corechart"] });
                                var data = new google.visualization.DataTable();
                                data.addColumn('string', 'Type');
                                data.addColumn('number', 'Count');
                                var dbl = [];
                                if (datagovtschemes != 'Errer') {
                                    $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                        Type = obj.Type;
                                        Count = obj.Count;

                                        data.addRows([[Type, Count]]);
                                    });
                                }
                                var Sourceoptions = {
                                   /* title: "Type Of Disability",*/
                                    legend: { position: "none" },
                                };
                                var optionsgovtschemes = new google.visualization.DataView(data);
                                ////  optionsgovtschemes.setColumns([0, 1,
                                //      {
                                //          calc: "stringify",
                                //          sourceColumn: 1,
                                //          type: "string",
                                //          role: "annotation"
                                //      },
                                //      2]);
                                var chart8 = new google.visualization.ColumnChart(document.getElementById('divDisabilitytype'));
                                chart8.draw(data, Sourceoptions);
                            }
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    // Family Land Ownership
                    Obj.ChartName = "FamilyLandOwnership";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.IsOwnershipinLand == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.IsOwnershipinLand == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['Family Land Ownership', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: 'Family Land Ownership',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('FamilyLandOwnership'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    // Whether woman has ownership in land (Yes/No)
                    Obj.ChartName = "womanhasownershipinland";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {

                            //console.log('womanhasownershipinland');
                            //console.log(datagovtschemes)
                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['Whether woman has ownership in land', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                   /* title: 'Whether woman has ownership in land',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('Whetherwomanhasownershipinland'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    // Whether a sharecropper (Yes/No)
                    Obj.ChartName = "sharecropper";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['Whether a sharecroppe', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: 'Whether a sharecroppe',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('divsharecropper'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    // Whether a DemoPlot (Yes/No)
                    Obj.ChartName = "DemoPlot";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['Demo plot', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: 'Demo plot',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('divDemoplot'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    //Have accessed govt. schemes after facilitation by project team
                    Obj.ChartName = "Haveaccessedgovt";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    [' schemes after facilitation by project team', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: ' schemes after facilitation by project team',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('Haveaccessedgovt'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    //ParticipatedinBaselineSurvey
                    Obj.ChartName = "ParticipatedinBaselineSurvey";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['Participated in Baseline Survey', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: 'Participated in Baseline Survey',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('ParticipatedinBaselineSurvey'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    //Participated in Climate Change Vulnerability study
                    Obj.ChartName = "ClimateStudy";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    [' Climate Change Vulnerability study', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: ' Climate Change Vulnerability study',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('divClimateChange'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    //Participated in Gender Vulnerability Study
                    Obj.ChartName = "GenderStudy";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    [' Participated in Gender Vulnerability Study', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: 'Gender Vulnerability Study',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('GenderVulnerability'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    //Participated in Gender Vulnerability Study
                    Obj.ChartName = "HasAttendedTraining";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    [' Has attended trainings', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: 'Has attended trainings',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('trainings'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    //Buisness
                    Obj.ChartName = "Buisness";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['members with access to business incubator services with support ', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                   /* title: 'members with access to business incubator services with support',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('businessincubator'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    //AccessService
                    Obj.ChartName = "AccessService";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {
                            google.charts.load("current", { packages: ["corechart"] });
                            var data = new google.visualization.DataTable();
                            data.addColumn('string', 'Type');
                            data.addColumn('number', 'Count');
                            var dbl = [];
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    Type = obj.Type;
                                    Count = obj.Count;

                                    data.addRows([[Type, Count]]);
                                });
                            }
                            //console.log(data);

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                //  var datagovtschemes = google.visualization.arrayToDataTable(data);

                                var Sourceoptions = {
                                   /* title: "Which Service",*/
                                    legend: { position: "none" },
                                };
                                var optionsgovtschemes = new google.visualization.DataView(data);
                                ////  optionsgovtschemes.setColumns([0, 1,
                                //      {
                                //          calc: "stringify",
                                //          sourceColumn: 1,
                                //          type: "string",
                                //          role: "annotation"
                                //      },
                                //      2]);
                                var chart8 = new google.visualization.ColumnChart(document.getElementById('WhichService'));
                                chart8.draw(data, Sourceoptions);
                            }


                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    // WFG members 
                    //  (on agricultural land) practising
                    // climate friendly agriculture 
                    Obj.ChartName = "ClimateFriendly";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }


                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['members with access to business incubator services with support ', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                   /* title: 'members with access to business incubator services with support',*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('divClimateFriendly'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                    //  WFG members
                    ////  cultivating 3 or more crops thanks to
                    // support of this Action, disaggregated
                    Obj.ChartName = "MoreCultivating";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (result, textStatus, xhr) {
                            //console.log('MoreCultivating')
                            //console.log(result)

                            var No = 0;
                            var Yes = 0;
                            /*var title = "WFG members cultivating 3 or more crops"*/
                            if (result != 'Errer') {
                                $.each(JSON.parse(result), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart

                            if (Yes == 0 && No == 0) {
                                title = "NO DATA";
                            }

                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['WFG members cultivating 3 or more crops thanks to support of this Action, disaggregated  ', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No]
                                ]);
                                var withData = datagovtschemes.clone();
                                var optionsgovtschemes = {
                                    annotations: {
                                        // remove annotation stem and push to middle of chart
                                        stem: {
                                            color: 'transparent',
                                            length: 120
                                        },
                                        textStyle: {
                                            color: '#9E9E9E',
                                            fontSize: 18
                                        }
                                    },
                                   /* title: title,*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };
                                // if no data add row for annotation -- No Data Copy


                                //if (datagovtschemes.getNumberOfRows() === 0) {
                                //    datagovtschemes.addRows([
                                //        ['', 0, null, 'No Data Copy']
                                //    ]);
                                //}
                                var chart8 = new google.visualization.PieChart(document.getElementById('DivWFGmemberscultivating'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);

                            }


                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    // Percentage of trained WFG    members that demonstrate an   increase in knowledge and skills 
                    Obj.ChartName = "PercTrained";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //
                            /*var title = "Percentage of trained WFG members that demonstrate an increase in knowledge and skills";*/
                            if (Yes == 0 && No == 0) {
                                title = "NO DATA";
                            }
                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    [' Percentage of trained WFG members that demonstrate an increase in knowledge and skills  ', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: title,*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('PercentageoftrainedWFG'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    // Percentage of trained WFG    members that demonstrate an   increase in knowledge and skills 
                    Obj.ChartName = "isBankAccount";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //

                            //Donut chart

                            var title = "bank account";
                            if (Yes == 0 && No == 0) {
                                title = "NO DATA";
                            }
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['Has a bank account ', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: title,*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('Hasabankaccount'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    // Knows how to obtain a loan from a formal financial institution
                    Obj.ChartName = "LoanObtain";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            google.charts.load("current", { packages: ["corechart"] });
                            var data = new google.visualization.DataTable();
                            data.addColumn('string', 'Type');
                            data.addColumn('number', 'Count');
                            var dbl = [];
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    Type = obj.Type;
                                    Count = obj.Count;

                                    data.addRows([[Type, Count]]);
                                });
                            }
                            //console.log(data);

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                //  var datagovtschemes = google.visualization.arrayToDataTable(data);

                                var Sourceoptions = {
                                   /* title: "Knows how to obtain a loan from a formal financial institution",*/
                                    legend: { position: "none" },
                                };
                                var optionsgovtschemes = new google.visualization.DataView(data);
                                ////  optionsgovtschemes.setColumns([0, 1,
                                //      {
                                //          calc: "stringify",
                                //          sourceColumn: 1,
                                //          type: "string",
                                //          role: "annotation"
                                //      },
                                //      2]);
                                var chart8 = new google.visualization.ColumnChart(document.getElementById('Knowshowtoobtainaloan'));
                                chart8.draw(data, Sourceoptions);
                            }


                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    //Feels confident in managing money
                    Obj.ChartName = "ManageMoney";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            google.charts.load("current", { packages: ["corechart"] });
                            var data = new google.visualization.DataTable();
                            data.addColumn('string', 'Type');
                            data.addColumn('number', 'Count');
                            var dbl = [];
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    Type = obj.Type;
                                    Count = obj.Count;

                                    data.addRows([[Type, Count]]);
                                });
                            }
                            //console.log(data);

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                //  var datagovtschemes = google.visualization.arrayToDataTable(data);

                                var Sourceoptions = {
                                   /* title: "Feels confident in managing money",*/
                                    legend: { position: "none" },
                                };
                                var optionsgovtschemes = new google.visualization.DataView(data);
                                ////  optionsgovtschemes.setColumns([0, 1,
                                //      {
                                //          calc: "stringify",
                                //          sourceColumn: 1,
                                //          type: "string",
                                //          role: "annotation"
                                //      },
                                //      2]);
                                var chart8 = new google.visualization.ColumnChart(document.getElementById('managingmoney'));
                                chart8.draw(data, Sourceoptions);
                            }


                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    //WFG members with business plans developed 
                    Obj.ChartName = "businessDevelop";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //
                            /*var title = "WFG members with business plans developed ";*/
                            if (Yes == 0 && No == 0) {
                                title = "NO DATA";
                            }
                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['WFG members with business plans developed ', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                   /* title: title,*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('WFGmemberswithbusinessplansdeveloped'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    //WFG                     members have access to ICT. 
                    Obj.ChartName = "ICTAccess";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //
                            /*var title = "WFG members have access to ICT";*/
                            if (Yes == 0 && No == 0) {
                                title = "NO DATA";
                            }
                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    [' WFG members have access to ICT ', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                   /* title: title,*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('WFGmembershaveaccesstoICT'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    // On farm members part of FPC.
                    Obj.ChartName = "OnFarm";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //
                            /*var title = "On farm members part of FPC";*/
                            if (Yes == 0 && No == 0) {
                                title = "NO DATA";
                            }
                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['On farm members part of FPC ', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                   /* title: title,*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('OnfarmmemberspartofFPC'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    // Off farm members part of FPC.
                    Obj.ChartName = "OffFarm";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //
                           /* var title = "Off farm members part of FPC";*/
                            if (Yes == 0 && No == 0) {
                                title = "NO DATA";
                            }
                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['Off farm members part of FPC ', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                   /* title: title,*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('OfffarmmemberspartofFPC'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    //  WFG members has become a shareholder in a FPC.
                    Obj.ChartName = "ShareHolder";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //
                            /*var title = "WFG members has become a shareholder in a FPC";*/
                            if (Yes == 0 && No == 0) {
                                title = "NO DATA";
                            }
                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['WFG members has become a shareholder in a FPC', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: title,*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('shareholderinaFPC'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    // Name of the Training attended
                    Obj.ChartName = "TrainingName";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            google.charts.load("current", { packages: ["corechart"] });
                            var data = new google.visualization.DataTable();
                            data.addColumn('string', 'Type');
                            data.addColumn('number', 'Count');
                            var dbl = [];
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    Type = obj.Type;
                                    Count = obj.Count;

                                    data.addRows([[Type, Count]]);
                                });
                            }
                            //console.log(data);

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                //  var datagovtschemes = google.visualization.arrayToDataTable(data);

                                var Sourceoptions = {
                                    /*title: "Name of the Training attended",*/
                                    legend: { position: "none" },
                                };
                                var optionsgovtschemes = new google.visualization.DataView(data);
                                ////  optionsgovtschemes.setColumns([0, 1,
                                //      {
                                //          calc: "stringify",
                                //          sourceColumn: 1,
                                //          type: "string",
                                //          role: "annotation"
                                //      },
                                //      2]);
                                var chart8 = new google.visualization.ColumnChart(document.getElementById('Trainingattended'));
                                chart8.draw(data, Sourceoptions);
                            }


                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    // Ujjwala.
                    Obj.ChartName = "UjjwalaGasConnection";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            var No = 0;
                            var Yes = 0;
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    if (obj.Type == 'Yes') {
                                        Yes = obj.Count;
                                    }
                                    if (obj.Type == 'No') {
                                        No = obj.Count;
                                    }

                                });
                            }
                            //
                            var title = "Ujjwala Yojana";
                            if (Yes == 0 && No == 0) {
                                title = "NO DATA";
                            }
                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                var datagovtschemes = google.visualization.arrayToDataTable([
                                    ['Ujjwala Yojana ', 'No of women'],
                                    ['Yes', Yes],
                                    ['No', No],


                                ]);

                                var optionsgovtschemes = {
                                    /*title: title,*/
                                    pieSliceText: 'value',
                                    position: 'top',
                                    pieHole: 0.3,
                                    colors: ['green', 'red', 'Pink'],
                                    legend:
                                        { position: 'bottom', textStyle: { color: 'blue', fontSize: 13 } }
                                };

                                var chart8 = new google.visualization.PieChart(document.getElementById('divUjjwala'));
                                chart8.draw(datagovtschemes, optionsgovtschemes);
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });

                    // GovSchemeName
                    Obj.ChartName = "GovSchemeName";
                    $.ajax({
                        url: "api/Filter/yearWiseData",
                        type: 'POST',
                        data: Obj,
                        dataType: 'json',
                        success: function (datagovtschemes, textStatus, xhr) {


                            google.charts.load("current", { packages: ["corechart"] });
                            var data = new google.visualization.DataTable();
                            data.addColumn('string', 'Type');
                            data.addColumn('number', 'Count');
                            var dbl = [];
                            if (datagovtschemes != 'Errer') {
                                $.each(JSON.parse(datagovtschemes), function (idx, obj) {

                                    Type = obj.Type;
                                    Count = obj.Count;

                                    data.addRows([[Type, Count]]);
                                });
                            }
                            //console.log(data);

                            //Donut chart
                            google.charts.load("current", { packages: ["corechart"] });
                            google.charts.setOnLoadCallback(drawChartDonut);
                            function drawChartDonut() {
                                //  var datagovtschemes = google.visualization.arrayToDataTable(data);

                                var Sourceoptions = {
                                    /*title: "Benefit/s availing if any from  govt schemes",*/
                                    legend: { position: "none" },
                                };
                                var optionsgovtschemes = new google.visualization.DataView(data);
                                ////  optionsgovtschemes.setColumns([0, 1,
                                //      {
                                //          calc: "stringify",
                                //          sourceColumn: 1,
                                //          type: "string",
                                //          role: "annotation"
                                //      },
                                //      2]);
                                var chart8 = new google.visualization.ColumnChart(document.getElementById('govtschemes'));
                                chart8.draw(data, Sourceoptions);
                            }


                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //console.log('Error in Operation');
                        }
                    });
                }
                bindChart();

                $('#<%=ddlState.ClientID%>').change(function () {
                    bindChart();
                });

                $('#<%=ddlDistrict.ClientID%>').change(function () {
                    bindChart();
                });

                $('#<%=ddlBlock.ClientID%>').change(function () {
                    bindChart();
                });

                $('#<%=ddlCSO.ClientID%>').change(function () {
                    bindChart();
                });

                $('#<%=ddlvillage.ClientID%>').change(function () {
                    bindChart();
                });

                $('#<%=ddlWFG.ClientID%>').change(function () {
                    bindChart();
                });

                $('#<%=txtyear.ClientID%>').change(function () {
                    bindChart();
                });
            });
        </script>
    </form>
</asp:Content>

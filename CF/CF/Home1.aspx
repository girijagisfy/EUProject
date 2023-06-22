<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home1.aspx.cs" Inherits="CF.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ChildFund Home</title>
    <meta name="description" content="Srikandi Responsive Admin Templates" />
    <meta name="keywords" content="GAD, gad" />


    <link href="HomePageStyles/font-awesome.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css" />
    <link href="HomePageStyles/bootstrap.min.css" rel="stylesheet" />
    <link href="HomePageStyles/bootstrap-reset.css" rel="stylesheet" />


    <link href="HomePageStyles/Home1.css" rel="stylesheet" />
    <link href="HomePageStyles/Home2.css" rel="stylesheet" />
    <link href="HomePageStyles/style.css" rel="stylesheet" />
    <link href="HomePageStyles/fadeinfadeout.css" rel="stylesheet" />
    <link href="HomePageStyles/custom_style.css" rel="stylesheet" />
    <link rel="shortcut icon" href="images/Ap.ico" />
    <style>
        .fourth_title {
            padding-left: 40px;
        }

        .gallery {
            display: inline-block;
            margin-top: 20px;
        }

        .latestnewsdiv h1 {
            margin-bottom: 15px;
            margin-top: 24px;
            font-size: 25px;
            font-weight: 600;
            color: #00524b;
        }


        #MainContent {
            /* min-height: calc(100vh - calc(1.5rem + 1px) - calc(1.5rem + 1px));*/
        }

        .carousel-control.left, .carousel-control.right {
            background-image: none;
        }

        .servicesslider .left {
            right: 27px !important;
            left: auto;
        }

        .thumbnail {
            margin-bottom: 0px;
        }

        .carousel-control .glyphicon-chevron-left, .carousel-control .glyphicon-chevron-right, .carousel-control .icon-next, .carousel-control .icon-prev {
            width: auto;
            margin-top: -7px;
            font-size: 12px;
            height: auto;
            margin-left: -6px;
            margin-right: -7px;
        }

        .carousel-control {
            background: #38455d;
            color: #fffefe;
        }

        .carousel-control {
            width: 20px;
            height: 20px;
            text-shadow: none;
            background-color: rgba(0,0,0,0);
            filter: alpha(opacity=50);
            opacity: 1;
            background: #009688;
            border-radius: 0px;
            margin-top: 8px;
            margin-right: 20px;
            text-align: center;
            border-radius: 2px;
        }

        @media only screen and (max-width: 840px) {
            #header {
                color: white !important;
                FONT-SIZE: 22PX !important;
                MARGIN-TOP: -10PX !important;
                /*MARGIN-LEFT: -15PX;*/
            }

            #headerLogo {
                margin-left: 35%;
            }

            .Short {
                display: block !important;
            }

            .Long {
                display: none !important;
            }
        }

        .Short {
            display: none;
        }

        .Long {
            display: block;
            text-align: center;
        }

        @media (min-width: 992px) {
            .col-md-2 {
                width: 12.666667%;
            }
        }

        .container {
            width: -webkit-fill-available !important;
            margin-left: 7% !important;
            margin-right: 7% !important;
        }



        #header .navbar-collapse {
            padding-left: 10% !important;
            padding-right: 10% !important;
        }

        a:hover {
            background-color: #19b973 !important;
        }
    </style>
    <style type="text/css">
        .fancybox-margin {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <div id="Forgory" runat="server"></div>
        <div id="wrapper" class="resize-md animate">
            <%--<script src="js/header.js"></script>--%>
            <header class="header" style="background-color: #007a45; border-bottom: solid #19b973 3px;">
                <!--logo start-->
                <div class="container">
                    <div class="row ">
                        <div class="col-md-3" style="padding: 10px; text-align: center;">
                            <img src="https://childfundindia.org//wp-content/uploads/2017/04/copy-logor.png" alt="Childfund India Ngo" style="height: 56px;" />
                        </div>
                        <div class="col-md-3" style="padding: 10px; text-align: center;">
                            <img src="Images/Barnfonden.jpg" style="height: 56px;" />
                        </div>
                        <div class="col-md-2" style="padding: 10px; text-align: center;">
                            <img src="Images/European_Union-logo-75776F70C0-seeklogo.com.png" style="height: 56px;" />
                        </div>
                    </div>
                </div>
            </header>

            <div id="MainContent">
                <div id="header" class="slider">
                    <div class="overlay">
                        <nav class="navbar" role="navigation">
                            <div class="container">
                                <div class="navbar-header">
                                    <button type="button" class="btn-block btn-drop navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                                        <strong>MENU</strong>
                                    </button>
                                </div>
                                <div class="collapse navbar-collapse navbar-ex1-collapse">
                                    <ul class="nav navbar-nav">
                                        <li>
                                            <a href="Login.aspx" target="_blank">
                                                <div class="text-center">
                                                    <i class="fa fa-database fa-3x" data-original-title="" title=""></i>
                                                    <br>
                                                    Master Data
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <div class="text-center">
                                                    <i class="fa fa-home fa-3x" data-original-title="" title=""></i>
                                                    <br>
                                                    FPC
                                                </div>
                                            </a>
                                        </li>

                                        <li>
                                            <a href="http://148.72.208.177/ChildFund-PM/Login.aspx" target="_blank">
                                                <div class="text-center">
                                                    <i class="fa fa-tasks fa-3x" data-original-title="" title=""></i>
                                                    <br>
                                                    Project Management System
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <div class="text-center">
                                                    <i class="fa fa-shopping-cart fa-3x" data-original-title="" title=""></i>
                                                    <br>
                                                    Market Place
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <div class="text-center">
                                                    <i class="fa fa-laptop fa-3x" data-original-title="" title=""></i>
                                                    <br>
                                                    LMS
                                                </div>
                                            </a>
                                        </li>

                                        <li>
                                            <a href="#">
                                                <div class="text-center">
                                                    <i class="fa fa-mobile fa-3x" data-original-title="" title=""></i>
                                                    <br>
                                                    Mobile Application
                                                </div>
                                            </a>
                                        </li>
                                        <li></li>
                                        <li></li>
                                        <li></li>
                                    </ul>
                                </div>
                            </div>
                        </nav>
                    </div>
                </div>
                <div class="container">
                    <div id="main">
                        <div class="container">
                            <img src="Images/Farmer.jpg" style="width: 100%" />
                        </div>
                    </div>
                </div>
            </div>
            <!-- end:main -->
            <%--<script src="js/footer.js"></script>--%>
            <div class="footer-bottom">
                <div class="container">
                    <div class="footer-bottom-widget">
                        <div class="row">
                            <p style="text-align: center">
                                <strong>Copyright &copy; 2020 <a href="https://gisfy.co.in" target="_blank">Gisfy Private Limited</a>.</strong> All rights    reserved.
                        <img src="Images/gisfyLogo.jpg" style="height: 30px;" />
                            </p>
                        </div>
                    </div>
                </div>
                <div id="back-to-top" data-spy="affix" data-offset-top="10" class="back-to-top affix-top" style="display: none;" data-original-title="" title="">
                    <button class="btn btn-top" title="" data-original-title="Back to Top"><i class="fa fa-angle-double-up" data-original-title="" title=""></i></button>
                    <div class="popover fade right in" role="tooltip" id="popover630723" style="top: 16.5px; left: 42px; display: block;">
                        <div class="arrow"></div>
                        <h3 class="popover-title">Back to Top</h3>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!-- end:wrapper -->
    <!-- start:javascript -->
    <!-- javascript default for all pages-->

    <script src="HomePageStyles/jquery-1.11.1.min.js"></script>
    <script src="HomePageStyles/bootstrap.min.js"></script>
    <!-- javascript for Srikandi admin -->
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>--%>

    <script src="HomePageStyles/themes.js"></script>
    <!-- end:javascript -->

    <script src="HomePageStyles/jquery.resizer.min.js"></script>
    <script type="text/javascript">




        //function flashtext1(ele, col) {

        //    if (tmpColCheck === 'white') {
        //        document.getElementById(ele).style.color = col;
        //    } else {
        //        document.getElementById(ele).style.color = 'white';
        //    }
        //}

        //setInterval(function () {
        //    flashtext1('flashingtext1', 'yellow');
        //}, 500); //set an interval timer up to repeat the function

        $("#wrapper").resizable();


        $(document).ready(function () {
            //FANCYBOX

            //$(".fancybox").fancybox({
            //    openEffect: "none",
            //    closeEffect: "none"
            //});
        });


    </script>


</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="CF.About" %>

<!DOCTYPE html>

<html xmlns="https://www.w3.org/1999/xhtml">


<!-- Mirrored from demo.w3layouts.com/demos_new/template_demo/14-05-2019/mulching-demo_Free/2130651615/web/about.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 03 Feb 2021 05:00:12 GMT -->
<!-- Added by HTTrack -->
<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<!-- /Added by HTTrack -->
<head>
    <title>About</title>
    <!--meta tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="Mulching Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
      Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }
    </script>
    <!--//meta tags ends here-->
    <link href="HomePageStyles/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
    <!-- font-awesome icons -->

    <link href="HomePageStyles/css/font-awesome.min.css" rel="stylesheet" />
    <!-- //font-awesome icons -->

    <link href="HomePageStyles/css/style.css" rel="stylesheet" />
    <link href="HomePageStyles/style.css" rel="stylesheet" />
    <!--//stylesheets-->
    <!-- Web-Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Poiret+One&amp;subset=cyrillic,latin-ext" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Mada:200,300,400,500,600,700,900&amp;subset=arabic" rel="stylesheet">
    <!-- //Web-Fonts -->

</head>
<body>
    <script src="../../../../../../../m.servedby-buysellads.com/monetization.js" type="text/javascript"></script>
    <script>
        (function () {
            if (typeof _bsa !== 'undefined' && _bsa) {
                // format, zoneKey, segment:value, options
                _bsa.init('flexbar', 'CKYI627U', 'placement:w3layoutscom');
            }
        })();
    </script>
    <script>
        (function () {
            if (typeof _bsa !== 'undefined' && _bsa) {
                // format, zoneKey, segment:value, options
                _bsa.init('fancybar', 'CKYDL2JN', 'placement:demo');
            }
        })();
    </script>
    <script>
        (function () {
            if (typeof _bsa !== 'undefined' && _bsa) {
                // format, zoneKey, segment:value, options
                _bsa.init('stickybox', 'CKYI653J', 'placement:w3layoutscom');
            }
        })();
    </script>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src='https://www.googletagmanager.com/gtag/js?id=UA-149859901-1'></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag() { dataLayer.push(arguments); }
        gtag('js', new Date());

        gtag('config', 'UA-149859901-1');
    </script>

    <script>
        window.ga = window.ga || function () { (ga.q = ga.q || []).push(arguments) }; ga.l = +new Date;
        ga('create', 'UA-149859901-1', 'demo.w3layouts.com');
        ga('require', 'eventTracker');
        ga('require', 'outboundLinkTracker');
        ga('require', 'urlChangeTracker');
        ga('send', 'pageview');
    </script>
    <script async src='../../../../../../js/autotrack.js'></script>

    <meta name="robots" content="noindex">
    <body>
        <link rel="stylesheet" href="../../../../../../assests/css/font-awesome.min.css">
        <!-- New toolbar-->
        <style>
            * {
                box-sizing: border-box;
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif;
            }


            #w3lDemoBar.w3l-demo-bar {
                top: 0;
                right: 0;
                bottom: 0;
                z-index: 9999;
                padding: 40px 5px;
                padding-top: 70px;
                margin-bottom: 70px;
                background: #0D1326;
                border-top-left-radius: 9px;
                border-bottom-left-radius: 9px;
            }

                #w3lDemoBar.w3l-demo-bar a {
                    display: block;
                    color: #e6ebff;
                    text-decoration: none;
                    line-height: 24px;
                    opacity: .6;
                    margin-bottom: 20px;
                    text-align: center;
                }

                #w3lDemoBar.w3l-demo-bar span.w3l-icon {
                    display: block;
                }

                #w3lDemoBar.w3l-demo-bar a:hover {
                    opacity: 1;
                }

                #w3lDemoBar.w3l-demo-bar .w3l-icon svg {
                    color: #e6ebff;
                }

                #w3lDemoBar.w3l-demo-bar .responsive-icons {
                    margin-top: 30px;
                    border-top: 1px solid #41414d;
                    padding-top: 40px;
                }

                #w3lDemoBar.w3l-demo-bar .demo-btns {
                    border-top: 1px solid #41414d;
                    padding-top: 30px;
                }

                #w3lDemoBar.w3l-demo-bar .responsive-icons a span.fa {
                    font-size: 26px;
                }

                #w3lDemoBar.w3l-demo-bar .no-margin-bottom {
                    margin-bottom: 0;
                }

            .toggle-right-sidebar span {
                background: #0D1326;
                width: 50px;
                height: 50px;
                line-height: 50px;
                text-align: center;
                color: #e6ebff;
                border-radius: 50px;
                font-size: 26px;
                cursor: pointer;
                opacity: .5;
            }

            .pull-right {
                float: right;
                position: fixed;
                right: 0px;
                top: 70px;
                width: 90px;
                z-index: 99999;
                text-align: center;
            }

            #right-sidebar {
                width: 90px;
                position: fixed;
                height: 100%;
                z-index: 1000;
                right: 0px;
                top: 0;
                margin-top: 60px;
                -webkit-transition: all .5s ease-in-out;
                -moz-transition: all .5s ease-in-out;
                -o-transition: all .5s ease-in-out;
                transition: all .5s ease-in-out;
                overflow-y: auto;
            }



            .hide-right-bar-notifications {
                margin-right: -300px !important;
                -webkit-transition: all .3s ease-in-out;
                -moz-transition: all .3s ease-in-out;
                -o-transition: all .3s ease-in-out;
                transition: all .3s ease-in-out;
            }



            @media (max-width: 992px) {
                #w3lDemoBar.w3l-demo-bar a.desktop-mode {
                    display: none;
                }
            }

            @media (max-width: 767px) {
                #w3lDemoBar.w3l-demo-bar a.tablet-mode {
                    display: none;
                }
            }

            @media (max-width: 568px) {
                #w3lDemoBar.w3l-demo-bar a.mobile-mode {
                    display: none;
                }

                #w3lDemoBar.w3l-demo-bar .responsive-icons {
                    margin-top: 0px;
                    border-top: none;
                    padding-top: 0px;
                }

                #right-sidebar, .pull-right {
                    width: 90px;
                }

                #w3lDemoBar.w3l-demo-bar .no-margin-bottom-mobile {
                    margin-bottom: 0;
                }
            }
        </style>
        <style>
            html, body {
                height: 100%;
                width: 100%;
                margin: 0;
            }

            .bg-primary {
                background-color: #007a45 !important;
            }

            .nav-link {
                padding-left: 1rem !important;
                padding-right: 1rem !important;
                font-size: 16px !important;
                text-transform: uppercase;
                font-family: inherit;
                font-weight: inherit;
            }

            @media (min-width: 992px) {
                .carousel {
                    height: 60%;
                }

                .carousel-inner {
                    height: 100% !important
                }
            }
        </style>
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top bg-primary">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <img src="https://childfundindia.org//wp-content/uploads/2017/04/copy-logor.png" alt="Childfund India Ngo" style="height: 56px;" />
                </a>
                <a class="navbar-brand" href="#">
                    <img src="Images/Barnfonden.jpg" style="height: 56px;" />
                </a>
                <a class="navbar-brand" href="#">
                    <img src="Images/European_Union-logo-75776F70C0-seeklogo.com.png" style="height: 56px;" />
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#main_nav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="main_nav">
                    <ul class="navbar-nav">
                        <li class="nav-item active"><a class="nav-link" href="Index.aspx">Home </a></li>
                        <li class="nav-item"><a class="nav-link" href="About.aspx">About Us </a></li>
                        <li class="nav-item"><a class="nav-link" href="Gallery.aspx">Gallery </a></li>
                        <li class="nav-item"><a class="nav-link" href="Innovation.aspx">Innovation </a></li>
                        <li class="nav-item"><a class="nav-link" href="Login.aspx">Login </a></li>

                    </ul>

                </div>
                <!-- navbar-collapse.// -->
            </div>
            <!-- container //  -->
        </nav>

        <div class="main-top" id="home" style="background-image: url(HomePageStyles/images/all-bg-title.jpg); min-height: 60% !important">
            <!-- header -->

        </div>


        <!--//headder-->

        <!-- 
	<!---728x90--->

        <!-- about -->
        <section class="about py-lg-4 py-md-3 py-sm-3 py-3" id="Home">
            <div class="container">
                <div class="row form-group">
                    <div class="col-lg-8 col-md-8">
                        <h1 style="text-align: justify">About</h1>
                        <div class="about-para-txt">
                            <p>sed do eiusmod tempor incididunt ut Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet, eiusmod tempor incididunt ut labore et consectetur adipiscing sed do eiusmod tempor incididunt ut Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet, eiusmod tempor incididunt ut labore et consectetur adipiscing</p>
                            <p class="mt-2">sed do eiusmod tempor incididunt ut Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet, eiusmod tempor incididunt ut labore et consectetur adipiscing sed do eiusmod</p>
                        </div>
                    </div>


                    <div class="col-lg-4 col-md-4 about-imgs-txt">
                        <img src="HomePageStyles/images/g6.jpg" alt="news image" class="img-fluid" />
                    </div>
                </div>
            </div>
        </section>


        <!-- Footer -->
        <footer class="text-center text-white" style="background-color: #0a4275;">

            <!-- Grid container -->

            <!-- Copyright -->
            <div class="text-center p-3" style="background-color: #007a45;">
                Copyright © 2021 <strong>
                    <a class="text-white" href="https://childfundindia.org/" target="_blank">ChildFund India</a></strong> All rights reserved.  Developed and Managed by <a href="https://www.gisfy.co.in/" target="_blank">
                        <img src="Images/gisfyLogo.jpg" style="height: 30px;" /></a>

            </div>
            <!-- Copyright -->
        </footer>

    </body>

    <div id="v-w3layouts"></div>
    <script>(function (v, d, o, ai) { ai = d.createElement('script'); ai.defer = true; ai.async = true; ai.src = v.location.protocol + o; d.head.appendChild(ai); })(window, document, '../../../../../../../a.vdo.ai/core/v-w3layouts/vdo.ai.js');</script>


    <!-- Mirrored from demo.w3layouts.com/demos_new/template_demo/14-05-2019/mulching-demo_Free/2130651615/web/about.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 03 Feb 2021 05:00:12 GMT -->
</html>

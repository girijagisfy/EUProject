<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="UMS.Home" %>

<!DOCTYPE html>

<html xmlns="https://www.w3.org/1999/xhtml">
<head>
    <title>ChildFund Home</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta content="text/html; charset=iso-8859-2" http-equiv="Content-Type" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    <style>
        .mySlides {
            display: none;
        }
    </style>
    <script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }
    </script>
    <!--//meta tags ends here-->
    <!--booststrap-->


    <!--//booststrap end-->
    <link href="HomePageStyles/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
    <!-- font-awesome icons -->

    <link href="HomePageStyles/css/font-awesome.min.css" rel="stylesheet" />
    <!-- //font-awesome icons -->

    <link href="HomePageStyles/css/style.css" rel="stylesheet" />
    <link href="HomePageStyles/style.css" rel="stylesheet" />
    <!--stylesheets-->
    <link href="css/style.css" rel='stylesheet' type='text/css' media="all" />
    <!--//stylesheets-->
    <!-- Web-Fonts -->


    <link href="http://fonts.googleapis.com/css?family=Poiret+One&amp;subset=cyrillic,latin-ext" rel="stylesheet">
    <link href="http://fonts.googleapis.com/css?family=Mada:200,300,400,500,600,700,900&amp;subset=arabic" rel="stylesheet">
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

            */ #right-sidebar {
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

            .card-body {
                -webkit-box-flex: 1;
                -ms-flex: 1 1 auto;
                flex: 1 1 auto;
                padding: 0.5rem;
                text-align: center;
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
        <div class="main-top1" id="home">
            <!-- header -->
            <header class="header" style="background-color: #007a45; border-bottom: solid #19b973 3px;">
                <!--logo start-->
                <div class="container">
                    <div class="row ">
                        <div class="col-md-6" style="padding: 10px; text-align: center;">
                            <img src="https://childfundindia.org//wp-content/uploads/2017/04/copy-logor.png" alt="Childfund India Ngo" style="height: 56px;" />
                            <img src="Images/Barnfonden.jpg" style="height: 56px;" />
                            <img src="Images/European_Union-logo-75776F70C0-seeklogo.com.png" style="height: 56px;" />
                        </div>
                        <div class="headder-top">
                            <nav>
                                <label for="drop" class="toggle">Menu</label>
                                <input type="checkbox" id="drop" />
                                <ul class="menu mt-2" style="padding: 0px 130px!important">
                                    <li>
                                        <a href="Home.aspx" target="_blank">
                                            <div class="text-center">                                             
                                   Home
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="About.aspx" target="_blank">
                                            <div class="text-center">
                                  About us
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="Gallery.aspx" target="_blank">
                                            <div class="text-center">
                                   Gallery
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="Innovation.aspx" target="_blank">
                                            <div class="text-center">
                        
                                  Innovation
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="Login.aspx" target="_blank">
                                            <div class="text-center">
                                    login
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                            <!-- //nav -->
                        </div>


                    </div>
                </div>
            </header>
        </div>
        <div style="max-width: 100%;">
            <img class="mySlides" src="HomePageStyles/images/b3.jpg" style="width: 100%;" />
            <img class="mySlides" src="HomePageStyles/images/banners-1.png" style="width: 100%;" />
            <img class="mySlides" src="HomePageStyles/images/banner-03.jpg" style="width: 100%;" />
        </div>
    </body>
    <section class="about py-lg-4 py-md-3 py-sm-3 py-3">
        <div class="container">
            <div class="row">
                <div class="form-group col-md-4">
                    <div class="card" style="width: 18rem;">
                        <a href="Login.aspx" target="_blank">
                            <img class="card-img-top" src="HomePageStyles/images/Masterdata.jpg" alt="Card image cap" />
                            <div class="card-body">
                                <h5 class="card-title">Master Data</h5>

                            </div>
                        </a>
                    </div>
                </div>
                <div class="form-group col-md-4">
                    <div class="card" style="width: 18rem;">
                        <a href="https://www.PMKS.co.in/FPC/login.aspx" target="_blank">
                            <img class="card-img-top" src="HomePageStyles/images/FPC1.jpg" alt="Card image cap" style="height: 190px" />
                            <div class="card-body">
                                <h5 class="card-title">Farmers Producer Company</h5>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="form-group col-md-4">
                    <div class="card" style="width: 18rem;">
                        <a href="https://www.PMKS.co.in/CFPM/Login.aspx" target="_blank">
                            <img class="card-img-top" src="HomePageStyles/images/Projectmanagement.png" alt="Card image cap" style="height: 190px" />
                            <div class="card-body">
                                <h5 class="card-title">Project Management System</h5>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section>
        <div class="container">
            <div class="row">
                <div class="form-group col-md-4">
                    <div class="card" style="width: 18rem;">
                        <a href="https://www.PMKS.co.in/MarketPlace" target="_blank">
                            <img class="card-img-top" src="HomePageStyles/images/Marketplace2.jpg" alt="Card image cap" />
                            <div class="card-body">
                                <h5 class="card-title">Market Place</h5>

                            </div>
                        </a>
                    </div>
                </div>
                <div class="form-group col-md-4">
                    <div class="card" style="width: 18rem;">
                        <a href="https://www.PMKS.co.in/moodle/admin/search.php" target="_blank">
                            <img class="card-img-top" src="HomePageStyles/images/LMS.jpg" alt="Card image cap" style="height: 178px" />
                            <div class="card-body">
                                <h5 class="card-title">Learning Management System</h5>
                            </div>
                        </a>

                    </div>

                </div>
                <div class="form-group col-md-4">
                    <div class="card" style="width: 18rem;">
                        <a href="https://www.gisfy.co.in/CF_APK/Child_Fund.apk" target="_blank">
                            <img class="card-img-top" src="HomePageStyles/images/mobile1.jpg" alt="Card image cap" />
                            <div class="card-body">
                                <h5 class="card-title">Mobile Application</h5>
                            </div>
                        </a>

                    </div>

                </div>
            </div>


        </div>


    </section>

    <section class="about py-lg-4 py-md-3 py-sm-3 py-3" id="Home">
        <div class="container">
            <h1 style="text-align: justify">Home</h1>
            <div class="row form-group">
                <div class="col-lg-8 col-md-8">
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
    <!-- footer -->
    <footer style="background-color: white!important">
        <div class="footer-bottom">
            <div class="container">
                <div class="footer-bottom-widget">
                    <div class="row">
                        <div class="col-md-2">
                        </div>
                        <div class="col-md-7">
                            <p>
                                <strong>Copyright &copy; 2021 <a href="https://childfundindia.org/" target="_blank">ChildFund India</a>.</strong> All rights
                    reserved.
                  <img src="Images/gisfyLogo.jpg" style="height: 30px;" />
                            </p>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </footer>
</body>

<div id="v-w3layouts"></div>
<script>(function (v, d, o, ai) { ai = d.createElement('script'); ai.defer = true; ai.async = true; ai.src = v.location.protocol + o; d.head.appendChild(ai); })(window, document, '../../../../../../../a.vdo.ai/core/v-w3layouts/vdo.ai.js');</script>
</html>
<script>
    var myIndex = 0;
    carousel();

    function carousel() {
        var i;
        var x = document.getElementsByClassName("mySlides");
        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
        }
        myIndex++;
        if (myIndex > x.length) { myIndex = 1 }
        x[myIndex - 1].style.display = "block";
        setTimeout(carousel, 2000); // Change image every 2 seconds
    }
</script>


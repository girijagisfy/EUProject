<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="CF.Index" %>

<!DOCTYPE html>

<html xmlns="https://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Home</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="scripts/bootstrap.js"></script>
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

    <script src="scripts/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

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
                height: 100% !important;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="https://childfundindia.org//wp-content/uploads/2017/04/copy-logor.png" alt="Childfund India Ngo" style="height: 56px;" />
            </a>
            <a class="navbar-brand" href="#">
                <img src="Images/CFLogo.png" style="height: 56px;" />
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
                    <li class="nav-item"><a class="nav-link" href="Login.aspx">Login </a></li>

                </ul>

            </div>
            <!-- navbar-collapse.// -->
        </div>
        <!-- container //  -->
    </nav>

    <div style="background-color: #f2fffe; min-height: calc(100vh - 144px);">
        <section class="about py-lg-4 py-md-3 py-sm-3 py-3">
            <div class="container">
                <div class="row">
                    <div class="form-group col-md-4">
                        <div class="card" style="width: 18rem;">
                            <a href="Login.aspx" target="_blank">
                                <img class="card-img-top" src="HomePageStyles/images/Masterdata.jpg" alt="Card image cap" style="height: 190px" />
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
                            <a href="https://www.PMKS.co.in/MarketPlace/" target="_blank">
                                <img class="card-img-top" src="HomePageStyles/images/Marketplace2.jpg" alt="Card image cap" style="height: 190px" />
                                <div class="card-body">
                                    <h5 class="card-title">Market Online Business</h5>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="form-group col-md-4">
                        <div class="card" style="width: 18rem;">
                            <a href="https://www.PMKS.co.in/moodle/admin/search.php"target="_blank">
                                <img class="card-img-top" src="HomePageStyles/images/LMS.jpg" alt="Card image cap" style="height: 190px" />
                                <div class="card-body">
                                    <h5 class="card-title">Learning Management System</h5>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="form-group col-md-4">
                        <div class="card" style="width: 18rem;">
                            <a href="https://www.PMKS.co.in/CF_APK/app-debug.apk" target="_blank" download>
                                <img class="card-img-top" src="HomePageStyles/images/mobile1.jpg" alt="Card image cap" style="height: 190px" />
                                <div class="card-body">
                                    <h5 class="card-title">Mobile Application</h5>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <footer class="text-center text-white" style="background-color: #0a4275;">
        <!-- Grid container -->
        <!-- Copyright -->
        <div class="text-center p-3" style="background-color: #007a45;">
            Copyright © 2021 <strong><a style="color: #f8b246" href="https://childfundindia.org/" target="_blank">ChildFund India</a>            </strong>All rights reserved.  Developed and Managed by <a href="http://www.gisfy.co.in/" target="_blank">
                <img src="Images/gisfyLogo.jpg" style="height: 30px;" />
            </a>
        </div>
        <!-- Copyright -->
        <%--#f8b246--%>
    </footer>
</body>
</html>

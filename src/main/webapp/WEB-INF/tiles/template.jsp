<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="path_role" content="MAIN" />
    <meta name="author" content="더삼점영 임시 웹사이트" />

    <!-- user define CSS -->
    <link rel="stylesheet" type="text/css" href="/css/froala.css" />
    <link rel="stylesheet" type="text/css" href="/css/the3.css" />
    <link rel="stylesheet" type="text/css" href="/css/modal.css" />

    <style>
        @font-face {
            font-family: 'KCC-eunyoung';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/KCC-eunyoung-Regular.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }
    </style>

    <link
            rel="stylesheet"
            href="https://unpkg.com/swiper@7/swiper-bundle.min.css"
    />

    <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>

    <title>더3.0피부과 임시 누리집</title>

</head>
<body>

<div class="container">
    <tiles:insertAttribute name="header" />

    <tiles:insertAttribute name="main" />

    <tiles:insertAttribute name="footer" />
</div>


<!-- jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<!-- user defined javascript -->
<script src="/js/modal.js"></script>
<script src="/js/video.js"></script>
<script src="/js/swiper.js"></script>


</body>

<div id="top_btn">
    <a href="#top">
        <img src="/images/logo/top_btn.png" height="50" width=50" alt="Top 버튼" />
    </a>
</div>

</html>
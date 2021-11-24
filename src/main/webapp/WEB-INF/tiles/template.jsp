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

    <link rel="stylesheet" type="text/css" href="/css/the3.css" />
    <link rel="stylesheet" type="text/css" href="/css/modal.css" />
    <link rel="stylesheet" type="text/css" href="/css/froala.css" />
    <link rel="stylesheet" type="text/css" href="/css/animate.css" />
    <link rel="stylesheet" type="text/css" href="/css/header.css" />
    <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
    <script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>

    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="/js/wow.min.js"></script>
    <script>
        new WOW().init();
    </script>

    <title>더3.0피부과 임시 누리집</title>

</head>

<body>

    <div class="container">
        <tiles:insertAttribute name="header" />

        <tiles:insertAttribute name="main" />

        <tiles:insertAttribute name="footer" />
    </div>
	
	<div id="top_btn">
		<a href="#top">
			<img src="/images/home/right_quick/top_btn.png" height="50" width=50" alt="Top 버튼" />
		</a>
	</div>

    <script src="/js/header.js"></script>
    <script src="/js/video.js"></script>
    <script src="/js/swiper.js"></script>
    <script src="/js/member.js"></script>
    <script src="/js/notice.js"></script>
    <script src="/js/date.js"></script>
    <script src="/js/time.js"></script>
    <script src="/js/event.js"></script>
    <script src="/js/inquiry.js"></script>
    <script src="/js/modal.js"></script>
    <script src="/js/diagnosis.js"></script>
    <script src="/js/adminData.js"></script>
    <script src="/js/home.js"></script>

</body>



</html>
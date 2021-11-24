<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- header -->
<div id="header">
    <!-- 헤더 이너 -->
    <div class="header_inner">

        <!-- 메인 카테고리 메뉴 -->
        <div class="util_left">
            <div id="category" class="xans-element- xans-layout xans-layout-category">
                <div class="position">
                    <ul>
                        <li><a id="skinDiagnosis" href="/diagnosis/intro">피부진단</a></li>
						<li><a id="notice" href="/notice/list?cp=1">공지사항</a></li>
                        <li><a id="event" href="/event/list?cp=1">이벤트</a></li>
                        <li><a id="inquiry" href="/inquiry/list?cp=1">1:1 문의</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 회원 -->
        <div class="util_right">
            <style>
                #chk1 { position: absolute; display: none;}
                #chk1 + #chk1Label { overflow: hidden; display: inline-block; position: relative; width: 60px;
                height: 30px; background: #749DFF; box-shadow: 1px 1px 0.5px 1px; border-radius: 30px; transition: all 0.5s; }
                #chk1 + #chk1Label:before { content: url("https://img.cafe24.com/img/common/global/ko_KR_16x12.png"); position: absolute; right: 3px; top: 3px; width: 24px;
                height: 24px; background: #fff; border-radius: 30px; line-height: 35px; text-indent: -25px; transition: all 0.5s; }
                #chk1:checked + #chk1Label:before { right: 33px;}
                #chk1:checked + #chk1Label {background: #a36c6c;}
                #chk1 + #chk1Label:after { content: url("https://img.cafe24.com/img/common/global/zh_CN_16x12.png"); position: absolute; right: -100px; top: 2px; color: #fff; line-height: 35px; transition: all 0.5s;}
                #chk1:checked + #chk1Label:after { right: 6px;}
            </style>
            <div class="loginoff "><ul>
                <div style="position: absolute; bottom: 21px; left: -70px">
                    <input type="checkbox" id="chk1"><label id="chk1Label" for="chk1"></label>
                </div>
				<c:if test="${sessionScope.MyInfo.uid eq 'admin'}">
					<li><a href="/admin/main">데이터 기록</a></li>
				</c:if>
                <c:if test="${empty sessionScope.MyInfo}">
                    <li><a href="/member/login">로그인</a></li>
                    <li><a href="/member/regAgree">회원가입</a></li>
                </c:if>
                <c:if test="${not empty sessionScope.MyInfo}">
                    <li><a href="/mypage/myInfo">마이페이지</a></li>
                    <li><a href="/member/logout">로그아웃</a></li>
                </c:if>
            </ul>
            </div>
        </div>

        <!-- 상단 로고 -->
        <div><a href="/"><img src="/images/logo/main_logo.png" style="max-height:60px;" alt="the 3.0"/></a>
        </div>


    </div>
</div>

<!-- mobile header -->
<header class="mob_header">
	<a class="nav" style="width: 15%; margin-left: -5%;">
	<img src="/images/logo/head_i_nav.png" alt="" style="width: 80%;"/>
	</a>
	<a href="/" style="width: 30%"><img src="/images/logo/main_logo.png" alt="" style="width: 80%"/></a>
	<c:if test="${empty sessionScope.MyInfo}">
		<a href="/member/login" style="width: 15%; margin-right: -5%">
		<img src="/images/logo/head_i_login.png" alt="" style="width: 80%;"/>
		</a>
	</c:if>
	<c:if test="${not empty sessionScope.MyInfo}">
		<li style="width:15%; margin-right: -5%;"><a href="/member/logout" style="font-size:13px;">로그아웃</a></li>
    </c:if>
</header>

<div class="sidebar_menu">
     <div class="close_btn" style="float:right;">
		<a>       
			<img src="/images/logo/head_i_close.png" style="width:100%;">
        </a>
     </div>
     <ul class="menu_wrap">
		<c:if test="${empty sessionScope.MyInfo}">
            <li><a href="/member/regAgree">회원가입</a></li>
        </c:if>
		<c:if test="${not empty sessionScope.MyInfo}">
            <li><a href="/mypage/myInfo">마이페이지</a></li>
        </c:if>
        <li><a href="/diagnosis/intro">피부진단</a></li>
        <li><a href="/notice/list?cp=1">공지사항</a></li>
        <li><a href="/inquiry/list?cp=1">1:1 문의</a></li>
        <li><a href="/event/list?cp=1">이벤트</a></li>
		<c:if test="${sessionScope.MyInfo.uid eq 'admin'}">
			<li><a href="/admin/main">데이터 기록</a></li>
        </c:if>
		<li><a href="/intro">ABOUT</a></li>
     </ul>
</div>

<script>
    $(document).ready(function(){
 
        $('.mob_header .nav').on('click', function(){
            $('.menu_bg').show(); 
            $('.sidebar_menu').show().animate({
                left:0
            });  
        });
        $('.close_btn>a').on('click', function(){
            $('.menu_bg').hide(); 
            $('.sidebar_menu').animate({
                left: '-' + 80 + '%'
                       },function(){
		$('.sidebar_menu').hide(); 
		}); 
				});
		 
			});
</script>


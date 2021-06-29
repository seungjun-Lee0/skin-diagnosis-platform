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
                        <li><a id="skinDiagnosis" href="/diagnosis/intro">SKIN DIAGNOSIS</a></li>
                        <li><a id="event" href="/event/list?cp=1">EVENT</a></li>
                        <li><a id="notice" href="/notice/list?cp=1">NOTICE</a></li>
                        <li><a id="inquiry" href="/inquiry/list?cp=1">1:1 문의</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 회원 -->
        <div class="util_right">
            <style>
                #chk1 { position: absolute; left: 3000%}
                #chk1 + #chk1Label { overflow: hidden; display: inline-block; position: relative; width: 60px;
                height: 30px; background: #749DFF; box-shadow: 1px 1px 0.5px 1px; border-radius: 30px; transition: all 0.5s; }
                #chk1 + #chk1Label:before { content: url("https://img.cafe24.com/img/common/global/ko_KR_16x12.png"); position: absolute; right: 3px; top: 3px; width: 24px;
                height: 24px; background: #fff; border-radius: 30px; line-height: 26px; text-indent: -26px; transition: all 0.5s; }
                #chk1:checked + #chk1Label:before { right: 33px;}
                #chk1:checked + #chk1Label {background: #a36c6c;}
                #chk1 + #chk1Label:after { content: url("https://img.cafe24.com/img/common/global/zh_CN_16x12.png"); position: absolute; right: -100px; top: 2px; color: #fff; line-height: 28px; transition: all 0.5s;}
                #chk1:checked + #chk1Label:after { right: 6px;}
            </style>
            <div class="loginoff "><ul>
                <div style="position: absolute; bottom: 21px; left: -70px">
                    <input type="checkbox" id="chk1"><label id="chk1Label" for="chk1"></label>
                </div>
                <c:if test="${empty sessionScope.MyInfo}">
                    <li><a href="/member/login">LOGIN</a></li>
                    <li><a href="/member/regAgree">JOIN US</a></li>
                </c:if>
                <c:if test="${not empty sessionScope.MyInfo}">
                    <li><a href="/mypage/myInfo">MY PAGE</a></li>
                    <li><a href="/member/logout">LOGOUT</a></li>
                </c:if>
            </ul>
            </div>
        </div>

        <!-- 상단 로고 -->
        <div><a href="/"><img src="/images/logo/main_logo.png" style="margin-top:20px;max-height:60px;" alt="the 3.0"/></a>
        </div>


    </div>
</div>
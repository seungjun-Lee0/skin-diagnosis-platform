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
                        <li><a href="/#">SKIN DIAGNOSIS</a></li>
                        <li><a href="/event/list/">EVENT</a></li>
                        <li><a href="/notice/list">NOTICE</a></li>
                        <li><a href="/cscenter/list">CS CENTER</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 회원 -->
        <div class="util_right">
            <div class="xans-element- xans-layout xans-layout-statelogoff loginoff "><ul>
                <li><a href="/member/login">LOGIN</a></li>
                <li><a href="/member/joinAgree">JOIN US</a></li>
            </ul>
            </div>
        </div>

        <!-- 상단 로고 -->
        <div class="xans-element- xans-layout xans-layout-logotop top_logo "><a href="/home"><img src="/images/logo/logo.png" style="margin-top:20px;max-height:60px;" alt="the 3.0"/></a>
        </div>


    </div>
</div>
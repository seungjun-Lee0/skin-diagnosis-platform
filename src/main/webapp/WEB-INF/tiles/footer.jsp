<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- footer -->
<hr class="layout"/><div id="footer_top" class="xans-element- xans-layout xans-layout-footer "><div class="footer_inner">
    <div class="foot_content">
        <ul>
            <li style="width:26%;padding-right:0;">
                <h2>CS CENTER</h2>
                <h1>02-511-0079</h1>
                <p>월,화,수,금 : 오전10시 ~ 오후 8시</p>
                <p>토요일 : 오전10시 ~ 오후 4시</p>
                <p>목, 일요일 및 공휴일 휴진</p>
            </li>
            <li style="width:34%;padding-right:0;">
                <h2 style="margin-bottom:7px;">NOTICE</h2>
                <div>
                    <c:forEach var="n" items="${sessionScope.Notice}" begin="0" end="4">
                    <ul>
                        <li>
                            <a href="/notice/detail?bno=${n.bno}">${n.title}</a> <!--2019/01/31-->
                        </li>
                    </ul>
                        <br>
                    </c:forEach>
                </div>
            </li>
        </ul>
    </div>
</div>
</div>

<div id="footer_bottom" class="xans-element- xans-layout xans-layout-footer "><div class="footer_inner" style="border-top:1px dashed #ddd;padding-top:20px;">
    <div class="foot_menu">
        <ul>
            <li><a href="/tos">이용약관</a></li>
            <li><a href="/privacy"><strong>개인정보처리방침</strong></a></li>
        </ul>
        <div class="f_right">
        <ul>
            <li><a href="https://cafe.naver.com/memoryforum2" target="_blank"><img src="/images/sns/naver_cafe.png" height="20px" alt="cafe"/></a></li>
            <li><a href="https://blog.naver.com/kota30" target="_blank"><img src="/images/sns/naver_blog.png" height="20px" alt="blog"/></a></li>
            <li><a href="https://www.instagram.com/the3.0clinic/" target="_blank"><img src="/images/sns/instagram.png" height="20px" alt="instagram"/></a></li>
            <li><a href="https://www.facebook.com/the3.0clinic/" target="_blank"><img src="/images/sns/facebook.png" height="20px" alt="facebook"/></a></li>
        </ul>
        </div>
    </div>
    <div class="foot_info">
        <span>상호 : (주)더삼점영</span>
        <span>대표 : 황은주</span>
        <span>사업자등록번호 : 211-08-12612</span>
        <span>주소 : 서울특별시 강남구 압구정로 28길 48. 참빌딩 4층</span>
        <br/>
        <span>전화 : 02-511-0079</span>
        <span>이메일 : <a href="mailto:hunny8553@gmail.com">hunny8553@gmail.com</a></span>
        <span>개인정보보호책임자 : <a href="mailto:hunny8553@gmail.com">황은주</a></span>
    </div>
</div>

</div>

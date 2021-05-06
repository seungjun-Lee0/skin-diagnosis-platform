<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String strReferer = request.getHeader("referer");

    if(strReferer == null || session.getAttribute("MyInfo") == null){
%>
<script language="javascript">
    alert("정상적인 경로를 통해 다시 접근해 주세요.");
    document.location.href="/";
</script>
<%
        return;
    }
%>

<div id="contents">

    <div class="titleArea">
        <h2>마이페이지</h2>
    </div>


    <div>
        <h2  style="text-align: center">
            <span></span>
            님 환영합니다.
        </h2>
    </div>

    <div class = "mypage">
        <div class="pageMain">
            <a href="/mypage/myInfo" class="pageMain_box">
                <h3>회원 정보</h3>
                <p>회원이신 고객님의 개인정보를 관리하는 공간입니다.</p>
            </a>
        </div>
        <div class="pageMain">
            <a href="/mypage/myDiagnosis" class="pageMain_box mypageBtnActive">
                <h3>진단결과 조회</h3>
                <p>피부진단 결과를 조회하실 수 있습니다.</p>
            </a>
        </div>
        <div class="pageMain">
            <a href="/mypage/myInquiry" class="pageMain_box">
                <h3>문의내역 조회</h3>
                <p>문의하신 내역과 답변을 확인하실 수 있습니다.</p>
            </a>
        </div>
    </div>

    <div class="mypageMainView">

    </div>

</div>
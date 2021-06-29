<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String strReferer = request.getHeader("referer");

    if(strReferer == null){
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
        <h2><a href="/inquiry/list?cp=1">1:1 문의</a></h2>
        <p>더삼점영 피부과 1:1 문의 페이지입니다.</p>
    </div>

    <div class="secretInquiry">
    <form id="inquirysecurefrm" name="inquirysecurefrm">
        <h3>비밀글보기</h3>
        <fieldset>
            <legend>비밀글보기</legend>
            <p class="info">이 글은 비밀글입니다.<br>
                <span class="txtEm">비밀번호를 입력하여 주세요.</span>
            </p>
            <p class="password">
                <input id="pwd" name="pwd" type="password">
            </p>
            <div style="padding:20px 0 !important;">
                <div class="btnArea M b_center">
                    <a id="ipwdcheckbtn" class="black">확인</a>
                </div>
                <div class="btnArea M b_center">
                    <a href="/inquiry/list?cp=1" class="white">목록</a>
                </div>
            </div>
        </fieldset>
    </form>
    </div>
</div>
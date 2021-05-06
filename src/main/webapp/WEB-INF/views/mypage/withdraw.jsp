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

<div id="contents" style="height: 450px">
    <form class="loginForm" role="form" name="withdrawfrm" id="withdrawfrm">
        <h2>WITHDRAW</h2>
        <div class="idForm">
            <input type="text" id="uid" name="uid" class="id" placeholder="ID">
        </div>
        <div class="passForm">
            <input type="password" id="upwd" name="upwd" class="pw" placeholder="PW">
        </div>
        <button type="button" id="cancelbtn" name="cancelbtn" class="btn">돌아가기</button>
        <button type="button" id="withdrawbtn" name="withdrawbtn" class="btn">
            탈퇴하기
        </button>
        <span><br/>회원탈퇴를 위해 아이디와 비밀번호를<br/>한번 더 입력해주세요</span>
    </form>
    <input type="hidden" id="curruid" name="curruid" value="${sessionScope.MyInfo.uid}">
</div>
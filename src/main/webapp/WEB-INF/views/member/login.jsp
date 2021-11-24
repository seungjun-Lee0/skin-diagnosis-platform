<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="contents">
<form class="loginForm" role="form" name="loginfrm" id="loginfrm">
    <h2>LOGIN</h2>
    <div class="idForm">
        <input type="text" id="uid" name="uid" class="id" placeholder="ID" onkeyup="if(window.event.keyCode==13){ login() }" >
    </div>
    <div class="passForm">
        <input type="password" id="upwd" name="upwd" class="pw" placeholder="PW" onkeyup="if(window.event.keyCode==13){ login() }" >
    </div>
    <button type="button" id="loginbtn" name="loginbtn" class="btn">
        로그인
    </button>
    <div class="bottomText">
        <a href="/member/findid">아이디/비밀번호 찾기</a>
    </div>
</form>
</div>

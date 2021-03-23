<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="contents" style="height: 450px">
<form action="index.html" method="post" class="loginForm">
    <h2>Login</h2>
    <div class="idForm">
        <input type="text" class="id" placeholder="ID">
    </div>
    <div class="passForm">
        <input type="password" class="pw" placeholder="PW">
    </div>
    <button type="button" id="loginbtn" name="loginbtn" class="btn" onclick="button()">
        LOG IN
    </button>
    <div class="bottomText">
        <a href="#">아이디/비밀번호 찾기</a>
    </div>
</form>
</div>

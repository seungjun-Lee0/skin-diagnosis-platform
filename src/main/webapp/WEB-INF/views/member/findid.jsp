<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="contents" style="height: 450px">

    <form class="loginForm" role="form" name="fidfrm" id="fidform">

        <div class="findpage">
            <div class="findnav">
                <a href="/member/findid" class="find_box findBtnActive">
                    <h3>아이디 찾기</h3>
                </a>
            </div>
            <div class="findnav">
                <a href="/member/findpwd" class="find_box">
                    <h3>비밀번호 찾기</h3>
                </a>
            </div>
        </div>

        <h2>아이디 찾기</h2>
        <div class="idForm">
            <input type="text" id="uname" name="uname" class="id" placeholder="이름을 입력해주세요">
        </div>
        <div class="passForm">
            <input type="text" id="uemail" name="uemail" class="id" placeholder="이메일을 입력해주세요">
        </div>
        <button type="button" id="fidbtn" name="fidbtn" class="btn">
            확인
        </button>
    </form>
</div>

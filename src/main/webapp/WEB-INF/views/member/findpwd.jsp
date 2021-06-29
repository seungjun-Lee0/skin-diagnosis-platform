<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="contents" style="height: 450px">

    <form class="loginForm" role="form" name="fpwdfrm" id="fpwdfrm">

        <div class="findpage">
            <div class="findnav">
                <a href="/member/findid" class="find_box ">
                    <h3>아이디 찾기</h3>
                </a>
            </div>
            <div class="findnav">
                <a href="/member/findpwd" class="find_box findBtnActive">
                    <h3>비밀번호 찾기</h3>
                </a>
            </div>
        </div>

        <h2>비밀번호 찾기</h2>
        <div class="idForm">
            <input type="text" id="uid" name="uid" class="id" placeholder="아이디를 입력해주세요" onkeyup="if(window.event.keyCode==13){ findpwd() }" >
        </div>
        <div class="passForm">
            <input type="text" id="uemail" name="uemail" class="id" placeholder="이메일을 입력해주세요" onkeyup="if(window.event.keyCode==13){ findpwd() }" >
        </div>
        <button type="button" id="fpwdbtn" name="fpwdbtn" class="btn">
            확인
        </button>
    </form>
</div>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
            ${sessionScope.MyInfo.uname}님 환영합니다.
        </h2>
    </div>

    <div class="mypage">
        <div class="pageMain">
            <a href="/mypage/myInfo" class="pageMain_box mypageBtnActive">
                <h3>회원 정보</h3>
                <p>회원이신 고객님의 개인정보를 관리하는 공간입니다.</p>
            </a>
        </div>
        <div class="pageMain">
            <a href="/mypage/myDiagnosis" class="pageMain_box">
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
        <h2 style="text-align: center; padding-top: 30px">회원정보 수정</h2>
        <form name="modifyform" id="modifyform" method="post" role="form" ENCTYPE="multipart/form-data">
            <div class="signIn_page_wrap">
                <div class="text_right" style="margin-right: 5%">
                    <span class="red_01">*</span> 필수 입력 항목
                </div>
                <table class="signIn-table-form joinType">
                    <colgroup>
                        <col style="width: 120px;">
                        <col>
                    </colgroup>
                    <tbody>

                    <tr>
                        <th>* 아이디</th>
                        <td>
                            <div>
                                <input type="hidden" name="uid" id="uid" value="${sessionScope.MyInfo.uid}">
                                <input type="text" name="uid_" id="uid_" title="아이디"  maxlength="20" txtlimit="5" class="input_440" value="${sessionScope.MyInfo.uid}" disabled>
                                <br/>
                                <span id="uidmsg">영문, 숫자로만 구성된 5~20자를 입력해주세요</span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            * 비밀번호
                        </th>
                        <td>
                            <input type="password" class="input_440" name="upwd" id="upwd" title="비밀번호" txtlimit="8" maxlength="20" placeholder="비밀번호를 입력하세요">
                            <br/>
                            <span id="upwdmsg">영문, 숫자, 특수문자(!@#$%^*) 조합 8~20자를 입력해주세요</span>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            * 비밀번호 확인
                        </th>
                        <td>
                            <input type="password" name="upwdcheck" id="upwdcheck" title="비밀번호 확인" txtlimit="8" maxlength="12" class="input_440" placeholder="비밀번호를 한번 더 입력하세요">
                            <br/><span id="upwdcheckmsg"></span>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            * 이름
                        </th>
                        <td>
                            <input type="text"  name="uname" id="uname" title="성명" maxlength="12" class="input_440" value="${sessionScope.MyInfo.uname}" disabled>
                            <br/><span id="unamemsg"></span>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            * 이메일
                        </th>
                        <td>
                            <div class="mail_box">
                            <span>
                                <c:set var="emailid" value="${fn:split(sessionScope.MyInfo.uemail,'@')[0]}" />
                                <c:set var="emailadr" value="${fn:split(sessionScope.MyInfo.uemail,'@')[1]}" />
                                <input type="text"  name="uemail1" id="uemail1" title="이메일" class="input_for" value="${emailid}" placeholder="이메일 아이디" required>
                            </span>
                                <span>@</span>
                                <span><input type="text" name="uemail2" id="uemail2" title="이메일" class="input_for" value="${emailadr}" placeholder="주소 선택" readonly></span>
                                <span>
                                <select name="uemail3" id="uemail3" style="width: 100px;">
                                    <option value="" selected>이메일선택</option>
                                    <option>nate.com</option>
                                    <option>gmail.com</option>
                                    <option>naver.com</option>
                                    <option>hotmail.com</option>
                                    <option>yahoo.co.kr</option>
                                    <option value="직접입력">직접입력</option>
                                </select>
                            </span>
                                <br/><span id="uemailmsg"></span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            * 휴대전화번호
                        </th>
                        <td>
                            <c:set var="tel1" value="${fn:split(sessionScope.MyInfo.utel,'-')[0]}" />
                            <c:set var="tel2" value="${fn:split(sessionScope.MyInfo.utel,'-')[1]}" />
                            <c:set var="tel3" value="${fn:split(sessionScope.MyInfo.utel,'-')[2]}" />
                            <ul class="num">
                                <li>
                                    <input name="utel1" id="utel1" title="휴대전화번호" maxlength="4" type="text" size="4" value="${tel1}" />
                                </li>
                                <li>-
                                    <input name="utel2" id="utel2" title="휴대전화번호" maxlength="4" type="text" size="4" value="${tel2}" placeholder="앞자리" /></li>
                                <li>-
                                    <input name="utel3" id="utel3" title="휴대전화번호" maxlength="4" type="text" size="4" value="${tel3}" placeholder="뒷자리" /></li>
                            </ul>
                            <span id="utelmsg"></span>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            수신동의
                        </th>
                        <td>
                            <div>
                                <input type="checkbox" id="smsagreed" name="smsagreed" value="1"
                                <c:if test="${sessionScope.MyInfo.sms eq 'true'}"> checked </c:if>>
                                <label for="smsagreed" class="mr_20">문자 동의</label>
                                <input type="checkbox" id="mailagreed" name="mailagreed" value="1"
                                <c:if test="${sessionScope.MyInfo.mail eq 'true'}"> checked </c:if>>
                                <label for="mailagreed">메일 동의</label>
                            </div>
                            <p>
                                ※ 할인, 이벤트 소식에 관련된 동의 입니다.<br>
                                (서비스 주요 정책 관련 내용은 수신동의 여부와 관계없이 발송됩니다)
                            </p>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="join_btn">
                    <a href="#" id="modify_submit" class="btn-type-01">정보수정</a>
                    <a href="#" id="quit_btn" class="btn-type-02">회원탈퇴</a>
                </div>

                <input type="hidden" id="sms" name="sms">
                <input type="hidden" id="mail" name="mail">
                <input type="hidden" id="uemail" name="uemail">
                <input type="hidden" id="utel" name="utel">
            </div>
        </form>
    </div>
</div>
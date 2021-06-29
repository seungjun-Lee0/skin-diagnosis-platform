<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="fname" value="${fn:split(its.fnames,'/')}" />


<div id="contents">

    <div class="titleArea">
        <h2><a href="/inquiry/list?cp=1">1:1 문의</a></h2>
        <p>더삼점영 피부과 1:1 문의 페이지입니다.</p>
    </div>

    <form id="imodifyfrm" name="imodifyfrm" >
        <div class="the3-base-table writeType">
            <table border="0" summary="">
                <input type="text" hidden disabled>
                <input type="hidden" id="uid" name="uid" value="${sessionScope.MyInfo.uid}">
                <caption>1:1 문의 글수정하기</caption>
                <colgroup>
                    <col style="width:130px;"/>
                    <col style="width:auto;"/>
                </colgroup>
                <tbody>
                <input type="checkbox" id="fixedagreed" value="1" <c:if test="${its.fixed eq 'true'}">checked</c:if>>
                <label for="fixedagreed">공지글 고정</label>|
                <input type="checkbox" id="secretagreed" value="1" <c:if test="${its.secret eq 'true'}">checked</c:if>>
                <label for="secretagreed">비밀글</label>
                <tr style="border-bottom: 1px solid #ddd;">
                    <td colspan="2" style="border-bottom:0;color:#000;">
                        제&nbsp;&nbsp;목&nbsp;:&nbsp;<input name="title" id="title" title="글제목" value="${its.title}" maxlength="30" type="text" placeholder="제목을 입력하세요." style="width: 90%; margin-left: 20px;"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="fr-view fr-view-article">
                            내&nbsp;&nbsp;용&nbsp;:&nbsp;<textarea name="content" id="content" style="width: 89.6%; height: 250px; margin-left: 20px;">${its.content}</textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <span>
                            <input type="checkbox" id="idie1">
                            <label for="idie1"></label>
                        </span>
                        첨부&nbsp;파일&nbsp;:&nbsp;<input type="file" name="img" id="img1" onchange="ifileTypeCheck1(this)" accept="image/*" style="display: none" disabled>
                        <label for="img1" id="label1" style="width: 300px;">${fname[0]}</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <span>
                            <input type="checkbox" id="idie2">
                            <label for="idie2"></label>
                        </span>
                        첨부&nbsp;파일&nbsp;:&nbsp;<input type="file" name="img" id="img2" onchange="ifileTypeCheck2(this)" accept="image/*" style="display: none" disabled>
                        <label for="img2" id="label2" style="width: 300px;">${fname[1]}</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <span>
                            <input type="checkbox" id="idie3">
                            <label for="idie3"></label>
                        </span>
                        첨부&nbsp;파일&nbsp;:&nbsp;<input type="file" name="img" id="img3" onchange="ifileTypeCheck3(this)" accept="image/*" style="display: none" disabled>
                        <label for="img3" id="label3" style="width: 300px;">${fname[2]}</label>
                    </td>
                </tr>

                    <tr>
                        <td colspan="2" id="pwdelement" <c:if test="${its.secret eq 'false'}">hidden</c:if>>
                            <input type="checkbox" id="pwdmodify" value="1">
                            <label for="pwdmodify">비밀번호 수정:&nbsp;<input type="password" name="pwd" id="pwd" value="${its.pwd}" style="width: 244px; height: 36px" readonly></label>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
        <div class="button_pos">
            <div class="btnArea M b_left">
                <a href="/inquiry/list?cp=1" class="black_s">수정취소</a>
            </div>

            <div class="btnArea M b_right">
                <a id="imodifybtn" class="white_s">수정완료</a>
            </div>
        </div>

        <input type="hidden" id="fixed" name="fixed">
        <input type="hidden" id="secret" name="secret">
        <input type="hidden" name="uuid" id="uuid" value="${its.uuid}">
        <input type="hidden" name="bno" id="bno" value="${its.bno}">

        <%-- 첨부파일 수정여부를 저장하기 위한 변수 --%>
        <input type="hidden" name="todie" id="todie">

        <%-- 파일확장자가 이미지 인지 확인하기 위한 변수--%>
        <input type="hidden" id="ftype1" name="ftype1">
        <input type="hidden" id="ftype2" name="ftype2">
        <input type="hidden" id="ftype3" name="ftype3">
    </form>
</div>
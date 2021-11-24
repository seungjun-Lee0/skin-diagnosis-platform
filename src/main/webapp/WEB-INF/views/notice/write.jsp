<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!--
<!%
    String strReferer = request.getHeader("referer");

    if(strReferer == null){
%>
<script language="javascript">
    alert("정상적인 경로를 통해 다시 접근해 주세요.");
    document.location.href="/";
</script>
<!%
        return;
    }
%>
-->

<div id="contents">

    <div class="titleArea">
        <h2><a href="/notice/list?cp=1">NOTICE</a></h2>
        <p>Dr.Wellmadeone의 공지사항입니다.</p>
    </div>

    <form id="noticefrm" name="noticefrm">
        <div class="the3-base-table writeType">
            <table border="0" summary="">
                <input type="text" hidden disabled>
                <input type="hidden" id="uid" name="uid" value="${sessionScope.MyInfo.uid}">
                <caption>공지사항 글쓰기</caption>
                <tbody>
                <input type="checkbox" id="fixedagreed" value="1" <c:if test="${nts.fixed eq 'true'}">checked</c:if>> <label for="fixedagreed">공지글 고정</label>
                <tr style="border-bottom: 1px solid #ddd;">
                    <td colspan="2" style="border-bottom:0;color:#000;">
                        제&nbsp;&nbsp;목&nbsp;:&nbsp;<input name="title" id="title" title="글제목" maxlength="30" type="text" placeholder="제목을 입력하세요." style="width: 90%; margin-left: 20px;"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="fr-view fr-view-article">
                            내&nbsp;&nbsp;용&nbsp;:&nbsp;<textarea name="content" id="content" style="width: 89.6%; height: 250px; margin-left: 20px;"></textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        첨부&nbsp;파일&nbsp;:&nbsp;<input type="file" name="img" id="img1" onchange="nfileTypeCheck1(this)" accept="image/*">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        첨부&nbsp;파일&nbsp;:&nbsp;<input type="file" name="img" id="img2" onchange="nfileTypeCheck2(this)" accept="image/*">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        첨부&nbsp;파일&nbsp;:&nbsp;<input type="file" name="img" id="img3" onchange="nfileTypeCheck3(this)" accept="image/*">
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="button_pos">
            <div class="btnArea M b_left">
                <a id="ncancelbtn" href="/notice/list?cp=1" class="black_s">작성취소</a>
            </div>

            <div class="btnArea M b_right">
                <a id="nwritebtn" class="white_s">작성완료</a>
            </div>
        </div>
        <input type="hidden" id="fixed" name="fixed">
        <input type="hidden" id="ftype1" name="ftype1">
        <input type="hidden" id="ftype2" name="ftype2">
        <input type="hidden" id="ftype3" name="ftype3">
    </form>
</div>
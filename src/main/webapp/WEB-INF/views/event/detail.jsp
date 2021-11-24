<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>


<c:set var="baseURL" value="${pageContext.request.contextPath}/images/downloadedImages/event/" />
<c:set var="fnames" value="${fn:split(ets.fnames,'/')}"/>

<c:if test="${ets.title eq null}">
    <script language="javascript">
        alert("정상적인 경로를 통해 다시 접근해 주세요.");
        document.location.href="/event/list?cp=1";
    </script>
</c:if>

<div id="contents">

    <div class="titleArea">
        <h2><a href="/event/list?cp=1">EVENT</a></h2>
        <p>저희 피부과가 준비한 다양하고 풍성한 이벤트를 확인하세요.</p>
    </div>

     <div class="the3-base-table writeType">
        <table border="0" summary="">
            <caption>게시판 상세</caption>
            <colgroup>
                <col style="width:130px;"/>
                <col style="width:auto;"/>
            </colgroup>
            <tbody>
            <tr>
                <td colspan="2" style="border-bottom:0;font-size:14px;font-weight:500;color:#000;">${ets.title}</td>
            </tr>
            <tr>
                <td colspan="2" style="padding:0 0 15px">
                    <ul class="noticeInfo">
                        <li>
                            <strong>작성자 :</strong>  ${ets.uid}
                        </li>
                        <li class="">
                            <strong>작성일 :</strong> <span class="txtNum">${fn:substring(ets.regdate, 0, 10)}</span>
                        </li>
                        <li class="">
                            <strong>조회수 :</strong> <span class="txtNum">${ets.views}</span>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                        <div class="fr-view fr-view-article">
                            <p><br></p>
                            <p style="text-align: center">
                                ${fn:replace(ets.content, replaceChar, "<br/>")}
                                <c:set var="pos" value="${fn:indexOf(fnames[1],'.')}" />
                                <c:set var="fname" value="${fn:substring(fnames[1], 0, pos)}" />
                                <c:set var="fext" value="${fn:substring(fnames[1], pos+1, fn:length(fnames[1]))}" />
                                <c:if test="${fname ne '-'}">
                                    <img src="${baseURL}${fname}_main_${ets.uuid}.${fext}">
                                </c:if>
                            </p>
                            <p><br></p>
                        </div>
                </td>
            </tr>
            <tr>
                <th scope="row">첨부파일</th>
                <td>${fnames[0]}</td>
            </tr>
            <tr>
                <th scope="row">첨부파일</th>
                <td>${fnames[1]}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="button_pos">
        <div class="btnArea M b_left">
            <a href="/event/list?cp=1" class="black_s">목록보기</a>
        </div>

        <c:if test="${sessionScope.MyInfo.uid eq 'admin'}">
            <div class="btnArea M b_right">
                <a href="/event/modify?bno=${ets.bno}" class="gray_s">수정하기</a>
            </div>

            <div class="btnArea M b_right">
                <a id="edeletebtn" class="white_s">삭제하기</a>
            </div>
        </c:if>
    </div>

    <div class="the3-board-movement">
        <ul>
            <c:if test="${prev.title ne null}">
                <li class="prev">
                    <strong>이전글</strong><a href="/event/detail?bno=${prev.bno}">${prev.title}</a>
                </li>
            </c:if>
            <c:if test="${next.title ne null}">
                <li class="next ">
                    <strong>다음글</strong><a href="/event/detail?bno=${next.bno}">${next.title}</a>
                </li>
            </c:if>
        </ul>
    </div>

    <form id="eventdeletefrm" name="eventdeletefrm">
        <input type="hidden" id="bno" value="${ets.bno}">
    </form>

</div>
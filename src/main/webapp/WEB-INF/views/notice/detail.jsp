<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<%-- <c:set var="baseURL" value="${pageContext.request.contextPath}/images/downloadedImages/notice/" /> --%>
<c:set var="baseURL" value="/home/ec2-user/downloadedImages/notice/" />
<c:set var="fnames" value="${fn:split(nts.fnames,'/')}"/>

<c:if test="${nts.title eq null}">
<script language="javascript">
    alert("정상적인 경로를 통해 다시 접근해 주세요.");
    document.location.href="/notice/list?cp=1";
</script>
</c:if>

<div id="contents">

        <div class="titleArea">
            <h2><a href="/notice/list?cp=1">NOTICE</a></h2>
            <p>더삼점영 피부과 공지사항 페이지입니다.</p>
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
                        <td colspan="2" style="border-bottom:0;font-size:14px;font-weight:500;color:#000;">${nts.title}</td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding:0 0 15px">
                            <ul class="noticeInfo">
                                <li>
                                    <strong>작성자 :</strong> ${nts.uid}
                                </li>
                                <li class="">
                                    <strong>작성일 :</strong> <span class="txtNum">${fn:substring(nts.regdate, 0, 10)}</span>
                                </li>
                                <li class="">
                                    <strong>조회수 :</strong> <span class="txtNum">${nts.views}</span>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="fr-view fr-view-article">
                                ${fn:replace(nts.content, replaceChar, "<br/>")}

                                <c:forEach var="f" items="${fnames}">
                                    <c:set var="pos" value="${fn:indexOf(f,'.')}" />
                                    <c:set var="fname" value="${fn:substring(f, 0, pos)}" />
                                    <c:set var="fext" value="${fn:substring(f, pos+1, fn:length(f))}" />
                                    <c:if test="${fname ne '-'}">
                                        <img src="${baseURL}${fname}${nts.uuid}.${fext}">
                                    </c:if>
                                </c:forEach>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="button_pos">
                <div class="btnArea M b_left">
                    <a href="/notice/list?cp=1" class="black_s">목록보기</a>
                </div>


                <c:if test="${sessionScope.MyInfo.uid eq 'admin'}">
                    <div class="btnArea M b_right">
                        <a href="/notice/modify?bno=${nts.bno}" class="gray_s">수정하기</a>
                    </div>

                    <div class="btnArea M b_right">
                        <a id="ndeletebtn" class="white_s">삭제하기</a>

                        <form id="ndeletefrm" name="ndeletefrm">
                            <input type="hidden" id="bno" name="bno" value="${nts.bno}">
                        </form>
                    </div>
                </c:if>
            </div>

    <div class="the3-board-movement">
        <ul>
            <c:if test="${prev.title ne null}">
                <li class="prev">
                    <strong>이전글</strong><a href="/notice/detail?bno=${prev.bno}">${prev.title}</a>
                </li>
            </c:if>
            <c:if test="${next.title ne null}">
                <li class="next">
                    <strong>다음글</strong><a href="/notice/detail?bno=${next.bno}">${next.title}</a>
                </li>
            </c:if>
        </ul>
    </div>


</div>


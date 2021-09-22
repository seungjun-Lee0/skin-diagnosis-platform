<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:parseNumber var="cp" value="${param.cp}" />
<fmt:parseNumber var="sp" value="${(cp - 1) / 5}" integerOnly="true" />
<fmt:parseNumber var="sp" value="${sp * 5 + 1}" />
<fmt:parseNumber var="ep" value="${sp + 4}" />

<%-- 총 게시물수를 페이지 당 게시물 수로 나눔 : 총 페이지수 --%>
<fmt:parseNumber var="tp" value="${ecnt / 4}" integerOnly="true" />
<c:if test="${ecnt % 4 gt 0}">
    <fmt:parseNumber var="tp" value="${tp + 1}" />
</c:if>

<%-- 글번호 --%>
<fmt:parseNumber var="snum" value="${ecnt - (cp-1) * 4}" />

<%-- 페이지링크 : 검색기능 x --%>
<c:set var="pglink" value="/event/list?cp=" />

<%-- 페이지링크 : 검색기능 o --%>
<c:if test="${not empty param.findkey}">
    <c:set var="pglink" value="/event/find?findtype=${param.findtype}&findkey=${param.findkey}&cp=" />
</c:if>

<c:set var="baseURL" value="${pageContext.request.contextPath}/images/downloadedImages/event/" />
<%--<c:set var="baseURL" value="/home/ec2-user/downloadedImages/event/" /> --%>

<div id="contents">

    <div class="titleArea">
        <h2><a href="/event/list?cp=1">EVENT</a></h2>
        <p>저희 피부과가 준비한 다양하고 풍성한 이벤트를 확인하세요.</p>
    </div>
    <div class="title-right">
        <div class="search-bar">
            <form name="esearch" method="get" role="form">
                <input type="text" hidden/>
                <select name="findtype" id="findtype">
                    <option value="title">제목</option>
                </select>
                <input type="text" name="findkey" value="" required id="findkey" maxlength="20" placeholder="검색어를 입력해 주세요"
                       onkeyup="if(window.event.keyCode==13){ esearchbar() }"/>
                <button type="button" class="submit" id="efindbtn">
                    <img src="/images/paging/search.png" />
                </button>
            </form>
        </div>
    </div>

    <div class="event_list">
        <ul class="list clearfix">
            <c:forEach var="e" items="${es}">
                <c:set var="thumb" value="${fn:split(e.fnames,'/')[0]}"/>
                <li class="item">
                    <a href="/event/detail?bno=${e.bno}" class="wrap">
                            <c:set var="pos" value="${fn:indexOf(thumb,'.')}" />
                            <c:set var="fname" value="${fn:substring(thumb, 0, pos)}" />
                            <c:set var="fext" value="${fn:substring(thumb, pos+1, fn:length(thumb))}" />
                            <c:if test="${fname ne '-'}">
                                <div>
                                    <img src="${baseURL}${fname}_thumb_${e.uuid}.${fext}">
                                </div>
                            </c:if>
                        <div class="txt_bx">
                            <div class="txt_wrap">
                                <p class="tit">${e.title}</p>
                                <p class="date">${e.sdate} ~ ${e.edate}</p>
                            </div>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <div class="button_pos">
        <div class="btnArea M b_right">
            <c:if test="${sessionScope.MyInfo.uid eq 'admin'}">
                <a href="/event/write" class="black_s">작성하기</a>
            </c:if>
        </div>
    </div>


    <div class="the3-base-paginate">
        <c:if test="${cp ge sp and sp-1 != 0}">
            <a href="${pglink}${sp-1}">
                <img src="/images/paging/paging_left_arrow01.png" alt="이전 페이지">
            </a>
        </c:if>
        <c:if test="${sp-1 le 0}">
            <a href="${pglink}${sp}">
                <img src="/images/paging/paging_left_arrow01.png" alt="이전 페이지">
            </a>
        </c:if>

        <ol>
            <c:forEach var="i" begin="${sp}" end="${ep}" step="1">
                <%-- 표시하는 페이지i가 총 페이지 수보다 작거나 같을 동안만 출력 --%>
                <c:if test="${i le tp}">
                    <c:if test="${i eq cp}">
                        <li><a class="this" href="${pglink}${i}">${i}</a></li>
                    </c:if>
                    <c:if test="${i ne cp}">
                        <li><a href="${pglink}${i}">${i}</a></li>
                    </c:if>
                </c:if>
            </c:forEach>
        </ol>

        <c:if test="${cp+1 le tp and ep le tp}">
            <a href="${pglink}${ep+1}">
                <img src="/images/paging/paging_right_arrow01.png" alt="다음 페이지"/>
            </a>
        </c:if>
        <c:if test="${cp+1 ge tp or ep ge tp}">
            <a href="${pglink}${tp}">
                <img src="/images/paging/paging_right_arrow01.png" alt="다음 페이지"/>
            </a>
        </c:if>
    </div>

</div>
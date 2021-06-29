<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:parseNumber var="cp" value="${param.cp}" />
<fmt:parseNumber var="sp" value="${(cp - 1) / 5}" integerOnly="true" />
<fmt:parseNumber var="sp" value="${sp * 5 + 1}" />
<fmt:parseNumber var="ep" value="${sp + 4}" />

<%-- 총 게시물수를 페이지 당 게시물 수로 나눔 : 총 페이지수 --%>
<fmt:parseNumber var="tp" value="${ncnt / 10}" integerOnly="true" />
<c:if test="${ncnt % 10 gt 0}">
    <fmt:parseNumber var="tp" value="${tp + 1}" />
</c:if>

<%-- 글번호 --%>
<fmt:parseNumber var="snum" value="${ncnt - (cp-1) * 10}" />

<%-- 페이지링크 : 검색기능 x --%>
<c:set var="pglink" value="/notice/list?cp=" />

<%-- 페이지링크 : 검색기능 o --%>
<c:if test="${not empty param.findkey}">
    <c:set var="pglink" value="/notice/find?findtype=${param.findtype}&findkey=${param.findkey}&cp=" />
</c:if>

<div id="contents">

        <div class="titleArea">
            <h2><a href="/notice/list?cp=1">NOTICE</a></h2>
            <p>더삼점영 피부과 공지사항 페이지입니다.</p>
        </div>
        <div class="title-right">
            <div class="search-bar">
                <input type="text" hidden/>
                <select name="findtype" id="findtype">
                    <option value="title">제목</option>
                    <option value="contents">내용</option>
                    <option value="titcont">제목+내용</option>
                </select>
                <input type="text" name="findkey" value="" required id="findkey" maxlength="20" placeholder="검색어를 입력해 주세요"
                       onkeyup="if(window.event.keyCode==13){ nsearchbar() }"/>
                <button type="button" class="submit" id="nfindbtn">
                    <img src="/images/paging/search.png" />
                </button>
            </div>
        </div>

    <div class="the3-base-table listType">
            <table border="1" summary="">
                <caption>게시판 목록</caption>
                <colgroup>
                    <col style="width:70px;"/>
                    <col style="width:auto;"/>
                    <col style="width:130px;"/>
                    <col style="width:100px;"/>
                    <col style="width:55px;"/>
                </colgroup>
                <thead><tr>
                    <th scope="col"> 번호</th>
                    <th scope="col">제목</th>
                    <th scope="col">작성자</th>
                    <th scope="col" class="">작성일</th>
                    <th scope="col" class="">조회</th>
                </tr></thead>
                <tbody class="center">
                <c:set var="trucnt" value="0"/>
                <c:forEach var="n" items="${nsall}">
                    <c:if test="${n.fixed eq 'true'}">
                        <tr style="background:#fcfcfc; color:#555555;">
                            <td>공지</td>
                            <td class="left txtBreak">
                                <strong>
                                    <a href="/notice/detail?bno=${n.bno}" style="color:#555555;">${n.title}</a>
                                </strong>
                            </td>
                            <td>${n.uid}</td>
                            <td><span class="txtNum">${fn:substring(n.regdate, 0, 10)}</span></td>
                            <td><span class="txtNum">${n.views}</span></td>
                        </tr>
                        <c:set var="trucnt" value="${trucnt+1}"/>
                    </c:if>
                </c:forEach>
                </tbody>
                <tbody class="center">
                <c:forEach var="n" items="${ns}">
                        <tr style="background-color:#FFFFFF; color:#555555;">
                            <td>
                                <c:if test="${find eq null}">${snum - trucnt}</c:if>
                                <c:if test="${find ne null}">${snum}</c:if>
                            </td>
                            <td class="left txtBreak">
                                <a href="/notice/detail?bno=${n.bno}" style="color:#555555;">${n.title}</a>
                                <span class="txtEm"></span>
                            </td>
                            <td>${n.uid}</td>
                            <td><span class="txtNum">${fn:substring(n.regdate, 0, 10)}</span></td>
                            <td><span class="txtNum">${n.views}</span></td>
                            <c:set var="snum" value="${snum-1}" />
                        </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    <div class="button_pos">
        <div class="btnArea M b_right">
            <c:if test="${sessionScope.MyInfo.uid eq 'admin'}">
                <a href="/notice/write" class="black_s">작성하기</a>
            </c:if>
        </div>
    </div>


    <div class="the3-base-paginate">
        <c:if test="${cp ge sp and sp-1 gt 0}">
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

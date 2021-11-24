<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:parseNumber var="cp" value="${param.cp}" />
<fmt:parseNumber var="sp" value="${(cp - 1) / 5}" integerOnly="true" />
<fmt:parseNumber var="sp" value="${sp * 5 + 1}" />
<fmt:parseNumber var="ep" value="${sp + 4}" />

<%-- 총 게시물수를 페이지 당 게시물 수로 나눔 : 총 페이지수 --%>
<fmt:parseNumber var="tp" value="${adCnt / 10}" integerOnly="true" />
<c:if test="${adCnt % 10 gt 0}">
    <fmt:parseNumber var="tp" value="${tp + 1}" />
</c:if>

<%-- 글번호 --%>
<fmt:parseNumber var="snum" value="${adCnt - (cp-1) * 10}" />

<%-- 페이지링크 : 검색기능 x --%>
<c:set var="pglink" value="/admin/inquiry?cp=" />

<%-- 페이지링크 : 검색기능 o --%>
<c:if test="${not empty param.findkey1 or not empty param.findkey2}">
    <c:set var="pglink" value="/admin/inquiry/find?findkey1=${param.findkey1}&findkey2=${param.findkey2}&cp=" />
</c:if>

<div class="section8">
    <div class="comm_wrap2">
        <div class="cetnerDiv wow fadeInUp top" data-wow-delay="0.1s">
            <div class="adminTitle">환자 데이터 조회 및 저장</div>
        </div>
        <div class="flex">
            <div class="adminModal">
                <div class="adminModalContent">
                    <div class="adminModalTitle">조회</div>
                    <div style="text-align: center">
                        성함 :<input type="text" id="findkey1" name="findkey1" maxlength="20" txtlimit="5" class="adminUsrInfo">
                        생년월일 :<input type="text" id="findkey2" name="findkey2" class="adminUsrInfo"readonly>
                        <span class="btnArea M b_center adminSearchBtn">
                            <a id="adminDataInquiryBtn" class="close custom_s" style="height: 18.5px; margin-left: 4px;">검색</a>
                        </span>
                    </div>
                    <div class="the3-base-table listType">
                        <table border="1" summary="">
                            <caption>게시판 목록</caption>
                            <colgroup>
                                <col style="width:10%;"/>
                                <col style="width:25%;"/>
                                <col style="width:25%;"/>
                                <col style="width:20%;"/>
                                <col style="width:10%;"/>
                            </colgroup>
                            <thead><tr>
                                <th scope="col">번호</th>
                                <th scope="col">성함</th>
                                <th scope="col">생년월일</th>
                                <th scope="col" class="">측정날짜</th>
                                <th scope="col" class="">종류</th>
                            </tr></thead>
                            <c:if test="${snum lt 1}">
                                <tbody class="center" style="height: 144px">
                                    <tr>
                                        <td class="noResult" colspan="5">검색 결과가 없습니다.</td>
                                    </tr>
                                </tbody>
                            </c:if>
                            <c:if test="${snum ge 1}">
                                <tbody class="center">
                                <c:forEach var="ad" items="${ads}">
                                        <tr onclick="location.href='/admin/inquiry/detail?adno=${ad.adno}'" style="background:#fcfcfc; color:#555555;">
                                            <td>${snum}</td>
                                            <td>${ad.uname}</td>
                                            <td>${ad.ubdate}</td>
                                            <td><span class="txtNum">${fn:substring(ad.regdate, 0, 10)}</span></td>
                                            <c:if test="${ad.type eq 'C'}">
                                            <td><span class="txtNum">측정</span></td>
                                            </c:if>
                                            <c:if test="${ad.type eq 'V' or ad.type eq 'I' or ad.type eq 'T' or ad.type eq 'L'}">
                                                <td><span class="txtNum">치료</span></td>
                                            </c:if>
                                            <c:set var="snum" value="${snum-1}" />
                                        </tr>
                                </c:forEach>
                                </tbody>
                            </c:if>
                        </table>
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
            </div>
            <div class="right wow fadeInDown" data-wow-delay="0.2s">
                <div class="adminPage">
                    <div class="adminPageMain">
                        <a href="/admin/inquiry?cp=1" class="adminPageMain_box adminPageBtnActive">
                            <h3>조회</h3>
                            <p>환자의 피부 측정값과<br>치료 내용을 조회합니다.</p>
                        </a>
                    </div>
                    <div class="adminPageMain">
                        <a href="/admin/cureMain" class="adminPageMain_box">
                            <h3>치료</h3>
                            <p>치료 내용을 저장합니다.</p>
                        </a>
                    </div>
					<div class="adminPageMain">
                        <a href="/admin/main" class="adminPageMain_box">
                            <h3>측정</h3>
                            <p>진단을 통한 측정값을<br>저장합니다.</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


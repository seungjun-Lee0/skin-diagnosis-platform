<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<c:if test="${sessionScope.MyInfo eq null}">
    <script language="javascript">
        alert("로그인이 필요한 기능입니다.");
        document.location.href="/";
    </script>
</c:if>

<%-- 페이지링크 : 검색기능 x --%>
<c:set var="pglink" value="/mypage/myDiagnosis?cp=" />

<%-- 페이지링크 : 검색기능 o --%>
<c:if test="${not empty param.findkey}">
    <c:set var="pglink" value="/mypage/myDiagnosis/find?findtype=${param.findtype}&findkey=${param.findkey}&cp=" />
</c:if>

<div id="contents">

    <div class="titleArea">
        <h2>마이페이지</h2>
    </div>


    <div>
        <h2  style="text-align: center">
            <span><c:if test="${sessionScope.MyInfo.uid eq 'admin'}">관리자</c:if>
                <c:if test="${sessionScope.MyInfo.uid ne 'admin'}">${sessionScope.MyInfo.uname}</c:if> 님 환영합니다.</span>
        </h2>
    </div>
	<div class="mypageDisplay">
		<div class = "mypage">
			<div class="pageMain">
				<a href="/mypage/myInfo" class="pageMain_box">
					<h3>회원 정보</h3>
					<p>고객님의 개인정보를 관리하는 공간입니다.</p>
				</a>
			</div>
			<div class="pageMain">
				<a href="/mypage/myDiagnosis?cp=1" class="pageMain_box mypageBtnActive">
					<h3>
						<c:if test="${sessionScope.MyInfo.uid eq 'admin'}">신청된 검사 목록</c:if>
						<c:if test="${sessionScope.MyInfo.uid ne 'admin'}">진단결과 조회</c:if>
					</h3>
					<p>
						<c:if test="${sessionScope.MyInfo.uid eq 'admin'}">신청된 검사 목록을 조회하고 결과를<br>작성하실 수 있습니다.</c:if>
						<c:if test="${sessionScope.MyInfo.uid ne 'admin'}">피부진단 결과를 조회하실 수 있습니다.</c:if></p>
				</a>
			</div>
			<div class="pageMain">
				<a href="/mypage/myInquiry?cp=1&uid=${sessionScope.MyInfo.uid}" class="pageMain_box">
					<h3>문의내역 조회</h3>
					<p>문의하신 내역과 답변을 확인하실 수 있습니다.</p>
				</a>
			</div>
		</div>

		<div class="mypageMainView">
			<c:if test="${sessionScope.MyInfo.uid ne 'admin'}">
				<div style="margin-left: 5%; width: 90%;">
					<h2 style="text-align: center; padding-top: 30px">검사목록 조회</h2>
					<div class="the3-base-table listType" style="padding-top: 25px;">
						<table border="1" summary="">
							<colgroup>
								<col style="width:12%;"/>
								<col style="width:33%;"/>
								<col style="width:30%;"/>
								<col style="width:25%;"/>
							</colgroup>
							<thead><tr style=" ">
								<th scope="col">번호</th>
								<th scope="col">이름</th>
								<th scope="col">상태</th>
								<th scope="col" class="">작성일</th>
							</tr></thead>
							<tbody class="center">
							<c:set var="snum" value="0"/>
								<c:forEach var="d" items="${ds}">
									<c:if test="${d.uid eq sessionScope.MyInfo.uid}">
										<c:set var="snum" value="${snum+1}" />
									</c:if>
								</c:forEach>
							<c:if test="${snum lt 1}">
							<tbody class="center" style="height: 144px">
							<tr>
								<td class="noResult" colspan="5">검색 결과가 없습니다.</td>
							</tr>
							</tbody>
							</c:if>
							<c:forEach var="d" items="${ds}">
								<c:if test="${d.uid eq sessionScope.MyInfo.uid}">
									<tr style="background-color:#FFFFFF; color:#333333;">
										<td>${snum}</td>
										<td><a href="/mypage/myDiagnosis/detail?dno=${d.dno}">${d.uname}</a></td>
										<td><c:if test="${d.status eq 'true'}">
												<c:set var="status" value="검사완료"/>
											</c:if>
											<c:if test="${d.status eq 'false'}">
												<c:set var="status" value="검사중"/>
											</c:if>
											<a href="/mypage/myDiagnosis/detail?dno=${d.dno}">${status}</a>
										</td>
										<td><span class="txtNum">${fn:substring(d.regdate, 0, 10)}</span></td>
										</a>
									</tr>
									<c:set var="snum" value="${snum-1}" />
								</c:if>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</c:if>
			
			<c:if test="${sessionScope.MyInfo.uid eq 'admin'}">
				<div style="margin-left: 5%; width: 90%;">
					<h2 style="text-align: center; padding-top: 30px">검사목록 조회</h2>
					<div class="the3-base-table listType" style="padding-top: 25px;">
						<table border="1" summary="">
							<colgroup>
								<col style="width:11%;"/>
								<col style="width:24%;"/>
								<col style="width:24%;"/>
								<col style="width:20%;"/>
								<col style="width:21%;"/>
							</colgroup>
							<thead><tr style=" ">
								<th scope="col">번호</th>
								<th scope="col">아이디</th>
								<th scope="col">이름</th>
								<th scope="col">상태</th>
								<th scope="col" class="">작성일</th>
							</tr></thead>
							<tbody class="center">
							<c:set var="snum" value="0" />
							<c:forEach var="d" items="${ds}">
								<c:set var="snum" value="${snum+1}" />
							</c:forEach>
							<c:if test="${snum lt 1}">
								<tbody class="center" style="height: 144px">
								<tr>
									<td class="noResult" colspan="5">검색 결과가 없습니다.</td>
								</tr>
								</tbody>
							</c:if>
							<c:forEach var="d" items="${ds}">
								<tr style="background-color:#FFFFFF; color:#333333;">
									<td>${snum}</td>
									<td><a href="/mypage/myDiagnosis/detail?dno=${d.dno}">${d.uid}</a></td>
									<td><a href="/mypage/myDiagnosis/detail?dno=${d.dno}">${d.uname}</a></td>
									<td><c:if test="${d.status eq 'true'}">
											<c:set var="status" value="답변완료"/>
										</c:if>
										<c:if test="${d.status eq 'false'}">
											<c:set var="status" value="답변대기"/>
										</c:if>
										<a href="/mypage/myDiagnosis/detail?dno=${d.dno}">${status}</a>
									</td>
									<td><span class="txtNum">${fn:substring(d.regdate, 0, 10)}</span></td>
									</a>
								</tr>
								<c:set var="snum" value="${snum-1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</div>
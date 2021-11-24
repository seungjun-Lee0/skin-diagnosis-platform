<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

<div id="contents" style="background-color: snow; border: 1px solid #ccc; padding-bottom: 40px; border-radius: 5px;">
    <ul class="breadcrumb">
        <li>자가진단</li>
        <li>원인분석</li>
        <li>진단결과</li>
        <li class="active">검사완료</li>
    </ul>

    <div class="join_title">
        <h4 class="title">검사 완료</h4>
    </div>

    <div class="join_done_page">
        <div class="img"><img src="/images/register_done.png" style="width: 20%; padding-left: 15px;" alt=""></div>
        <h4 class="title">검사가 <span style="color: rgb(224,213,202)">완료</span>되었습니다.</h4>
        <div class="join_btn btn">
            <div class="row">
                <div class="col-lg-6">
                    <a href="/" class="btn-type-02">메인으로 이동</a>
                </div>
                <div class="col-lg-6">
                    <a href="/mypage/myDiagnosis" class="btn-type-01">검사결과 조회</a>
                </div>
            </div>
        </div>
    </div>

</div>

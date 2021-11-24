<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<style>
    .diagnosis-text .btn:hover{
        opacity: 1;
        background-color: transparent;
    }
</style>

<div id="contents" style="background-color:snow; border: 1px solid #ccc; padding-bottom: 40px; border-radius: 5px;">

    <ul class="breadcrumb">
        <li>자가진단</li>
        <li>원인분석</li>
        <li class="active">진단결과</li>
        <li>검사완료</li>
    </ul>
    <div class="join_title">
        <h4 class="title" style="margin-top: 0;">여드름상태 진단 결과</h4>
    </div>
    <div class="diagnosis-wrap">
        <div class="diagnosis-image"><img src="/images/diagnosis/face.png"></div>
        <div class="diagnosis-text">
            <div class="diagnosis-text-table">
                <div class="diagnosis-text-table-row">
                    <fmt:parseNumber var="fh" type="number" value="${rsall.fh}" />
                    <c:if test="${fh ge 0 and fh lt 1.5}">
                        <button class="btn" style="width: 150%;height: 45%;margin-left: 67%;margin-top: 80%;margin-bottom: 15%;background-color:rgb(34,139,34,0.7);">
                        매우 좋음
                        </button>
                    </c:if>
                    <c:if test="${fh ge 1.5 and fh lt 2.5}">
                        <button class="btn" style="width: 150%;height: 45%;margin-left: 67%;margin-top: 80%;margin-bottom: 15%;background-color:rgb(0,255,0,0.5);">
                            좋음
                        </button>
                    </c:if>
                    <c:if test="${fh ge 2.5 and fh lt 3.5}">
                        <button class="btn" style="width: 150%;height: 45%;margin-left: 67%;margin-top: 80%;margin-bottom: 15%;background-color:rgb(240,230,140,0.5);">
                            보통
                        </button>
                    </c:if>
                    <c:if test="${fh ge 3.5 and fh lt 4.5}">
                        <button class="btn" style="width: 150%;height: 45%;margin-left: 67%;margin-top: 80%;margin-bottom: 15%;background-color:rgb(255,165,0,0.5);">
                            나쁨
                        </button>
                    </c:if>
                    <c:if test="${fh ge 4.5 and fh lt 5.5}">
                        <button class="btn" style="width: 150%;height: 45%;margin-left: 67%;margin-top: 80%;margin-bottom: 15%;background-color:rgb(255,0,0,0.5);">
                            매우나쁨
                        </button>
                    </c:if>
                    <c:if test="${fh lt 0 or fh ge 5.5 or fh eq null}">
                        <button class="btn" style="width: 150%;height: 45%;margin-left: 67%;margin-top: 80%;margin-bottom: 15%;">
                            없음
                        </button>
                    </c:if>

                </div>
                <div class="diagnosis-text-table-row">
                </div>
                <div class="diagnosis-text-table-row">
                    <div></div>
                    <div class="diagnosis-text-table-cell">
                        <fmt:parseNumber var="lc" type="number" value="${rsall.lc}" />
                        <c:if test="${lc ge 0 and lc lt 1.5}">
                            <button class="btn" style="width: 75%;height: 60%;margin-top: 65%;margin-left: -65%;background-color:rgb(34,139,34,0.7);">
                                    매우좋음</button>
                        </c:if>
                        <c:if test="${lc ge 1.5 and lc lt 2.5}">
                            <button class="btn" style="width: 75%;height: 60%;margin-top: 65%;margin-left: -65%;background-color:rgb(0,255,0,0.5);">
                                좋음</button>
                        </c:if>
                        <c:if test="${lc ge 2.5 and lc lt 3.5}">
                            <button class="btn" style="width: 75%;height: 60%;margin-top: 65%;margin-left: -65%;background-color:rgb(240,230,140,0.5)">
                                보통</button>
                        </c:if>
                        <c:if test="${lc ge 3.5 and lc lt 4.5}">
                            <button class="btn" style="width: 75%;height: 60%;margin-top: 65%;margin-left: -65%;background-color:rgb(255,165,0,0.5);">
                                나쁨</button>
                        </c:if>
                        <c:if test="${lc ge 4.5 and lc lt 5.5}">
                            <button class="btn" style="width: 75%;height: 60%;margin-top: 65%;margin-left: -65%;background-color:rgb(255,0,0,0.5);">
                                매우나쁨</button>
                        </c:if>
                        <c:if test="${lc lt 0 or lc ge 5.5 or lc eq null}">
                            <button class="btn" style="width: 75%;height: 60%;margin-top: 65%;margin-left: -65%;">
                                없음</button>
                        </c:if>
                    </div>
                    <div class="diagnosis-text-table-cell">
                        <fmt:parseNumber var="nose" type="number" value="${rsall.nose}" />
                        <c:if test="${nose ge 0 and nose lt 1.5}">
                            <button class="btn" style="width: 70%;height: 100%; margin-left: -65%;margin-top: 25%;margin-bottom: 60%;background-color:rgb(34,139,34,0.7);">
                                매우좋음</button>
                        </c:if>
                        <c:if test="${nose ge 1.5 and nose lt 2.5}">
                            <button class="btn" style="width: 70%;height: 100%; margin-left: -65%;margin-top: 25%;margin-bottom: 60%;background-color:rgb(0,255,0,0.5);">
                                좋음</button>
                        </c:if>
                        <c:if test="${nose ge 2.5 and nose lt 3.5}">
                            <button class="btn" style="width: 70%;height: 100%; margin-left: -65%;margin-top: 25%;margin-bottom: 60%;background-color:rgb(240,230,140,0.5)">
                                보통</button>
                        </c:if>
                        <c:if test="${nose ge 3.5 and nose lt 4.5}">
                            <button class="btn" style="width: 70%;height: 100%; margin-left: -65%;margin-top: 25%;margin-bottom: 60%;background-color:rgb(255,165,0,0.5);">
                                나쁨</button>
                        </c:if>
                        <c:if test="${nose ge 4.5 and nose lt 5.5}">
                            <button class="btn" style="width: 70%;height: 100%; margin-left: -65%;margin-top: 25%;margin-bottom: 60%;background-color:rgb(255,0,0,0.5);">
                                매우나쁨</button>
                        </c:if>
                        <c:if test="${nose lt 0 or nose ge 5.5 or nose eq null}">
                            <button class="btn" style="width: 70%;height: 100%; margin-left: -65%;margin-top: 25%;margin-bottom: 60%;">
                                없음</button>
                        </c:if>
                    </div>
                    <div class="diagnosis-text-table-cell">
                        <fmt:parseNumber var="rc" type="number" value="${rsall.rc}" />
                        <c:if test="${rc ge 0 and rc lt 1.5}">
                            <button class="btn" style="width: 75%;height: 60%;margin-left: -65%;margin-top: 65%;background-color:rgb(34,139,34,0.7);">
                                매우좋음</button>
                        </c:if>
                        <c:if test="${rc ge 1.5 and rc lt 2.5}">
                            <button class="btn" style="width: 75%;height: 60%;margin-left: -65%;margin-top: 65%;background-color:rgb(0,255,0,0.5);">
                                좋음</button>
                        </c:if>
                        <c:if test="${rc ge 2.5 and rc lt 3.5}">
                            <button class="btn" style="width: 75%;height: 60%;margin-left: -65%;margin-top: 65%;background-color:rgb(240,230,140,0.5)">
                                보통</button>
                        </c:if>
                        <c:if test="${rc ge 3.5 and rc lt 4.5}">
                            <button class="btn" style="width: 75%;height: 60%;margin-left: -65%;margin-top: 65%;background-color:rgb(255,165,0,0.5);">
                                나쁨</button>
                        </c:if>
                        <c:if test="${rc ge 4.5 and rc lt 5.5}">
                            <button class="btn" style="width: 75%;height: 60%;margin-left: -65%;margin-top: 65%;background-color:rgb(255,0,0,0.5);">
                                매우나쁨</button>
                        </c:if>
                        <c:if test="${rc lt 0 or rc ge 5.5 or rc eq null}">
                            <button class="btn" style="width: 75%;height: 60%;margin-left: -65%;margin-top: 65%;">
                                없음</button>
                        </c:if>
                    </div>
                </div>
                <div class="diagnosis-text-table-row">
                    <fmt:parseNumber var="chin" type="number" value="${rsall.chin}" />
                    <c:if test="${chin ge 0 and chin lt 1.5}">
                        <button class="btn" style="width: 120%;height: 50%;margin-left: 82%; margin-top: 35%;margin-bottom: 15%;background-color:rgb(34,139,34,0.7);">
                            매우좋음</button>
                    </c:if>
                    <c:if test="${chin ge 1.5 and chin lt 2.5}">
                        <button class="btn" style="width: 120%;height: 50%;margin-left: 82%; margin-top: 35%;margin-bottom: 15%;background-color:rgb(0,255,0,0.5);">
                            좋음</button>
                    </c:if>
                    <c:if test="${chin ge 2.5 and chin lt 3.5}">
                        <button class="btn" style="width: 120%;height: 50%;margin-left: 82%; margin-top: 35%;margin-bottom: 15%;background-color:rgb(240,230,140,0.5)">
                            보통</button>
                    </c:if>
                    <c:if test="${chin ge 3.5 and chin lt 4.5}">
                        <button class="btn" style="width: 120%;height: 50%;margin-left: 82%; margin-top: 35%;margin-bottom: 15%;background-color:rgb(255,165,0,0.5);">
                            나쁨</button>
                    </c:if>
                    <c:if test="${chin ge 4.5 and chin lt 5.5}">
                        <button class="btn" style="width: 120%;height: 50%;margin-left: 82%; margin-top: 35%;margin-bottom: 15%;background-color:rgb(255,0,0,0.5);">
                            매우나쁨</button>
                    </c:if>
                    <c:if test="${chin lt 0 or chin ge 5.5 or chin eq null}">
                        <button class="btn" style="width: 120%;height: 50%;margin-left: 82%; margin-top: 35%;margin-bottom: 15%;">
                            없음</button>
                    </c:if>

                </div>
            </div>
        </div>
    </div>

    <div class="join_btn">
        <a href="/diagnosis/completed" class="btn-type-01">다음으로</a>
    </div>
</div>
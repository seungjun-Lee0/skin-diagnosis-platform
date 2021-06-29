<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String strReferer = request.getHeader("referer");

  if(strReferer == null){
%>
<script language="javascript">
  alert("정상적인 경로를 통해 다시 접근해 주세요.");
  document.location.href="/";
</script>
<%
    return;
  }
%>

<div id="contents">

  <div class="join_title">
    <h4 class="title">가입 완료</h4>
  </div>

  <div class="join_done_page">
    <div class="img"><img src="/images/register_done.png" style="width: 20%; padding-left: 15px;" alt=""></div>
    <h4 class="title">회원가입이 <span style="color: rgb(224,213,202)">완료</span>되었습니다.</h4>
    <div class="join_btn btn">
      <div class="row">
        <div class="col-lg-6">
          <a href="/" class="btn-type-02">메인으로 이동</a>
        </div>
        <div class="col-lg-6">
          <a href="/member/login" class="btn-type-01">로그인 하기</a>
        </div>
      </div>
    </div>
  </div>

</div>


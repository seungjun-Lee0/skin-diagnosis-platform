<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>

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

<%--<c:set var="baseURL" value="${pageContext.request.contextPath}/images/downloadedImages/inquiry/" /> --%>
<c:set var="baseURL" value="/home/ec2-user/downloadedImages/inquiry/" />
<c:set var="fnames" value="${fn:split(its.fnames,'/')}"/>

<div id="contents" style="margin-top: 150px; margin-bottom: 150px;">

  <div class="titleArea">
    <h2><a href="/inquiry/list?cp=1">1:1 문의</a></h2>
    <p>더삼점영 피부과 1:1 문의 페이지입니다.</p>
  </div>

  <!-- 글 내용-->
  <div class="the3-base-table writeType">
      <table border="0" summary="">
        <caption>게시판 상세</caption>
        <colgroup>
          <col style="width:130px;"/>
          <col style="width:auto;"/>
        </colgroup>
        <tbody>
        <tr>
          <td colspan="2" style="border-bottom:0;font-size:14px;font-weight:500;color:#000;">${its.title}</td>
        </tr>
        <tr>
          <td colspan="2" style="padding:0 0 15px">
            <ul class="noticeInfo">
              <li>
                <strong>작성자 :</strong>${its.uid}
              </li>
              <li>
                <strong>작성일 :</strong> <span class="txtNum">${fn:substring(its.regdate, 0, 10)}</span>
              </li>
              <li>
                <strong>조회수 :</strong> <span class="txtNum">${its.views}</span>
              </li>
            </ul>
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <div class="fr-view fr-view-article">
              ${fn:replace(its.content, replaceChar, "<br/>")}

                <c:forEach var="f" items="${fnames}">
                  <c:set var="pos" value="${fn:indexOf(f,'.')}" />
                  <c:set var="fname" value="${fn:substring(f, 0, pos)}" />
                  <c:set var="fext" value="${fn:substring(f, pos+1, fn:length(f))}" />
                  <c:if test="${fname ne '-'}">
                    <img src="${baseURL}${fname}${its.uuid}.${fext}">
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
        <a href="/inquiry/list?cp=1" class="black_s">목록보기</a>
      </div>

      <c:if test="${its.uid eq sessionScope.MyInfo.uid}">
        <div class="btnArea M b_right">
          <a href="/inquiry/modify?bno=${its.bno}" class="gray_s">수정하기</a>
        </div>

        <div class="btnArea M b_right">
          <a id="ideletebtn" class="white_s">삭제하기</a>

          <form id="ideletefrm" name="ideletefrm">
            <input type="hidden" name="bno" value="${its.bno}">
          </form>
        </div>
      </c:if>
    </div>

  <c:set var="cnt" value="1"/>
  <c:forEach var="ir" items="${irps}">
    <ul class="boardComment">
      <li class="first">
        <div class="commentTop">
          <strong>${ir.uid}</strong>&nbsp;|
          <strong>${fn:substring(ir.regdate, 0, 19)}</strong>
        </div>
        <span class="button btnArea">
          <c:if test="${ir.uid eq sessionScope.MyInfo.uid}">
            <a id="commentmodbtn${cnt}" class="white_s" style="width:40px;padding:3px;display:inline-block;">수정</a>
            <a id="commentdelbtn${cnt}" class="gray_s" style="width:40px;padding:3px;display:inline-block;">삭제</a>
          </c:if>
          <form id="cdeletefrm${cnt}" name="cdeletefrm${cnt}">
            <input type="hidden" name="rno" value="${ir.rno}">
            <input type="hidden" name="bno" value="${its.bno}">
          </form>
        </span>
        <form id="cmodifyfrm${cnt}" name="cmodifyfrm${cnt}" hidden>
          <input type="hidden" name="rno" value="${ir.rno}">
          <input type="hidden" name="bno" value="${its.bno}">
          <div class="commentModify">
            <div style="text-align: center; padding-bottom: 5px;">
              <h4>댓글수정</h4>
            </div>
            <fieldset>
              <legend>댓글 수정</legend>
              <div class="view">
                <textarea id="ccontent" name="content">${ir.content}</textarea>
                <div style="width:19%; float: right">
                    <div class="btnArea b_center" style="width:45%;vertical-align:bottom;margin:0 2px;">
                        <a id="cmodifybtn${cnt}" class="white" style="padding:14px 0;">수정</a>
                    </div>
                    <div class="btnArea b_center" style="width:45%;vertical-align:bottom;margin:0 2px;">
                        <a id="cmodifycancelbtn${cnt}" class="gray" style="padding:14px 0;">취소</a>
                    </div>
                </div>
              </div>
            </fieldset>
          </div>
        </form>
        <div class="comment${cnt}">
          <span>${ir.content}</span>
        </div>
      </li>
    </ul>
    <script>
      $('#commentmodbtn${cnt}').on('click', function (){
        $('#cmodifyfrm${cnt}').show();
        $('#commentmodbtn${cnt}').hide();
        $('.comment${cnt}').hide();
      });

      $('#cmodifycancelbtn${cnt}').on('click', function () {
        $('#cmodifyfrm${cnt}').hide();
        $('#commentmodbtn${cnt}').show();
        $('.comment${cnt}').show();
      });

      // modify board comment
      $('#cmodifybtn${cnt}').on('click', function (){
        if($('#ccontent${cnt}').val() == '') alert("댓글을 작성하세요");
        else {
          const frm = $('#cmodifyfrm${cnt}');
          frm.attr('method','post');
          frm.attr('action','/reply/modify');
          frm.attr('enctype', "multipart/form-data");
          frm.submit();
        }
      });

      // delete board comment
      $('#commentdelbtn${cnt}').on('click', function () {
        if (confirm("삭제된 댓글은 복구 하실 수 없습니다. 정말 삭제하시겠습니까?") == true){    //확인
          const frm = $('#cdeletefrm${cnt}');

          frm.attr("method", "post");
          frm.attr('action', "/reply/delete");
          frm.attr('enctype', "multipart/form-data");
          frm.submit();
        }else{   //취소
          return;
        }
      })
    </script>
    <c:set var="cnt" value="${cnt+1}" />
  </c:forEach>

  <c:if test="${sessionScope.MyInfo.uid ne null}">
    <form id="replyfrm" name="replyfrm">
      <c:if test="${sessionScope.MyInfo.uid eq 'Admin'}">
      <input type="hidden" id="status" name="status" value="true">
      </c:if>
      <c:if test="${sessionScope.MyInfo.uid ne 'Admin'}">
        <input type="hidden" id="status" name="status" value="false">
      </c:if>
      <input type="hidden" id="uid" name="uid" value="${sessionScope.MyInfo.uid}">
      <input type="hidden" id="bno" name="bno" value="${its.bno}">
      <div class="commentWrite">
        <div style="text-align: center; padding-bottom: 5px;">
          <h3>댓글달기</h3>
        </div>
        <fieldset>
          <div>
            <textarea class="replyTextArea" id="content" name="content"></textarea>
            <div class="btnArea M b_center" style="width: 12%; float: right;">
                <a id="replybtn" class="black_s" style="height: 58px;line-height: 58px;">답변 달기</a>
            </div>
            </span>
          </div>
        </fieldset>
      </div>
    </form>
  </c:if>
  <c:if test="${sessionScope.MyInfo.uid eq null}">
    <div class="commentWrite">
      <p style="margin: 20px 0 10px;">댓글 작성 권한이 없습니다.</p>
    </div>
  </c:if>
</div>
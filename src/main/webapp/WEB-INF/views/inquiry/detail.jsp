<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="contents" style="margin-top: 150px; margin-bottom: 150px;">

  <div class="titleArea">
    <h2>1:1 문의</h2>
    <p>더삼점영 피부과 1:1 문의 페이지입니다.</p>
  </div>

  <!-- 글 내용-->
  <form id="BoardDelForm" name="" action="/exec/front/Board/del/1" method="post" target="_self" enctype="multipart/form-data" >
    <div class="the3-base-table writeType">
      <table border="0" summary="">
        <caption>게시판 상세</caption>
        <colgroup>
          <col style="width:130px;"/>
          <col style="width:auto;"/>
        </colgroup>
        <tbody>
        <tr>
          <td colspan="2" style="border-bottom:0;font-size:14px;font-weight:500;color:#000;">2019년 1차 회원등급 변경 안내 </td>
        </tr>
        <tr>
          <td colspan="2" style="padding:0 0 15px">
            <ul class="noticeInfo">
              <li>
                <strong>작성자 :</strong>  닥터웰메이드원 공식몰
              </li>
              <li>
                <strong>작성일 :</strong> <span class="txtNum">2019-01-31</span>
              </li>
              <li>
                <strong>조회수 :</strong> <span class="txtNum">2502</span>
              </li>
            </ul>
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <div class="fr-view fr-view-article"><p>안녕하세요.</p><p>닥터웰메이드원입니다.</p><p><br></p><p>2019년 1차 회원 등급 변경이 진행되었으니,</p><p>이후 구입에 참고 부탁드립니다.</p><p><br></p><p>자세한 회원혜택 내용은 게시판 상단 공지사항의</p><p>[닥터웰메이드원 신규&구매고객 혜택 안내] 게시글에서 확인하실 수 있습니다.</p><p><br></p><p>앞으로도 많은 관심과 사랑 부탁드립니다.</p><p>감사합니다 :)</p></div>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
    <div class="button_pos">
      <div class="btnArea M b_left">
        <a href="/inquiry/list" class="black_s">목록보기</a>
      </div>

      <div class="btnArea M b_right">
        <a href="/inquiry/modify" class="gray_s">수정하기</a>
      </div>

      <div class="btnArea M b_right">
        <a href="#none" onclick="BOARD_READ.article_delete('BoardDelForm','1');" class="white_s">삭제하기</a>
      </div>
    </div>
  </form>

  <!-- 댓글 수정 -->
  <form id="commentForm" name="" action="/exec/front/Board/CommentUpdate/1" method="post" target="_self" enctype="multipart/form-data" >
    <input id="board_no" name="board_no" value="1" type="hidden"  />
    <input id="no" name="no" value="18779" type="hidden"  />
    <input id="comment_no" name="comment_no" value="" type="hidden"  />
    <input id="member_id" name="member_id" value="" type="hidden"  />
    <div>
      <fieldset>
      <div>

        <textarea class="replyTextArea" id="comment_modify" name="comment_modify" fw-filter="isFill" fw-label="댓글내용" fw-msg="" style="" ></textarea>

        <span class="submit">
                      <div class="btnArea M b_center" style="margin-left: 20px">
                          <a href="#none" onclick="BOARD_COMMENT.comment_update_ok('commentForm');" class="white white_s">답변 달기</a>
                      </div>
                      <div class="btnArea M b_center">
                          <a href="#none" onclick="BOARD_COMMENT.comment_cancel_ok('commentForm');" class="gray gray_s">취소</a>
                      </div>
        </span>
    </div>
  </fieldset>
  </div>
  </form>

  <div class="the3-board-movement"><ul>
    <li class="prev">
      <strong>이전글</strong><a href="/board/free/read.html?no=&board_no=1&page="></a>
    </li>
    <li class="next ">
      <strong style="background: url(/images/paging/ico_move_next.gif) no-repeat 0 15px;">다음글</strong><a href="/board/free/read.html?no=18778&board_no=1&page=">2019년 설 연휴 배송 및 휴무 안내 </a>
    </li>
  </ul>
  </div>


</div>
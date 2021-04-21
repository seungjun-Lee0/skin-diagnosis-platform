<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="contents" style="margin-top: 150px; margin-bottom: 150px;">

    <div class="titleArea">
        <h2>EVENT</h2>
        <p>저희 피부과가 준비한 다양하고 풍성한 이벤트를 확인하세요.</p>
    </div>

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
                            <li class="">
                                <strong>작성일 :</strong> <span class="txtNum">2019-01-31</span>
                            </li>
                            <li class="">
                                <strong>조회수 :</strong> <span class="txtNum">2502</span>
                            </li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                            <div class="fr-view fr-view-article">
                                <p><br></p>

                                <a href="http://the30mall.kr/product/detail.html?product_no=161" target="_self">
                                    <img src="/images/event/content/event_example.jpg" style="width: 1280px; height: 3401px;">
                                </a>

                                <p><br></p>
                            </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">첨부파일</th>
                    <td><a href="#none" onclick="BOARD_READ.file_download('/exec/front/Board/download/?no=19830&realname=2020/11/18/9235319ec7eb4994522663e9a55bf358.jpg&filename=메인배너.jpg');">메인배너.jpg</a> </td>
                </tr>

                </tbody>
            </table>
        </div>
        <div class="button_pos">
            <div class="btnArea M b_left">
                <a href="/event/list" class="black_s">목록보기</a>
            </div>

            <div class="btnArea M b_right">
                <a href="/event/modify" class="gray_s">수정하기</a>
            </div>

            <div class="btnArea M b_right">
                <a href="#none" onclick="BOARD_READ.article_delete('BoardDelForm','1');" class="white_s">삭제하기</a>
            </div>
        </div>
    </form>

    <div class="the3-board-movement">
        <ul>
            <li class="prev">
                <strong>이전글</strong><a href="/board/free/read.html?no=&board_no=1&page="></a>
            </li>
            <li class="next ">
                <strong style="background: url(/images/paging/ico_move_next.gif) no-repeat 0 15px;">다음글</strong><a href="/board/free/read.html?no=18778&board_no=1&page=">2019년 설 연휴 배송 및 휴무 안내 </a>
            </li>
        </ul>
    </div>


</div>
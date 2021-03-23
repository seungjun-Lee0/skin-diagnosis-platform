<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="contents">

        <div class="titleArea">
            <h2>NOTICE</h2>
            <p>더삼점영 피부과 공지사항 페이지입니다.</p>
        </div>
        <div class="title-right">
            <div class="search-bar">
                <form name="nseacrh" method="get" role="form">
                    <input type="hidden" name="bo_table" value="notice">
                    <input type="hidden" name="sca" value="">
                    <input type="hidden" name="sop" value="and">
                    <select name="findtype3" id="findtype3">
                        <option value="title">제목</option>
                        <option value="contents">내용</option>
                        <option value="titcont">제목+내용</option>
                    </select>
                    <input type="text" name="findkey" value="" required id="findkey" maxlength="20" placeholder="검색어를 입력해 주세요">
                    <button type="button" class="submit" id="findbtn">
                        <img src="/images/logo/search.png" />
                    </button>
                </form>
            </div>
        </div>

    <div class="ec-base-table typeList gBorder">
            <table border="1" summary="">
                <caption>게시판 목록</caption>
                <colgroup class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 "><col style="width:70px;"/>
                    <col style="width:135px;" class="displaynone"/>
                    <col style="width:auto;"/>
                    <col style="width:130px;"/>
                    <col style="width:100px;" class=""/>
                    <col style="width:55px;" class=""/>
                    <col style="width:55px;" class="displaynone"/>
                    <col style="width:80px;" class="displaynone"/>
                </colgroup>
                <thead class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 "><tr style=" ">
                    <th scope="col"> 번호</th>
                    <th scope="col" class="displaynone">카테고리</th>
                    <th scope="col">제목</th>
                    <th scope="col">작성자</th>
                    <th scope="col" class="">작성일</th>
                    <th scope="col" class="">조회</th>
                    <th scope="col" class="displaynone">추천</th>
                    <th scope="col" class="displaynone">평점</th>
                </tr></thead>
                <tbody class="xans-element- xans-board xans-board-notice-1002 xans-board-notice xans-board-1002 center">
                <tr style="background:#fcfcfc; color:#555555;" class="xans-record-">
                    <td> 공지</td>
                    <td class="displaynone"></td>
                    <td class="subject left txtBreak">
                        <strong> <a href="/board/free/read.html?no=18766&board_no=1" style="color:#555555;">[닥터웰메이드원 신규&구매고객 혜택 안내]</a> <span class="txtEm"></span></strong>
                    </td>
                    <td>닥터웰메이드원 공식몰</td>
                    <td class=""><span class="txtNum">2019-01-30</span></td>
                    <td class=""><span class="txtNum">616</span></td>
                    <td class="displaynone"><span class="txtNum">0</span></td>
                    <td class="displaynone"><img src="//img.echosting.cafe24.com/skin/base/board/ico_point0.gif" alt="0점"/></td>
                </tr>
                </tbody>
                <tbody class="xans-element- xans-board xans-board-list-1002 xans-board-list xans-board-1002 center">
                <tr style="background-color:#FFFFFF; color:#555555;" class="xans-record-">
                    <td> 57</td>
                    <td class="displaynone"></td>
                    <td class="subject left txtBreak">
                        <a href="/board/free/read.html?no=18779&board_no=1" style="color:#555555;">2019년 1차 회원등급 변경 안내 </a> <span class="txtEm"></span>
                    </td>
                    <td>닥터웰메이드원 공식몰</td>
                    <td class=""><span class="txtNum">2019-01-31</span></td>
                    <td class=""><span class="txtNum">2501</span></td>
                    <td class="displaynone"><span class="txtNum">0</span></td>
                    <td class="displaynone"><img src="//img.echosting.cafe24.com/skin/base/board/ico_point0.gif" alt="0점"/></td>
                </tr>
                </tbody>
            </table>
        </div>

    <div class="xans-element- xans-board xans-board-buttonlist-1002 xans-board-buttonlist xans-board-1002 button_g ">
        <div class="btnArea M b_right">
            <a href="/board/free/write.html?board_no=1" class="displaynone black_s">작성하기</a>
        </div>
    </div>


    <div class="xans-element- xans-board xans-board-paging-1002 xans-board-paging xans-board-1002 ec-base-paginate">
        <a href="?board_no=1&page=1">
            <img src="/images/logo/paging_left_arrow01.png" alt="이전 페이지"/>
        </a>
        <ol>
            <li class="xans-record-"><a href="?board_no=1&page=1" class="this">1</a></li>
            <li class="xans-record-"><a href="?board_no=1&page=2" class="other">2</a></li>
            <li class="xans-record-"><a href="?board_no=1&page=3" class="other">3</a></li>
            <li class="xans-record-"><a href="?board_no=1&page=4" class="other">4</a></li>
        </ol>
        <a href="?board_no=1&page=2" class="last">
            <img src="/images/logo/paging_right_arrow01.png" alt="다음 페이지"/>
        </a>
    </div>

</div>
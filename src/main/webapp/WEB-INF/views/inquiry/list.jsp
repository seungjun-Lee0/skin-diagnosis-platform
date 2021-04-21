<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="contents">

    <div class="titleArea">
        <h2>1:1 문의</h2>
        <p>더삼점영 피부과 1:1 문의 페이지입니다.</p>
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
                    <img src="/images/paging/search.png" />
                </button>
            </form>
        </div>
    </div>

    <div class="the3-base-table listType">
        <table border="1" summary="">
            <caption>상품 게시판 목록</caption>
            <colgroup>
                <col style="width:70px;"/>
                <col style="width:auto;"/>
                <col style="width:130px;"/>
                <col style="width:80px;"/>
                <col style="width:55px;"/>
            </colgroup>
            <thead><tr style=" ">
                <th scope="col"> 번호</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">작성일</th>
                <th scope="col">조회</th>
            </tr></thead>
            <tbody class="center">
                <tr style="background:#fcfcfc; color:#333333;">
                <td> 공지</td>
                <td class="left txtBreak">
                    <strong> <a href="/inquiry/detail" style="color:#333333;">****** 자주하는 Q&A******</a> <span class="txtEm">[1]</span></strong>
                </td>
                <td>닥터웰메이드원 공식몰</td>
                <td class=""><span class="txtNum">2019-05-09</span></td>
                <td class=""><span class="txtNum">336</span></td>
            </tr>
            </tbody>
            <tbody class="center">
                <tr style="background-color:#FFFFFF; color:#333333;">
                    <td> 748</td>
                    <td class="left txtBreak">
                        <a href="/inquiry/detail" style="color:#333333;">노세범크림 듀오크림</a> <img src="/web/upload/icon_201501032036236500.gif"  alt="비밀글" class="ec-common-rwd-image" /><span class="txtEm"></span>
                    </td>
                    <td>이****</td>
                    <td class=""><span class="txtNum">2022-02-05</span></td>
                    <td class=""><span class="txtNum">0</span></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="button_pos">
        <div class="btnArea M b_right">
            <a href="/inquiry/write" class="black_s">작성하기</a>
        </div>

    </div>
    <div class="the3-base-paginate">
        <a href="?board_no=1&page=1">
            <img src="/images/paging/paging_left_arrow01.png" alt="이전 페이지"/>
        </a>
        <ol>
            <li><a href="?board_no=1&page=1" class="this">1</a></li>
            <li><a href="?board_no=1&page=2" class="other">2</a></li>
            <li><a href="?board_no=1&page=3" class="other">3</a></li>
            <li><a href="?board_no=1&page=4" class="other">4</a></li>
        </ol>
        <a href="?board_no=1&page=2" class="last">
            <img src="/images/paging/paging_right_arrow01.png" alt="다음 페이지"/>
        </a>
    </div>

</div>
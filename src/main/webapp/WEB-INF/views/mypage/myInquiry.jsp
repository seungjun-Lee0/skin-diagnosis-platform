<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="contents">

    <div class="titleArea">
        <h2>마이페이지</h2>
    </div>


    <div>
        <h2  style="text-align: center">
            <span></span>
            님 환영합니다.
        </h2>
    </div>

    <div class="mypage">
        <div class="pageMain">
            <a href="/mypage/myInfo" class="pageMain_box">
                <h3>회원 정보</h3>
                <p>회원이신 고객님의 개인정보를 관리하는 공간입니다.</p>
            </a>
        </div>
        <div class="pageMain">
            <a href="/mypage/myDiagnosis" class="pageMain_box">
                <h3>진단결과 조회</h3>
                <p>피부진단 결과를 조회하실 수 있습니다.</p>
            </a>
        </div>
        <div class="pageMain">
            <a href="/mypage/myInquiry" class="pageMain_box mypageBtnActive">
                <h3>문의내역 조회</h3>
                <p>문의하신 내역과 답변을 확인하실 수 있습니다.</p>
            </a>
        </div>
    </div>

    <div class="mypageMainView">
        <h2 style="text-align: center; padding-top: 30px">문의내역 조회</h2>
        <div class="the3-base-table listType">
            <table border="1" summary="" style="width: 90%; margin: 50px;">
                <caption>상품 게시판 목록</caption>
                <colgroup>
                    <col style="width:70px;"/>
                    <col style="width:auto;"/>
                    <col style="width:150px;"/>
                    <col style="width:80px;"/>
                </colgroup>
                <thead><tr style=" ">
                    <th scope="col"> 번호</th>
                    <th scope="col" class="displaynone">카테고리</th>
                    <th scope="col">제목</th>
                    <th scope="col">상태</th>
                    <th scope="col" class="">작성일</th>
                </tr></thead>
                <tbody class="center">
                <tr style="background-color:#FFFFFF; color:#333333;" class="xans-record-">
                    <td> 748</td>
                    <td class="left txtBreak">
                        <a href="/board/product/read.html?no=20351&board_no=32" style="color:#333333;">노세범크림 듀오크림</a> <img src="/web/upload/icon_201501032036236500.gif"  alt="비밀글" class="ec-common-rwd-image" /><span class="txtEm"></span>
                    </td>
                    <td>답변대기</td>
                    <td class=""><span class="txtNum">2022-02-05</span></td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="the3-base-paginate">
            <a href="?board_no=1&page=1">
                <img src="/images/paging/paging_left_arrow01.png" alt="이전 페이지"/>
            </a>
            <ol>
                <li class="xans-record-"><a href="?board_no=1&page=1" class="this">1</a></li>
                <li class="xans-record-"><a href="?board_no=1&page=2" class="other">2</a></li>
                <li class="xans-record-"><a href="?board_no=1&page=3" class="other">3</a></li>
                <li class="xans-record-"><a href="?board_no=1&page=4" class="other">4</a></li>
            </ol>
            <a href="?board_no=1&page=2">
                <img src="/images/paging/paging_right_arrow01.png" alt="다음 페이지"/>
            </a>
        </div>
    </div>
</div>
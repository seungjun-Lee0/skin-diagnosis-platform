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

<c:if test="${dts eq null}">
    <script language="javascript">
        alert("정상적인 경로를 통해 다시 접근해 주세요.");
        document.location.href="/mypage/myDiagnosis?cp=1";
    </script>
</c:if>

<c:set var="c1" value="${fn:split(dts.c1,'/')}"/>
<c:set var="c2" value="${fn:split(dts.c2,'/')}"/>
<c:set var="c3" value="${fn:split(dts.c3,'/')}"/>
<c:set var="c4" value="${fn:split(dts.c4,'/')}"/>
<c:set var="c5" value="${fn:split(dts.c5,'/')}"/>
<c:set var="c6" value="${fn:split(dts.c6,'/')}"/>



<div id="contents" style="background-color:snow; border: 1px solid #ccc; padding-bottom: 40px; border-radius: 5px;">

    <ul class="breadcrumb">
        <li class="active">자가진단</li>
        <li>원인분석</li>
        <li>검사신청</li>
    </ul>
    <div class="join_title">
        <h4 class="title" style="margin-top: 0;">부위 별 피부고민</h4>
    </div>
    <div class="diagnosis-wrap">
        <div class="diagnosis-text">
            <div class="diagnosis-text-table">
                <div class="diagnosis-text-table-row">
                    <button class="btn" style="width: 150%;height: 35%;margin-left: 67%;margin-top: 80%;margin-bottom: 15%;">이마</button>

                </div>
                <div class="diagnosis-text-table-row">
                    <button class="btn" style="width: 190%;margin-left: 47%;margin-bottom: 20%;">눈주위</button>
                </div>
                <div class="diagnosis-text-table-row">
                    <div></div>
                    <div class="diagnosis-text-table-cell">
                        <button class="btn" style="width: 75%;height: 60%;margin-top: 65%;margin-left: -65%;">볼</button>
                    </div>
                    <div class="diagnosis-text-table-cell">
                        <button class="btn" style="width: 70%;height: 100%; margin-left: -65%;margin-top: 25%;margin-bottom: 60%;">코</button>
                    </div>
                    <div class="diagnosis-text-table-cell">
                        <button class="btn" style="width: 75%;height: 60%;margin-left: -65%;margin-top: 65%;">볼</button>
                    </div>
                </div>
                <div class="diagnosis-text-table-row">
                    <button class="btn" style="width: 120%;height: 50%;margin-left: 82%; margin-top: 35%;margin-bottom: 15%;">턱</button>
                </div>
            </div>
        </div>
    </div>

    <div class="join_btn">
        <a href="/mypage/myDiagnosis/detail2?dno=${param.dno}" class="btn-type-01">다음으로</a>
    </div>

    <!-- 첫 번째 Modal -->
    <div class="modal">
        <!-- 첫 번째 Modal의 내용 -->
        <div class="modal-content">
            <div class="modal-title">이마
            </div>
                <table class="table">
                <thead>
                    <tr class="tr">
                        <td style="text-align: center">항목</td>
                        <td width="210px"></td>
                        <td width="210px"></td>
                        <td width="210px"></td>
                        <td width="210px"></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="text-align: center">여드름</td>
                        <td>여드름이 안나게 해주세요<input class="skin" type="checkbox" id="c1_1" <c:if test="${c1[0] eq 1}">checked</c:if> /></td>
                        <td>여드름 자국을 없애주세요<input class="skin" type="checkbox" id="c1_2" <c:if test="${c1[1] eq 1}">checked</c:if> /></td>
                        <td>여드름 흉터를 재생시켜주세요.<input class="skin" type="checkbox" id="c1_3" <c:if test="${c1[2] eq 1}">checked</c:if> /></td>
                        <td>모공을 작아지게 해주세요<input class="skin" type="checkbox" id="c1_4" <c:if test="${c1[3] eq 1}">checked</c:if> /></td>
                    </tr>
                    <tr>
                        <td style="text-align: center">색소</td>
                        <td>홍조를 줄여주세요<input class="skin" type="checkbox" id="c1_5" <c:if test="${c1[4] eq 1}">checked</c:if> /></td>
                        <td>피부톤을 환하게 해주세요<input class="skin" type="checkbox" id="c1_6" <c:if test="${c1[5] eq 1}">checked</c:if> /></td>
                        <td>잡티를 없애주세요<input class="skin" type="checkbox" id="c1_7" <c:if test="${c1[6] eq 1}">checked</c:if> /></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="text-align: center">노화</td>
                        <td>탱탱한 피부를 갖게 해주세요<input class="skin" type="checkbox" id="c1_8" <c:if test="${c1[7] eq 1}">checked</c:if> /></td>
                        <td>주름을 없애 주세요<input class="skin" type="checkbox" id="c1_9" <c:if test="${c1[8] eq 1}">checked</c:if> /></td>
                        <td>리프팅을 해주세요<input class="skin" type="checkbox" id="c1_10" <c:if test="${c1[9] eq 1}">checked</c:if> /></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <div class="button_pos" style="margin-bottom: 0">
                <div class="btnArea M b_center">
                    <a class="close black_s" >확인</a>
                </div>
            </div>
        </div>
    </div>

    <!-- 두 번째 Modal -->
    <div class="modal">
        <div class="modal-content">
            <div class="modal-title">눈 주위
            </div>
            <table class="table">
                <thead>
                <tr class="tr">
                    <td style="text-align: center">항목</td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td style="text-align: center">여드름</td>
                    <td>여드름이 안나게 해주세요<input class="skin" type="checkbox" id="c2_1" <c:if test="${c2[0] eq 1}">checked</c:if> /></td>
                    <td>여드름 자국을 없애주세요<input class="skin" type="checkbox" id="c2_2" <c:if test="${c2[1] eq 1}">checked</c:if> /></td>
                    <td>여드름 흉터를 재생시켜주세요.<input class="skin" type="checkbox" id="c2_3" <c:if test="${c2[2] eq 1}">checked</c:if>/></td>
                    <td>모공을 작아지게 해주세요<input class="skin" type="checkbox" id="c2_4" <c:if test="${c2[3] eq 1}">checked</c:if>/></td>
                </tr>
                <tr>
                    <td style="text-align: center">색소</td>
                    <td>홍조를 줄여주세요<input class="skin" type="checkbox" id="c2_5" <c:if test="${c2[4] eq 1}">checked</c:if>/></td>
                    <td>피부톤을 환하게 해주세요<input class="skin" type="checkbox" id="c2_6" <c:if test="${c2[5] eq 1}">checked</c:if>/></td>
                    <td>잡티를 없애주세요<input class="skin" type="checkbox" id="c2_7" <c:if test="${c2[6] eq 1}">checked</c:if>/></td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: center">노화</td>
                    <td>탱탱한 피부를 갖게 해주세요<input class="skin" type="checkbox" id="c2_8" <c:if test="${c2[7] eq 1}">checked</c:if>/></td>
                    <td>주름을 없애 주세요<input class="skin" type="checkbox" id="c2_9" <c:if test="${c2[8] eq 1}">checked</c:if>/></td>
                    <td>리프팅을 해주세요<input class="skin" type="checkbox" id="c2_10" <c:if test="${c2[9] eq 1}">checked</c:if>/></td>
                    <td></td>
                </tr>
                </tbody>
            </table>
            <div class="button_pos" style="margin-bottom: 0">
                <div class="btnArea M b_center">
                    <a class="close black_s" >확인</a>
                </div>
            </div>
        </div>
    </div>

    <!-- 세 번째 Modal -->
    <div class="modal">
        <div class="modal-content">
            <div class="modal-title">오른쪽 볼
            </div>
            <table class="table">
                <thead>
                <tr class="tr">
                    <td style="text-align: center">항목</td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td style="text-align: center">여드름</td>
                    <td>여드름이 안나게 해주세요<input class="skin" type="checkbox" id="c3_1" <c:if test="${c3[0] eq 1}">checked</c:if> /></td>
                    <td>여드름 자국을 없애주세요<input class="skin" type="checkbox" id="c3_2" <c:if test="${c3[1] eq 1}">checked</c:if>/></td>
                    <td>여드름 흉터를 재생시켜주세요.<input class="skin" type="checkbox" id="c3_3" <c:if test="${c3[2] eq 1}">checked</c:if>/></td>
                    <td>모공을 작아지게 해주세요<input class="skin" type="checkbox" id="c3_4" <c:if test="${c3[3] eq 1}">checked</c:if>/></td>
                </tr>
                <tr>
                    <td style="text-align: center">색소</td>
                    <td>홍조를 줄여주세요<input class="skin" type="checkbox" id="c3_5" <c:if test="${c3[4] eq 1}">checked</c:if>/></td>
                    <td>피부톤을 환하게 해주세요<input class="skin" type="checkbox" id="c3_6" <c:if test="${c3[5] eq 1}">checked</c:if>/></td>
                    <td>잡티를 없애주세요<input class="skin" type="checkbox" id="c3_7" <c:if test="${c3[6] eq 1}">checked</c:if>/></td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: center">노화</td>
                    <td>탱탱한 피부를 갖게 해주세요<input class="skin" type="checkbox" id="c3_8" <c:if test="${c3[7] eq 1}">checked</c:if>/></td>
                    <td>주름을 없애 주세요<input class="skin" type="checkbox" id="c3_9" <c:if test="${c3[8] eq 1}">checked</c:if>/></td>
                    <td>리프팅을 해주세요<input class="skin" type="checkbox" id="c3_10" <c:if test="${c3[9] eq 1}">checked</c:if>/></td>
                    <td></td>
                </tr>
                </tbody>
            </table>
            <div class="button_pos" style="margin-bottom: 0">
                <div class="btnArea M b_center">
                    <a class="close black_s" >확인</a>
                </div>
            </div>
        </div>
    </div>

    <!-- 네 번째 Modal -->
    <div class="modal">
        <div class="modal-content">
            <div class="modal-title">코
            </div>
            <table class="table">
                <thead>
                <tr class="tr">
                    <td style="text-align: center">항목</td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td style="text-align: center">여드름</td>
                    <td>여드름이 안나게 해주세요<input class="skin" type="checkbox" id="c4_1" <c:if test="${c4[0] eq 1}">checked</c:if>/></td>
                    <td>여드름 자국을 없애주세요<input class="skin" type="checkbox" id="c4_2" <c:if test="${c4[1] eq 1}">checked</c:if>/></td>
                    <td>여드름 흉터를 재생시켜주세요.<input class="skin" type="checkbox" id="c4_3" <c:if test="${c4[2] eq 1}">checked</c:if>/></td>
                    <td>모공을 작아지게 해주세요<input class="skin" type="checkbox" id="c4_4" <c:if test="${c4[3] eq 1}">checked</c:if>/></td>
                </tr>
                <tr>
                    <td style="text-align: center">색소</td>
                    <td>홍조를 줄여주세요<input class="skin" type="checkbox" id="c4_5" <c:if test="${c4[4] eq 1}">checked</c:if>/></td>
                    <td>피부톤을 환하게 해주세요<input class="skin" type="checkbox" id="c4_6" <c:if test="${c4[5] eq 1}">checked</c:if>/></td>
                    <td>잡티를 없애주세요<input class="skin" type="checkbox" id="c4_7" <c:if test="${c4[6] eq 1}">checked</c:if>/></td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: center">노화</td>
                    <td>탱탱한 피부를 갖게 해주세요<input class="skin" type="checkbox" id="c4_8" <c:if test="${c4[7] eq 1}">checked</c:if>/></td>
                    <td>주름을 없애 주세요<input class="skin" type="checkbox" id="c4_9" <c:if test="${c4[8] eq 1}">checked</c:if>/></td>
                    <td>리프팅을 해주세요<input class="skin" type="checkbox" id="c4_10" <c:if test="${c4[9] eq 1}">checked</c:if>/></td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: center">기타</td>
                    <td>코의 블랙헤드를 좋아지게 해주세요<input class="skin" type="checkbox" name="c4_11" <c:if test="${c4[10] eq 1}">checked</c:if>/></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                </tbody>
            </table>
            <div class="button_pos" style="margin-bottom: 0">
                <div class="btnArea M b_center">
                    <a class="close black_s" >확인</a>
                </div>
            </div>
        </div>
    </div>

    <!-- 다섯 번째 Modal -->
    <div class="modal">
        <!-- 첫 번째 Modal의 내용 -->
        <div class="modal-content">
            <div class="modal-title">왼쪽 볼
            </div>
            <table class="table">
                <thead>
                <tr class="tr">
                    <td style="text-align: center">항목</td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td style="text-align: center">여드름</td>
                    <td>여드름이 안나게 해주세요<input class="skin" type="checkbox" id="c5_1" <c:if test="${c5[0] eq 1}">checked</c:if>/></td>
                    <td>여드름 자국을 없애주세요<input class="skin" type="checkbox" id="c5_2" <c:if test="${c5[1] eq 1}">checked</c:if>/></td>
                    <td>여드름 흉터를 재생시켜주세요.<input class="skin" type="checkbox" id="c5_3" <c:if test="${c5[2] eq 1}">checked</c:if>/></td>
                    <td>모공을 작아지게 해주세요<input class="skin" type="checkbox" id="c5_4" <c:if test="${c5[3] eq 1}">checked</c:if>/></td>
                </tr>
                <tr>
                    <td style="text-align: center">색소</td>
                    <td>홍조를 줄여주세요<input class="skin" type="checkbox" id="c5_5" <c:if test="${c5[4] eq 1}">checked</c:if>/></td>
                    <td>피부톤을 환하게 해주세요<input class="skin" type="checkbox" id="c5_6" <c:if test="${c5[5] eq 1}">checked</c:if>/></td>
                    <td>잡티를 없애주세요<input class="skin" type="checkbox" id="c5_7" <c:if test="${c5[6] eq 1}">checked</c:if>/></td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: center">노화</td>
                    <td>탱탱한 피부를 갖게 해주세요<input class="skin" type="checkbox" id="c5_8" <c:if test="${c5[7] eq 1}">checked</c:if>/></td>
                    <td>주름을 없애 주세요<input class="skin" type="checkbox" id="c5_9" <c:if test="${c5[8] eq 1}">checked</c:if>/></td>
                    <td>리프팅을 해주세요<input class="skin" type="checkbox" id="c5_10" <c:if test="${c5[9] eq 1}">checked</c:if>/></td>
                    <td></td>
                </tr>
                </tbody>
            </table>
            <div class="button_pos" style="margin-bottom: 0">
                <div class="btnArea M b_center">
                    <a class="close black_s" >확인</a>
                </div>
            </div>
        </div>
    </div>

    <!-- 여섯 번째 Modal -->
    <div class="modal">
        <div class="modal-content">
            <div class="modal-title">턱
            </div>
            <table class="table">
                <thead>
                <tr class="tr">
                    <td style="text-align: center">항목</td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                    <td width="210px"></td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td style="text-align: center">여드름</td>
                    <td>여드름이 안나게 해주세요<input class="skin" type="checkbox" id="c6_1" <c:if test="${c6[0] eq 1}">checked</c:if>/></td>
                    <td>여드름 자국을 없애주세요<input class="skin" type="checkbox" id="c6_2" <c:if test="${c6[1] eq 1}">checked</c:if>/></td>
                    <td>여드름 흉터를 재생시켜주세요.<input class="skin" type="checkbox" id="c6_3" <c:if test="${c6[2] eq 1}">checked</c:if>/></td>
                    <td>모공을 작아지게 해주세요<input class="skin" type="checkbox" id="c6_4" <c:if test="${c6[3] eq 1}">checked</c:if>/></td>
                </tr>
                <tr>
                    <td style="text-align: center">색소</td>
                    <td>홍조를 줄여주세요<input class="skin" type="checkbox" id="c6_5" <c:if test="${c6[4] eq 1}">checked</c:if>/></td>
                    <td>피부톤을 환하게 해주세요<input class="skin" type="checkbox" id="c6_6" <c:if test="${c6[5] eq 1}">checked</c:if>/></td>
                    <td>잡티를 없애주세요<input class="skin" type="checkbox" id="c6_7" <c:if test="${c6[6] eq 1}">checked</c:if>/></td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: center">노화</td>
                    <td>탱탱한 피부를 갖게 해주세요<input class="skin" type="checkbox" id="c6_8" <c:if test="${c6[7] eq 1}">checked</c:if>/></td>
                    <td>주름을 없애 주세요<input class="skin" type="checkbox" id="c6_9" <c:if test="${c6[8] eq 1}">checked</c:if> /></td>
                    <td>리프팅을 해주세요<input class="skin" type="checkbox" id="c6_10" <c:if test="${c6[9] eq 1}">checked</c:if>/></td>
                    <td></td>
                </tr>
                </tbody>
            </table>
            <div class="button_pos" style="margin-bottom: 0">
                <div class="btnArea M b_center">
                    <a class="close black_s" >확인</a>
                </div>
            </div>
        </div>
    </div>
</div>
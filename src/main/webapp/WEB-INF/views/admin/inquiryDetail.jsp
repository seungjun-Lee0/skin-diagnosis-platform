<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="section8">
    <div class="comm_wrap2">
        <div class="cetnerDiv wow fadeInUp top" data-wow-delay="0.1s">
            <div class="adminTitle">환자 데이터 조회 및 저장</div>
        </div>
        <div class="flex">
            <div class="adminModal">
                <div class="adminModalContent">
                    <div class="adminModalTitle">
						<c:if test="${adTs.type eq 'C'}">측정 수치</c:if>
                        <c:if test="${adTs.type eq 'V'}">진동자 치료 수치</c:if>
                        <c:if test="${adTs.type eq 'I'}">이온전극 치료 수치</c:if>
                        <c:if test="${adTs.type eq 'T'}">T.E.N.S 치료 수치</c:if>
                        <c:if test="${adTs.type eq 'L'}">라이트닝 치료 수치</c:if>
					</div>
                    <div class="adminInquiryInfo">
                        성함 : ${adTs.uname} |
                        생년월일 : ${adTs.ubdate} |
                        측정날짜 : ${fn:substring(adTs.regdate, 0, 10)}
                        <span class="btnArea M b_center" style="float: right; width: 22%; max-width: 80px">
                            <a href="/admin/inquiry?cp=1" class="close custom_s">이전</a>
                        </span>
                    </div>
                    <c:if test="${adTs.type eq 'C'}">
                    <table class="table">
                        <thead>
                        <tr class="tr">
                            <td style="text-align: center;">항목</td>
                            <td style="width: 22%"></td>
                            <td style="width: 22%"></td>
                            <td style="width: 22%"></td>
                            <td style="width: 22%"></td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td style="text-align: center">피부 두께</td>
                            <td>
                                PD1 :<input type="text" maxlength="4" txtlimit="5" class="adminInput" value="${adTs.pd1}" readonly>
                            </td>
                            <td>
                                PD2 :<input type="text" maxlength="4" txtlimit="5" class="adminInput" value="${adTs.pd2}" readonly>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: center">피부 탄성도</td>
                            <td>
                                주파수 :<input type="text" maxlength="4" class="adminInput" value="${adTs.hz}" readonly>
                            </td>
                            <td>
                                S1 :<input type="text" maxlength="4" class="adminInput" value="${adTs.s1}" readonly>
                            <td>
                                S2 :<input type="text" maxlength="4" class="adminInput" value="${adTs.s2}" readonly>
                            </td>
                            <td>
                                S3 :<input type="text" maxlength="4" class="adminInput" value="${adTs.s3}" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">피부 수분도</td>
                            <td>
                                수분도 :<input type="text" maxlength="4" class="adminInput" value="${adTs.moistureLev}" readonly>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: center">측정 결과</td>
                            <td>
                                두께 :<input type="text" maxlength="4" class="adminInput" value="${adTs.thicknessRes}" readonly>
                            </td>
                            <td>
                                탄성도 :<input type="text" maxlength="4" class="adminInput" value="${adTs.elasticityRes}" readonly>
                            </td>
                            <td>
                                수분도 :<input type="text" maxlength="4" class="adminInput" value="${adTs.moistureLevRes}" readonly>
                            </td>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>
                    </c:if>
                    <c:if test="${adTs.type eq 'V'}">
                    <table class="table">
                        <thead>
                        <tr class="tr">
                            <td style="text-align: center;">항목</td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td style="text-align: center">모드</td>
                            <td>
                                M1<input type="radio" name="mode" id="m1" class="radioBtnRight" <c:if test="${adTs.vMode eq 'm1'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                M2<input type="radio" name="mode" id="m2" class="radioBtnRight" <c:if test="${adTs.vMode eq 'm2'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                M3<input type="radio" name="mode" id="m3" class="radioBtnRight" <c:if test="${adTs.vMode eq 'm3'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                M4<input type="radio" name="mode" id="m4" class="radioBtnRight" <c:if test="${adTs.vMode eq 'm4'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                M5<input type="radio" name="mode" id="m5" class="radioBtnRight" <c:if test="${adTs.vMode eq 'm5'}">checked</c:if> onclick="return(false);">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">감도</td>
                            <td>
                                1<input type="radio" name="intensity" id="i1" class="radioBtnRight" <c:if test="${adTs.vSensitivity eq '1'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                2<input type="radio" name="intensity" id="i2" class="radioBtnRight" <c:if test="${adTs.vSensitivity eq '2'}">checked</c:if> onclick="return(false);">
                            <td>
                                3<input type="radio" name="intensity" id="i3" class="radioBtnRight" <c:if test="${adTs.vSensitivity eq '3'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                4<input type="radio" name="intensity" id="i4" class="radioBtnRight" <c:if test="${adTs.vSensitivity eq '4'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                5<input type="radio" name="intensity" id="i5" class="radioBtnRight" <c:if test="${adTs.vSensitivity eq '5'}">checked</c:if> onclick="return(false);">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">시간</td>
                            <td>
                                5<input type="radio" name="time" id="t1" class="radioBtnRight" <c:if test="${adTs.vTime eq '5'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                10<input type="radio" name="time" id="t2" class="radioBtnRight" <c:if test="${adTs.vTime eq '10'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                15<input type="radio" name="time" id="t3" class="radioBtnRight" <c:if test="${adTs.vTime eq '15'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                20<input type="radio" name="time" id="t4" class="radioBtnRight" <c:if test="${adTs.vTime eq '20'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                30<input type="radio" name="time" id="t5" class="radioBtnRight" <c:if test="${adTs.vTime eq '30'}">checked</c:if> onclick="return(false);">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">주파수</td>
                            <td colspan="5">
                                <input style="height: 20px; width: 50px;" type="text" maxlength="4" class="" value="${adTs.vHz}" readonly>&nbsp;HZ
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    </c:if>
                    <c:if test="${adTs.type eq 'I'}">
                    <table class="table">
                        <thead>
                        <tr class="tr">
                            <td style="text-align: center;">항목</td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td style="text-align: center">시간</td>
                            <td>
                                5<input type="radio" name="time" id="t1" class="radioBtnRight" <c:if test="${adTs.iTime eq '5'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                10<input type="radio" name="time" id="t2" class="radioBtnRight" <c:if test="${adTs.iTime eq '10'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                15<input type="radio" name="time" id="t3" class="radioBtnRight" <c:if test="${adTs.iTime eq '15'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                20<input type="radio" name="time" id="t4" class="radioBtnRight" <c:if test="${adTs.iTime eq '20'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                30<input type="radio" name="time" id="t5" class="radioBtnRight" <c:if test="${adTs.iTime eq '30'}">checked</c:if> onclick="return(false);">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">전류</td>
                            <td colspan="5">
                                <input style="height: 20px; width: 50px;" type="text" maxlength="4" class="" value="${adTs.iCurrent}" readonly>&nbsp;uA
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    </c:if>
                    <c:if test="${adTs.type eq 'T'}">
                    <table class="table">
                        <thead>
                        <tr class="tr">
                            <td style="text-align: center;">항목</td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td style="text-align: center">시간</td>
                            <td>
                                5<input type="radio" name="time" id="t1" class="radioBtnRight" <c:if test="${adTs.tTime eq '5'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                10<input type="radio" name="time" id="t2" class="radioBtnRight" <c:if test="${adTs.tTime eq '10'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                15<input type="radio" name="time" id="t3" class="radioBtnRight" <c:if test="${adTs.tTime eq '15'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                20<input type="radio" name="time" id="t4" class="radioBtnRight" <c:if test="${adTs.tTime eq '20'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                30<input type="radio" name="time" id="t5" class="radioBtnRight" <c:if test="${adTs.tTime eq '30'}">checked</c:if> onclick="return(false);">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">전압</td>
                            <td colspan="5">
                                <input style="height: 20px; width: 50px;" type="text" maxlength="4" class="" value="${adTs.tVoltage}" readonly>&nbsp;V
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">주파수</td>
                            <td colspan="5">
                                <input style="height: 20px; width: 50px;" type="text" maxlength="4" class="" value="${adTs.tHz}" readonly>&nbsp;HZ
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    </c:if>
                    <c:if test="${adTs.type eq 'L'}">
                    <table class="table">
                        <thead>
                        <tr class="tr">
                            <td style="text-align: center;">항목</td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                            <td style="width: 18%"></td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td style="text-align: center">모드</td>
                            <td>
                                M1<input type="radio" name="mode" id="m1" class="radioBtnRight" <c:if test="${adTs.lMode eq 'm1'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                M2<input type="radio" name="mode" id="m2" class="radioBtnRight" <c:if test="${adTs.lMode eq 'm2'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                M3<input type="radio" name="mode" id="m3" class="radioBtnRight" <c:if test="${adTs.lMode eq 'm3'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: center">밝기</td>
                            <td>
                                1<input type="radio" name="bright" id="b1" class="radioBtnRight" <c:if test="${adTs.lBrightness eq '1'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                2<input type="radio" name="bright" id="b2" class="radioBtnRight" <c:if test="${adTs.lBrightness eq '2'}">checked</c:if> onclick="return(false);">
                            <td>
                                3<input type="radio" name="bright" id="b3" class="radioBtnRight" <c:if test="${adTs.lBrightness eq '3'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                4<input type="radio" name="bright" id="b4" class="radioBtnRight" <c:if test="${adTs.lBrightness eq '4'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                5<input type="radio" name="bright" id="b5" class="radioBtnRight" <c:if test="${adTs.lBrightness eq '5'}">checked</c:if> onclick="return(false);">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">시간</td>
                            <td>
                                5<input type="radio" name="time" id="t1" class="radioBtnRight" <c:if test="${adTs.lTime eq '5'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                10<input type="radio" name="time" id="t2" class="radioBtnRight" <c:if test="${adTs.lTime eq '10'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                15<input type="radio" name="time" id="t3" class="radioBtnRight" <c:if test="${adTs.lTime eq '15'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                20<input type="radio" name="time" id="t4" class="radioBtnRight" <c:if test="${adTs.lTime eq '20'}">checked</c:if> onclick="return(false);">
                            </td>
                            <td>
                                30<input type="radio" name="time" id="t5" class="radioBtnRight" <c:if test="${adTs.lTime eq '30'}">checked</c:if> onclick="return(false);">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">주파수</td>
                            <td colspan="5">
                                <input style="height: 20px; width: 50px;" type="text" maxlength="4" class="" value="${adTs.lHz}" readonly>&nbsp;HZ
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    </c:if>

                    <div class="adminButton_pos">
                        <div class="btnArea M b_right">
                            <a id="adminInquiryDeleteBtn" class="close black_s" >삭제</a>

                            <form id="adminInquiryDeleteFrm" name="adminInquiryDeleteFrm">
                                <input type="hidden" id="adno" name="adno" value="${adTs.adno}">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="right wow fadeInDown" data-wow-delay="0.2s">
                <div class="adminPage">
                    <div class="adminPageMain">
                        <a href="/admin/inquiry?cp=1" class="adminPageMain_box adminPageBtnActive">
                            <h3>조회</h3>
                            <p>환자의 피부 측정값과<br>치료 내용을 조회합니다.</p>
                        </a>
                    </div>
                    <div class="adminPageMain">
                        <a href="/admin/cureMain" class="adminPageMain_box">
                            <h3>치료</h3>
                            <p>치료 내용을 저장합니다.</p>
                        </a>
                    </div>
					<div class="adminPageMain">
                        <a href="/admin/main" class="adminPageMain_box">
                            <h3>측정</h3>
                            <p>진단을 통한 측정값을<br>저장합니다.</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


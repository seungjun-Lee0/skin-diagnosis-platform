<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<c:if test="${dts eq null}">
    <script language="javascript">
        alert("정상적인 경로를 통해 다시 접근해 주세요.");
        document.location.href="/mypage/myDiagnosis?cp=1";
    </script>
</c:if>

<c:set var="baseURL" value="${pageContext.request.contextPath}/images/downloadedImages/diagnosis/" />
<c:set var="fnames" value="${fn:split(dts.fnames,'/')}"/>
<c:set var="s1" value="${fn:split(dts.s1,'/')}"/>
<c:set var="s2" value="${fn:split(dts.s2,'/')}"/>
<c:set var="s3" value="${fn:split(dts.s3,'/')}"/>
<c:set var="s4" value="${fn:split(dts.s4,'/')}"/>
<c:set var="s5" value="${fn:split(dts.s5,'/')}"/>
<c:set var="s6" value="${fn:split(dts.s6,'/')}"/>
<c:set var="s7" value="${fn:split(dts.s7,'/')}"/>
<c:set var="s8" value="${fn:split(dts.s8,'/')}"/>
<c:set var="s9" value="${fn:split(dts.s9,'/')}"/>
<c:set var="s10" value="${fn:split(dts.s10,'/')}"/>
<c:set var="s11" value="${fn:split(dts.s11,'/')}"/>
<c:set var="s12" value="${fn:split(dts.s12,'/')}"/>

<div id="contents" style="background-color:snow; border: 1px solid #ccc; padding-bottom: 40px; border-radius: 5px; width: calc(60% - 80px)">
    <ul class="breadcrumb">
        <li>자가진단</li>
        <li class="active">원인분석</li>
        <li>검사신청</li>
    </ul>

    <div class="join_title">
        <h4 class="title" style="margin-top: 0;">원인진단 설문지</h4>
    </div>

    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>아침에 사용하는 세안제는 무엇입니까?(중복선택가능)</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
                <span class="diagnosis-radio">
                    <input class="skin" type="checkbox" id="s1_1" value="1" <c:if test="${s1[0] eq 1}">checked</c:if>/></td>
                </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>오일 클렌저</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s1_2" value="2" <c:if test="${s1[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>폼 클렌저</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s1_3" value="3" <c:if test="${s1[2] eq 1}">checked</c:if> /></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>비누</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s1_4" value="4" <c:if test="${s1[3] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>효소세안</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s1_5" value="5" <c:if test="${s1[4] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>물세안</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>저녁에 사용하는 세안제는 무엇입니까(중복선택가능)</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
                <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s2_1" value="1" <c:if test="${s2[0] eq 1}">checked</c:if>/></td>
                </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>오일 클렌저</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s2_2" value="2" <c:if test="${s2[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>폼 클렌저</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s2_3" value="3" <c:if test="${s2[2] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>비누</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s2_4" value="4" <c:if test="${s2[3] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>효소세안</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s2_5" value="5" <c:if test="${s2[4] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>물세안</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>아침(외출전) : 현재 피부 관리를 위해 하고 계신 화장품을 선택</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
                <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_1" value="1" <c:if test="${s3[0] eq 1}">checked</c:if>/></td>
                </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>토너</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_2" value="2" <c:if test="${s3[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>에센스</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_3" value="3" <c:if test="${s3[2] eq 1}">checked</c:if>></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>로션</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_4" value="4" <c:if test="${s3[3] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>보습제</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_5" value="5" <c:if test="${s3[4] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>엠플</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_6" value="6" <c:if test="${s3[5] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>미스트</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_7" value="7" <c:if test="${s3[6] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>파운데이션</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_8" value="8" <c:if test="${s3[7] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>비비크림</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_9" value="9" <c:if test="${s3[8] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>선크림</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_10" value="10" <c:if test="${s3[9] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>컨실러</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_11" value="11" <c:if test="${s3[10] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>팩트</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s3_12" value="12" <c:if test="${s3[11] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>오일</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="etc1" value="13" <c:if test="${s3[12] ne null}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>기타<span style="margin: 0 10px;">
                        (<input type="text" id="s3_13" style="height: 18px; background: transparent; border-top: none; border-right: none; border-left: none; text-indent: 0;" <c:if test="${s3[12] ne null}">value="${s3[12]}"</c:if> readonly>)
                    </span></p>
                </div>

            </li>
        </ul>
    </div>
    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>저녁(귀가,화장 지운후 ) : 현재 피부 관리를 위해 하고 계신 화장품을 선택해 주세요.</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
                <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_1" value="1" <c:if test="${s4[0] eq 1}">checked</c:if>/></td>
                </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>토너</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_2" value="2" <c:if test="${s4[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>에센스</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_3" value="3" <c:if test="${s4[2] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>로션</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_4" value="4" <c:if test="${s4[3] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>보습제</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_5" value="5" <c:if test="${s4[4] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>엠플</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_6" value="6" <c:if test="${s4[5] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>미스트</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_7" value="7" <c:if test="${s4[6] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>파운데이션</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_8" value="8" <c:if test="${s4[7] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>비비크림</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_9" value="9" <c:if test="${s4[8] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>선크림</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_10" value="10" <c:if test="${s4[9] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>컨실러</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_11" value="11" <c:if test="${s4[10] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>팩트</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="s4_12" value="12" <c:if test="${s4[11] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>오일</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="checkbox" id="etc2" value="13" <c:if test="${s4[12] ne null}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>기타<span style="margin: 0 10px;">
                        (<input type="text" id="s4_13" style="height: 18px; background: transparent; border-top: none; border-right: none; border-left: none; text-indent: 0;" <c:if test="${s4[12] ne null}">value="${s3[12]}"</c:if> readonly>)
                    </span></p>
                </div>
            </li>
        </ul>
    </div>
    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>세안 시 세안 방법을 선택해주세요</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
                <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s5_1" name="s5_" value="1" <c:if test="${s5[0] eq 1}">checked</c:if>/></td>
                </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>코를 포함, 모공에 보이는 피지까지 완벽하게 제거하려고 한다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s5_2" name="s5_" value="2" <c:if test="${s5[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>손으로 만졌을 때 뽀드득 소리가 날 정도로 닦아 내려고 한다.&nbsp;&nbsp;</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width: 100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s5_3" name="s5_" value="3" <c:if test="${s5[2] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>적당히 닦아 낸다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s5_4" name="s5_" value="4" <c:if test="${s5[3] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>자극이 없게 살살 조심스럽게 닦아 내려고 한다.</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>세안 시 물의 온도는 어떻게 선택하십니까?</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
                <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s6_1" name="s6_" value="1" <c:if test="${s6[0] eq 1}">checked</c:if>/></td>
                </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>따뜻한 물로만 세안한다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s6_2" name="s6_" value="2" <c:if test="${s6[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>따뜻한 물로 했다가 찬물로 행군다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s6_3" name="s6_" value="3" <c:if test="${s6[2] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>찬물만 사용한다.</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>세안 시 소요 시간은?</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
                <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s7_1" name="s7_" value="1" <c:if test="${s7[0] eq 1}">checked</c:if>/></td>
                </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>1분 이내</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s7_2" name="s7_" value="2" <c:if test="${s7[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>1~3분</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s7_3" name="s7_" value="3" <c:if test="${s7[2] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>3~5분</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s7_4" name="s7_" value="4" <c:if test="${s7[3] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>5분 이상</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>각질이 생길 때 어떻게 직접 관리하고 계십니까?</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
                <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s8_1" name="s8_" value="1" <c:if test="${s8[0] eq 1}">checked</c:if>/></td>
                </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>각질 제거는 안 하는 것이 좋다고 해서 그냥 둔다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s8_2" name="s8_" value="2" <c:if test="${s8[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>손으로 살짝 벗긴다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s8_3" name="s8_" value="3" <c:if test="${s8[2] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>약이나 AHA등이 포함된 화장품을 써서 녹인다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s8_4" name="s8_" value="4" <c:if test="${s8[3] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>스크럽제나 초음파 필링기를 써서 물리적으로 벗겨낸다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s8_5" name="s8_" value="5" <c:if test="${s8[4] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>직접하는 것은 없지만 종종 병원이나 관리실을 찾아 각질 제거(필링) 받는다.</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>피지 관리를 주로 어떻게 하십니까?</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
                <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s9_1" name="s9_" value="1" <c:if test="${s9[0] eq 1}">checked</c:if>/></td>
                </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>그냥 놔둔다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s9_2" name="s9_" value="2" <c:if test="${s9[0] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>세안할 때 손으로 몇 개 짠다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s9_3" name="s9_" value="3" <c:if test="${s9[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>피지 발견하면 바로 짠다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s9_4" name="s9_" value="4" <c:if test="${s9[2] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>정기적으로 스크럽제와 코팩 등을 이용하여 집에서 깨끗하게 제거한다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s9_5" name="s9_" value="5" <c:if test="${s9[3] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>정기적으로 약물(AHA, 그 밖의 과일산 성분등)을 이용하여 집에서 녹인다.</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice" style="width:100%">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s9_6" name="s9_" value="6" <c:if test="${s9[4] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>정기적으로 병원에서 케어를 받는다.</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>샴푸를 헹굴 때 샴푸 물이 얼굴이나 턱에 한번이라도 닿습니까?</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s10_1" name="s10_" value="1" <c:if test="${s10[0] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>예</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s10_2" name="s10_" value="2" <c:if test="${s10[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>아니요</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>샴푸를 헹굴 때 샴푸 물이 등이나 가슴에 닿습니까?</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s11_1" name="s11_" value="1" <c:if test="${s11[0] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>예</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s11_2" name="s11_" value="2" <c:if test="${s11[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>아니요</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div>
                <p>샴푸를 머리에 묻히고 완전히 행구어 내는데 걸리는 시간이 얼마나 걸리나요?</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice">
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s12_1" name="s12_" value="1" <c:if test="${s12[0] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>1분 이내</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s12_2" name="s12_" value="2" <c:if test="${s12[1] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>1~3분</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s12_3" name="s12_" value="3" <c:if test="${s12[2] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>3~5분</p>
                </div>
            </li>
            <li class="select-one-and-many diagnosis-style-mutiplechoice">
            <span class="diagnosis-radio">
                <input class="skin" type="radio" id="s12_4" name="s12_" value="4" <c:if test="${s12[3] eq 1}">checked</c:if>/></td>
            </span>
                <div class="diagnosis-style-mutiplechoice-text">
                    <p>5분 이상</p>
                </div>
            </li>
        </ul>
    </div>

    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum" style="float: left">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div style="padding-bottom: 5%;">
                <p>정면 사진을 제출해주세요</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice" style="text-align: center">
            <c:set var="pos" value="${fn:indexOf(fnames[0],'.')}" />
            <c:set var="fname" value="${fn:substring(fnames[0], 0, pos)}" />
            <c:set var="fext" value="${fn:substring(fnames[0], pos+1, fn:length(fnames[0]))}" />
            <c:if test="${fname ne '-'}">
                <img src="${baseURL}${fname}${dts.uuid}.${fext}" style="width: 30%">
            </c:if>
        </ul>
    </div>

    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum" style="float: left">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div style="padding-bottom: 5%;">
                <p>측면 사진을 제출해주세요 (오른쪽)</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice" style="text-align: center">
            <c:set var="pos" value="${fn:indexOf(fnames[1],'.')}" />
            <c:set var="fname" value="${fn:substring(fnames[1], 0, pos)}" />
            <c:set var="fext" value="${fn:substring(fnames[1], pos+1, fn:length(fnames[1]))}" />
            <c:if test="${fname ne '-'}">
                <img src="${baseURL}${fname}${dts.uuid}.${fext}" style="width: 30%">
            </c:if>
        </ul>
    </div>

    <div class="diagnosis-choice-wrapper js-question js-block-1 number-type-nonum" style="float: left">
        <div class="diagnosis-question-wrapper">
            <span class="diagnosis-question-number diagnosis-style-question-number">
                <span class="diagnosis-icon-required">*</span>
            </span>
            <div style="padding-bottom: 5%;">
                <p>측면 사진을 제출해주세요 (왼쪽)</p>
            </div>
        </div>
        <ul class="diagnosis-pv-choice-wrapper js-choice multiplechoice" style="text-align: center">
            <c:set var="pos" value="${fn:indexOf(fnames[2],'.')}" />
            <c:set var="fname" value="${fn:substring(fnames[2], 0, pos)}" />
            <c:set var="fext" value="${fn:substring(fnames[2], pos+1, fn:length(fnames[2]))}" />
            <c:if test="${fname ne '-'}">
                <img src="${baseURL}${fname}${dts.uuid}.${fext}" style="width: 30%">
            </c:if>
        </ul>
    </div>

    <div style="clear: both"></div>

    <div class="join_btn" style="margin-top: 50px;">
        <a href="/mypage/myDiagnosis" class="btn-type-01">목록보기</a>
    </div>
</div>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="section8">
    <div class="comm_wrap2">
        <div class="cetnerDiv wow fadeInUp top" data-wow-delay="0.1s">
            <div class="adminTitle">환자 데이터 조회 및 저장</div>
        </div>
        <div class="flex">
            <div class="adminModal">
                <form id="adminDataCureIFrm" name="adminDataCureIFrm" role="form" enctype="multipart/form-data">
                <div class="adminModalContent" style="margin: 4.3% 0;">
                    <div class="adminModalTitle">이온전극</div>
                    <div class="userInfo">
                        성함 :<input type="text" id="uname" name="uname" maxlength="20" txtlimit="5" class="adminUsrInfo">
                        생년월일 :<input type="text" name="ubdate" id="ubdate" class="adminUsrInfo"readonly>
                        <span class="btnArea M b_center" style="float: right; width: 18%; max-width: 80px;">
                            <a href="/admin/cureMain" class="close custom_s">이전</a>
                        </span>
                    </div>
					<div class="current_date">측정날짜 : <span id="current_date"></span></div>
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
                                5<input type="radio" name="iTime" id="t1" value="5" class="radioBtnRight">
                            </td>
                            <td>
                                10<input type="radio" name="iTime" id="t2" value="10" class="radioBtnRight">
                            </td>
                            <td>
                                15<input type="radio" name="iTime" id="t3" value="15" class="radioBtnRight">
                            </td>
                            <td>
                                20<input type="radio" name="iTime" id="t4" value="20" class="radioBtnRight">
                            </td>
                            <td>
                                30<input type="radio" name="iTime" id="t5" value="30" class="radioBtnRight">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">전류</td>
                            <td colspan="5">
                                <input style="height: 20px; width: 50px;" type="text" maxlength="4" name="iCurrent" id="iCurrent" class="">&nbsp;uA
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="adminButton_pos">
                        <div class="btnArea M b_center">
                            <a id="adminDataCureIBtn" class="close black_s" >저장</a>
                        </div>
                    </div>
                </div>
                </form>
            </div>
            <div class="right wow fadeInDown" data-wow-delay="0.2s">
                <div class="adminPage">
                    <div class="adminPageMain">
                        <a href="/admin/inquiry?cp=1" class="adminPageMain_box">
                            <h3>조회</h3>
                            <p>환자의 피부 측정값과<br>치료 내용을 조회합니다.</p>
                        </a>
                    </div>
                    <div class="adminPageMain">
                        <a href="/admin/cureMain" class="adminPageMain_box adminPageBtnActive">
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


<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="section8">
    <div class="comm_wrap2">
        <div class="cetnerDiv wow fadeInUp top" data-wow-delay="0.1s">
            <div class="adminTitle">환자 데이터 조회 및 저장</div>
        </div>
        <div class="flex">
            <div class="adminModal">
                <form id="adminDataCureLFrm" name="adminDataCureLFrm" role="form" enctype="multipart/form-data">
                <div class="adminModalContent">
                    <div class="adminModalTitle">라이트닝</div>
                    <div style="padding-bottom: 12px">
                        성함 :<input type="text" id="uname" name="uname" maxlength="20" txtlimit="5" class="adminUsrInfo">
                        생년월일 :<input type="text" name="ubdate" id="ubdate" class="adminUsrInfo"readonly>
                        <span class="btnArea M b_center" style="float: right">
                            <a href="/admin/cureMain" class="close custom_s">이전</a>
                        </span>
                    </div>
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
                                M1<input type="radio" name="lMode" id="m1" value="m1" class="radioBtnRight">
                            </td>
                            <td>
                                M2<input type="radio" name="lMode" id="m2" value="m2" class="radioBtnRight">
                            </td>
                            <td>
                                M3<input type="radio" name="lMode" id="m3" value="m3" class="radioBtnRight">
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: center">밝기</td>
                            <td>
                                1<input type="radio" name="lBrightness" id="b1" value="1" class="radioBtnRight">
                            </td>
                            <td>
                                2<input type="radio" name="lBrightness" id="b2" value="2" class="radioBtnRight">
                            <td>
                                3<input type="radio" name="lBrightness" id="b3" value="3" class="radioBtnRight">
                            </td>
                            <td>
                                4<input type="radio" name="lBrightness" id="b4" value="4" class="radioBtnRight">
                            </td>
                            <td>
                                5<input type="radio" name="lBrightness" id="b5" value="5" class="radioBtnRight">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">시간</td>
                            <td>
                                5<input type="radio" name="lTime" id="t1" value="5" class="radioBtnRight">
                            </td>
                            <td>
                                10<input type="radio" name="lTime" id="t2" value="10" class="radioBtnRight">
                            </td>
                            <td>
                                15<input type="radio" name="lTime" id="t3" value="15" class="radioBtnRight">
                            </td>
                            <td>
                                20<input type="radio" name="lTime" id="t4" value="20" class="radioBtnRight">
                            </td>
                            <td>
                                30<input type="radio" name="lTime" id="t5" value="30" class="radioBtnRight">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">주파수</td>
                            <td colspan="5">
                                <input style="height: 20px; width: 50px;" type="text" maxlength="4" id="lHz" name="lHz" class="">&nbsp;HZ
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="adminButton_pos">
                        <div class="btnArea M b_center">
                            <a id="adminDataCureLBtn" class="close black_s" >저장</a>
                        </div>
                    </div>
                </div>
                </form>
            </div>
            <div class="right wow fadeInDown" data-wow-delay="0.2s">
                <div class="adminPage">
                    <div class="adminPageMain">
                        <a href="/admin/main" class="adminPageMain_box">
                            <h3>측정</h3>
                            <p>진단을 통한 측정값을<br>저장합니다.</p>
                        </a>
                    </div>
                    <div class="adminPageMain">
                        <a href="/admin/cureMain" class="adminPageMain_box adminPageBtnActive">
                            <h3>치료</h3>
                            <p>치료 내용을 저장합니다.</p>
                        </a>
                    </div>
                    <div class="adminPageMain">
                        <a href="/admin/inquiry?cp=1" class="adminPageMain_box">
                            <h3>조회</h3>
                            <p>환자의 피부 측정값과<br>치료 내용을 조회합니다.</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


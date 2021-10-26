<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="section8">
    <div class="comm_wrap2">
        <div class="cetnerDiv wow fadeInUp top" data-wow-delay="0.1s">
            <div class="adminTitle">환자 데이터 조회 및 저장</div>
        </div>

        <div class="flex">
            <div class="adminModal">
                <form id="adminDataLogFrm" name="adminDataLogFrm" role="form" enctype="multipart/form-data">
                <div class="adminModalContent">
                    <div class="adminModalTitle">측정값</div>
                    <div style="padding-bottom: 12px">
                        성함 :<input type="text" id="uname" name="uname" maxlength="20" txtlimit="20" class="adminUsrInfo">
                        생년월일 :<input type="text" id="ubdate" name="ubdate" class="adminUsrInfo"readonly>
                    </div>
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
                                PD1 :<input type="text" id="pd1" name="pd1" maxlength="4" txtlimit="5" class="adminInput">
                            </td>
                            <td>
                                PD2 :<input type="text" id="pd2" name="pd2" maxlength="4" txtlimit="5" class="adminInput">
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: center">피부 탄성도</td>
                            <td>
                                주파수 :<input type="text" id="hz" name="hz" maxlength="4" class="adminInput">
                            </td>
                            <td>
                                S1 :<input type="text" id="s1" name="s1" maxlength="4" class="adminInput">
                            <td>
                                S2 :<input type="text" id="s2" name="s2" maxlength="4" class="adminInput">
                            </td>
                            <td>
                                S3 :<input type="text" id="s3" name="s3" maxlength="4" class="adminInput">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">피부 수분도</td>
                            <td>
                                수분도 :<input type="text" id="moistureLev" name="moistureLev" maxlength="4" class="adminInput">
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="text-align: center">측정 결과</td>
                            <td>
                                두께 :<input type="text" id="thicknessRes" name="thicknessRes" maxlength="4" class="adminInput">
                            </td>
                            <td>
                                탄성도 :<input type="text" id="elasticityRes" name="elasticityRes" maxlength="4" class="adminInput">
                            </td>
                            <td>
                                수분도 :<input type="text" id="moistureLevRes" name="moistureLevRes" maxlength="4" class="adminInput">
                            </td>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="adminButton_pos">
                        <div class="btnArea M b_center">
                            <a id="adminDataLogBtn" class="close black_s" >저장</a>
                        </div>
                    </div>
                </div>
                </form>
            </div>
            <div class="right wow fadeInDown" data-wow-delay="0.2s">
                <div class="adminPage">
                    <div class="adminPageMain">
                        <a href="/admin/main" class="adminPageMain_box adminPageBtnActive">
                            <h3>측정</h3>
                            <p>진단을 통한 측정값을<br>저장합니다.</p>
                        </a>
                    </div>
                    <div class="adminPageMain">
                        <a href="/admin/cureMain" class="adminPageMain_box">
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
<%--
<div id="section4">
    <div class="comm_wrap">
        <h2 class="wow fadeInUp commo_h2" data-wow-delay="0.2s">피부 진단 수치</h2>
        <p class="wow fadeInUp top" data-wow-delay="0.3s">기록 및 조회</p>
        <div class="secWrap4">
            <div class="table">
                <div class="room1 r_ovlay">
                    <img src="/images/admin/hospital_4.png" alt="" />
                    <div class="opaBox">
                        <div class="opaLineBox">
                            <div class="opaLine">
                                <div class="S_opaLine">
                                    <dl>
                                        <dt>Interior for you</dt>
                                        <dd>환자분의 편의와 편안함을 최우선으로 하여
                                            <span>솔루션의원의 모든 공간을 1인실로 구성하였습니다.</span>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="room2 r_ovlay">
                    <img src="/images/admin/hospital_1.png" alt="" />
                    <div class="opaBox">
                        <div class="opaLineBox">
                            <div class="opaLine">
                                <div class="S_opaLine">
                                    <dl>
                                        <dt>1 use item</dt>
                                        <dd>가운, 배드 시트 등 몸에 닿는 모든
                                            <span>물품은 1회용으로 사용합니다.</span>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="room3 r_ovlay">
                    <img src="/images/admin/hospital_2.png" alt="" />
                    <div class="opaBox">
                        <div class="opaLineBox">
                            <div class="opaLine">
                                <div class="S_opaLine">
                                    <dl>
                                        <dt>Completely <span>private space</span></dt>
                                        <dd>솔루션의 아늑하고 프라이빗한
                                            <span>공간에서 편안히 시술받으세요.</span>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="table">
                <div class="room4 r_ovlay">
                    <img src="/images/admin/hospital_5.png" alt="" />
                    <div class="opaBox">
                        <div class="opaLineBox">
                            <div class="opaLine">
                                <div class="S_opaLine">
                                    <dl>
                                        <dt>No touch <span>System</span></dt>
                                        <dd>터치없는 센서 작동으로
                                            <span>완벽한 클린 시스템을 구현하였습니다.</span>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="room5 r_ovlay">
                    <img src="/images/admin/hospital_3.jpg" alt="" />
                    <div class="opaBox">
                        <div class="opaLineBox">
                            <div class="opaLine">
                                <div class="S_opaLine">
                                    <dl>
                                        <dt>Sollution Clinic</dt>
                                        <dd>편안한 분위기와 함께 진행되는 김솔원장의 집중 케어는
                                            <span>완전한 힐링과 최고의 결과를 선물합니다.</span>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>--%>


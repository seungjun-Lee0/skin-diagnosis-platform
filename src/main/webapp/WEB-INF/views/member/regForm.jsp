<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="contents">
    <div class="join_title">
        <h4 class="title">회원 정보 입력</h4>
    </div>

    <form name="signform" id="signform" method="post" action="/pc/member/join-02.html" ENCTYPE="multipart/form-data">
        <input type="hidden" name="formmode" value="save">
        <input type="hidden" name="conf" value="member_1">
        <input type="hidden" name="bmain" value="ok">

        <div class="u_page_wrap">
            <div class="text_right" style="border-bottom:1px solid #000;">
                <span class="red_01">*</span> 필수 입력 항목
            </div>
            <table class="table-form-01 type_join">
                <colgroup>
                    <col class="col_w">
                    <col width="*">
                </colgroup>
                <tbody>

                <tr>
                    <th><span class="red_01">*</span> 아이디</th>
                    <td>
                        <div class="input_find clearfix">
                            <input type="text" name="mid" id="mid" title="아이디"  maxlength="20" txtlimit="5" chk="idcheck" value="" class="input_55" placeholder="영문, 숫자로만 구성된 5~20자 ">
                            <!-- <a href="javascript:;" id="btn-idcheck" class="table-btn-01 ">중복확인 </a> -->
                            <span class="font_12" id="loginId"></span>
                            <input type="hidden" name="mid_chk" id="mid_chk" title="중복확인">
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>
                        <span class="red_01">*</span> 비밀번호
                    </th>
                    <td>
                        <input type="password" class="input_55" name="upasswd" id="upasswd" title="비밀번호" txtlimit="8" maxlength="12" chk="pwcheck" placeholder="영문, 숫자, 특수문자(!@#$%^*) 조합 8~12자 "><span class="font_12 mt_10" id="passId"></span>

                    </td>
                </tr>
                <tr>
                    <th>
                        <span class="red_01">*</span> 비밀번호 확인
                    </th>
                    <td>
                        <input type="password" name="upasswd1" id="upasswd1" title="비밀번호" txtlimit="8" maxlength="12" chk="pwcheck1" class="input_55" placeholder="비밀번호를 한번 더 입력하세요"><span id="passId_1" class="ml_10 font_12 mt_10"></span>
                    </td>
                </tr>
                <tr>
                    <th>
                        <span class="red_01">*</span> 이름
                    </th>
                    <td><input type="text"  name="uname" id="uname" title="성명" value="" maxlength="12" class="input_55"></td>
                </tr>
                <tr>
                    <th>
                        <span class="red_01">*</span> 이메일
                    </th>
                    <td>

                        <div class="e_mail_box">
                            <span class="mail_txt"><input type="text"  name="uemail1" id="uemail1" title="이메일" value="" class="input_for" chk="email_check"></span>
                            <span class="mail_a">@</span>
                            <span class="mail_txt2"><input type="text" name="uemail2" id="uemail2" title="이메일" class="input_for" placeholder="직접입력" value="" class="input_for" chk="email_check"></span>
                            <span class="mail_sel">
                                <select name="uemail3" onChange="changeEmail(this.value)" class="sel_for">
                                    <option value="" selected>이메일선택</option>
                                                                        <option value="naver.com">naver.com</option>
                                                                        <option value="dreamwiz.com">dreamwiz.com</option>
                                                                        <option value="empal.com">empal.com</option>
                                                                        <option value="hanmir.com">hanmir.com</option>
                                                                        <option value="hanafos.com">hanafos.com</option>
                                                                        <option value="hotmail.com">hotmail.com</option>
                                                                        <option value="lycos.co.kr">lycos.co.kr</option>
                                                                        <option value="nate.com">nate.com</option>
                                                                        <option value="paran.com">paran.com</option>
                                                                        <option value="netian.com">netian.com</option>
                                                                        <option value="yahoo.co.kr">yahoo.co.kr</option>
                                                                        <option value="kornet.net">kornet.net</option>
                                                                        <option value="nownuri.net">nownuri.net</option>
                                                                        <option value="unitel.co.kr">unitel.co.kr</option>
                                                                        <option value="freechal.com">freechal.com</option>
                                                                        <option value="korea.com">korea.com</option>
                                                                        <option value="orgio.net">orgio.net</option>
                                                                        <option value="chollian.net">chollian.net</option>
                                                                        <option value="hitel.net">hitel.net</option>
                                                                        <option value="gmail.com">gmail.com</option>

                                    <option value="1">직접입력</option>
                                </select>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>
                        <span class="red_01">*</span> 휴대전화번호
                    </th>
                    <td>
                        <ul class="num ">
                            <li class="">
                                <input name="uptel1" id="uptel1" title="휴대전화번호" maxlength="4" type="text" size="4"  class="input_for"  onKeyUp="if(isNaN(this.value)) {alert('숫자만 입력해 주세요.');this.value=''};"  value="" placeholder="앞자리" />
                            </li>
                            <li class="">-
                                <input name="uptel2" id="uptel2" title="휴대전화번호" maxlength="4" type="text" size="4"  class="input_for"  onKeyUp="if(isNaN(this.value)) {alert('숫자만 입력해 주세요.');this.value=''};"  value="" placeholder="앞자리" /></li>
                            <li class="">-
                                <input name="uptel3" id="uptel3" title="휴대전화번호" maxlength="4" type="text" size="4"  class="input_for"  onKeyUp="if(isNaN(this.value)) {alert('숫자만 입력해 주세요.');this.value=''};"  value="" placeholder="뒷자리" /></li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <th>
                        유선연락처
                    </th>
                    <td>
                        <ul class="num ">
                            <li class="">
                                <input name="utel1" id="utel1" title="유선연락처" maxlength="4" type="text" size="4"  class="input_for"  onKeyUp="if(isNaN(this.value)) {alert('숫자만 입력해 주세요.');this.value=''};"  value="" placeholder="앞자리" />
                            </li>
                            <li class="">-
                                <input name="utel2" id="utel2" title="유선연락처" maxlength="4" type="text" size="4"  class="input_for"  onKeyUp="if(isNaN(this.value)) {alert('숫자만 입력해 주세요.');this.value=''};"  value="" placeholder="앞자리" /></li>
                            <li class="">-
                                <input name="utel3" id="utel3" title="유선연락처" maxlength="4" type="text" size="4"  class="input_for"  onKeyUp="if(isNaN(this.value)) {alert('숫자만 입력해 주세요.');this.value=''};"  value="" placeholder="뒷자리" /></li>
                        </ul>

                    </td>
                </tr>
                <tr>
                    <th>
                        <span class="red_01"></span> 수신동의
                    </th>
                    <td>
                        <div class="chk_area">
                            <!-- <input type="checkbox" class="st2" id="info_all" name="check_all" checked>
                            <label for="info_all" class="mr_20">모두동의</label> -->
                            <input type="checkbox" id="smstype" name="smstype" checked>
                            <label for="smstype" class="mr_20">문자 동의</label>
                            <input type="checkbox" id="mailtype" name="mailtype"  checked>
                            <label for="mailtype">메일 동의</label>
                        </div>
                        <p class="mt_10 etc_p">
                            ※ 할인, 이벤트 소식에 관련된 동의 입니다.<br>
                            (서비스 주요 정책 관련 내용은 수신동의 여부와 관계없이 발송됩니다)
                        </p>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="join_btn_bx">
                <a href="/member/joinDone" class="btn-type-01">가입하기</a>
            </div>
        </div>
    </form>
</div>
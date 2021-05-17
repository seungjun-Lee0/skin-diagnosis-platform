function selectAll(selectAll)  {
    const checkboxes
        = document.getElementsByName('agree');

    checkboxes.forEach((checkbox) => {
        checkbox.checked = selectAll.checked;
    })
}

// 약관동의
$('#agreed').on('click', function() {
    if(!$('#agree1').is(':checked'))
        alert('서비스 이용약관에 동의해주세요!');
    else if(!$('#agree2').is(':checked'))
        alert('개인정보 수집 및 이용안내에 동의해주세요!');
    else if(!$('#agree3').is(':checked'))
        alert('개인정보 제 3자 제공 및 공유에 동의해주세요!');
    else
        location.href = '/member/regForm';
});

// email readonly 속성 잠금/해제
$('#uemail3').on('change', function () {
    let val = $('#uemail3 option:selected').text();

    if (val == '직접입력') {
        $('#uemail2').attr('readonly', false); // readonly 해제
        $('#uemail2').val('');
    } else {
        $('#uemail2').attr('readonly', true); // readonly 잠금
        $('#uemail2').val(val);
    }
});

$('#uid').on('blur', function () { checkuserid() });

// 데이터베이스에서 아이디 중복체크
function checkuserid() {
    let uid = $('#uid').val();

    var pattern1 = /[0-9]/;
    var pattern2 = /[a-zA-Z]/;

    $.ajax({
        url: '/member/checkuid',
        type: 'GET',
        data: { 'uid': uid }
    })
        .done(function(data){
            let msg = '';
            $('#uidmsg').attr('style', 'color:red !important');

            if (data.trim() == '0'){
                if(uid.length >= 5 && pattern1.test(uid) && pattern2.test(uid) ) {
                    msg = '사용 가능한 아이디입니다';
                    $('#uidmsg').attr('style', 'color:blue !important');
                }
                else{
                    msg = '영문, 숫자로만 구성된 5~20자를 입력해주세요'
                }
            }
            else{
                msg ='중복된 아이디입니다'
            }
            $('#uidmsg').text( msg );
        })
        .fail(function(xhr, status, error){
            alert(xhr.status + '/' + error);
        });
}

$('#upwd').on('blur', function () {  checkpassword(); });

// 비밀번호 최소 숫자 체크
function checkpassword() {
    var id = document.getElementById("uid").value;
    var pw = document.getElementById("upwd").value;

    var pattern1 = /[0-9]/;
    var pattern2 = /[a-zA-Z]/;
    var pattern3 = /[~!@\#$%<>^&*]/;
    let pwmsg = $('#upwdmsg');

    if(!pattern1.test(pw)||!pattern2.test(pw)||!pattern3.test(pw)||pw.length<8||pw.length>20){
        pwmsg.text("영문, 숫자, 특수문자(!@#$%^*) 조합 8~20자를 입력해주세요").attr('style', 'color:red');
    }

    else if(pw.indexOf(id) > -1) {
        pwmsg.text("비밀번호는 ID를 포함할 수 없습니다").attr('style', 'color:red');
    }

    else{
        pwmsg.text("사용 가능한 비밀번호입니다").attr('style', 'color:blue');
    }
}

$('#upwdcheck').on('blur', function () {  pwdsameness(); });

// 비밀번호 일치 체크
function pwdsameness() {
    var pw = document.getElementById("upwd").value;
    var pwcheck = document.getElementById("upwdcheck").value;
    let pwcheckmsg = $('#upwdcheckmsg');

    if (pw == pwcheck) {
        pwcheckmsg.text('비밀번호가 일치합니다').attr('style', 'color:blue');
    }
    else {
        pwcheckmsg.text('비밀번호가 일치하지 않습니다').attr('style', 'color:red');
    }
}

$('#uemail3').on('blur', function () {  checkuemail(); });

// 데이터베이스에서 이메일 중복체크
function checkuemail() {
    let email1 = $('#uemail1').val();
    let email2 = $('#uemail2').val();

    var pattern1 = /[0-9]/;
    var pattern2 = /[a-zA-Z]/;

    $.ajax({
        url: '/member/checkemail',
        type: 'GET',
        data: { 'email1': email1,
                'email2': email2}
    }).done(function(data){
            let msg = '';
            $('#uemailmsg').attr('style', 'color:red !important');

            if (data.trim() == '0'){
                if(email1.length > 0 && email2.length > 0 && (pattern1.test(email1) || pattern2.test(email1)) ) {
                    msg = '사용 가능한 이메일입니다';
                    $('#uemailmsg').attr('style', 'color:blue !important');
                }
                else{
                    msg = '올바르지 않은 이메일 형식입니다'
                }
            }
            else{
                msg ='중복된 이메일입니다'
            }
            $('#uemailmsg').text( msg );
        })
        .fail(function(xhr, status, error){
            alert(xhr.status + '/' + error);
        });
}

// 회원가입
$('#reg_submit').on('click', function() {
   if ($('#uidmsg').text() != '사용 가능한 아이디입니다') {
       alert('아이디를 올바르게 입력해주세요');
   }
   else if ($('#upwdmsg').text() != '사용 가능한 비밀번호입니다') {
       alert('비밀번호를 올바르게 입력해주세요');
   }
   else if ($('#upwdcheckmsg').text() != '비밀번호가 일치합니다') {
       alert('비밀번호가 일치하지 않습니다');
   }
   else if ($('#uname').val() == '') {
       $('#unamemsg').text('이름을 입력하세요').attr('style', 'color:red');
   }
   else if ($('#uemail1').val() == '' || $('#uemail2').val() == '') {
       $('#unamemsg').text('').attr('style', 'color:black');
       $('#uemailmsg').text('이메일을 입력하세요').attr('style', 'color:red');
   }
   else if ($('#utel1').val() =='' || $('#utel2').val() =='' || $('#utel3').val() =='') {
       $('#uemailmsg').text('').attr('style', 'color:black');
       $('#utelmsg').text('전화번호를 입력하세요').attr('style', 'color:red');
   }
   else {
       $('#utelmsg').text('').attr('style', 'color:black');

       $('#uemail').val($('#uemail1').val() + '@' + $('#uemail2').val());
       $('#utel').val($('#utel1').val() + '-' + $('#utel2').val() + '-' + $('#utel3').val())

       $('#sms').val($('input:checkbox[id="smsagreed"]').is(":checked"));
       $('#mail').val($('input:checkbox[id="mailagreed"]').is(":checked"));

       const frm = $('#signinform');
       frm.attr('method', 'post');
       frm.attr('action', '/member/regDone');
       frm.submit();
    }
});

// 정보수정
$('#modify_submit').on('click', function() {
    if ($('#upwdmsg').text() != '사용 가능한 비밀번호입니다') {
        alert('비밀번호를 올바르게 입력해주세요');
    }
    else if ($('#upwdcheckmsg').text() != '비밀번호가 일치합니다') {
        alert('비밀번호가 일치하지 않습니다');
    }
    else if ($('#uemail1').val() == '' || $('#uemail2').val() == '') {
        $('#unamemsg').text('').attr('style', 'color:black');
        $('#uemailmsg').text('이메일을 입력하세요').attr('style', 'color:red');
    }
    else if ($('#utel1').val() =='' || $('#utel2').val() =='' || $('#utel3').val() =='') {
        $('#uemailmsg').text('').attr('style', 'color:black');
        $('#utelmsg').text('전화번호를 입력하세요').attr('style', 'color:red');
    }
    else if (confirm('정말 수정하시겠습니까?') == true){
        $('#utelmsg').text('').attr('style', 'color:black');

        $('#uemail').val($('#uemail1').val() + '@' + $('#uemail2').val());
        $('#utel').val($('#utel1').val() + '-' + $('#utel2').val() + '-' + $('#utel3').val())

        $('#sms').val($('input:checkbox[id="smsagreed"]').is(":checked"));
        $('#mail').val($('input:checkbox[id="mailagreed"]').is(":checked"));

        const frm = $('#modifyform');
        frm.attr('method', 'post');
        frm.attr('action', '/member/myInfoChanged');
        frm.submit();
    }
    else{
        return false;
    }
});

// 로그인
$('#loginbtn').on('click', function() {

    if ($('#uid').val() == '') alert('아이디를 입력하세요')
    else if ($('#upwd').val() == '') alert('비밀번호를 입력하세요')
    else {
        const frm = $('#loginfrm');
        frm.attr('method', 'POST');
        frm.attr('action', '/member/login');
        frm.submit(); }
});

// 회원 탈퇴
$('#quit_btn').on('click', function() {
    location.href = '/mypage/withdraw';
});

$('#withdrawbtn').on('click', function() {
    if ($('#uid').val() == '') alert('아이디를 입력하세요');
    else if ($('#uid').val() != $('#curruid').val()) alert('아이디가 일치하지 않습니다')
    else if ($('#upwd').val() == '') alert('비밀번호를 입력하세요');
    else if (confirm('정말 탈퇴하시겠습니까?') == true){
        const frm = $('#withdrawfrm');
        frm.attr('method', 'post');
        frm.attr('action', '/mypage/withdraw');
        frm.submit();
    }
    else {
        return false;
    }
});

$('#cancelbtn').on('click', function() {
    location.href = '/';
});

// 아이디 찾기
$('#fidbtn').on('click', function() {
    if ($('#uname').val() == '') {
        alert('이름을 입력해주세요');
    }
    else if ($('#uemail').val() == '') {
        alert('이메일을 입력해주세요');
    }
    else {
        const frm = $('#fidform');
        frm.attr('method', 'post');
        frm.attr('action', '/member/findidok');
        frm.submit();
    }
});

// 비밀번호 찾기
$('#fpwdbtn').on('click', function() {
    if ($('#uid').val() == '') {
        alert('아이디를 입력해주세요');
    }
    else if ($('#uemail').val() == '') {
        alert('이메일을 입력해주세요');
    }
    else {
        const frm = $('#fpwdfrm');
        frm.attr('method', 'post');
        frm.attr('action', '/member/findpwdok');
        frm.submit();
    }
});
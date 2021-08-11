// search board
function isearchbar() {
    var reg = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gim;
    var contents = $('#findkey').val();

    if(reg.test(contents)){
        contents = contents.replace(reg, "");
    }
    if (contents == '') alert('검색할 내용을 입력하세요!');
    else if($('#findtype').val() == null) alert('카테고리를 선택하세요!');
    else {
        let qry = "?findtype=" + $('#findtype').val();
        qry += "&findkey=" + contents + "&cp=1";

        let url = '/inquiry/find' + qry
        location.href = url;
    }
}

$('#ifindbtn').on('click', function() { isearchbar() });

function ifileTypeCheck1(file) {
    fpath = file.value.lastIndexOf('.');
    ftype = file.value.substring(fpath+1, file.length);
    ftype = ftype.toLowerCase();

    if(ftype=='jpg' || ftype=='gif' || ftype=='png' || ftype=='jpeg'){
        $('#ftype1').val('');
    }
    else{
        $('#ftype1').val('false');
    }
}

function ifileTypeCheck2(file) {
    fpath = file.value.lastIndexOf('.');
    ftype = file.value.substring(fpath+1, file.length);
    ftype = ftype.toLowerCase();

    if(ftype=='jpg' || ftype=='gif' || ftype=='png' || ftype=='jpeg'){
        $('#ftype2').val('');
    }
    else{
        $('#ftype2').val('false');
    }
}

function ifileTypeCheck3(file) {
    fpath = file.value.lastIndexOf('.');
    ftype = file.value.substring(fpath+1, file.length);
    ftype = ftype.toLowerCase();

    if(ftype=='jpg' || ftype=='gif' || ftype=='png' || ftype=='jpeg'){
        $('#ftype3').val('');
    }
    else{
        $('#ftype3').val('false');
    }
}

$('#secretagreed1').on('change', function () {
    if($('#secretagreed1').is(':checked')){
        $('#pwd').attr('disabled', false);
    }
    else if (!$('#secretagreed1').is(':checked')){
        $('#pwd').attr('disabled', true);
    }
})

$('#secretagreed').on('change', function () {
    if($('#secretagreed').is(':checked')){
        $('#pwdelement').show();
    }
    else if (!$('#secretagreed1').is(':checked')){
        $('#pwdelement').hide();
    }
})


$('#pwdmodify').on('change', function () {
    if($('#pwdmodify').is(':checked')){
        $('#pwd').attr('readonly', false);
    }
    else if (!$('#pwdmodify').is(':checked')){
        $('#pwd').attr('readonly', true);
    }
})

// write inquiry
$('#iwritebtn').on('click', function () {
    if ($('#title').val() == '') alert('제목을 작성하세요!');
    else if ($('#content').val() == '') alert('본문을 작성하세요!');
    else if ($('#ftype1').val() == 'false' || $('#ftype2').val() == 'false' || $('#ftype3').val() == 'false') alert('이미지 파일(jpg, gif, png, jpeg)만 선택할 수 있습니다');
    else if ($('#secretagreed1').is(':checked') && $('#pwd').val() == '') alert('비밀번호를 입력해주세요!');
    else {
        $('#fixed').val($('input:checkbox[id="fixedagreed"]').is(":checked"));
        $('#secret').val($('input:checkbox[id="secretagreed1"]').is(":checked"));
        const frm = $('#inquiryfrm');

        frm.attr('method', 'post');
        frm.attr('action', '/inquiry/write');
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }
});

// 수정하기

$('#idie1').on('change', function (){
    if($('#idie1').is(':checked')) {
        $('#img1').attr('disabled', false);
        $('#img1').show();
        $('#label1').hide();
        $('#todie').val($('#todie').val() + "1");
    } else if (!$('#idie1').is(':checked')){
        $('#img1').attr('disabled', true);
        $('#img1').hide();
        $('#label1').show();
        $('#todie').val($('#todie').val().replace(/1/g, ''));
    }
})

$('#idie2').on('change', function (){
    if($('#idie2').is(':checked')) {
        $('#img2').attr('disabled', false);
        $('#img2').show();
        $('#label2').hide();
        $('#todie').val($('#todie').val() + "2");
    } else if (!$('#idie2').is(':checked')){
        $('#img2').attr('disabled', true);
        $('#img2').hide();
        $('#label2').show();
        $('#todie').val($('#todie').val().replace(/2/g, ''));
    }
})

$('#idie3').on('change', function (){
    if($('#idie3').is(':checked')) {
        $('#img3').attr('disabled', false);
        $('#img3').show();
        $('#label3').hide();
        $('#todie').val($('#todie').val() + "3");
    } else if (!$('#idie3').is(':checked')){
        $('#img3').attr('disabled', true);
        $('#img3').hide();
        $('#label3').show();
        $('#todie').val($('#todie').val().replace(/3/g, ''));
    }
})

// modify inquiry
$('#imodifybtn').on('click', function () {
    if ($('#title').val() == '') alert('제목을 작성하세요!');
    else if ($('#content').val() == '') alert('본문을 작성하세요!');
    else if ($('#ftype1').val() == 'false' || $('#ftype2').val() == 'false' || $('#ftype3').val() == 'false') alert('이미지 파일(jpg, gif, png, jpeg)만 선택할 수 있습니다');
    else if ($('#pwdmodify').is(':checked') && $('#pwd').val() == '') alert('비밀번호를 입력해주세요!');
    else {
        $('#fixed').val($('input:checkbox[id="fixedagreed"]').is(":checked"));
        $('#secret').val($('input:checkbox[id="secretagreed"]').is(":checked"));
        if (!$('#secretagreed').is(':checked')){
            $('#pwd').val(null
            );
        }

        const frm = $('#imodifyfrm');

        frm.attr('method', 'post');
        frm.attr('action', '/inquiry/modify');
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }
});

$('#ideletebtn').on('click', function () {
    if (confirm("삭제된 게시물은 복구 하실 수 없습니다. 정말 삭제하시겠습니까?") == true){    //확인
        const frm = $('#ideletefrm');

        frm.attr("method", "post");
        frm.attr('action', "/inquiry/delete");
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }else{   //취소
        return;
    }
})

// new board comment
$('#replybtn').on('click', function (){
    if($('#content').val() == '') alert("댓글을 작성하세요");
    else {
        const frm = $('#replyfrm');
        frm.attr('method','post');
        frm.attr('action','/reply/write');
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }
});

// check password of secret inquiry
$('#ipwdcheckbtn').on('click', function (){
    if($('#pwd').val() == '') alert("암호를 입력하세요");
    else {
        const frm = $('#inquirysecurefrm');
        frm.attr('method','post');
        frm.attr('action','/inquiry/secret');
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }
});

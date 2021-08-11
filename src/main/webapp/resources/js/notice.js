// search board
function nsearchbar() {
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

        let url = '/notice/find' + qry
        location.href = url;
    }
}

$('#nfindbtn').on('click', function() { nsearchbar() });

function nfileTypeCheck1(file) {
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

function nfileTypeCheck2(file) {
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

function nfileTypeCheck3(file) {
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

// write notice
$('#nwritebtn').on('click', function () {
    if ($('#title').val() == '') alert('제목을 작성하세요!');
    else if ($('#content').val() == '') alert('본문을 작성하세요!');
    else if ($('#ftype1').val() == 'false' || $('#ftype2').val() == 'false' || $('#ftype3').val() == 'false') alert('이미지 파일(jpg, gif, png, jpeg)만 선택할 수 있습니다');
    else {
        $('#fixed').val($('input:checkbox[id="fixedagreed"]').is(":checked"));
        const frm = $('#noticefrm');

        frm.attr('method', 'post');
        frm.attr('action', '/notice/write');
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }
});

// modify

$('#ndie1').on('change', function (){
    if($('#ndie1').is(':checked')) {                 // can upload the image when checkbox is checked
        $('#img1').attr('disabled', false);
        $('#img1').show();
        $('#label1').hide();
        $('#todie').val($('#todie').val() + "1");     // differentiate the order of the image
    } else if (!$('#ndie1').is(':checked')){
        $('#img1').attr('disabled', true);
        $('#img1').hide();
        $('#label1').show();
        $('#todie').val($('#todie').val().replace(/1/g, ''));
    }
})

$('#ndie2').on('change', function (){
    if($('#ndie2').is(':checked')) {
        $('#img2').attr('disabled', false);
        $('#img2').show();
        $('#label2').hide();
        $('#todie').val($('#todie').val() + "2");
    } else if (!$('#ndie2').is(':checked')){
        $('#img2').attr('disabled', true);
        $('#img2').hide();
        $('#label2').show();
        $('#todie').val($('#todie').val().replace(/2/g, ''));
    }
})

$('#ndie3').on('change', function (){
    if($('#ndie3').is(':checked')) {
        $('#img3').attr('disabled', false);
        $('#img3').show();
        $('#label3').hide();
        $('#todie').val($('#todie').val() + "3");
    } else if (!$('#ndie3').is(':checked')){
        $('#img3').attr('disabled', true);
        $('#img3').hide();
        $('#label3').show();
        $('#todie').val($('#todie').val().replace(/3/g, ''));
    }
})

$('#nmodifybtn').on('click', function () {
    if ($('#title').val() == '') alert('제목을 작성하세요');
    else if ($('#content').val() == '') alert('본문을 작성하세요');
    else if ($('#ftype1').val() == 'false' || $('#ftype2').val() == 'false' || $('#ftype3').val() == 'false') alert('이미지 파일(jpg, gif, png, jpeg)만 선택할 수 있습니다');
    else {
        $('#fixed').val($('input:checkbox[id="fixedagreed"]').is(":checked"));
        const frm = $('#noticemodifyfrm');

        frm.attr('method', 'post');
        frm.attr('action', '/notice/modify');
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }
});

$('#ndeletebtn').on('click', function () {
    if (confirm("삭제된 게시물은 복구 하실 수 없습니다. 정말 삭제하시겠습니까?") == true){    //확인
        const frm = $('#ndeletefrm');

        frm.attr("method", "post");
        frm.attr('action', "/notice/delete");
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }else{   //취소
        return;
    }
})
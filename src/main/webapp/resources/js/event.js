// search board

function esearchbar() {
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

        let url = '/event/find' + qry
        location.href = url;
    }
}

$('#efindbtn').on('click', function() { esearchbar() })

function efileTypeCheck1(file) {
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

function efileTypeCheck2(file) {
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

// write notice
$('#ewritefrm').on('click', function () {
    if ($('#title').val() == '') alert('제목을 작성하세요!');
    else if ($('#sdate').val() == '' || $('#edate').val() == '') alert('이벤트 기간을 설정하세요!');
    else if (!$('#img1').val() || !$('#img2').val()) alert('썸네일 이미지와 컨텐츠 이미지를 모두 넣어주세요!');
    else if ($('#ftype1').val() == 'false' || $('#ftype2').val() == 'false') alert('이미지 파일(jpg, gif, png, jpeg)만 선택할 수 있습니다');
    else {
        const frm = $('#eventfrm');

        frm.attr('method', 'post');
        frm.attr('action', '/event/write');
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }
});

$('#emodifybtn').on('click', function () {
    if ($('#title').val() == '') alert('제목을 작성하세요');
    else if ($('#sdate').val() == '' || $('#edate').val() == '') alert('이벤트 기간을 설정하세요!');
    else if($('#die1').is(':checked') && !$('#img1').val()) {
        alert('파일을 선택하세요');
    }
    else if($('#die2').is(':checked') && !$('#img2').val()) {
        alert('파일을 선택하세요');
    }
    else if ($('#ftype1').val() == 'false' || $('#ftype2').val() == 'false') alert('이미지 파일(jpg, gif, png, jpeg)만 선택할 수 있습니다');
    else {
        const frm = $('#eventmodifyfrm');

        frm.attr('method', 'post');
        frm.attr('action', '/event/modify');
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }
});

$('#edeletebtn').on('click', function () {
    if (confirm("삭제된 게시물은 복구 하실 수 없습니다. 정말 삭제하시겠습니까?") == true){
        const frm = $('#eventdeletefrm');

        frm.attr("method", "post");
        frm.attr('action', "/event/delete?bno=" + $("#bno").val());
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }else{
        return;
    }
})
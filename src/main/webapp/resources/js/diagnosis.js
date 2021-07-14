// terms and condifiton
$('#dagreed').on('click', function() {
    if($('#agree1').is(':checked'))
        location.href = '/diagnosis/check';
    else
        alert('민감 정보 수집에 대해 동의해주세요!');
});


$('#selftestbtn').on('click', function () {
    var temp1 = "";
    var choice = 0;

    for(var j = 1; j < 7; j++) {
        for (var i = 1; i < 12; i++) {
            if (eval("$('#c" + j + "_" + i + "')").is(':checked')) {
                eval("var c" + j + "_" + i + "= 1");
            }
            else if (!eval("$('#c" + j + "_" + i + "')").is(':checked')) {
                eval("var c" + j + "_" + i + "= 0");
                choice++;
            }
            temp1 += eval("c" + j + "_" + i) + "/";
        }
        temp1 += "\n"
    }
    var check1 = temp1.split("\n");

    $('#c1').val(check1[0]);
    $('#c2').val(check1[1]);
    $('#c3').val(check1[2]);
    $('#c4').val(check1[3]);
    $('#c5').val(check1[4]);
    $('#c6').val(check1[5]);

    if(choice >= 66){
        if(confirm("모든 부위의 피부 고민에 체크 하지 않으셨습니다. 진행하시겠습니까?") == true){
            const frm = $('#selftestfrm');
            frm.attr('method', 'post');
            frm.attr('action', '/diagnosis/check');
            frm.attr('enctype', "multipart/form-data");
            frm.submit();
        }
    }
    else{
        const frm = $('#selftestfrm');
        frm.attr('method', 'post');
        frm.attr('action', '/diagnosis/check');
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }
})

$('#etc1').on('change', function () {
    if ($('#etc1').is(':checked')) {
        $('#s3_13').attr('readonly', false);
    }
    else{
        $('#s3_13').attr('readonly', true);
        $('#s3_13').val('');
    }
});


$('#etc2').on('change', function () {
    if ($('#etc2').is(':checked')) {
        $('#s4_13').attr('readonly', false);
    } else {
        $('#s4_13').attr('readonly', true);
        $('#s4_13').val('');
    }
});

function dfileTypeCheck1(file) {
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

function dfileTypeCheck2(file) {
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

function dfileTypeCheck3(file) {
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

$('#analysisbtn').on('click', function () {
    var temp2 = "";
    var isSubmitted = false;

    for(var j = 1; j < 13; j++) {
        var choice = 0;
        for (var i = 1; i < 13; i++) {
            if (eval("$('#s" + j + "_" + i + "')").is(':checked')) {
                eval("var s" + j + "_" + i + "= 1");
            }
            else if (!eval("$('#s" + j + "_" + i + "')").is(':checked')) {
                eval("var s" + j + "_" + i + "= 0");
                choice++;
            }
            temp2 += eval("s" + j + "_" + i) + "/";
        }
        if(choice >= 12 && j != 3 && j != 4){
            alert('최소 하나의 답을 체크해주세요!');
            isSubmitted = false;
            break;
        }
        else if(choice >= 12 && j == 3){
            if(!$('#etc1').is(':checked')){
                alert('최소 하나의 답을 체크해주세요!')
                isSubmitted = false;
                break;
            }
        }
        else if(choice >= 12 && j == 4){
            if(!$('#etc2').is(':checked')){
                alert('최소 하나의 답을 체크해주세요!')
                isSubmitted = false;
                break;
            }
        }
        temp2 += "\n"
        isSubmitted = true;
    }

    var check2 = temp2.split("\n");

    if($('#etc1').is(':checked')){
        check2[2] = check2[2] + $('#s3_13').val();
    }
    if($('#etc2').is(':checked')){
        check2[3] = check2[3] + $('#s4_13').val();
    }


    $('#s1').val(check2[0]);
    $('#s2').val(check2[1]);
    $('#s3').val(check2[2]);
    $('#s4').val(check2[3]);
    $('#s5').val(check2[4]);
    $('#s6').val(check2[5]);
    $('#s7').val(check2[6]);
    $('#s8').val(check2[7]);
    $('#s9').val(check2[8]);
    $('#s10').val(check2[9]);
    $('#s11').val(check2[10]);
    $('#s12').val(check2[11]);

    var pattern = /^[a-zA-Zㄱ-힣0-9|s]*$/;

    if (!$('#img1').val() || !$('#img2').val() || !$('#img3').val()) alert('정면과 측면 사진을 모두 올려주세요!');
    else if ($('#ftype1').val() == 'false' || $('#ftype2').val() == 'false' || $('#ftype3').val() == 'false') alert('이미지 파일(jpg, gif, png, jpeg)만 선택할 수 있습니다');
    else if (!pattern.test($('#s3_13').val()) || !pattern.test($('#s4_13').val())) alert('특수문자를 포함할 수 없습니다!')
    else {
        if (isSubmitted) {
            const frm = $('#analysisfrm');

            frm.attr('method', 'post');
            frm.attr('action', '/diagnosis/check2');
            frm.submit();
        }
    }
})

$('#dfindbtn').on('click', function() { dsearchbar() });

// search board
function dsearchbar() {
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

        let url = '/mypage/myDiagnosis' + qry
        location.href = url;
    }
}
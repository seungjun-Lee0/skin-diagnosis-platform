$('#adminDataLogBtn').on('click', function() {

    let check = /^[0-9.]+$/

    if ($('#uname').val() == '') {
        alert('이름을 입력하세요!')
    }
    else if ($('#ubdate').val() == ''){
        alert('생년월일을 입력하세요!')
    }
    else if ($('#pd1').val() == '' || $('#pd2').val() == '' || $('#hz').val() == '' || $('#s1').val() == '' || $('#s2').val() == '' ||
        $('#s3').val() == '' || $('#moistureLev').val() == '' || $('#thicknessRes').val() == '' || $('#elasticityRes').val() == '' || $('#moistureLevRes').val() == ''){
        alert('값을 모두 입력하세요!')
    }
    else if (!check.test($('#pd1').val()) || !check.test($('#pd2').val()) || !check.test($('#hz').val()) || !check.test($('#s1').val()) || !check.test($('#s2').val()) ||
        !check.test($('#s3').val()) || !check.test($('#moistureLev').val()) || !check.test($('#thicknessRes').val()) || !check.test($('#elasticityRes').val()) || !check.test($('#moistureLevRes').val())){
        alert('숫자 및 소수점만 입력가능합니다.')
    }
    else{
        const frm = $('#adminDataLogFrm');
        frm.attr('method', 'post')
        frm.attr('action', '/admin/main');
        frm.submit();
        alert('값이 저장되었습니다.')
    }
})

$('#adminDataCureVBtn').on('click', function() {

    let check = /^[0-9]+$/;

    if ($('#uname').val() == '') {
        alert('이름을 입력하세요!')
    }
    else if ($('#ubdate').val() == ''){
        alert('생년월일을 입력하세요!')
    }
    else if (!$("input[type=radio][name=vMode]:checked").is(':checked') ||
        !$("input[type=radio][name=vSensitivity]:checked").is(':checked') ||
        !$("input[type=radio][name=vTime]:checked").is(':checked') || $('#vHz').val() == ''){
        alert('값을 모두 선택하세요!')
    }
    else if (!check.test($('#vHz').val())){
        alert('숫자만 입력하세요!')
    }
    else{
        const frm = $('#adminDataCureVFrm');
        frm.attr('method', 'post')
        frm.attr('action', '/admin/cure/V');
        frm.submit();
        alert('값이 저장되었습니다.')
    }
})

$('#adminDataCureIBtn').on('click', function() {

    let check = /^[0-9]+$/;

    if ($('#uname').val() == '') {
        alert('이름을 입력하세요!')
    }
    else if ($('#ubdate').val() == ''){
        alert('생년월일을 입력하세요!')
    }
    else if (!$("input[type=radio][name=iTime]:checked").is(':checked') || $('#iCurrent').val() == ''){
        alert('값을 모두 선택하세요!')
    }
    else if (!check.test($('#iCurrent').val())){
        alert('숫자만 입력하세요!')
    }
    else{
        const frm = $('#adminDataCureIFrm');
        frm.attr('method', 'post')
        frm.attr('action', '/admin/cure/I');
        frm.submit();
        alert('값이 저장되었습니다.')
    }
})

$('#adminDataCureTBtn').on('click', function() {

    let check = /^[0-9]+$/;

    if ($('#uname').val() == '') {
        alert('이름을 입력하세요!')
    }
    else if ($('#ubdate').val() == ''){
        alert('생년월일을 입력하세요!')
    }
    else if (!$("input[type=radio][name=tTime]:checked").is(':checked') ||
        $('#tVoltage').val() == '' || $('#tHz').val() == ''){
        alert('값을 모두 선택하세요!')
    }
    else if (!check.test($('#tVoltage').val()) || !check.test($('#tHz').val()) ){
        alert('숫자만 입력하세요!')
    }
    else{
        const frm = $('#adminDataCureTFrm');
        frm.attr('method', 'post')
        frm.attr('action', '/admin/cure/T');
        frm.submit();
        alert('값이 저장되었습니다.')
    }
})

$('#adminDataCureLBtn').on('click', function() {

    let check = /^[0-9]+$/;

    if ($('#uname').val() == '') {
        alert('이름을 입력하세요!')
    }
    else if ($('#ubdate').val() == ''){
        alert('생년월일을 입력하세요!')
    }
    else if (!$("input[type=radio][name=lMode]:checked").is(':checked') ||
        !$("input[type=radio][name=lBrightness]:checked").is(':checked') ||
        !$("input[type=radio][name=lTime]:checked").is(':checked') ||
        $('#lHz').val() == ''){
        alert('값을 모두 선택하세요!')
    }
    else if (!check.test($('#lHz').val())){
        alert('숫자만 입력하세요!')
    }
    else{
        const frm = $('#adminDataCureLFrm');
        frm.attr('method', 'post')
        frm.attr('action', '/admin/cure/L');
        frm.submit();
        alert('값이 저장되었습니다.')
    }
})

$('#adminDataInquiryBtn').on('click', function() {
    var reg = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gim;
    var content1 = $('#findkey1').val();
    var content2 = $('#findkey2').val();

    if(reg.test(content1)){
        content1 = content1.replace(reg, "");
    }
    if (content1 == '' || content2 == '') alert('검색할 내용을 입력하세요!');
    else {
        let qry = "?findkey1=" + content1;
        qry += "&findkey2=" + content2 + "&cp=1";

        let url = '/admin/inquiry/find' + qry
        location.href = url;
    }
})

$('#adminInquiryDeleteBtn').on('click', function () {
    if (confirm("삭제된 게시물은 복구 하실 수 없습니다. 정말 삭제하시겠습니까?") == true){    //확인
        const frm = $('#adminInquiryDeleteFrm');

        frm.attr("method", "post");
        frm.attr('action', "/admin/inquiry/delete");
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }else{   //취소
        return;
    }
})


function adminData(){
	$('#adminDataLogBtn').on('click', function() {

    let check = /^[0-9.]+$/

    if ($('#uname').val() == '') {
        alert('이름을 입력하세요!')
    }
    else if ($('#ubdate').val() == ''){
        alert('생년월일을 입력하세요!')
    }
    else if ($('#pd1').val() == '' || $('#pd2').val() == '' || $('#hz').val() == '' || $('#s1').val() == '' || $('#s2').val() == '' ||
        $('#s3').val() == '' || $('#moistureLev').val() == '' || $('#thicknessRes').val() == '' || $('#elasticityRes').val() == '' || $('#moistureLevRes').val() == ''){
        alert('값을 모두 입력하세요!')
    }
    else if (!check.test($('#pd1').val()) || !check.test($('#pd2').val()) || !check.test($('#hz').val()) || !check.test($('#s1').val()) || !check.test($('#s2').val()) ||
        !check.test($('#s3').val()) || !check.test($('#moistureLev').val()) || !check.test($('#thicknessRes').val()) || !check.test($('#elasticityRes').val()) || !check.test($('#moistureLevRes').val())){
        alert('숫자 및 소수점만 입력가능합니다.')
    }
    else{
        const frm = $('#adminDataLogFrm');
        frm.attr('method', 'post')
        frm.attr('action', '/admin/main');
        frm.submit();
        alert('값이 저장되었습니다.')
    }
})

$('#adminDataCureVBtn').on('click', function() {

    let check = /^[0-9]+$/;

    if ($('#uname').val() == '') {
        alert('이름을 입력하세요!')
    }
    else if ($('#ubdate').val() == ''){
        alert('생년월일을 입력하세요!')
    }
    else if (!$("input[type=radio][name=vMode]:checked").is(':checked') ||
        !$("input[type=radio][name=vSensitivity]:checked").is(':checked') ||
        !$("input[type=radio][name=vTime]:checked").is(':checked') || $('#vHz').val() == ''){
        alert('값을 모두 선택하세요!')
    }
    else if (!check.test($('#vHz').val())){
        alert('숫자만 입력하세요!')
    }
    else{
        const frm = $('#adminDataCureVFrm');
        frm.attr('method', 'post')
        frm.attr('action', '/admin/cure/V');
        frm.submit();
        alert('값이 저장되었습니다.')
    }
})

$('#adminDataCureIBtn').on('click', function() {

    let check = /^[0-9]+$/;

    if ($('#uname').val() == '') {
        alert('이름을 입력하세요!')
    }
    else if ($('#ubdate').val() == ''){
        alert('생년월일을 입력하세요!')
    }
    else if (!$("input[type=radio][name=iTime]:checked").is(':checked') || $('#iCurrent').val() == ''){
        alert('값을 모두 선택하세요!')
    }
    else if (!check.test($('#iCurrent').val())){
        alert('숫자만 입력하세요!')
    }
    else{
        const frm = $('#adminDataCureIFrm');
        frm.attr('method', 'post')
        frm.attr('action', '/admin/cure/I');
        frm.submit();
        alert('값이 저장되었습니다.')
    }
})

$('#adminDataCureTBtn').on('click', function() {

    let check = /^[0-9]+$/;

    if ($('#uname').val() == '') {
        alert('이름을 입력하세요!')
    }
    else if ($('#ubdate').val() == ''){
        alert('생년월일을 입력하세요!')
    }
    else if (!$("input[type=radio][name=tTime]:checked").is(':checked') ||
        $('#tVoltage').val() == '' || $('#tHz').val() == ''){
        alert('값을 모두 선택하세요!')
    }
    else if (!check.test($('#tVoltage').val()) || !check.test($('#tHz').val()) ){
        alert('숫자만 입력하세요!')
    }
    else{
        const frm = $('#adminDataCureTFrm');
        frm.attr('method', 'post')
        frm.attr('action', '/admin/cure/T');
        frm.submit();
        alert('값이 저장되었습니다.')
    }
})

$('#adminDataCureLBtn').on('click', function() {

    let check = /^[0-9]+$/;

    if ($('#uname').val() == '') {
        alert('이름을 입력하세요!')
    }
    else if ($('#ubdate').val() == ''){
        alert('생년월일을 입력하세요!')
    }
    else if (!$("input[type=radio][name=lMode]:checked").is(':checked') ||
        !$("input[type=radio][name=lBrightness]:checked").is(':checked') ||
        !$("input[type=radio][name=lTime]:checked").is(':checked') ||
        $('#lHz').val() == ''){
        alert('값을 모두 선택하세요!')
    }
    else if (!check.test($('#lHz').val())){
        alert('숫자만 입력하세요!')
    }
    else{
        const frm = $('#adminDataCureLFrm');
        frm.attr('method', 'post')
        frm.attr('action', '/admin/cure/L');
        frm.submit();
        alert('값이 저장되었습니다.')
    }
})

$('#adminDataInquiryBtn').on('click', function() {
    var reg = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gim;
    var content1 = $('#findkey1').val();
    var content2 = $('#findkey2').val();

    if(reg.test(content1)){
        content1 = content1.replace(reg, "");
    }
    if (content1 == '' || content2 == '') alert('검색할 내용을 입력하세요!');
    else {
        let qry = "?findkey1=" + content1;
        qry += "&findkey2=" + content2 + "&cp=1";

        let url = '/admin/inquiry/find' + qry
        location.href = url;
    }
})

$('#adminInquiryDeleteBtn').on('click', function () {
    if (confirm("삭제된 게시물은 복구 하실 수 없습니다. 정말 삭제하시겠습니까?") == true){    //확인
        const frm = $('#adminInquiryDeleteFrm');

        frm.attr("method", "post");
        frm.attr('action', "/admin/inquiry/delete");
        frm.attr('enctype', "multipart/form-data");
        frm.submit();
    }else{   //취소
        return;
    }
})

}
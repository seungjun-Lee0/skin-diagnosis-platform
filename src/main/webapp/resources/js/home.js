
$('#chk1').on('change', function(){
    var isChk = this.checked;
    if(isChk){
        setTimeout(function () {
        $('#skinDiagnosis').text("皮肤诊断")
        $('#event').text("事件")
        $('#notice').text("通知单")
        $('#inquiry').text("1:1问讯问")
        $('#right_quick > ul > li:nth-child(1) > a > div > div.text_con').text("在线咨询")
        $('#right_quick > ul > li:nth-child(2) > a > div > div.text_con').text("微信")
        $('#right_quick > ul > li:nth-child(3) > a > div > div.text_con').text("登门路")
        $('#right_quick > ul > li:nth-child(4) > a > div > div.text_con').text("医院简介")
        $('#right_quick > ul > li:nth-child(5) > a > div > div.text_con').text("紫砂商城")
        }, 500)
    } else {
        setTimeout(function () {
            location.reload()
        }, 500)
    }
})

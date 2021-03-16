// popup youtube video
$(".popupModalVideo a").click(function() {
    $(".video_modal_popup").addClass("reveal"),
        $(".video_modal_popup .video-wrapper").remove(),
        $(".video_modal_popup").append("<div class='video-wrapper'><iframe width='560' height='315' src='https://youtube.com/embed/" + $(this).data("video") + "?rel=0&playsinline=1&autoplay=1' allow='autoplay; encrypted-media' allowfullscreen></iframe></div>")
}),
    $(".video_modal_popup-closer").click(function() {
        $(".video_modal_popup .video-wrapper").remove(),
            $(".video_modal_popup").removeClass("reveal")
    });

let header = document.querySelector("#header");
let headerHeight = header.offsetHeight;

window.onscroll = function () {
    let windowTop = window.scrollY;
    // 스크롤 세로값이 헤더높이보다 크거나 같으면
    // 헤더에 클래스 'drop'을 추가한다
    if (windowTop >= headerHeight/2) {
        header.classList.add("drop");
    }
    // 아니면 클래스 'drop'을 제거
    else {
        header.classList.remove("drop");
    }
};

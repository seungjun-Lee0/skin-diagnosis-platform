new Swiper('.swiperMain', {
    // Optional parameters
    direction: 'horizontal',
    effect: "fade",
    centerSlides: true ,

    /*// If we need pagination
    pagination: {
        el: '.swiper-pagination',
        clickable: true,
    },*/

    autoplay: {
        delay: 5000,
        disableOnInteraction: false,
    },
});

new Swiper(".swiperYoutube", {
    effect: "coverflow",
    centeredSlides: true,
    slidesPerView: 2.3,
    initialSlide: 2,
    coverflowEffect: {
        rotate: 20,
        stretch: 0,
        depth: 100,
        modifier: 1,
    },

    // Navigation arrows
    navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
    },

    pagination: {
        el: ".swiper-pagination",
    },
});
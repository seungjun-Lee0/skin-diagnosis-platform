const swiper = new Swiper('.swiper', {
    // Optional parameters
    direction: 'horizontal',
    effect: "fade",
    centerSlides: true ,

    // If we need pagination
    pagination: {
        el: '.swiper-pagination',
        clickable: true,
    },

    // Navigation arrows
    navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
    },

    autoplay: {
        delay: 5000,
        disableOnInteraction: false,
    },
});
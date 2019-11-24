$(document).ready(function () {

    $('.slider-container').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        dots: false,
        fade: false,
        infinite: false
    });

    $('.slider-nav').slick({
        slidesToShow: 3,
        slidesToScroll: 0,
        asNavFor: '.slider-container',
        dots: false,
        arrows: false,
        centerMode: true,
        focusOnSelect: true,
        infinite: false
    });

    $(".slider-nav-item").click(function () {
        $(".slider-nav-item").removeClass("inverted");
        $(this).addClass("inverted");
    });
});
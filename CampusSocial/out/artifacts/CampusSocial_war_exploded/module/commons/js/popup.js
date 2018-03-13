$(function () {
    $(".popup").hide();
    $(".popup .popup-content").click(function () {
        event.stopPropagation();
    })
    $(".popup .popup-footer .popup-close").click(function () {
        $(".popup").hide();
    })
    $(".popup").click(function () {
        $(".popup").hide();
    })
})
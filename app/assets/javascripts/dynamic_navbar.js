$(document).ready(function () {
  $(window).scroll(function (e) {
    if ($(window).scrollTop() > 0) {
      $('.navbar-fixed nav').css('background', '#607d8b');
    } else {
      $('.navbar-fixed nav').css('background', 'transparent');
    }
  });
});

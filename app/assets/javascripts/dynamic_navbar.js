$(document).ready(function () {
  $(window).scroll(function (e) {
    if ($(window).scrollTop() > 0) {
      $('nav').css('background', '#607d8b');
    } else {
      $('nav').css('background', 'transparent');
    }
  });
});

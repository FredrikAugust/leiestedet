$(document).ready(function () {
  $(window).scroll(function (e) {
    if ($(window).scrollTop() > 0) {
      $('.navbar-fixed nav').css('background', '#607d8b');
      $('nav *').css('text-shadow', 'none');
    } else {
      $('.navbar-fixed nav').css('background', 'transparent');
      $('nav *').css('text-shadow', '1px 1px black');
    }
  });
});

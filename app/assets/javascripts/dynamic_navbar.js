$(document).ready(function () {
  var h = $('.full-page-jumbotron').height();
  $(window).on('scroll', function (e) {
    if ($(window).scrollTop() > 0) {
      $('.navbar-fixed nav').css('background', 'rgba(21, 21, 21, 0.9)');
      $('.full-page-jumbotron').height(h/2);
    } else {
      $('.navbar-fixed nav').css('background', 'transparent');
      $('.full-page-jumbotron').height(h);
    }
  });
});

$(document).ready(function () {
  $('.button-collapse').sideNav();
  $('.dropdown-button').dropdown();
  $('.modal').modal();

  $('.listingimage').on('click', function () {
    $('.modal-content').html($(this).clone());
    $('.modal').modal('open');
  });
});

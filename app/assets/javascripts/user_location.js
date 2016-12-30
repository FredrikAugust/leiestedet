$(document).on('turbolinks:load', function () {
  if ($('form input#user_location').length > 0) {
    var autocomplete = new google.maps.places.Autocomplete(
      document.getElementById('user_location')
    );

    $('#new_user,#edit_user').on('submit', function (e) {
      $('input#user_place_id[type="hidden"]').val(autocomplete.getPlace().place_id);
    });
  }
});

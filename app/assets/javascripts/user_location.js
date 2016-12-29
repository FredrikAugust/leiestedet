$(document).on('turbolinks:load', function () {
  var autocomplete = new google.maps.places.Autocomplete(
    document.getElementById('user_location')
  );

  $('#new_user').on('submit', function (e) {
    $('input#user_place_id[type="hidden"]').val(autocomplete.getPlace().place_id);
  });
});

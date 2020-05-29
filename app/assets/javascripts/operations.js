$(document).ready(function() {
  $('.delete').bind('ajax:success', function () {
    $(this).closest('.card-col').fadeOut();
  });
})

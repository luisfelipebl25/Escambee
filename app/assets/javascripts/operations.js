$(document).ready(function() {
  $('.delete').bind('ajax:success', function () {
    $(this).closest('.card-col').fadeOut();
  });
  $('.add').bind('ajax:success', function() {
    $(this).fadeOut(function() {
      $(this).replaceWith('<h4>Desejado</h4>');
    })
    
  })
})

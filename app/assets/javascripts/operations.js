$(document).ready(function() {
  $('.delete').bind('ajax:success', function () {
    $(this).closest('.card-col').fadeOut();
  });

  $('.add').bind('ajax:success', function() {
    $(this).fadeOut(function() {
      $(this).closest('.btns').replaceWith('<i class="fas fa-check text-success"></i>&nbsp;Jogo adicionado na sua coleção!');
    })
  })

  $('.accept').bind('ajax:success', function() {
    $(this).fadeOut(function() {
      $(this).closest('.btns').replaceWith('<i class="fas fa-check text-success"></i>&nbsp;Proposta respondida!')
    })
  });

  $('.reject').bind('ajax:success', function() {
    $(this).fadeOut(function() {
      $(this).closest('.btns').replaceWith('<i class="fas fa-times text-danger"></i>&nbsp;Proposta rejeitada.')
    })
  });
})

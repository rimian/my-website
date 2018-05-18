$(document).ready(function() {
  $('#send').click(function(e) {
    e.preventDefault();
    const modalSuccess = UIkit.modal('#modal-success');
    const modalError = UIkit.modal('#modal-error');
    const data = $('form').serialize();

    $.ajax({
      url: '/',
      type: 'post',
      dataType: 'json',
      accepts: 'application/json',
      data: data,
      success: function(data) {
        modalSuccess.show();
      },
      error: function(jqXHR, textStatus, msg) {
        $('#modal-error .msg').text(msg);
        modalError.show();
      }
    });
  });
});

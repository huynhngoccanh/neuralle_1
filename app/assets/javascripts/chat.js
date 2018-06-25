$(document).ready(function(){
  if($('.chat-button:not(:hidden)').length) {
    $('.chat-button').click(function(){
      $('.zopim').show()
      $zopim.livechat.window.show();
    })

    $zopim.livechat.window.hide()
  }
})
$(document).ready ->
  $('body').on 'click', '[data-video-control="toggle"]', ->
    video = $($(@).data('video-target'))
    console.log(video)
    if video.prop('paused')
      console.log('paused')
      $(video).trigger('play')
      $(@).html('❚❚');
    else
      console.log('playing')
      $(video).trigger('pause')
      $(@).html('►');
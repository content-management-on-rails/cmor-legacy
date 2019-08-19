$(document).ready ->
  $('body').on 'click', '[data-video-control="toggle"]', ->
    video = $($(@).data('video-target'))
    if video.prop('paused')
      video.trigger('play')
      $(@).html('<i class="fas fa-pause">');
    else
      video.trigger('pause')
      $(@).html('<i class="fas fa-play">');

  $('body').on 'click', '[data-video-control="play"]', ->
    video = $($(@).data('video-target'))
    video.trigger('play')

  $('body').on 'click', '[data-video-control="pause"]', ->
    video = $($(@).data('video-target'))
    video.trigger('pause')

  $('body').on 'click', '[data-video-control="stop"]', ->
    video = $($(@).data('video-target'))
    video.trigger('pause')
    video.attr('currentTime', 0)
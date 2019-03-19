$ ->
  $('[data-tag]').not('.ui-draggable').on 'mouseover', ->
    $(this).draggable({
      revert: true
    })

$ ->
  $('[data-taggable]').each ->
    authenticity_token = $( 'meta[name="csrf-token"]' ).attr( 'content' );

    $(@).droppable({
      accept: '.draggable-tag',
      activeClass: 'highlight',
      drop: (event, ui) ->
        dropped_element = $(ui.draggable)
        tag_id = dropped_element.attr('data-tag-uid')
        taggable_gid = $(@).attr('data-gid')
        post_url = dropped_element.attr('data-tag-url')
        console.log(post_url)
        jqxhr = $.post(post_url, { authenticity_token: authenticity_token, gid: taggable_gid, tag_id: tag_id  }, ->
          # alert 'success'
          return
        ).done(->
          # alert 'second success'
          return
        ).fail(->
          # alert 'error'
          return
        ).always(->
          # alert 'finished'
          return
        )
    })
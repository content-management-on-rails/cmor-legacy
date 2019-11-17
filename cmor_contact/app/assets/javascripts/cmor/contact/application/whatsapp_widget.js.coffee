$ ->
  initializePopover = (element) ->
    url = $(element).data('url')

    jqxhr = $.get(url, (data) =>
      createPopover(element, data)
      return
    ).done(->
      return
    ).fail(->
      return
    ).always(->
      return
    )

  createPopover = (element, data) ->
    popover = $(element).popover
      sanitize: false
      content: data
      html: true
      trigger: 'click'
    return

  initializePopover('#cmor-contact-whatsapp-popover-button')

  $(document).on 'keypress', 'textarea', (e) ->
    if e.which == 13 and !e.shiftKey
      $(this).closest('form').submit()
      e.preventDefault()
    return
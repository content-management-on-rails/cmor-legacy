$(document).ready ->
  $('[data-load][data-target]').on 'click', ->
    modal = $(this).attr('data-target')

    spinner = """
      <div class="d-flex justify-content-center">
        <div class="spinner-border text-secondary" role="status">
          <span class="sr-only">Loading...</span>
        </div>
      </div>
    """

    $(modal).find(".modal-body").html(spinner);

    url = $(this).attr('data-load')
    $(modal).removeData 'bs.modal'
    if url.endsWith('.json')
      $.getJSON url, (data) ->
        $(modal).find('.modal-body').html data['content']
        return
    else
      $(modal).find('.modal-body').load url
    $(modal).modal 'show'

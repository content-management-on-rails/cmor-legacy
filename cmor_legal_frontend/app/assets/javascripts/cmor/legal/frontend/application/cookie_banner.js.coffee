$ ->
  $('.cmor-legal-cookies-accept_all').click ->
    $("input.cmor-legal-cookie-accept:not(:disabled)").prop("checked", true)
    return
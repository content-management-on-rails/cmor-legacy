$ ->
  $("li[data_add_icon] a").each (index, element) ->
    icon = $(element).parent().attr('data_add_icon')
    $(element).prepend("<span class=\"glyphicon glyphicon-#{icon}\"></span>")



# AUTOCOMPLETE

$(document).ready ->
  $("#header input#search" ).autocomplete {
		source: groups,
		select: (event, ui) ->
		  $('#header input#group_id').val(ui.item.id)
  }
  $("li.menu").click ->
    if $(this).attr('class') == "menu"
      $(this).addClass("open")
    else
      $(this).removeClass("open")



# AUTOCOMPLETE

$(document).ready ->
  $("#header input" ).autocomplete {
		source: groups,
		select: (event, ui) ->
      $.get "/group/" + ui.item.id
  }

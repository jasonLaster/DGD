$(document).ready ->
  
  # Autocomplete for main nav search bar
  $(".topbar input#search" ).autocomplete {
		source: groups,
		select: (event, ui) ->
		  $("#group_id").val(ui.item.id)
  }
  
  # Secondary nav dropdown menu
  $("li.menu").hover ->
    if $(this).attr('class') == "menu"
      $(this).addClass("open")
    else
      $(this).removeClass("open")

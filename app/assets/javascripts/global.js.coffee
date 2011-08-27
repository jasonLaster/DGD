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
  
  # Slide down groups
  $("#directory h4.category_header").click ->
    group = $(this).attr('id')
    $("#directory .groups_container#"+group).slideToggle('fast')

  # Columnize groups list
  $(".groups_container").each ->
    number_of_columns = Math.ceil( $(this).find("li").size() / 30 )
    number_of_columns++ if number_of_columns == 1
    $(this).find("ul").makeacolumnlists({ cols: number_of_columns })
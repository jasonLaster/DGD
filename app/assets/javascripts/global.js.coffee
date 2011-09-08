$(document).ready ->
  
  # Autocomplete for main nav search bar
  $("input#search" ).autocomplete {
		source: groups,
		select: (event, ui) ->
		  $("#group_id").val(ui.item.id)
		  $(this).closest('form').submit()
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
    if $(this).parent().find(".ui-icon").hasClass("ui-icon-triangle-1-s")
      $(this).parent().find(".ui-icon").removeClass("ui-icon-triangle-1-s").addClass("ui-icon-triangle-1-n")
    else
      $(this).parent().find(".ui-icon").removeClass("ui-icon-triangle-1-n").addClass("ui-icon-triangle-1-s")
  $("#directory ul.pills a.expand_all").click ->
    $("#directory .groups_container").slideDown('fast')
    $(".ui-icon").removeClass("ui-icon-triangle-1-s").addClass("ui-icon-triangle-1-n")
  $("#directory ul.pills a.collapse_all").click ->
    $("#directory .groups_container").slideUp('fast')
    $(".ui-icon").removeClass("ui-icon-triangle-1-n").addClass("ui-icon-triangle-1-s")

  # Columnize groups list
  $(".groups_container").each ->
    number_of_columns = Math.ceil( $(this).find("li").size() / 30 )
    number_of_columns++ if number_of_columns == 1
    $(this).find("ul").makeacolumnlists({ cols: number_of_columns })
  

  $("table#admin-table").tablesorter({ sortList: [[1,0]] })
  
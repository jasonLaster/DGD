$(document).ready ->
  # EDITOR
  $edit = $('#edit_description')
  $edit.find('#page-editor').wysihtml5()
  $edit.find('form').removeClass('formtastic')
  $edit.find('fieldset').addClass("formtastic")
  
  
  # CHECKLIST
  $checklist = $('#checklist')
  $checklist.find('input').live 'click', ->
    $form = $(this).closest('form')
    $.ajax
      type: 'put'
      url: $form.attr('action')
      data: $form.serialize()
      success: (data) ->
        $checklist.html(data)
    
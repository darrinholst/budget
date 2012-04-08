(($) ->
  $.fn.inlineEditable = ->
    this.find(".inline-edit").andSelf().filter(".inline-edit").each ->
      input = $(this)
      originalValue = input.val()

      input.focus (event) ->
        select = -> input.select()
        setTimeout(select, 0)
        originalValue = input.val()

      input.keydown (event) ->
        returnKeyPressed(event) if event.keyCode is 13
        escapeKeyPressed(event) if event.keyCode is 27

      returnKeyPressed = (event) ->
        if event.target.tagName.match(/textarea/i)
          saveEdit() if event.ctrlKey or event.shiftKey
        else
          saveEdit()

      escapeKeyPressed = (event) ->
        restoreOriginal()

      saveEdit = ->
        input.blur()

      restoreOriginal = ->
        input.val(originalValue).blur()

    return this
)(jQuery)

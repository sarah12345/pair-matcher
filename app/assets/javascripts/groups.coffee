$ ->
  group_modal = $("#group-modal")
  if group_modal.length > 0

    show_errors = (form, errors) ->
      alert_box = $(form.find(".alert"))
      alert_box.html("Errors: " + errors)
      alert_box.removeClass('hidden')

    submit_group_form = (form) ->
      form = $(form)
      $.post(form.attr('action'),
        form.serialize()
        (data) ->
          if data.errors.length == 0
            location.reload()
          else
            show_errors(form, data.errors)
      ).fail -> form.find(".modal-body").text("Something went wrong.")

    group_modal.find('form').submit (event) ->
      submit_group_form(event.target)
      event.preventDefault()

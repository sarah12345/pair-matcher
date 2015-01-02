module GroupsHelper

  def add_group_button
    button_options = {
      :type => 'button',
      :class => 'pull-right btn btn-sm btn-default',
      "data-target" => "#group-modal",
      "data-toggle" => "modal"
    }
    classes = "glyphicon glyphicon-plus"
    button_tag(button_options) do
      content_tag(:span, '', 'class' => classes, 'aria-hidden' => 'true') + ' ' +
      content_tag(:span, 'add group')
    end
  end

  def delete_group_button(group)
    url = team_group_path(current_team, group)
    button_options = {
      method: :delete,
      data: { confirm: "Are you sure? All team members in this group will also be deleted." },
      class: 'pull-right btn btn-xs btn-default'
    }
    classes = 'glyphicon glyphicon-trash'
    button_to(url, button_options) do
      content_tag(:span, '', class: classes, 'aria-hidden' => 'true')
    end
  end

end

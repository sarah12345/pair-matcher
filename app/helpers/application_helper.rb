module ApplicationHelper

  def flash_messages
    flash.map do |msg_type, message|
      content_tag(:div, class: "alert alert-#{msg_type} fade in") do
        content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' }) +
        content_tag(:span, Array(message).join(', '))
      end
    end.join.html_safe
  end
end

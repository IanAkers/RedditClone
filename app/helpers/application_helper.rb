module ApplicationHelper

  def form_auth
    <<-HTML
      <input
        type="hidden"
        name="authenticity_token"
        value="#{h(form_authenticity_token)}">
    HTML
    .html_safe
  end
end

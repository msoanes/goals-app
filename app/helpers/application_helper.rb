module ApplicationHelper
  def auth_token_input
    <<-HTM.html_safe
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTM
  end
end

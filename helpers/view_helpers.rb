module ViewHelper
  def render(view_name, *options)
    return erb "../views/#{view_name}.erb", options if options
    return erb "../views/#{view_name}.erb"
  end
end

def self.render(view_name, *options)
  return erb "../views/#{view_name}", options if options
  return erb "../views/#{view_name}"
end
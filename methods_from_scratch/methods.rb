def pluralize_ng(number, singular, plural=nil)
    if number == 1
        "1 #{singular}"
    elsif plural
        "#{number} #{plural}"
    else
        "#{number} #{singular}s"
    end
end

def split_name(model)
  words = model.scan(/[A-Z][^A-Z]*/)
  str = " "
  words.each { |word| str += "#{word} "}
  str
end
#puts pluralize_ng(2, 'dog')
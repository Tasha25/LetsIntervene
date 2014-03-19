def pluralize_ng(number, singular, plural=nil)
    if number == 1
        "1 #{singular}"
    elsif plural
        "#{number} #{plural}"
    else
        "#{number} #{singular}s"
    end
end


#puts pluralize_ng(2, 'dog')
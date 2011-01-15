module TimeConversion

  def minutes_in_decimal(minutes)
    ((minutes / 60.0) * 100 ).round / 100.0
  end

  def ceil_to_quarter(number)
    difference = (number * 100) % 25
    return number if difference.zero?
    
    ((number * 100 ) + (25 - difference)) / 100
  end

  def decimal_duration(seconds)
    d = Duration.new(seconds)
    d.hours + minutes_in_decimal(d.minutes)
  end
end
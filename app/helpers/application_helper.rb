module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Siwapp").join(" - ")
      end
    end
  end

  # To put class=active into the menu links
  def active_link(link)
    link.split(',').each do |value|
      if value.strip == params[:controller]
        return "active"
      end
    end
    return ""
  end

  def display_money(amount)
    currency = get_currency
    format = currency.symbol_first? ? "%u %n" : "%n %u"
    number_to_currency amount, precision: currency.exponent, unit: currency.symbol,
    separator: currency.separator, delimiter: currency.delimiter, format: format,
    negative_format: "(#{format})"
  end

end

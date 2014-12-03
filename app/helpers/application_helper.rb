module ApplicationHelper

  def select_day_with_blank_tag(name, options={})
    days = (1..31).collect {|d| d }
    days.insert(0, "")

    if options[:selected].present?
      selected = options.delete(:selected)
      selected = selected.class.eql?(String) ? selected : selected.day.to_s
    else
      selected = nil
    end

    select_tag name, options_for_select(days, selected), options
  end

  def select_month_with_blank_tag(name, options={})
    months = Date::MONTHNAMES.dup
    months[0] = ""

    if options[:selected].present?
      selected = options.delete(:selected)
      selected = selected.class.eql?(String) ? selected : months[selected.month]
    else
      selected = nil
    end

    select_tag name, options_for_select(months, selected), options
  end

end
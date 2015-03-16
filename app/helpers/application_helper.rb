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
    months = months.each_with_index.map { |m,i| [m, i] }
    months[0] = ["",""]

    if options[:selected].present?
      selected = options.delete(:selected)
      selected = selected.class.eql?(String) ? selected : selected.month
    else
      selected = nil
    end

    select_tag name, options_for_select(months, selected), options
  end

  def link_to_add_fields(name, f, association, opts={})
    new_object = f.object.send(association).build
    id = new_object.object_id

    partial_location = opts[:partial_location]
    partial_location ||= "admin/shared/#{association}_fields"

    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(partial_location, {f: builder}.merge(opts))
    end

    link_to(name, '#', class: 'add_fields btn btn-primary', data: { id: id, fields: fields.gsub('\n', '') })
  end

  def link_to_add_array_fields(name, model, field)
    id = ''.object_id
    fields = render("admin/#{model}/forms/#{field}_fields")
    link_to(name, '#', class: 'add_array_fields btn btn-primary', data: { id: id, fields: fields.gsub('\n', '') })
  end


end
Popolo::Organization.class_eval do
  accepts_nested_attributes_for :links, allow_destroy: true
  accepts_nested_attributes_for :sources, allow_destroy: true
  accepts_nested_attributes_for :contact_details, allow_destroy: true
end